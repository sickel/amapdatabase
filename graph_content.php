<?php

/*
$Id$
*/

function filter_crosstab($value){
// To be used to filter data  when crosstabbing
	return $value<0;
}
header("Content-type: image/png");


require_once $_SERVER['DOCUMENT_ROOT'].'/../libs/dblibs.php';
require_once 'amaplibs.php';
$prefix='amap_';
// Reads in tables
	
if(!($_COOKIE['username'] && $_COOKIE['userid'])){ 
	// Should have been logged on here but is not logged in, so we'll try (again)
			throw new Exception('Not Logged In');	
}
try{
	if(!($_GET)){
		throw new Exception('Need parameters');
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
	}else{
		throw new Exception('Need unit');
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
	//debug($dataset);
	}else{throw new Exception('Need something to crosstab on');}
	//debug(count($dataset));
	//debug($dataset);
	$min_y=$dataset['min'];
	unset($dataset['min']);
	$max_y=$dataset['max']*1.02; // multiply to get some space at the top
	unset($dataset['max']);
	$max_x=count($dataset);
	$min_x=0;
	include('imagesettings.php');
	$x_title = 'year';
	$y_title = $unit;
    $avg_y = 0.0;
	$max_y=ceil($max_y);
	$graph_n=$max_x;
	//throw new Exception($graph_n);
	$avg_y = array_sum($spectre)/$graph_n;	
	$image = ImageCreate($right - $left, $bottom - $top);
	$background_color = imagecolorallocate($image, 255, 255, 255);
	$text_color = imagecolorallocate($image, 233, 14, 91);

	$grey = ImageColorAllocate($image, 204, 204, 204);
	$white = imagecolorallocate($image, 255, 255, 255);
	$black = imagecolorallocate($image, 0, 0, 0);
	$red = imagecolorallocate($image, 255, 0, 0);
	$kerning=1.2;
	$leg_width=100;
	$line=$char_height*$kerning;
	$divider=$_GET['divider']*1?$_GET['divider']:10;
	for($i = 1; $i < $graph_n; $i++ ) // Plotting years and vertical guide lines
		{
			$string=$dataset[$i]['year'];
			if(!($string%$divider)){ 
			$pt_x = $x_start + ($x_end-$x_start)*($i-$min_x)/($max_x-$min_x);
			$pt_y = $y_end+$char_height*$kerning;
			imagestring($image,4,$pt_x-2*$char_width,$pt_y,$string,$black);
			imageline($image,$pt_x,$pt_y-$line*0.5 ,$pt_x,$y_start,$black); // Vertical guide line
			}
		}
	
//	throw new Exception('huh');
	//syslog(LOG_WARNING,"min: ".min($graph_h));
	
	if ($setlog){
		$ymax=pow(10,$max_y);
		$ymin=pow(10,$min_y);
	}else{
		$ymax=sprintf("%2.5f", $max_y);
		$ymin=sprintf("%2.5f", $min_y);
	}
	imagestring($image, 4, $x_start + ($x_end - $x_start) / 2 - strlen($x_title) * $char_width / 2, $y_end+$char_height*$kerning*2, $x_title, $black);
	imagestring($image, 4, $char_width, ($y_end - $y_start) / 2, $y_title, $black);
	if($setlog){ // Horisontale hjelpelinjer
		for ($i=$min_y;$i<=$max_y;$i++){
			$pt_y = $y_end - ($y_end - $y_start)*($i-$min_y)/($max_y-$min_y);
			imageline($image,$x_start,$pt_y,$x_end,$pt_y,$grey);
			$string=pow(10,$i);
			imagestring($image, 4, $x_start - (1+strlen($string)) * $char_width, $pt_y - $char_width, $string, $black);
		}
	}else{
		$oom=pow(10,floor(log10($max_y-$min_y))); // Order of magnitude
		$minmark=floor($min_y/$oom);
		$maxmark=floor($max_y/$oom);
		if(($maxmark-$minmark)<4){
			$maxmark*=2;
			$minmark*=2;
			$oom/=2;
		}
		for($i=$minmark;$i<=$maxmark;$i++){ 
			$val=$i*$oom;
			$pt_y = $y_end - ($y_end - $y_start)*($val-$min_y)/($max_y-$min_y);
			imageline($image,$x_start,$pt_y,$x_end,$pt_y,$grey); 
			$string=$i*$oom;
			imagestring($image, 4, $x_start - (1+strlen($string)) * $char_width, $pt_y - $char_width, $string, $black);
		}
		// TODO lag -liner ved 
		$leg_start=$_GET['legstart']*1?$_GET['legstart']*1:50;
	if($leg_start<0){
		$leg_start=$leg_start+$x_size-60;
	}
	$legend_box=array($right-($leg_width+$leg_start),30,$right-$leg_start,50+$char_height*$kerning*count($paraset[$group]));
	imagerectangle($image, $left, $top, $right - 1, $bottom - 1, $black );
	imagerectangle($image, $x_start, $y_start, $x_end, $y_end, $grey );
	imagefilledrectangle($image,$legend_box[0],$legend_box[1],$legend_box[2],$legend_box[3],$white);
	imagerectangle($image,$legend_box[0],$legend_box[1],$legend_box[2],$legend_box[3],$black);
	
	$leg_line=$char_height;
	$leg_line_offset=5;
	$leg_line_length=15;
	$oldpt_x=false;
	foreach($paraset[$group] as $par){ // plotting graph
		$color=imagecolorallocate($image,rand(0,255),rand(0,255),rand(0,255));
		for($i = 1; $i < $graph_n; $i++ )
		{
			if(strlen($dataset[$i][$par])){
				$pt_x = $x_start + ($x_end-$x_start)*($i-$min_x)/($max_x-$min_x);
				$pt_y = $y_end - ($y_end - $y_start)*($dataset[$i][$par]-$min_y)/($max_y-$min_y);
				imagerectangle($image,$pt_x-1,$pt_y-1,$pt_x+1,$pt_y+1,$color);
				// imagestring($image,3,$pt_x,$pt_y,$dataset[$i][$par],$black);
				if($oldpt_x){
					imageline($image,$oldpt_x,$oldpt_y,$pt_x,$pt_y,$color);
				}
				$oldpt_x=$pt_x;
				$oldpt_y=$pt_y;
			}else{
				$oldpt_x=false;
			}
		}
		$leg_line_x=$legend_box[1]+$leg_line+$char_height/2*$kerning;
		imageline($image,$legend_box[0]+$leg_line_offset,$leg_line_x,$legend_box[1]+$legend_box[0]+$leg_line_offset+$leg_line_length,$leg_line_x,$color);
		imagestring($image,4,$legend_box[0]+$leg_line_offset*2+$leg_line_length*3,$leg_line_x-$char_height*$kerning/2,$par,$black);
		$leg_line+=$char_height*$kerning;
		$oldpt_x=false; 
	}

	imagepng($image);
	}		
}
catch(Exception $e){
	$image = ImageCreate(400, 50);
	$bg = imagecolorallocate($image, 255, 255, 255);
	$red = imagecolorallocate($image, 255, 0, 0);
	$string=$e->getMessage();
	imagestring($image,4,4,10,$string,$red);
	imagepng($image);
}