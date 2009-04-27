<?php

// load Smarty library
require($_SERVER['DOCUMENT_ROOT'].'/../Smarty/libs/Smarty.class.php');
class smarty_connect extends Smarty 
{
   function smarty_connect()
   {
		$appdir="AMAP/datasenter";

        // Class Constructor. 
        // These automatically get set with each new instance.

		$this->Smarty();
		$smartydir="${_SERVER['DOCUMENT_ROOT']}/../smarty/$appdir";
		$smartyhere="${_SERVER['DOCUMENT_ROOT']}/$appdir/smarty";
		$this->template_dir = "$smartyhere/templates";
		$this->config_dir = "$smartyhere/config";
		$this->cache_dir = "$smartydir/cache";
		$this->compile_dir = "$smartydir/templates_c";
		$this->assign('app_name', 'AMAP datacentre');
		$this->assign('app_root',$appdir);
	}
}

?>


