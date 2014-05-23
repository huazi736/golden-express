<?php
/**
 * CMS 管理
 * 
 * 
 * @author 苏宁 <suning@corp.the9.com>
 * 
 * $Id: Manager.class.php 225 2009-09-16 09:29:47Z suning $
 */

class Manager
{
	/**
	 * APP对象
	 *
	 * @var object
	 */
	private $app;
	
	/**
	 * 当前游戏类型
	 *
	 * @var integer
	 */
	private $game_type = 0;
	
	public function __construct()
	{
		global $app;
		$this->app = $app;
		if (defined('GAME_ID'))
		{
			$this->game_type = GAME_ID;
		}
		else
		{
			$this->game_type = $_SESSION['gameid'];
		}
	}
	
	/**
	 * 根据节点ID 更新HTML页面
	 *
	 * @param integer $nid		节点ID
	 * @param boolean $publish	是否发布,默认只重新生产HTML页面不发布!
	 */
	public function updateNode($nid, $publish = false)
	{
		// 取出所有使用此节点的模板
		$db = $this->app->orm()->query();
		$db->addTable('Template');
		$db->addWhere('GameType', $this->game_type);
		$db->addWhere('NodeId', $nid);
		$data = $db->getArray();
		foreach ($data as $v)
		{
			if ($v['Type'] == 1) // 节点列表
			{
				squid_clear($this->app->cfg['game'][$this->game_type]['host'] . 'newslist/' . $v['TemplateId'] . '.html');			
			}
			if ($v['Type'] == 2) // 节点分页
			{
				$this->updateTemplateWithPage($v['TemplateId']);
			}
		}
	}
	
	/**
	 * 获取节点文章的数据
	 *
	 * @param integer $nid		节点ID
	 * @param integer $size		取出节点下文章条数
	 * @return array
	 */
	public function getNodeArticle($nid, $size = 6)
	{
		$db = $this->app->orm()->query();
		$db->addTable('NodeLink');
		$db->addField('ArticleId');		
		$db->addWhere('NodeId', $nid);
		$db->addWhere('GameType', $this->game_type);
		$data = $db->getArray();
		if (!is_array($data))
		{
			$data = array();
		}
		$aids = array();
		$flag = true;
		foreach ($data as $v)
		{
			$aids[] = $v['ArticleId'];
			$flag = false;
		}
		if ($flag)
		{
			$aids = array(-1);
		}
		
		$db->clear();
		$db->addTable('Article');
		$db->addField('ArticleId');
		$db->addField('Title');
		$db->addField('Link');
		$db->addField('PublishTime');
		$db->addField('CreateTime');
		$db->addField('Url');
		$db->addField('SubTitle');
		$db->addField('Desc1');
		$db->addField('Desc2');
		$db->addField('Desc3');		
		$db->addOrderBy('Sort', _ORM_OP_DESC);
		$db->addOrderBy('PublishTime', _ORM_OP_DESC);
		$db->addWhere('GameType', $this->game_type);
		$db->addWhere('Status', 3);
		$db->addWhere('ArticleId', $aids, _ORM_OP_IN);
		$newlist = $db->getArray(NULL, 0, $size);
		if (!is_array($newlist))
		{
			$newlist = array();
		}
		$news = array();
		foreach ($newlist as $v)
		{
			$article_time = strtotime($v['PublishTime']);
			$url = empty($v['Link']) ? $v['Url'] : $v['Link'];
			$news[] = array(
				'ArticleId' => $v['ArticleId'],
				'Title' => $v['Title'],
				'Link' => $v['Link'],
				'PublishTime' => $article_time,
				'Date' => date("[m/d]", $article_time),
				'Img' => '/images/' . date("Ymd", strtotime($v['CreateTime'])) . '/thumb' . $v['ArticleId']. '.jpg',
				'Url' => $url,
				'SubTitle' => $v['SubTitle'],
				'Desc1' => $v['Desc1'],
				'Desc2' => $v['Desc2'],
				'Desc3' => $v['Desc3']
			);
		}	
		return $news;
	}
	
