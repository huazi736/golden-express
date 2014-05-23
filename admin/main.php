<?php
/**
 * 管理首页
 * 
 * 
 * @author 苏宁 <suning@corp.the9.com>
 * 
 * $Id: main.php 10 2009-07-17 09:14:22Z suning $
 */

require_once('./common.inc.php');

class main extends Action
{
	/**
	 * 程序入口
	 *
	 */
	public function doDefault()
	{
		$smarty = $this->app->page();
		$smarty->output();
	}
	
	public function doPhpinfo()
	{
		phpinfo();
	}
}
$app->run();

?>