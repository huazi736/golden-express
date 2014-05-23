<?php
/**
 * 网站入口
 * 
 * @author 苏宁 <snsnsky@gmail.com>
 * 
 * $Id$
 */

require_once('./common.inc.php');

class guide extends Action
{
	/**
	 * 程序入口
	 *
	 */
	public function doDefault()
	{
		$this->doProcess();	
	}
	
	public function doProcess()
	{
		$sid = 4;
		$db = $this->app->orm()->query();
		$data = $db->getRow("select * from data where DataId='{$sid}'");
		
		$page = $this->app->page();
		$page->value('current', 'guide');
		$page->value('data', $data);
		$page->value('sid', $sid);
		$page->output();
	}
	
	public function doNotice()
	{
		$sid = 5;
		$db = $this->app->orm()->query();
		$data = $db->getRow("select * from data where DataId='{$sid}'");
		
		$page = $this->app->page();
		$page->value('current', 'guide');
		$page->value('data', $data);
		$page->value('sid', $sid);
		$page->output();
	}
	
	public function doClaimant()
	{
		$sid = 6;
		$db = $this->app->orm()->query();
		$data = $db->getRow("select * from data where DataId='{$sid}'");
		
		$page = $this->app->page();
		$page->value('current', 'guide');
		$page->value('data', $data);
		$page->value('sid', $sid);
		$page->output();
	}
	
}
$app->run();

?>