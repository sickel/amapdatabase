<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">	
<?php
require_once $_SERVER['DOCUMENT_ROOT'].'/../libs/dblibs.php';
require_once 'amaplibs.php';
require('./smarty/Smarty_Connect.php');
$setsize=$_GET['n']?$_GET['n']:30; // number of elements per page in list mode
$setsize=bracket($setsize,10,501);
$prefix='amap_';
define('MAXFIELDSIZE',60); // Largest allowable size of a field
define('DEFFIELDSIZE',8);  
// Reads in tables
$sql='SELECT Table_name,table_comment FROM information_schema.`TABLES` T where table_schema=? and table_type="BASE TABLE" and ! (table_name like "%\_%")';
$tableset=fetchset($sql,$database,PDO::FETCH_NUM);

foreach($tableset as $t){
	if(!(substr($t[1],0,2)=='__')){ // administrative tables are marked with __admin__
		$tables[$t[0]]=$t[1]?$t[1]:$t[0]; // Makes an array table_name => table_comment if table_comment is defined, else table_name => table_name
	}
}
$smarty = new smarty_connect; // Sets up the standard connection to use smarty
$template='listtables.tpl';
if(!($_COOKIE['username'] && $_COOKIE['userid'])){ 
	// Should have been logged on here but is not logged in, so we'll try (again)
	$smarty->assign('logonerror',$logonerror);
	$smarty->display('login.tpl');
}else{ // Start the real work
	$name=$_COOKIE['username'];
	$userid=$_COOKIE['userid'];
	$table=$_REQUEST['table']; // table and id may either come from  get /when going to a new record / or post, when updating a record
	$id=$_REQUEST['id'];
	try{
		if(!$table){
			$template='listtables.tpl';
			throw new Exception('Out');
		}
		if(!$tables[$table]){throw new Exception('Invalidtable');} // This should not happen unless someone is typing in table names directly
		$smarty->assign('table',$tables[$table]);
		$smarty->assign('tableid',$tables[$table].'id');
		
		if($_GET['mode']=='list'){
			$ntot=fetchset("select count(id) n from $table",'',PDO::FETCH_NUM);
			$pages=ceil($ntot[0]/$setsize); 
			$offset=bracket($_GET['offset'],0,$ntot[0]);
			$activepage=ceil($offset/$setsize);
			$first=bracket($activepage-1,1,bracket($pages-4,1,$pages));
			$last=bracket($first+4,1,$pages);
			if($first>1){$browsepages[]=1;}
			for($i=$first;$i<=$last;$i++){
				$browsepages[]=$i;
			}
			if($last<$pages-1){$browsepages[]=$pages;}
			$pagebrowser='';
			foreach($browsepages as $page){
				$pagebrowser.=$page-1==$activepage?"<span class=\"activepage\">[$page]</span>":sprintf('[<a href="data.php?mode=list&table=%s&offset=%s">%s</a>]',$table,($page-1)*$setsize,$page);
			}
			$smarty->assign('browse',$pagebrowser);
			for($i=$activepage-2;$i<=$activepage+2;$i++);
			$offset=$activepage*$setsize;
			$sql=listsql($table,$offset,$setsize);
			$data=fetchset($sql,'',PDO::FETCH_ASSOC);
			$template='listdata.tpl';
			$smarty->assign('p',$data);
			throw new Exception('Out');
		}
		$tablefields=fetchset("show COLUMNS FROM $table",'');
		//debug($tablefields);
		$nfields=count($tablefields); // need to preset it, since we are manipulating the array inside the loop.Even though it should not matter, this will mess up the loop
		for($i=0;$i<$nfields;$i++){
			$len=DEFFIELDSIZE;
			if(strstr($tablefields[$i]['Type'],'char')){
				$len=trim($tablefields[$i]['Type'],'varch(');
				$len=rtrim($len,')');
				$len=min($len,MAXFIELDSIZE); 
			}elseif($tablefields[$i]['Type']=='timestamp'){$len=17;}
			$tablefields[$i]['length']=$len;
			if(substr($tablefields[$i]['Field'],-2)=='id'){
				$tablefields[$i]['main']=substr($tablefields[$i]['Field'],0,-2);
			}
		}
		if($_POST['submitdata']=='Store'){
			$fieldlist='';
			
			$update=strlen($id);
			if(!$update){
				if($_POST['name']){
					$id=createid($_POST['name'],$table);
					$_POST['id']=$id;
				}
			}
			
			for($n=0;$n<$nfields;$n++){
				$f=$tablefields[$n];
				//debug($f);
				$fn=$f['Field'];
				if($f['Type']=='tinyint(1)'){
					$_POST[$fn]=$_POST[$fn]=='on'?1:0;
				}
				$storedata[]=$_POST[$fn]!=''?$_POST[$fn]:NULL;
				$fieldlist.=$fieldlist?',':'';
				if(!$update){ // new record
					$vallist.=$vallist?',':'';
					$fieldlist.=$fn;
					$vallist.='?';
				}else{
					$fieldlist.="$fn=?";
				}
			}
			//debug($storedata);
			//debug($sql);	
			if($update){
				if(tableexists("${table}_log",$database)){ // updates are to be logged, that is, the old version is stored with the current timestamp
					$logfields=$storedata;
					array_unshift($logfields,null);
					$logfields[]=null;
					$logfields[]=$name;
					$sql="insert into ${table}_log values(?".str_repeat(',?',count($logfields)-1).')';
					$sqlh=$dbh->prepare($sql);
					$sqlh->execute($logfields);
					$error=$sqlh->errorInfo();
					if($error[0]!='00000'){debug($error);}
				}
				$storedata[]=$id;
				
			}
			$sql=$update?"update $table set $fieldlist where id = ?":
				"insert into $table ($fieldlist) values ($vallist)";
			$inserth=$dbh->prepare($sql);
			$inserth->execute($storedata);
			$error=$inserth->errorInfo();
			if($error[0]!='00000'){debug($error);}
			else{$status='<p class="Status">Update OK</p>';}// La denne stå!
			if (!$id){
				$last=fetchset('select  LAST_INSERT_ID()');
				$id=$last[0];
			}
		}	
		if($id){
			$values=fetchset("select * from $table where id=?",$id);
			//debug($values);
			for($i=0;$i<$nfields;$i++){
				//$tablefields[$i]['Value']=utf8_encode($values[$i]); 
				$tablefields[$i]['Value']=$values[$i];
				if ($tablefields[$i]['Field']=='name'){
					$recname=$tablefields[$i]['Value'];
				}
			}
			//debug($recname);
			//debug($tablefields);
		}
		if(fieldexists('name',$table,$database)){
			$sortfield='name';
		}else{
			$sortfield='id';
			$recname=$id;
		}
		$recname=$recname?$recname:'1'; // record to look up. Set to 1 if no ID is set.
		$sqls=array(
				'<<-'=>"select min(id) from $table",
				'<-'=>"select id from $table where $sortfield < ? order by $sortfield desc limit 1 ",
				'->'=>"select id from $table where $sortfield > ? order by $sortfield asc limit 1 ",
				'->>'=>"select max(id) from $table"
				);
		
		$browse='|';
		foreach($sqls as $key=>$sql){
			$goto=fetchset($sql,$recname);
			$subtab=$_GET['subtab']?"&subtab=${_GET['subtab']}":'';
			$browse.=" <a href=\"data.php?table=$table&id=${goto[0]}$subtab\">$key</a> |";
		}
		
		$offset=fetchset("select count(id) from $table where $sortfield < ?",$recname);
		$browse.=" <a href=\"data.php?table=$table&offset=$offset[0]&mode=list\">List</a> |";
		$browse.=" <a href=\"data.php?table=$table&amp;id=0\">Add</a> |</p>";
		$browse.='<p>';
		$tables=fetchset("SELECT table_name FROM information_schema.`COLUMNS` C where table_schema=? and column_name='${table}id' and table_name not like '%\_%' ",$database,PDO::FETCH_ASSOC,false);
//debug($tables);
		foreach($tables as $tab){
			$ta=$tab['table_name'];
			$browse.=sprintf('%s |<a href="data.php?table=%s">browse</a>|<a href="data.php?table=%s&subtab=%s&id=%s">subtable</a>|<br />',$ta,$ta,$table,$ta,$id);
		}
		$browse.='</p>';
		$smarty->assign('browse',$browse);		
		$smarty->assign('p',$tablefields);
		$template='displaydata.tpl';
		if($_GET['subtab']){
			$subtable="${_GET['subtab']}_e"; // if a $subtable_e view exists, then we prefer to use that, if not we'll use the 'raw' table
			if(tableexists($subtable)){
				$sql="select s.* from $subtable s,${_GET['subtab']} m where m.${table}id=? and m.id=s.id";
			}else{
				$sql="select s.* from ${_GET['subtab']} s where ${table}id=?";
			}
			//debug($sql);
			$sqlh=$dbh->prepare($sql);
			$sqlh->execute(array($id));
			
			$error=$sqlh->errorInfo();
			if($error[0]>'0'){throw new Exception("Subtable ${_GET['subtab']} does not exist");}
			$nrows=$sqlh->rowCount();
			if($nrows<=$setsize){
				$smarty->assign('subtable',$_GET['subtab']);
				$smarty->assign('sub',$sqlh->fetchAll(PDO::FETCH_ASSOC));
			}else{
				throw new Exception("Too many items ($nrows)");
			}
		}
		
	}
	catch(Exception $e){
		$errormsg=$e->getMessage();
		$smarty->assign('error',$errormsg=='Out'?'':$errormsg);
	}
//	debug($p);
	if($template=='listtables.tpl'){
		$smarty->assign('tables',$tables);
	}else{
		//debug($tablefields);
		$smarty->assign('userid',$userid);  		// The userid, to be put away in a hidden field 
		$smarty->assign('today',date('Y.m.d')); 	// Todays date, default for registration
		$smarty->assign('name',$name);				// Username
	}
	$smarty->display($template);
}
?>
