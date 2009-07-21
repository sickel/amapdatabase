<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">	
<?php

/*
$Id$
*/
define('ABSMAXITEMS',50000); // THe largest number of items that can be displayed in lists
require_once $_SERVER['DOCUMENT_ROOT'].'/../libs/dblibs.php';
require_once 'amaplibs.php';
require('./smarty/Smarty_Connect.php');
$setsize=$_GET['n']?$_GET['n']:30; // number of elements per page in list mode
$setsize=bracket($setsize,10,ABSMAXITEMS);
$nsub=$_GET['nsub']?$_GET['nsub']:30; // number of elements in a subtable
$nsub=bracket($nsub,10,ABSMAXITEMS);

$prefix='';
define('MAXFIELDSIZE',60); // Largest allowable size of a field
define('DEFFIELDSIZE',8);  
// Reads in tables
$sql='SELECT Table_name,table_comment FROM information_schema.`TABLES` T where table_schema=? and table_type="BASE TABLE" ';
$sql.=$prefix?" and table_name like '${prefix}%'":'and ! (table_name like "%\_%")';
$tableset=fetchset($sql,$database,PDO::FETCH_NUM);
foreach($tableset as $t){
	if(!(substr($t[1],0,2)=='__')){ // administrative tables are marked with __admin__
		$t[1]=preg_replace('/; Inno.*/','',$t[1]);
		$t[0]=preg_replace("/^$prefix/",'',$t[0]);
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
	$username=$_COOKIE['username'];
	$userid=$_COOKIE['userid'];
	$table=$_REQUEST['table']; // table and id may either come from  get /when going to a new record / or post, when updating a record
	$id=$_REQUEST['id'];
	try{
		if(!$table){
			$template='listtables.tpl';
			throw new Exception('Out');
		}
		if(!$tables[$table]){throw new Exception('Invalidtable');} // This should not happen unless someone is typing in table names directly
		$smarty->assign('tablename',$tables[$table]);
		$smarty->assign('table',$table);
		$smarty->assign('tableid',$tables[$table].'id');
		$tablefields=fetchset("show COLUMNS FROM ${prefix}$table",'');
		if($_POST['submitdata']=='Search'){
			$searchsql="select id, name from $prefix$table where true ";
			$nsql="select count(id) from $prefix$table where true ";
			$searchfields=array();
			$_POST['username']='';
			$sqltail='';
			foreach($tablefields as $field){
				if(strlen($_POST[$field['Field']])){
					$sqltail.="and ${field['Field']} like ? ";
					$searchfields[]=$_POST[$field['Field']];
				}
			}
			
			//debug($searchfields);
			$searchsql.=$sqltail;
			$nsql.=$sqltail;
			$_GET['mode']='list';
		}
		
		if($_GET['mode']=='list'){
		// TODO: Må kunne bla i resultater fra et søk. Detter over i hele tabellen nå.
			$nsql=$nsql?$nsql:"select count(id) n from ${prefix}$table";
			$ntot=fetchset($nsql,$searchfields,PDO::FETCH_NUM);
			//debug($ntot);
			$pages=ceil($ntot[0]/$setsize); 
			$offset=bracket($_GET['offset'],0,$ntot[0]);
			$activepage=floor($offset/$setsize);
			$first=bracket($activepage-1,1,bracket($pages-4,1,$pages));
			$last=bracket($first+4,1,$pages);
			if($first>1){$browsepages[]=1;}
			for($i=$first;$i<=$last;$i++){
				$browsepages[]=$i;
			}
			if($last<$pages-1){$browsepages[]=$pages;}
			$pagebrowser='';
			foreach($browsepages as $page){
				$pagebrowser.=$page-1==$activepage?"<span class=\"activepage\">[$page]</span>":sprintf('[<a href="'.$_SERVER['PHP_SELF'].'?mode=list&table=%s&offset=%s">%s</a>]',$table,($page-1)*$setsize,$page);
			}
			$smarty->assign('browse',$pagebrowser);
			for($i=$activepage-2;$i<=$activepage+2;$i++);
			$offset=$activepage*$setsize;
			$sql=$searchsql?$searchsql:listsql($prefix.$table,$offset,$setsize);
			//debug($sql);
			$data=fetchset($sql,$searchfields,PDO::FETCH_ASSOC,false);
			$template='listdata.tpl';
			$smarty->assign('p',$data);
			throw new Exception('Out');
		}
		$nfields=count($tablefields); // need to preset it, since we are manipulating the array inside the loop.Even though it should not matter, this will mess up the loop
		for($i=0;$i<$nfields;$i++){
			$len=DEFFIELDSIZE;
			if(strstr($tablefields[$i]['Type'],'char')){
				$len=trim($tablefields[$i]['Type'],'varch(');
				$len=rtrim($len,')')+1;
				$len=min($len,MAXFIELDSIZE); 
			}elseif($tablefields[$i]['Type']=='timestamp'){$len=17;
			}elseif($tablefields[$i]['Type']=='datetime'){$len=17;}
			
			$tablefields[$i]['length']=$len;
			$tablefields[$i]['Label']=$tablefields[$i]['Field']; // Removes the id also from the field name
			if(substr($tablefields[$i]['Field'],-2)=='id' and $tablefields[$i]['Field']!='id'){
				$tablefields[$i]['main']=substr($tablefields[$i]['Field'],0,-2);
				$tablefields[$i]['Label']=$tablefields[$i]['main']; // Removes the id also from the field name
			}
			// Presets a value for an added record this value will be overridden if an existing record is read in
			if($_GET["val_".$tablefields[$i]['Field']]) { 
				$tablefields[$i]['Value']=$_GET["val_".$tablefields[$i]['Field']];
			}
		}
		//debug($tablefields);
		if($_GET['mode']=='search'){
			$template='displaydata.tpl';
			$smarty->assign('p',$tablefields);
			$smarty->assign('mode',$_GET['mode']);
			throw new Exception('Out');
		}
		if($_POST['submitdata']=='Store'){
			$fieldlist='';	
			$update=strlen($id);
			if(!$update ){ // AMAPdb   -> must also check if id is numeric..
				if(strtolower(substr($tablefields[0]['Type'],0,4))=='char')
				{
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
				if(tableexists("${prefix}${table}_log",$database)){ // updates are to be logged, that is, the old version is stored with the current timestamp
					$sql="insert into ${prefix}${table}_log select null,t.*,null,'$username' from $prefix$table t where t.id=?";
					$sqlh=$dbh->prepare($sql);
					$sqlh->execute(array($id));
					$error=$sqlh->errorInfo();
					if($error[0]!='00000'){debug($error);}
				}
				$storedata[]=$id;
				
			}
			$sql=$update?"update $prefix$table set $fieldlist where id = ?":
				"insert into $prefix$table ($fieldlist) values ($vallist)";
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
/* 
	Reads in a record for display
*/

		if($id){
			$values=fetchset("select * from $prefix$table where id=?",$id);
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
				'first'=>"select min(id) from $prefix$table",
				'prev'=>"select id from $prefix$table where $sortfield < ? order by $sortfield desc limit 1 ",
				'next'=>"select id from $prefix$table where $sortfield > ? order by $sortfield asc limit 1 ",
				'last'=>"select max(id) from $prefix$table"
				);
		
		foreach($sqls as $key=>$sql){
			$goto=fetchset($sql,$recname);
			$subtab=$_GET['subtab']?"&subtab=${_GET['subtab']}":'';
			$b[$key]="$table&id=${goto[0]}$subtab";
		}
		$offset=fetchset("select count(id) from $prefix$table where $sortfield < ?",$recname);
		$b['list']="$table&offset=$offset[0]";
		$b['add']=$table;
		$smarty->assign('b',$b);
		
		$subtables=fetchset("SELECT table_name FROM information_schema.`COLUMNS` C where table_schema=? and column_name='${table}id' and table_name not like '%\_%' ",$database,PDO::FETCH_ASSOC,false);
//debug($tables);
		foreach($subtables as $tab){
			$ta=$tab['table_name'];
			if((substr($ta,-2)!='_e') and (substr($ta,-4)!='_log')){ // remove "expanded view" - like table but showing names rather than Ids,. This is what is to be shown.
				if(strpos($ta,$prefix)===0){$ta=substr($ta,strlen($prefix));}
				if($tables[$ta]){
					$subtablelist[$tables[$ta]]=$ta;
				}
				
			}
		}
		$smarty->assign('subtablelist',$subtablelist);
		$smarty->assign('id',$id);
		$smarty->assign('p',$tablefields);
		if(tableexists("${prefix}${table}_log",$database)){ // updates are to be logged, that is, the old version is stored with the current timestamp
			$sql="select max(logtime) from ${prefix}${table}_log where id=?";
			$last=fetchset($sql,$id,PDO::FETCH_NUM);
			$smarty->assign('last',$last[0]);
		}
		$template='displaydata.tpl';
		if($_GET['subtab']){
			$subtable=$prefix.$_GET['subtab'];
			$subtable_e="${subtable}_e"; // if a $subtable_e view exists, then we prefer to use that, if not we'll use the 'raw' table
			//debug($subtable_e);
			if(tableexists($subtable_e,$database)){
				$sql="select s.* from ${subtable_e} s,${subtable} m where m.${table}id=? and m.id=s.id";
			}else{
				$sql="select s.* from ${subtable} s where ${table}id=?";
			}
			//debug($sql);
			$sqlh=$dbh->prepare($sql);
			$sqlh->execute(array($id));
			
			$error=$sqlh->errorInfo();
			if($error[0]>'0'){throw new Exception("Subtable ${_GET['subtab']} does not exist");}
			$nrows=$sqlh->rowCount();
			if($nrows<=$nsub){
				$smarty->assign('subtable',$_GET['subtab']);
				$smarty->assign('sub',$sqlh->fetchAll(PDO::FETCH_ASSOC));
			}else{
				$exception=$nrows>ABSMAXITEMS?
					"More items ($nrows) than can be displayed (".ABSMAXITEMS.")":
					"Too many ($nrows) items in subtable <a href=\"data.php?${_SERVER['QUERY_STRING']}&nsub=$nrows\">Show all</a>";
				throw new Exception($exception);
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
		$smarty->assign('refbase',$_SERVER['PHP_SELF'].'?mode=list&table=');
	}else{
		//debug($tablefields);
		$smarty->assign('userid',$userid);  		// The userid, to be put away in a hidden field 
		$smarty->assign('today',date('Y.m.d')); 	// Todays date, default for registration
		$smarty->assign('name',$username);				// Username
	}
	$smarty->display($template);
}
?>
