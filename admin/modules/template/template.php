<?php
/**
 * CMS 模板管理
 * 
 * 
 * @author 苏宁 <suning@corp.the9.com>
 * 
 * $Id: template.php 143 2009-08-06 08:26:38Z suning $
 */

$global_allow_group = array(4);
require_once('../../common.inc.php');

class template extends Action
{
	/**
	 * 程序入口
	 *
	 */
	public function doDefault()
	{
		$db = $this->app->orm()->query();
		$db->addTable('Node');
		$db->addWhere('GameType', $_SESSION['gameid']);
		$node = $db->getArray();
		
		$smarty = $this->app->page();
		$smarty->params['template'] = 'template/add_template.tpl';
		$smarty->value('node', $node);
		$smarty->output();
	}
	
	/**
	 * 添加模板
	 *
	 */
	public function doAddTemplate()
	{
		extract($_POST, EXTR_SKIP);
		if (empty($name) || empty($templatecode) || $type == '-1')
		{
			$this->showMsg('所填内容不能为空');
		}
		$type = intval($type);
		if ($type < 0 || $type > 2)
		{
			$type = 0;
		}
		$itemlist = intval($itemlist);
		$node = intval($node);
		$listmax = 0;
		$listpage = 0;
		
		if ($type == '1') // 节点列表模板, 无分页
		{
			if ($node == 0)
			{
				$this->showMsg('必须选择节点!');
			}
			$listmax = ($itemlist > 0) ? $itemlist : 6;
			$listpage = 0;
		}
		elseif ($type == '2') // 节点分页模板, 有分页
		{
			if ($node == 0)
			{
				$this->showMsg('必须选择节点!');
			}
			$listmax = 0;
			$listpage = ($itemlist > 0) ? $itemlist : 20;
		}
		elseif ($type == '0') // 内容模板, 无分页
		{
			$node = 0;
			$listpage = 0;
			$listmax = 0;
		}		
		
		$db = $this->app->orm()->query();
		$db->addTable('Template');
		$db->addValue('Name', $name);
		$db->addValue('NodeId', $node);
		$db->addValue('ListMax', $listmax);
		$db->addValue('ListPage', $listpage);
		$db->addValue('Type', $type);
		$db->addValue('GameType', $_SESSION['gameid']);
		$db->addValue('Template', $templatecode);
		$db->addValue('CreateTime', date("Y-m-d H:i:s"));
		$db->addValue('UpdateTime', date("Y-m-d H:i:s"));
		$db->addValue('TemplateUserId', $_SESSION['uid']);
		$db->insert();
		$this->showMsg('模板添加成功!');		
	}
	
	/**
	 * 模板管理
	 *
	 */
	public function doManager()
	{
		$db = $this->app->orm()->query();		
		$sql = "select a.*,b.Name as NodeName from Template as a left join Node as b on a.NodeId = b.NodeId where a.GameType = '" . $_SESSION['gameid'] . "' order by Type ASC,TemplateId DESC";		
		$rs = $db->getArray($sql);
		
		$smarty = $this->app->page();
		$smarty->params['template'] = 'template/list_template.tpl';
		$smarty->value('list', $rs);
		$smarty->output();		
	}
	
	/**
	 * 删除模板
	 *
	 */
	public function doDelTemplate()
	{
		$tid = intval($_GET['tid']);
		$db = $this->app->orm()->query();
		$db->addTable('Template');
		$db->addWhere('TemplateId', $tid);
		$db->delete();
		$this->showMsg('模板删除成功!');		
	}
	
	/**
	 * 编辑模板
	 *
	 */
	public function doEditTemplate()
	{
		$tid = intval($_GET['tid']);
		$db = $this->app->orm()->query();
		$db->addTable('Template');
		$db->addWhere('TemplateId', $tid);
		$db->addWhere('GameType', $_SESSION['gameid']);
		$template = $db->getRow();
		
		if (!isset($template['TemplateId']))
		{
			$this->showMsg('模板不存在!');
		}
		
		$db->clear();
		$db->addTable('Node');
		$db->addWhere('GameType', $_SESSION['gameid']);
		$node = $db->getArray();
		$listtype = 0;
		if ($template['Type'] == '1')
		{
			$listtype = $template['ListMax'];
		}
		if ($template['Type'] == '2')
		{
			$listtype = $template['ListPage'];
		}
		$template['ListVal'] = $listtype;
		
		$smarty = $this->app->page();
		$smarty->params['template'] = 'template/edit_template.tpl';
		$smarty->value('tp', $template);
		$smarty->value('node', $node);
		$smarty->output();
	}
	
