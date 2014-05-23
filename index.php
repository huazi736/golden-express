<?php
/**
 * 网站入口
 * 
 * @author 苏宁 <snsnsky@gmail.com>
 * 
 * $Id$
 */
// phpinfo();exit;
require_once('./common.inc.php');

class index extends Action
{
	/**
	 * 程序入口
	 *
	 */
	public function doDefault()
	{
		// 获取新闻
		$db = $this->app->orm()->query();
		$news = $db->getArray('select NewsId,Title,CreateTime,Color from news order by Top DESC, CreateTime DESC', 0, 5);
		
		// 获取幻灯片
		$cfg_file = $this->app->cfg['path']['root'] . 'admin/config/index.cfg.conf';
		$cfg_data = array();
		if (file_exists($cfg_file))
		{
			$cfg_data = unserialize(file_get_contents($cfg_file));
			if (!is_array($cfg_data))
			{
				$cfg_data = array();
			}
		}
				
		$page = $this->app->page();
		$page->value('current', 'index');
		$page->value('news', $news);
		$page->value('play', $cfg_data);
		$page->output();	
	}
	
}
$app->run();

?>