<?php
/**
 * 网站入口
 * 
 * @author 苏宁 <snsnsky@gmail.com>
 * 
 * $Id$
 */

require_once('./common.inc.php');

class help extends Action
{
	/**
	 * 程序入口
	 *
	 */
	public function doDefault()
	{
		/*
		$help_file =  $this->app->cfg['path']['conf'] . 'help.cfg.php';
		include $help_file;
		
		$page = $this->app->page();
		$page->params['template'] = 'help-cate.tpl';
		$page->value('cate', $help_cfg);
		$page->output();
		*/
		$this->app->redirect('help.php?do=view&id=1-1');
	}
	
	public function doView()
	{
		$help_file =  $this->app->cfg['path']['conf'] . 'help.cfg.php';
		include $help_file;
		
		$id = mysql_escape_string(trim($_GET['id']));
		list($key, $key2) = explode('-', $id);
		if (!$help_cfg[$key] || !$help_cfg[$key]['item'][$key2])
		{
			$id = '1-1';
			$key = '1';
			$key2 = '2';
		}
		
		$db = $this->app->orm()->query();
		$data = $db->getRow("select * from data where Type='{$id}'");
		$page = $this->app->page();
		$page->params['template'] = 'help-cate.tpl';
		$page->value('data', $data);
		$page->value('title', $help_cfg[$key]['item'][$key2]['name']);
		$page->value('cate', $help_cfg);
		$page->output();
	}
	
	public function doAbout()
	{
		$sid = 10;
		$db = $this->app->orm()->query();
		$data = $db->getRow("select * from data where DataId='{$sid}'");
		
		$page = $this->app->page();
		$page->value('data', $data);
		$page->value('sid', $sid);
		$page->output();
	}
	
	public function doPay()
	{
		$sid = 13;
		$db = $this->app->orm()->query();
		$data = $db->getRow("select * from data where DataId='{$sid}'");
		
		$page = $this->app->page();
		$page->value('data', $data);
		$page->value('sid', $sid);
		$page->output();
	}
	
	public function doCareer()
	{
		$sid = 12;
		$db = $this->app->orm()->query();
		$data = $db->getRow("select * from data where DataId='{$sid}'");
		
		$page = $this->app->page();
		$page->value('data', $data);
		$page->value('sid', $sid);
		$page->output();
	}
	
	public function doProfessional()
	{
		$sid = 14;
		$db = $this->app->orm()->query();
		$data = $db->getRow("select * from data where DataId='{$sid}'");
		
		$page = $this->app->page();
		$page->value('data', $data);
		$page->value('sid', $sid);
		$page->output();
	}
}
$app->run();

?>