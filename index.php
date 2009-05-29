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
		if($_POST['password1']!=$_POST['password2']){throw new Exception('New passwords doesn\'t match');} 
		$sqlh=$dbh->prepare("update ${prefix}user set password=md5(?) where id=? and password=md5(?)");
		$params=array($_POST['password1'],$_COOKIE['userid'],$_POST['oldpassword']);
		$sqlh->execute($params);
		// If no rows are affected, the old password is probably wrong. Might also be a problem with the user id from the coockie, but that is not as probable
		if(!$sqlh->rowCount()){throw new Exception('Could not update, old password might be wrong');} 
		$smarty->assign('headercomment','Password changed');
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
	try{
		logon();
	}
	catch(Exception $e){
		$logonerror="<p><b>Ukjent brukernavn eller passord</b></p>";
	}
}	
if(!($_COOKIE['username'] && $_COOKIE['userid'])){
	// Should have been logged on here but is not logged in, so we'll try (again)
	$smarty->assign('logonerror',$logonerror);
	$smarty->assign('action',$_SERVER['PHP_SELF'].'?'.$_SERVER['QUERY_STRING']);
	$smarty->display('login.tpl');
}elseif(!$_GET['newpass']){ // Start the real work
	$name=$_COOKIE['username'];
	$year=date('Y');
	$userid=$_COOKIE['userid'];	
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
