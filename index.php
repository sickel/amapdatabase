<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">	
<?php
$tablename="user";
require_once $_SERVER['DOCUMENT_ROOT'].'/../libs/dblibs.php';
$prefix='amap_';
require('./smarty/Smarty_Connect.php');
$smarty = new smarty_connect; // Sets up the standard connection to use smarty

if($_GET['logout']==1){
// Deletes current credenciales when a user is logged off
		$_COOKIE['username']="";
		$_COOKIE['userid']="";
		setcookie('username',"");
		setcookie('userid',"");
}

if($_POST['SavePass']){ // Oppdaterer passordet
	try{
		if($_POST['password1']!=$_POST['password2']){throw new Exception('Nye passord stemmer ikke overens');} 
		$sqlh=$dbh->prepare("update ${prefix}user set password=md5(?) where id=? and password=md5(?)");
		$params=array($_POST['password1'],$_COOKIE['userid'],$_POST['oldpassword']);
		$sqlh->execute($params);
		// If no rows are affected, the old password is probably wrong. Might also be a problem with the user id from the coockie, but that is not as probable
		if(!$sqlh->rowCount()){throw new Exception('Kunne ikke oppdatere, skjekk at gammelt passord stemmer');} 
		$smarty->assign('headercomment','Passord endret');
	}
	catch (Exception $e){ // If the password is not changed, inform the user and set up the form again
		$smarty->assign('passworderr','<p><b>'.$e->getMessage().'</b></p>');
		$_GET['newpass']=1;
	}
}
if($_GET['newpass']){ // Form to change password
	$smarty->display('newpass.tpl');
}
if($_POST['name']){ // logging in 
	$sqlh=$dbh->prepare("select id,name from ${prefix}user where username=? and password=md5(?)");
	$sqlh->execute(array($_POST['name'],$_POST['password']));
	$row=$sqlh->fetchAll();
	//debug($row);
	//debug($sqlh->errorInfo());
	$id=$row[0]['id'];
	$name=$row[0]['name'];
	if($id>0){
		$_COOKIE['username']=$name;
		$_COOKIE['userid']=$id;
		setcookie('username',$name);
		setcookie('userid',$id);
		
	}else{
		$logonerror="<p><b>Ukjent brukernavn eller passord</b></p>";
	}
}	
if(!($_COOKIE['username'] && $_COOKIE['userid'])){
	// Should have been logged on here but is not logged in, so we'll try (again)
	$smarty->assign('logonerror',$logonerror);
	$smarty->display('login.tpl');
}elseif(!$_GET['newpass']){ // Start the real work
	$name=$_COOKIE['username'];
	$year=date('Y');
	$userid=$_COOKIE['userid'];
	if($_POST['Save']=='Lagre'){
		$inserth=$dbh->prepare("insert into ${prefix}registration (userid,projectid,workhours,start,ip) values(?,?,?,?,?);");
		foreach($_POST as $key=>$value){
			/* goes through all posted variables and looks for valid time values 
			The time values are stored with keys called hours_{projectid} and have a numeric value. 
			
			*/
			if((substr($key,0,5)=='hours') and ($value*1)){
				$parts=explode('_',$key);
				$projectid=$parts[1]*1?$parts[1]:$_POST['projectid']; // either a former defined projet or a new one from the dropdown box
				$workhours=$value;
				$start=$_POST["from_${parts[1]}"];
				if($parts[1]=='new'){
					$_POST["hours_$projectid"]=$value; // Must set this as it is used further down to give feedback on what is saved.
				}
				$inserth->execute(array($userid,$projectid,$workhours,$start,$_SERVER['REMOTE_ADDR']));
				
			}
		}
	}	
	// Fetch projects for dialog box:
	$sqlh=$dbh->prepare("select p.id,concat(p.name,' (',s.shortname,')') as name from ${prefix}project p, ${prefix}section s where year=? and sectionid=s.id order by sectionid,p.name");
	$sqlh->execute(array($year));
	$projectids[]=0; // Starts off with a blank value
	$projects[]='';
	while ($row=$sqlh->fetch()){
		$projectids[]=$row['id'];
		$projects[]=utf8_encode($row['name']);
	}
	/* Selects all projects in which the current user is active */
	$sql="select concat(p.name,' (',s.shortname,')') as name, p.id, sum(workhours) total 
	from ${prefix}section s, ${prefix}project  p, ${prefix}registration r 
	where projectid=p.id  and userid = ? and s.id=p.sectionid group by p.name, p.id 
	order by s.id, p.name";
	$sqlh=$dbh->prepare($sql);
	$sqlh->execute(array($userid));
	// debug($sqlh->errorInfo());
	$i=0;
	$replevel=error_reporting(E_ALL ^ E_NOTICE); // Set to avoid a lot of notices due to missing index.
	//debug($_POST);
	while ($row=$sqlh->fetch()){
		//debug($row);
		$p[$i]['id']=$row['id'];
		$p[$i]['name']=utf8_encode($row['name']);
		$p[$i]['total']=$row['total'];
		if($_POST["hours_${row['id']}"]*1){
		// Just to give some feedback that newly stored values indeed are handeled
			$p[$i]['last']=$_POST["hours_${row['id']}"];
		}
		$rev_p[$id]=$i;
		$i++;
	}
	error_reporting($replevel); // resets the error reporting level
	/* Must also get summaries for the last week and the current day. 
	TODO: This should have been done in the same query as above, but that does for some reason not work in mysql
	*/
	$sqls=array('weektotal'=>
	"select p.id, sum(workhours) total from ${prefix}project  p, ${prefix}registration r where projectid=p.id  and userid = ? and yearweek(start) = yearweek(curdate())	group by p.name, p.id",
		'today'=>"select p.id, sum(workhours) total from ${prefix}project  p, ${prefix}registration r where projectid=p.id  and userid = ? and start = curdate()	group by p.name, p.id");
	foreach($sqls as $field=>$sql){
		$sqlh=$dbh->prepare($sql);
		$sqlh->execute(array($userid));	
		while ($row=$sqlh->fetch()){
		/* This is not too efficient, as it is looking through all of the rows until it finds the correct
		TODO : use the reverse lookup table rev_p
		*/
			for($j=0;$j<$i;$j++){
				if($p[$j]['id']==$row['id']){
					$p[$j][$field]=$row['total'];
					$j=$i;
				}
			}
			$total[$field]+=$row['total'];
		}
	}
	//debug($total);
	$menu=array('data.php'=>'Data maintenance'
	,'report_content.php'=>'Sources reporting');
	
	$smarty->assign('m',$menu); 					// All selections
	$smarty->assign('userid',$userid);  		// The userid, to be put away in a hidden field 
	$smarty->assign('projects',$projects); 		// project names for drop down list
	$smarty->assign('projectids',$projectids); 	// project ids for drop down list
	$smarty->assign('today',date('Y.m.d')); 	// Todays date, default for registration
	$smarty->assign('name',$name);				// Username
	$smarty->display('index.tpl');
}
?>
