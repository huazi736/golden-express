<?php
/**
 * CMS 节点管理
 * 
 * 
 * @author 苏宁 <suning@corp.the9.com>
 * 
 * $Id: node.php 225 2009-09-16 09:29:47Z suning $
 */

$global_allow_group = array(4);
require_once('../../common.inc.php');

class node extends Action
{
	/**
	 * 程序入口
	 *
	 */
	public function doDefault()
	{				
		$smarty = $this->app->page();
		$smarty->params['template'] = 'node/add_node.tpl';
		$smarty->output();
	}
	
	/**
	 * 添加新节点
	 *
	 */	
	public function doAddNode()
	{
		$name = trim($_POST['name']);
		if (empty($name))
		{
			$this->showMsg('节点名称不能为空!');
		}
		
		$db = $this->app->orm()->query();
		$db->addTable('Node');
		$db->addValue('Name', $name);
		$db->addValue('GameType', $_SESSION['gameid']);
		$db->insert();
		
		$this->showMsg('节点添加成功', '/modules/node/node.php?do=Manager');
	}


	/**
	 * 增加节点分组
	 *
	 */
	public function doAddNodeGroup()
	{
		if (isset($_POST['groupname']) && !empty($_POST['groupname']))
		{
			$nodes_str = "";
			$nodes = $_POST['nodes0'];
			if (is_array($nodes))
			{
				foreach ($nodes as $v)
				{
					$v = intval($v);
					if ($v > 0) 
					{
						$nodes_str .= $v . ',';
					}
				}
				$nodes_str = rtrim($nodes_str, ',');
			}
			$db = $this->app->orm()->query();
			$db->addTable('NodeGroup');
			$db->addValue('Name', $_POST['groupname']);
			$db->addValue('Nodes', $nodes_str);
			$db->addValue('GameType', $_SESSION['gameid']);
			$db->insert();
			$this->showMsg('分组添加成功!');
		}
		$this->showMsg('数据不完整!');
	}

	/**
	 * 删除节点分组
	 *
	 */
	public function dodelNodeGroup()
	{
		$gid = intval($_POST['gid']);
		$db = $this->app->orm()->query();
		$db->addTable('NodeGroup');
		$db->addWhere('NodeGroupId', $gid);
		$db->addWhere('GameType', $_SESSION['gameid']);
		$db->delete();
		exit(1);
	}

	/**
	 * 删除节点分组
	 *
	 */
	public function doupdateNodeGroup()
	{
		$name = $_POST['name'];
		$nodes = $_POST['nodes'];
		$gid = $_POST['gid'];

		if (empty($name)) exit(0);
		if (!preg_match("/^[0-9,]+$/", $nodes)) exit(0);

		$db = $this->app->orm()->query();
		$db->addTable('NodeGroup');
		$db->addValue('Name', $name);
		$db->addValue('Nodes', $nodes);
		$db->addWhere('NodeGroupId', $gid);
		$db->addWhere('GameType', $_SESSION['gameid']);
		$db->update();
		exit(1);
	}

	/**
	 * 节点分组
	 *
	 */	
	public function doGroup()
	{
		// 取出所有节点
		$db = $this->app->orm()->query();
		$db->addTable('NodeGroup');
		$db->addWhere('GameType', $_SESSION['gameid']);
		$data = $db->getArray();
		$group_data = array();
		if (is_array($data))
		{
			foreach ($data as $v)
			{
				$group_data[] = array(
					'gid' => $v['NodeGroupId'],
					'name' => $v['Name'],
					'nodes' => explode(',', $v['Nodes'])
				);
			}
		}

		// 取所有分组节点
		$db->clear();
		$db->addTable('Node');
		$db->addWhere('GameType', $_SESSION['gameid']);
		$data = $db->getArray();
		$node_data = array();
		if (is_array($data))
		{
			foreach ($data as $v)
			{
				$node_data[$v['NodeId']] = $v['Name'];
			}
		}

		$smarty = $this->app->page();
		$smarty->params['template'] = 'node/group_node.tpl';
		$smarty->value('group_data', $group_data);
		$smarty->value('node_data', $node_data);
		$smarty->output();
	}
	
