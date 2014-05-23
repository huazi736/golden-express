<?php
/**
 * 管理入口
 * 
 * 
 * @author 苏宁 <suning@corp.the9.com>
 * 
 * $Id: left.php 195 2009-09-01 09:52:20Z suning $
 */

require_once('./common.inc.php');

class left extends Action
{
	/**
	 * 程序入口
	 *
	 */
	public function doDefault()
	{	
		if (empty($_SESSION['admin_info']['group']))
		{
			$_SESSION['admin_info']['group'] = array();
		}
		$smarty = $this->app->page();		
		$smarty->output();
	}
}
$app->run();

?>