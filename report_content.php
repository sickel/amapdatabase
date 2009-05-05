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
	try{
		if(!($_GET)){
			$template='selectitems00.tpl';
			$nucs=fetchset('select distinct n.id,n.name from nuclide n, content c where nuclideid=n.id order by name','',PDO::FETCH_ASSOC,0,1);
			$srcs=fetchset('select distinct s.id,s.name from source s, content c where sourceid=s.id order by name','',PDO::FETCH_ASSOC,0,1);
			//debug($nucs);
			//debug($srcs);
			$smarty->assign('nucs',$nucs);
			$smarty->assign('srcs',$srcs);		
			throw new Exception('Out');
		}
		$para=array();
		$val=array();
		foreach($_GET as $k=>$v){ 
			if(is_array($v)){
				$para=array_merge($para,array_fill(0,count($v),$k));
				$val=array_merge($val,$v);
			}
		}
			
		$sql=createsql("select * from content_rep ",$para,'content_rep',$database);
		$sql.=' order by year';
		$dataset=fetchset($sql,$val,PDO::FETCH_ASSOC);
		//debug($dataset);
		// ='graph'){}
		$smarty->assign('mode',$_GET['mode']);
		switch($_GET['mode']){
		case 'download':
		case 'graph':
			$smarty->assign('error',$_GET['mode'].' - to be implemented');
			break;
		case 'crosstab':
			for($i=0;$i<count($para);$i++){
				$paraset[$para[$i]][]=$val[$i]; 
			}
			foreach($paraset as $key=>$val){
				if(count($val)>1){
					$group=$key; 
				}
			}
			if($group){ // if no groupling, falls through to the default
				foreach($dataset as $data){
					$xtab[$data['year']][$data[$group]]=$data['amount']>0?$data['amount']:''; // Numbers less than 0 indicates missing value
				}
				$dataset=array();
				foreach($xtab as $year=>$vals){
					$row=array('year'=>$year);
					foreach($paraset[$group] as $head){
						$row[$head]=$xtab[$year][$head];
					}
					$dataset[]=$row;
				}
				$row=array('','year');
				$row=array_merge($row,$paraset[$group]);
				$smarty->assign('tablehead',$row);
			}
		default:
			$smarty->assign('table','Content');
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