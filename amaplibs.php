<?php
/*
$Id$

*/


function dataset(){
}

/* 
Makes an xtabbed table so that the rows are numbered 0,1... and all parameters are within the 'inner array'
*/ 
function normalize_xtab($xtab,$oldidx,$paras){
	$dataset=array();
	$min=1E35;
	$max=0;
	// Makes sure that all values are defined - moves year into the table, it used to be the main key
	foreach($xtab as $key=>$vals){
		$row=array($oldidx=>$key);
		foreach($paras as $head){
			$row[$head]=$xtab[$key][$head];
			$max=max($max,$row[$head]);
			
			$min=is_numeric($row[$head])?min($min,$row[$head]):$min;
		}
		$dataset[]=$row;
	}
	$dataset['min']=$min;
	$dataset['max']=$max;
	//debug(array($max,$min));
	return($dataset);
}


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

function xtab($dataset,$row,$col,$data,$invaliddata=false){
	// Does a basic cross-tabulation- removes data 
	foreach($dataset as $datarow){
		if(!$invaliddata){
			$xtab[$datarow[$row]][$datarow[$col]]=$datarow[$data];
		}else{
			// Numbers less than 0 indicates missing value
			$xtab[$datarow[$row]][$datarow[$col]]=$invaliddata($datarow[$data])?'':$datarow[$data]; 
		}
	}
	return $xtab; 
}