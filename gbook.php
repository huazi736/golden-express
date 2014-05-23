<?php
/**
 * 网站入口
 * 
 * @author 苏宁 <snsnsky@gmail.com>
 * 
 * $Id$
 */

require_once('./common.inc.php');

class gbook extends Action
{
	/**
	 * 程序入口
	 *
	 */
	public function doDefault()
	{
		$page = $this->app->page();
		$page->value('current', 'gbook');
		$page->output();	
	}
	
	public function doSubmit()
	{
		extract($_POST, EXTR_SKIP);
		
		$fields = array('Title', 'Type', 'Name', 'Email', 'Phone', 'Content');
		$data = array(
			'CreateTime' => date("Y-m-d H:i:s")
		);
		foreach ($fields as $v)
		{
			$data[$v] = $$v;
		}
		
		$db = $this->app->orm()->query();
		$db->addTable('gbook');
		$db->insert($data);
		
		echo '<script>alert("提交成功, 我们会尽快处理您提供的意见!")</script>';
		$this->app->redirect('gbook.php');
		
	}
	
}
$app->run();

?>