	/**
	 * 保存模板
	 *
	 */
	public function doEditTemplateInfo()
	{
		extract($_POST, EXTR_SKIP);
		if (empty($name) || empty($templatecode) || $type == '-1')
		{
			$this->showMsg('所填内容不能为空');
		}
		$type = intval($type);
		if ($type < 0 || $type > 2)
		{
			$type = 0;
		}
		$itemlist = intval($itemlist);
		$node = intval($node);
		$listmax = 0;
		$listpage = 0;
		
		if ($type == '1') // 节点列表模板, 无分页
		{
			if ($node == 0)
			{
				$this->showMsg('必须选择节点!');
			}
			$listmax = ($itemlist > 0) ? $itemlist : 6;
			$listpage = 0;
		}
		elseif ($type == '2') // 节点分页模板, 有分页
		{
			if ($node == 0)
			{
				$this->showMsg('必须选择节点!');
			}
			$listmax = 0;
			$listpage = ($itemlist > 0) ? $itemlist : 6;;
		}
		elseif ($type == '0') // 内容模板, 无分页
		{
			$node = 0;
			$listpage = 0;
			$listmax = 0;
		}		
		
		$db = $this->app->orm()->query();
		$db->addTable('Template');
		$db->addValue('Name', $name);
		$db->addValue('NodeId', $node);
		$db->addValue('ListMax', $listmax);
		$db->addValue('ListPage', $listpage);
		$db->addValue('Type', $type);		
		$db->addValue('Template', $templatecode);
		$db->addValue('UpdateTime', date("Y-m-d H:i:s"));
		$db->addWhere('GameType', $_SESSION['gameid']);
		$db->addWhere('TemplateId', $tid);
		$db->update();
		$this->showMsg('模板修改成功!');	
	}
	
	/**
	 * 预览页面
	 *
	 */
	public function doViewTemplate()
	{
		//  取出模板信息
		$tid = intval($_GET['tid']);
		$db = $this->app->orm()->query();
		$db->addTable('Template');
		$db->addWhere('TemplateId', $tid);
		$db->addWhere('GameType', $_SESSION['gameid']);
		$template = $db->getRow();
		
		if ($template == false)
		{
			$this->showMsg('模板不存在');
		}
		
		if ($template['Type'] != 1)
		{
			$this->showMsg('新闻内容模板不能在此处预览和发布', 'javascript:window.close()');
		}
		
		// 生成临时模板文件
		$template_file = tempnam($this->app->cfg['path']['temp'], "NODE");
		file_put_contents($template_file, $template['Template']);	
		
		// 取出属于节点的新闻
		$size = $template['ListMax'] > 0 ? $template['ListMax'] : 6;
		$newslist = $this->getNodeArticle($template['NodeId'], $size);
		
		$smarty = $this->app->page();
		$smarty->value('NewsList', $newslist);		
		$smarty->params['template'] = $template_file;
		$smarty->output();
		
		unlink($template_file);		
	}
	
