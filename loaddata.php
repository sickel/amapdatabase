
<?php
include("${_SERVER['DOCUMENT_ROOT']}/libs/dblibs.php");
include("${_SERVER['DOCUMENT_ROOT']}/libs/conf.php");
include("${_SERVER['DOCUMENT_ROOT']}/libs/radecolibs.php");
require_once("${_SERVER['DOCUMENT_ROOT']}/libs/htmllibs.php");
htmlheader();
//debug($_FILES);
//debug($_POST);
if ($_FILES['uploadedfile']){
	$target_path = "uploads/";
	
	$target_path = $target_path . basename( $_FILES['uploadedfile']['name']); 
	if(!(move_uploaded_file($_FILES['uploadedfile']['tmp_name'], $target_path))) {
		print_p("There was an error uploading the file, please try again!");
	} else{
		print_p("The file ".  basename( $_FILES['uploadedfile']['name']). " has been uploaded");
		$handle=@fopen($target_path,'r');
		if ($handle) {
			$buffer= fgets($handle,1024);
			debug($buffer);
			$fields=split('"',$buffer);
			$table=$fields[1];
			debug($table);
			query_err("truncate table $table");
			$sqlroot="insert into $table values ";
			$sql=$sqlroot;
		    while (!feof($handle)) {
				$n++;$tot++;
				$sqlrow="";
		        $buffer = fgets($handle, 4096);
				$fields=split("\t",$buffer);
				if(count($fields) > 1){
					foreach($fields as $field){
						$field=$field =='\N'?'NULL':"'".mysql_real_escape_string($field)."'";
						$sqlrow.=$sqlrow?",$field":"($field";
					}
					$sqlrow.=')';
			        //print_p($sqlrow);
					if ($n<50 ){
						$sql.="$sqlrow,";
					}else{
						//print_p('So far so ');
						$sql.=$sqlrow;
						query_err($sql);
						$n=0;
						$sql=$sqlroot;
						//print_p ('good');
					}
				}
		    }
			$sql=substr($sql,0,-1);
			query_err($sql);
			print_p("$tot poster lastet opp");
			fclose($handle);
		}
	}
}
$buf=form(FORM_POST,'loaddata.php',FORM_UPLOAD,2000000);
$buf.=upload('Datafil','uploadedfile');
$buf.=submit('Lagre');
$buf.=form();
print $buf;
htmlfooter();
?>
