<?php
/**
 * 网站入口
 * 
 * @author 苏宁 <snsnsky@gmail.com>
 * 
 * $Id$
 */

require_once('./common.inc.php');

class news extends Action
{
	/**
	 * 程序入口
	 *
	 */
	public function doDefault()
	{
		$nid = intval($_GET['nid']);
		if (!empty($nid))
		{
			$this->_view($nid);
			exit;
		}
		
		$smarty = $this->app->page();
		
		$page = max(1, intval($_GET['page']));
		$pagesize = PAGE_SIZE;
		
		$db = $this->app->orm()->query();
		$count = $db->getValue("select count(*) from news");
		$pagemax = max(1, $count / $pagesize);
		
		$db->clear();
		$offset = ($page - 1) * $pagesize;
		$news = $db->getArray("select NewsId,Title,Author,`From`,CreateTime,Top,Color from news order by Top DESC, CreateTime DESC", $offset, $pagesize);		
		
		$pagehtml = $smarty->getNav($pagemax, 7, $page, '<a href="?page=%d">%d</a>', '<strong>%d</strong>');
		
		$smarty->value('news', $news);
		$smarty->value('pages', $pagehtml);

		$smarty->output();
	}
	
	private function _view($nid)
	{
		$smarty = $this->app->page();
		$db = $this->app->orm()->query();
		$news = $db->getRow("select * from news where NewsId='{$nid}'");
		if ($news && $news['NewsId'] > 0)
		{
			$smarty = $this->app->page();
			$smarty->params['template'] = 'news_view.tpl';
			$smarty->value('news', $news);
			$smarty->output();
			exit;
		}
		$this->app->redirect('news.php');
	}
	
}
$app->run();

?>