	/**
	 * 取节点文章并分页
	 *
	 * @param integer $nid		节点ID
	 * @param integer $page		分页
	 * @param integer $pagesize	每页
	 * @param array $pageinfo	分页数据
	 */
	public function getNodeArticleByPage($nid, $page = 1, $pagesize = 20, & $pageinfo)
	{
		if ($pagesize < 0)
		{
			$pagesize = 20;
		}
		$db = $this->app->orm()->query();
		$db->addTable('NodeLink');
		$db->addField('ArticleId');		
		$db->addWhere('NodeId', $nid);
		$db->addWhere('GameType', $this->game_type);
		$data = $db->getArray();
		if (!is_array($data))
		{
			$data = array();
		}
		$aids = array();
		$flag = true;
		foreach ($data as $v)
		{
			$aids[] = $v['ArticleId'];
			$flag = false;
		}
		if ($flag)
		{
			$aids = array(-1);
		}		
		
		// 分页
		$db->clear();
		$db->addTable('Article');
		$db->addField('count(ArticleId)');
		$db->addWhere('GameType', $this->game_type);
		$db->addWhere('Status', 3);
		$db->addWhere('ArticleId', $aids, _ORM_OP_IN);
		$pageinfo['count'] = $count = $db->getValue();
		
		$pagecount = ceil($count / $pagesize);
		$pagecount = $pagecount < 1 ? 1 : $pagecount;
		$pageinfo['pagecount'] = $pagecount;
		if ($page < 1 || $page > $pagecount)
		{
			header('HTTP/1.1 404 Not Found');
			exit;
		}		
		
		$offset = ($page - 1) * $pagesize;		
		$db->clear();
		$db->addTable('Article');
		$db->addField('ArticleId');
		$db->addField('Title');
		$db->addField('Link');
		$db->addField('PublishTime');
		$db->addField('CreateTime');
		$db->addField('Url');
		$db->addField('SubTitle');
		$db->addField('Desc1');
		$db->addField('Desc2');
		$db->addField('Desc3');
		$db->addOrderBy('Sort', _ORM_OP_DESC);
		$db->addOrderBy('PublishTime', _ORM_OP_DESC);		
		$db->addWhere('GameType', $this->game_type);
		$db->addWhere('Status', 3);
		$db->addWhere('ArticleId', $aids, _ORM_OP_IN);
		$newlist = $db->getArray(NULL, $offset, $pagesize);
		if (!is_array($newlist))
		{
			$newlist = array();
		}
		$news = array();
		foreach ($newlist as $v)
		{
			$article_time = strtotime($v['PublishTime']);
			$url = empty($v['Link']) ? $v['Url'] : $v['Link'];
			$news[] = array(
				'ArticleId' => $v['ArticleId'],
				'Title' => $v['Title'],
				'Link' => $v['Link'],
				'PublishTime' => $article_time,
				'Date' => date("[m/d]", $article_time),
				'Img' => '/images/' . date("Ymd", strtotime($v['CreateTime'])) . '/thumb' . $v['ArticleId']. '.jpg',
				'Url' => $url,
				'SubTitle' => $v['SubTitle'],
				'Desc1' => $v['Desc1'],
				'Desc2' => $v['Desc2'],
				'Desc3' => $v['Desc3']
			);
		}
		return $news;		
	}
	
	/**
	 * 更新分页节点的所有目标
	 *
	 * @param integer $tid		模板ID
	 */
	public function updateTemplateWithPage($tid)
	{
		// 取模板信息
		$db = $this->app->orm()->query();
		$db->addTable('Template');
		$db->addWhere('TemplateId', $tid);
		$template = $db->getRow();
		
		if (!isset($template['TemplateId']))
		{
			Action::showMsg('模板ID不正确');
		}
		
		// 取节点数据
		$db->clear();
		$db->addTable('NodeLink');
		$db->addField('count(NodeLinkId)');
		$db->addWhere('NodeId', $template['NodeId']);
		$db->addWhere('GameType', $_SESSION['gameid']);
		$count = $db->getValue();
		
		$pagecount = ceil($count / $template['ListPage']);
		$urls = array();
		for ($i = 1; $i <= $pagecount; $i++)
		{
			$urls[] = $this->app->cfg['game'][$_SESSION['gameid']]['host'] . 'list' . $tid . '_' . $i . '.html';
		}
		squid_clear($urls);		
	}
	
}
?>