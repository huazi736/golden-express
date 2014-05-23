<?php
/**
 * 网站入口
 * 
 * @author 苏宁 <snsnsky@gmail.com>
 * 
 * $Id$
 */

require_once('./common.inc.php');

class service extends Action
{
	/**
	 * 程序入口
	 *
	 */
	public function doDefault()
	{
		$this->doExpress();			
	}
	
	public function doExpress()
	{
		$sid = 1;
		$db = $this->app->orm()->query();
		$data = $db->getRow("select * from data where DataId='{$sid}'");
		
		$page = $this->app->page();
		$page->value('current', 'service');
		$page->value('data', $data);
		$page->value('sid', $sid);
		$page->output();
	}
	
	public function doFreight()
	{
		$sid = 2;
		$db = $this->app->orm()->query();
		$data = $db->getRow("select * from data where DataId='{$sid}'");
		
		$page = $this->app->page();
		$page->value('current', 'service');
		$page->value('data', $data);
		$page->value('sid', $sid);
		$page->output();
	}
	
	public function doEcommerce()
	{
		$sid = 3;
		$db = $this->app->orm()->query();
		$data = $db->getRow("select * from data where DataId='{$sid}'");
		
		$page = $this->app->page();
		$page->value('current', 'service');
		$page->value('data', $data);
		$page->value('sid', $sid);
		$page->output();
	}
	
}
$app->run();

?>