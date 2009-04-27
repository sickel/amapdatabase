<?php

require_once 'amaplibs.php';
require_once $_SERVER['DOCUMENT_ROOT'].'/../libs/dblibs.php';
require_once 'PHPUnit.php';

// create a new instance of String with the
// string 'abc'

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
            }

    // called after the test functions are executed
    // this function is defined in PHPUnit_TestCase and overwritten
    // here
    function tearDown() {
        // delete your instance
		
    }
	
	function testcreateid_00(){
		$id=createid('ABCDEFG0');
		$this->assertTrue($id=='ABCDEFG0',$id);
	}
	
  }
?>