	public function doLocalUpdate()
	{
		//  取出模板信息
		$tid = intval($_GET['tid']);
		$db = $this->app->orm()->query();
		$db->addTable('Template');
		$db->addWhere('TemplateId', $tid);
		$db->addWhere('GameType', $_SESSION['gameid']);
		$template = $db->getRow();
		
		if ($template == false)
		{
			$this->showMsg('模板不存在');
		}
		
		if ($template['Type'] != 1)
		{
			$this->showMsg('新闻内容模板不能在此处预览和发布', 'javascript:window.close()');
		}
		
		// 生成临时模板文件
		$template_file = tempnam($this->app->cfg['path']['temp'], "NODE");
		file_put_contents($template_file, $template['Template']);	
		
		// 取出属于节点的新闻
		$size = $template['ListMax'] > 0 ? $template['ListMax'] : 6;
		$newslist = $this->getNodeArticle($template['NodeId'], $size);
		
		$smarty = $this->app->page();
		$smarty->value('NewsList', $newslist);		
		$smarty->params['template'] = $template_file;
		$output = $smarty->output(true);
		
		$html_file_path = $this->app->cfg['game'][$_SESSION['gameid']]['root'] . 'newslist/' . $tid . '.html';
		file_put_contents($html_file_path, $output);
		
		unlink($template_file);	
		
		// 进入预览地址
		$this->app->redirect($this->app->cfg['game'][$_SESSION['gameid']]['host'] . 'newslist/' . $tid . '.html');
	}
	
	/**
	 * 线上同步更新
	 *
	 */
	public function doOnlineUpdate()
	{
		$tid = intval($_GET['tid']);		
		squid_clear($this->app->cfg['game'][$_SESSION['gameid']]['host'] . 'newslist/' . $tid . '.html');
		$this->showMsg('线上同步完成!');
	}
	
	/**
	 * 预览分页模板
	 *
	 */
	public function doViewTemplateWithPage()
	{
		//  取出模板信息
		$tid = intval($_GET['tid']);
		$db = $this->app->orm()->query();
		$db->addTable('Template');
		$db->addWhere('TemplateId', $tid);
		$db->addWhere('GameType', $_SESSION['gameid']);
		$template = $db->getRow();
		
		if ($template == false)
		{
			$this->showMsg('模板不存在');
		}
		
		// 生成临时模板文件
		$template_file = tempnam($this->app->cfg['path']['temp'], "LIST");
		file_put_contents($template_file, $template['Template']);
		
		// 取出数据
		$page = isset($_GET['page']) ? intval($_GET['page']) : 1;
		if ($page < 1) $page = 1;		
		$pageinfo = array();
		
		importModule("Manager");
		$manager = new Manager();
		$newslist = $manager->getNodeArticleByPage($template['NodeId'], $page, $template['ListPage'], $pageinfo);
		$pagecount = $pageinfo['pagecount'];
		
		// 动态预览, 直接输出!
		$smarty = $this->app->page();
		
		$page_data = $smarty->getNav($pagecount, 7, $page, "<a href=\"?do=ViewTemplateWithPage&tid={$tid}&page=%d\">%d</a>", "<a class=\"page_on\" href=\"javascript://\">%d</a>");
		//($pagecount != 1) && $page_html = "{$page}/{$pagecount} 页 ";
		($page != $pagecount && $pagecount > 1) && $page_html .= "<span class=\"pageflow\"><a href=\"?do=ViewTemplateWithPage&tid={$tid}&page=" . ($page + 1) . "\">下一页</a> <a href=\"?do=ViewTemplateWithPage&tid={$tid}&page={$pagecount}\">末 页</a></span>";
		$page_html .= '<div class="pages">' . $page_data . '</div>';
		($page != 1 && $pagecount > 1) && $page_html .= "<span class=\"pageflow\"><a href=\"?do=ViewTemplateWithPage&tid={$tid}&page=1\">首 页</a> <a href=\"?do=ViewTemplateWithPage&tid={$tid}&page=". ($page - 1) . "\">上一页</a></span>";

		$smarty->value('NewsList', $newslist);
		$smarty->value('Pages', $page_html);
		$smarty->params['template'] = $template_file;
		$smarty->output();
		unlink($template_file);
	}
	
	/**
	 * 更新分页模板
	 *
	 */
	public function doUpdateTemplateWithPage()
	{
		$tid = intval($_GET['tid']);
		importModule("Manager");
		$manager = new Manager();
		$manager->updateTemplateWithPage($tid);
		$this->showMsg('更新成功!');
	}
	
	/**
	 * 获取节点数据
	 *
	 */
	private function getNodeArticle($nid, $size = 6)
	{
		importModule("Manager");
		$manager = new Manager();
		return $manager->getNodeArticle($nid, $size);
	}
}
$app->run();

?>