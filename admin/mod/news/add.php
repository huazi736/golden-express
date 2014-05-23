<?php 
/**
 * 管理首页
 * 
 * 
 * @author 苏宁 <suning@126.com>
 * 
 * $Id$
 */


require_once('../../common.inc.php');

class add extends Action
{
	public function doDefault()
	{
		$page = $this->app->page();
		$page->output();		
	}
	
	public function doAdd()
	{
		extract($_POST, EXTR_SKIP);
		$data = array(
			'Title' => $Title,
			'Author' => $Author,
			'From' => $From,
			'CreateTime' => empty($CreateTime) ? date("Y-m-d H:i:s") : $CreateTime,
			'Top' => empty($Top) ? 0 : 1,
			'Color' => empty($Color) ? '' : $Color,
			'Content' => $Content	
		);
		$db = $this->app->orm()->query();
		$db->addTable('news');
		$db->insert($data);
		
		$this->showMsg('新闻发布成功');
		
		
	}
}

$app->run();
?>