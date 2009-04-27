<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html><head>
<meta http-equiv="Content-Type" content="text/html; CHARSET=utf-8" />
<title>amaplibs test suite</title></head><body>
<?php

require_once 'amaplibtestcase.php';
require_once 'PHPUnit.php';

$suite  = new PHPUnit_TestSuite("AMAPLibsTest");
$result = PHPUnit::run($suite);

echo $result -> toHTML();
?>
</body></html>