<?php
/*
$Id$

*/
function createid($name,$table){
/* 
Makes a text id based on name. 
uppercase string, non 7-bit characters translated,
spaces removed. A number from 0 and upwards inserted to make it unique
*/
	global $dbh;
	$name=strtoupper($name);
	$name=strtr($name,'ÆØÅÂÄÔÖ','EOAAAOO');
	$name=preg_replace('/\s+/','',$name);
	$i=0;
	$sql="select count(id) from $table where id = ? ";
	$sqlh=$dbh->prepare($sql);
	$exists=TRUE;
	while($exists){
		$name=substr($name,0,8-strlen($i));
		$id="$name$i";
		$i++;
		$sqlh->execute(array($id));
		$n=$sqlh->fetchAll();
		$exists=$n[0][0];
	}
	return($id);
}