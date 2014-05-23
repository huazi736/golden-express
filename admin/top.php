<?php
/**
 * 顶部
 * 
 * 
 * @author 苏宁 <suning@corp.the9.com>
 * 
 * $Id: top.php 10 2009-07-17 09:14:22Z suning $
 */

require_once('./common.inc.php');

class top extends Action
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