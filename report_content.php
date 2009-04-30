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

$menu=array(
	'source'=>'Sources'
	,'measure'=>'Measurements'
);
	
$smarty = new smarty_connect; // Sets up the standard connection to use smarty
$template='report00.tpl';
if(!($_COOKIE['username'] && $_COOKIE['userid'])){ 
	// Should have been logged on here but is not logged in, so we'll try (again)
	$smarty->assign('logonerror',$logonerror);
	$smarty->display('login.tpl');
}else{ // Start the real work
	//debug($_GET);
	try{
		$sql=createsql("select * from content_rep ",$_GET['para'],'content_rep',$database);
		$sql.=' order by year';
		$dataset=fetchset($sql,$_GET['val'],PDO::FETCH_ASSOC);
		//debug($dataset);
		// ='graph'){}
		$smarty->assign('mode',$_GET['mode']);
		switch($_GET['mode']){
		case 'download':
		case 'graph':
			$smarty->assign('error',$_GET['mode'].' - to be implemented');
			break;
		default:
			$smarty->assign('table','content');
			$smarty->assign('p',$dataset);
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