<?php
/**
 * 网站入口
 * 
 * @author 苏宁 <snsnsky@gmail.com>
 * 
 * $Id$
 */

require_once('./common.inc.php');

class contact extends Action
{
	/**
	 * 程序入口
	 *
	 */
	public function doDefault()
	{
		$sid = 11;
		$db = $this->app->orm()->query();
		$data = $db->getRow("select * from data where DataId='{$sid}'");
		
		$page = $this->app->page();
		$page->value('current', 'contact');
		$page->value('data', $data);
		$page->value('sid', $sid);
		$page->output();
	}
	
}
$app->run();

?>