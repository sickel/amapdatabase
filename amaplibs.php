<?php

function createid($name,$table){
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
		//print_r($sqlh->errorInfo());
		$n=$sqlh->fetchAll();
		//print("|${n[0][0]}|");
		//print_r($n[0][0])
		$exists=$n[0][0];
	}
	return($id);
}