<?php
/**
 * 管理首页
 * 
 * 
 * @author 苏宁 <suning@corp.the9.com>
 * 
 * $Id: admin.php 10 2009-07-17 09:14:22Z suning $
 */

require_once('./common.inc.php');

class admin extends Action
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
}
$app->run();

?>