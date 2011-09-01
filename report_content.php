<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<?php

/*
$Id$
*/

function filter_crosstab($value){
// To be used to filter data  when crosstabbing
	return $value<0;
}



require_once $_SERVER['DOCUMENT_ROOT'].'/../libs/dblibs2.php';
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
	
}else{ // Start the real work
	try{
		if(!($_GET)){
			$template='selectitems00.tpl';
			$nucs=fetchset('select distinct n.id,n.name from nuclide n, content c where nuclideid=n.id order by name','',PDO::FETCH_ASSOC,0,1);
			$srcs=fetchset('select distinct s.id,s.name from source s, content c where sourceid=s.id order by name','',PDO::FETCH_ASSOC,0,1);
			$units=fetchset('select distinct u.unit as id,u.unit as name from unit u, content c where c.unit=u.relunit order by name','',PDO::FETCH_ASSOC,0,1);
			$units['0']='&nbsp;';
			//debug($units);
			$smarty->assign('nucs',$nucs);
			$smarty->assign('srcs',$srcs);		
			$smarty->assign('units',$units);
			throw new Exception('Out');
		}
		$units=fetchset('select distinct u.unit,u.relunit,u.factor from unit u, content c where c.unit=u.relunit order by name','',PDO::FETCH_ASSOC,0);
		foreach($units as $id=>$u){
			// To make sure that nothing is forgotten, use the factors both ways
			$units[$u['unit']][$u['relunit']]=$u['factor'];
			$units[$u['relunit']][$u['unit']]=1/$u['factor'];
			$units[$u['unit']][$u['unit']]=1;
			$units[$u['relunit']][$u['relunit']]=1;
			unset($units[$id]);
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
		$dataset=fetchset($sql,$val,PDO::FETCH_ASSOC,0);
		$unit=False;
		if($_GET['unitid'] and $units[$_GET['unitid']][$_GET['unitid']]){
			$unit=$_GET['unitid'];
			foreach($dataset as $i=>$row){
				$dataset[$i]['unit']=$unit;
				$dataset[$i]['amount']=$row['amount']/$units[$row['unit']][$unit];
			}
		}
		$smarty->assign('mode',$_GET['mode']);
		switch($_GET['mode']){
		case 'download':
			throw new Exception($_GET['mode'].' - to be implemented');
			break;
		case 'graph':
			$template='contentgraph.tpl';
			$smarty->assign('get',$_SERVER['QUERY_STRING']);
			$smarty->assign('xtabquery',str_replace('mode=graph','mode=crosstab',$_SERVER['QUERY_STRING']));
			break;
		case 'crosstab':
			$smarty->assign('graphquery',str_replace('mode=crosstab','mode=graph',$_SERVER['QUERY_STRING']));
			if(!$unit){
				throw new Exception('Cannot do cross-tabulation without a defined unit');
			}
			for($i=0;$i<count($para);$i++){
				$paraset[$para[$i]][]=$val[$i]; 
			}
			foreach($paraset as $key=>$val){
				if(count($val)>1){
					$group=$key;
					$ngroup++;
				}elseif(is_array($val)){
					$headgroup=$val[0];
				}
			}
			if($ngroup>1){throw new Exception('Can only crosstab on one parameter');}
			if($group){ // if no groupling, falls through to the default
				$crosstabbed=true;
				$dataset=normalize_xtab(xtab($dataset,'year',$group,'amount','filter_crosstab'),'year',$paraset[$group]); 
				//debug($paraset[$group]);
				//debug($dataset[1]);
				$row=array('','year');
				$row=array_merge($row,$paraset[$group]);
				$smarty->assign('tablehead',$row);
			}
			
			
		default:
			$smarty->assign('p',$dataset);
		}
		$smarty->assign('table',"content");
		$smarty->assign('header',"Content $headgroup ($unit)");
			
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
