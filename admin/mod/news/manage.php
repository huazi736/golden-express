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

class manage extends Action
{
	public function doDefault()
	{
		$smarty = $this->app->page();
		
		$page = max(1, intval($_GET['page']));
		$pagesize = PAGE_SIZE;
		
		$db = $this->app->orm()->query();
		$count = $db->getValue("select count(*) from news");
		$pagemax = max(1, $count / $pagesize);
		
		$db->clear();
		$offset = ($page - 1) * $pagesize;
		$news = $db->getArray("select NewsId,Title,Author,`From`,CreateTime,Top from news order by Top DESC, CreateTime DESC", $offset, $pagesize);		
		
		$pagehtml = $smarty->getNav($pagemax, 7, $page, '<a href="?page=%d">%d</a>', '<strong>%d</strong>');
		
		$smarty->value('news', $news);
		$smarty->value('pages', $pagehtml);

		$smarty->output();		
	}
	
	public function doDel()
	{
		$nid = intval($_GET['nid']);
		if ($nid > 0)
		{
			$db = $this->app->orm()->query();
			$db->exec("delete from news where NewsId='{$nid}' limit 1");
		}
		$this->showMsg('新闻已经删除成功');
	}
	
	public function doEdit()
	{
		$nid = intval($_GET['nid']);
		$db = $this->app->orm()->query();
		$news = $db->getRow("select * from news where NewsId='{$nid}'");
		if ($news && $news['NewsId'] > 0)
		{
			$smarty = $this->app->page();
			$smarty->params['template'] = 'mod/news/edit.tpl';
			$smarty->value('news', $news);
			$smarty->output();
			exit;
		}		
		$this->showMsg('新闻不存在!');
		
	}
	
	public function doSave()
	{
		extract($_POST, EXTR_SKIP);
		$NewsId = intval($NewsId);		
		$data = array(
			'Title' => $Title,
			'Author' => $Author,
			'From' => $From,
			'CreateTime' => empty($CreateTime) ? date("Y-m-d H:i:s") : $CreateTime,
			'Top' => empty($Top) ? 0 : 1,
			'Color' => empty($Color) ? '' : $Color,
			'Content' => $Content	
		);
		if ($NewsId > 0)
		{
			$db = $this->app->orm()->query();
			$db->addTable('news');
			$db->addWhere('NewsId', $NewsId);
			$db->update($data);
		}
			
		$this->showMsg('新闻修改成功');
	}
}

$app->run();
?>