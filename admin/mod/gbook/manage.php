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
		$count = $db->getValue("select count(*) from gbook");
		$pagemax = max(1, $count / $pagesize);
		
		$db->clear();
		$offset = ($page - 1) * $pagesize;
		$gbook = $db->getArray("select GbookId,Title,Type,CreateTime from gbook order by CreateTime DESC", $offset, $pagesize);		
		
		$pagehtml = $smarty->getNav($pagemax, 7, $page, '<a href="?page=%d">%d</a>', '<strong>%d</strong>');
		
		$smarty->value('gbook', $gbook);
		$smarty->value('pages', $pagehtml);

		$smarty->output();		
	}
	
	public function doDel()
	{
		$gid = intval($_GET['gid']);
		if ($gid > 0)
		{
			$db = $this->app->orm()->query();
			$db->exec("delete from gbook where GbookId='{$gid}' limit 1");
		}
		$this->showMsg('用户反馈已经删除成功!');
	}
	
	public function doView()
	{
		$gid = intval($_GET['gid']);
		$db = $this->app->orm()->query();
		$gbook = $db->getRow("select * from gbook where GbookId='{$gid}'");
		if ($gbook && $gbook['GbookId'] > 0)
		{
			$smarty = $this->app->page();
			$smarty->params['template'] = 'mod/gbook/view.tpl';
			$smarty->value('gbook', $gbook);
			$smarty->output();
			exit;
		}		
		$this->showMsg('用户反馈不存在!');
		
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