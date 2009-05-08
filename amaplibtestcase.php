<?php
/*
$Id$

*/
require_once 'amaplibs.php';
require_once 'PHPUnit.php';

// create a new instance of String with the
// string 'abc'
$dbh='';
class AMAPLibsTest extends PHPUnit_TestCase
{
	
	// constructor of the test suite
    function AMAPLibsTest($name) {
       $this->PHPUnit_TestCase($name);
    }

    // called before the test functions will be executed
    // this function is defined in PHPUnit_TestCase and overwritten
    // here
    function setUp() {
		global $dbh;
		try{
			$connectstring='mysql:host=localhost;dbname=test';
			//'mysql:host=localhost;dbname=radioecology'
			$dbh = new PDO($connectstring, 'apache', 'apache');
			$dbh->exec('truncate amaptest');
		}
		catch(PDOException $e){
			$database=$e->getMessage(); 
			exit( "<p>Cannot connect $database</p>");		
		}
	}

    // called after the test functions are executed
    // this function is defined in PHPUnit_TestCase and overwritten
    // here
    function tearDown() {
        // delete your instance
		
    }
	
	function testcreateid_00(){
		$id=createid('ABCDEFG0','amaptest');
		$this->assertTrue($id=='ABCDEFG0',$id);
	}
	
	function testcreateid_01(){
		$id=createid('ABC DEFG0','amaptest');
		$this->assertTrue($id=='ABCDEFG0',$id);
	}
	
	function testcreateid_02(){
		$id=createid('ABCDEFGH','amaptest');
		$this->assertTrue($id=='ABCDEFG0',$id);
	}
	
	function testcreateid_03(){
		$id=createid('abcdefgh','amaptest');
		$this->assertTrue($id=='ABCDEFG0',$id);
	}
	
	function testcreateid_04(){
		global $dbh;
		$dbh->exec("insert into amaptest (id,name) values('ABCDEFG0','test')");
		$id=createid('ABCDEFG0','amaptest');
		$this->assertTrue($id=='ABCDEFG1',$id);
	}
	function testcreateid_05(){
		$id=createid('ABCDEFH','amaptest');
		$this->assertTrue($id=='ABCDEFH0',$id);
	}
	function testcreateid_06(){
		global $dbh;
		for($i=0;$i<10;$i++){
			$dbh->exec("insert into amaptest (id,name) values('ABCDEFG$i','test')");
		}
		$id=createid('ABCDEFG','amaptest');
		$this->assertTrue($id=='ABCDEF10',$id);
	}
	
	function testcreateid_07(){
		$id=createid('ÆØÅ','amaptest');
		$this->assertTrue($id=='EOA0',$id);
	}
	function testcreateid_08(){
		global $dbh;
		$id=createid('ÆØÅ','amaptest');
		$dbh->exec("insert into amaptest (id,name) values('$id','test')");
		$id=createid('ÆØÅ','amaptest');
		$this->assertTrue($id=='EOA1',$id);
	}
  }
?>