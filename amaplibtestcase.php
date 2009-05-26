<?php
/*
$Id$

*/

function filter($data){
// To be used to filter data  when crosstabbing
	return $data!==-1;
}

require_once 'amaplibs.php';
require_once 'PHPUnit.php';

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
		$this->assertTrue($id=='OOOAOO0',$id); // Må rettes opp
	}
	function testcreateid_08(){
		global $dbh;
		$id=createid('ÆØÅ','amaptest');
		$dbh->exec("insert into amaptest (id,name) values('$id','test')");
		$id=createid('ÆØÅ','amaptest');
		$this->assertTrue($id=='OOOAOO1',$id); // Må rettes opp
	}
	
	function testxtab_00(){
		$table=array(
			array('y'=>1,'n'=>'a','a'=>1),
			array('y'=>2,'n'=>'a','a'=>2),
			array('y'=>3,'n'=>'a','a'=>3),
			array('y'=>1,'n'=>'b','a'=>4),
			array('y'=>2,'n'=>'b','a'=>5),
			array('y'=>3,'n'=>'b','a'=>6),
			array('y'=>1,'n'=>'c','a'=>7),
			array('y'=>2,'n'=>'c','a'=>8),
			array('y'=>3,'n'=>'c','a'=>9)
		);
		$testtab[1]['a']=1;
		$testtab[2]['a']=2;
		$testtab[3]['a']=3;
		$testtab[1]['b']=4;
		$testtab[2]['b']=5;
		$testtab[3]['b']=6;
		$testtab[1]['c']=7;
		$testtab[2]['c']=8;
		$testtab[3]['c']=9;
		$xtab=xtab($table,'y','n','a');
		$diff=array_diff($xtab,$testtab);
		$this->assertFalse(count($diff),$diff);
	}
	function testxtab_01(){
		$table=array(
			array('y'=>1,'n'=>'a','a'=>-1),
			array('y'=>2,'n'=>'a','a'=>2),
			array('y'=>3,'n'=>'a','a'=>3),
			array('y'=>1,'n'=>'b','a'=>4),
			array('y'=>2,'n'=>'b','a'=>5),
			array('y'=>3,'n'=>'b','a'=>6),
			array('y'=>1,'n'=>'c','a'=>7),
			array('y'=>2,'n'=>'c','a'=>8),
			array('y'=>3,'n'=>'c','a'=>9)
		);
		$testtab[1]['a']='';
		$testtab[2]['a']=2;
		$testtab[3]['a']=3;
		$testtab[1]['b']=4;
		$testtab[2]['b']=5;
		$testtab[3]['b']=6;
		$testtab[1]['c']=7;
		$testtab[2]['c']=8;
		$testtab[3]['c']=9;
		$xtab=xtab($table,'y','n','a',$filter);
		$diff=array_diff($xtab,$testtab);
		$this->assertFalse(count($diff),$diff);
	}	
	function testxtab_02(){
		$table=array(
			array('y'=>1,'n'=>'a','a'=>false),
			array('y'=>2,'n'=>'a','a'=>2),
			array('y'=>3,'n'=>'a','a'=>3),
			array('y'=>1,'n'=>'b','a'=>4),
			array('y'=>2,'n'=>'b','a'=>5),
			array('y'=>3,'n'=>'b','a'=>6),
			array('y'=>1,'n'=>'c','a'=>7),
			array('y'=>2,'n'=>'c','a'=>8),
			array('y'=>3,'n'=>'c','a'=>9)
		);
		$testtab[1]['a']='';
		$testtab[2]['a']=2;
		$testtab[3]['a']=3;
		$testtab[1]['b']=4;
		$testtab[2]['b']=5;
		$testtab[3]['b']=6;
		$testtab[1]['c']=7;
		$testtab[2]['c']=8;
		$testtab[3]['c']=9;
		$xtab=xtab($table,'y','n','a');
		$diff=array_diff($xtab,$testtab);
		$this->assertFalse(count($diff),$diff);
	}	
	function testxtab_03(){
		$table=array(
			array('y'=>1,'n'=>'a','a'=>0),
			array('y'=>2,'n'=>'a','a'=>2),
			array('y'=>3,'n'=>'a','a'=>3),
			array('y'=>1,'n'=>'b','a'=>4),
			array('y'=>2,'n'=>'b','a'=>5),
			array('y'=>3,'n'=>'b','a'=>6),
			array('y'=>1,'n'=>'c','a'=>7),
			array('y'=>2,'n'=>'c','a'=>8),
			array('y'=>3,'n'=>'c','a'=>9)
		);
		$testtab[1]['a']=0;
		$testtab[2]['a']=2;
		$testtab[3]['a']=3;
		$testtab[1]['b']=4;
		$testtab[2]['b']=5;
		$testtab[3]['b']=6;
		$testtab[1]['c']=7;
		$testtab[2]['c']=8;
		$testtab[3]['c']=9;
		$xtab=xtab($table,'y','n','a');
		$diff=array_diff($xtab,$testtab);
		$this->assertFalse(count($diff),$diff);
	}	
	function testxtab_04(){
		$table=array(
			array('y'=>1,'n'=>'a','a'=>0),
			array('y'=>2,'n'=>'a','a'=>2),
			array('y'=>3,'n'=>'a','a'=>3),
			array('y'=>1,'n'=>'b','a'=>4),
			array('y'=>2,'n'=>'b','a'=>5),
			array('y'=>3,'n'=>'b','a'=>6),
			array('y'=>1,'n'=>'c','a'=>7),
			array('y'=>2,'n'=>'c','a'=>8),
			array('y'=>3,'n'=>'c','a'=>9)
		);
		$testtab[1]['a']=0;
		$testtab[2]['a']=2;
		$testtab[3]['a']=3;
		$testtab[1]['b']=4;
		$testtab[2]['b']=5;
		$testtab[3]['b']=6;
		$testtab[1]['c']=7;
		$testtab[2]['c']=8;
		$testtab[3]['c']=9;
		$xtab=xtab($table,'y','n','a',$filter);
		$diff=array_diff($xtab,$testtab);
		$this->assertFalse(count($diff),$diff);
	}				
		function testxtab_05(){
		$table=array(
			array('y'=>1,'n'=>'a','a'=>-2),
			array('y'=>2,'n'=>'a','a'=>2),
			array('y'=>3,'n'=>'a','a'=>3),
			array('y'=>1,'n'=>'b','a'=>4),
			array('y'=>2,'n'=>'b','a'=>5),
			array('y'=>3,'n'=>'b','a'=>6),
			array('y'=>1,'n'=>'c','a'=>7),
			array('y'=>2,'n'=>'c','a'=>8),
			array('y'=>3,'n'=>'c','a'=>9)
		);
		$testtab[1]['a']=-2;
		$testtab[2]['a']=2;
		$testtab[3]['a']=3;
		$testtab[1]['b']=4;
		$testtab[2]['b']=5;
		$testtab[3]['b']=6;
		$testtab[1]['c']=7;
		$testtab[2]['c']=8;
		$testtab[3]['c']=9;
		$xtab=xtab($table,'y','n','a');
		$diff=array_diff($xtab,$testtab);
		$this->assertFalse(count($diff),$diff);
	}	
	function testxtab_06(){
		$table=array(
			array('y'=>1,'n'=>'a','a'=>'-1'),
			array('y'=>2,'n'=>'a','a'=>2),
			array('y'=>3,'n'=>'a','a'=>3),
			array('y'=>1,'n'=>'b','a'=>4),
			array('y'=>2,'n'=>'b','a'=>5),
			array('y'=>3,'n'=>'b','a'=>6),
			array('y'=>1,'n'=>'c','a'=>7),
			array('y'=>2,'n'=>'c','a'=>8),
			array('y'=>3,'n'=>'c','a'=>9)
		);
		$testtab[1]['a']='-1';
		$testtab[2]['a']=2;
		$testtab[3]['a']=3;
		$testtab[1]['b']=4;
		$testtab[2]['b']=5;
		$testtab[3]['b']=6;
		$testtab[1]['c']=7;
		$testtab[2]['c']=8;
		$testtab[3]['c']=9;
		$xtab=xtab($table,'y','n','a');
		$diff=array_diff($xtab,$testtab);
		$this->assertFalse(count($diff),$diff);
	}	
	
	function testxtab_07(){
		$table=array(
			array('y'=>1,'n'=>'a','a'=>'-1'),
			array('y'=>2,'n'=>'a','a'=>2),
			array('y'=>4,'n'=>'a','a'=>3),
			array('y'=>1,'n'=>'b','a'=>4),
			array('y'=>2,'n'=>'b','a'=>5),
			array('y'=>4,'n'=>'b','a'=>6),
			array('y'=>1,'n'=>'c','a'=>7),
			array('y'=>2,'n'=>'c','a'=>8),
			array('y'=>4,'n'=>'c','a'=>9)
		);
		$testtab[1]['a']='-1';
		$testtab[2]['a']=2;
		$testtab[4]['a']=3;
		$testtab[1]['b']=4;
		$testtab[2]['b']=5;
		$testtab[4]['b']=6;
		$testtab[1]['c']=7;
		$testtab[2]['c']=8;
		$testtab[4]['c']=9;
		$xtab=xtab($table,'y','n','a');
		$diff=array_diff($xtab,$testtab);
		$this->assertFalse(count($diff),$diff);
	}	
	function testxtab_08(){
		$table=array(
			array('y'=>1,'n'=>'a','a'=>'-1'),
			array('y'=>2,'n'=>'a','a'=>2),
			array('y'=>4,'n'=>'a','a'=>3),
			array('y'=>1,'n'=>'b','a'=>4),
			array('y'=>2,'n'=>'b','a'=>5),
			array('y'=>4,'n'=>'b','a'=>6),
			array('y'=>1,'n'=>'c','a'=>7),
			array('y'=>2,'n'=>'c','a'=>8),
			array('y'=>4,'n'=>'c','a'=>9)
		);
		$testtab[1]['a']='-1';
		$testtab[2]['a']=2;
		$testtab[3]['a']='';
		$testtab[4]['a']=3;
		$testtab[1]['b']=4;
		$testtab[2]['b']=5;
		$testtab[3]['b']='';
		$testtab[4]['b']=6;
		$testtab[1]['c']=7;
		$testtab[2]['c']=8;
		$testtab[3]['c']='';
		$testtab[4]['c']=9;
		$xtab=xtab($table,'y','n','a',false,true);
		$diff=array_diff($xtab,$testtab);
		$this->assertFalse(count($diff),$diff);
	}
	function testxtabnorm_00(){
		$testtab[1]['a']='-1';
		$testtab[2]['a']=2;
		$testtab[3]['a']=3;
		$testtab[1]['b']=4;
		$testtab[2]['b']=5;
		$testtab[3]['b']=6;
		$testtab[1]['c']=7;
		$testtab[2]['c']=8;
		$testtab[3]['c']=9;
		$norm=normalize_xtab($testtab,'y',array('a','b','c'));
		$goaltab[]=array('y'=>1,'a'=>-1,'b'=>4,'c'=>7);
		$goaltab[]=array('y'=>2,'a'=>2,'b'=>5,'c'=>8);
		$goaltab[]=array('y'=>3,'a'=>3,'b'=>6,'c'=>9);
		$goaltab['min']=-1;
		$goaltab['max']=9;
		//print_r($norm);
		//print_r($goaltab);
		$diff=array_diff($norm,$goaltab);
		$this->assertFalse(count($diff),count($diff));
	}	
  }
?>