	/**
	 * 管理节点
	 *
	 */
	public function doManager()
	{
		$db = $this->app->orm()->query();
		$db->addTable('Node');
		$db->addWhere('GameType', $_SESSION['gameid']);
		$data = $db->getArray();
		$smarty = $this->app->page();
		$smarty->params['template'] = 'node/list_node.tpl';
		$smarty->value('list', $data);
		$smarty->output();
	}
	
	/**
	 * 编辑节点
	 *
	 */
	public function doEditNode()
	{
		$nid = intval($_GET['nid']);
		
		$db = $this->app->orm()->query();
		$db->addTable('Node');
		$db->addWhere('NodeId', $nid);
		$db->addWhere('GameType', $_SESSION['gameid']);
		$node_data = $db->getRow();
		
		if ($node_data == false)
		{
			$this->showMsg('节点不存在!');
		}		
		
		$smarty = $this->app->page();
		$smarty->params['template'] = 'node/edit_node.tpl';
		$smarty->value('node_data', $node_data);
		$smarty->output();
	}
	
	/**
	 * 编辑节点信息
	 *
	 */
	public function doEditNodeInfo()
	{
		$nid = intval($_POST['nid']);
		$name = trim($_POST['name']);
		if (empty($name))
		{
			$this->showMsg('节点名称不能为空!');
		}
		if (empty($nid))
		{
			$this->showMsg('非法提交!');
		}
		$db = $this->app->orm()->query();
		$db->addTable('Node');
		$db->addValue('Name', $name);
		$db->addWhere('NodeId', $nid);
		$db->addWhere('GameType', $_SESSION['gameid']);
		$db->update();
		
		$this->showMsg('节点修改成功!', '/modules/node/node.php?do=Manager');
	}
	
	/**
	 * 删除节点
	 *
	 */
	public function doDelNode()
	{
		$nid = intval($_GET['nid']);
		
		$db = $this->app->orm()->query();
		$db->addTable('Node');
		$db->addWhere('NodeId', $nid);
		$db->addWhere('GameType', $_SESSION['gameid']);
		$db->delete();
		$this->showMsg('节点删除成功!');
	}	
	
	/**
	 * 获取节点下的文章列表
	 *
	 */
	private function getNodeArticle()
	{
		$db = $this->app->orm()->query();
		$db->addTable('NodeLink');
		$db->addField('ArticleId');		
		$db->addWhere('NodeId', $nid);
		$db->addWhere('GameType', $_SESSION['gameid']);
		$data = $db->getArray();
		if (!is_array($data))
		{
			$data = array();
		}
		$aids = array();
		foreach ($data as $v)
		{
			$aids[] = $v['ArticleId'];
		}
				
		$db->clear();
		$db->addTable('Article');
		$db->addField('ArticleId');
		$db->addField('Title');
		$db->addField('Link');
		$db->addField('PublishTime');
		$db->addField('Url');
		$db->addOrderBy('Sort', _ORM_OP_DESC);
		$db->addOrderBy('PublishTime', _ORM_OP_DESC);		
		$db->addWhere('GameType', $_SESSION['gameid']);
		$db->addWhere('Status', 3);
		$db->addWhere('ArticleId', $aids, _ORM_OP_IN);
		$newlist = $db->getArray(NULL, 0, 20);
		if (!is_array($newlist))
		{
			$newlist = array();
		}
		$news = array();
		foreach ($newlist as $v)
		{
			$article_time = strtotime($v['PublishTime']);
			$baseurl = $this->app->cfg['game'][$_SESSION['gameid']]['host'] . 
				'news/' . date("Ymd", $article_time) . '/' . $v['ArticleId'] . '.html';
			$news[] = array(
				'Title' => $v['Title'],
				'Link' => $v['Link'],
				'PublishTime' => $v['PublishTime'],
				'Date' => date("Y-m-d", $article_time),
				'Url' => $v['Url'],
				'BaseUrl' => $baseurl
			);
		}
		return $news;				
	}
}
$app->run();

?>