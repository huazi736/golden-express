<?php
/**
 * 原稿库
 * @author 庾洋 <yuyangvi@gmail.com>
 * $Id$
 */
$global_allow_group = array(1,2,3,4);
require_once('../../common.inc.php');

class original extends Action
{

	/**
	 * 每页条目数目
	 * @var int
	 */
	const PER_PAGE = 15;
	/**
	 * 程序入口
	 */
	public function doDefault()
	{
		//判断编辑权限
		$right = in_array($_SESSION['group'],array(2,3,4));
		
		//获取数据
		$query = $this->app->orm()->query();
		$total = $query->addTable('Article')
			->addWhere('Status',1)
			->addWhere('GameType', intval($_SESSION['gameid']))
			->addField('*','Count',_ORM_OP_COUNT)
			->getValue();
		
		$curpage = intval($_GET['page'])?intval($_GET['page']):1;
		$maxpage = ceil($total/original::PER_PAGE);
		$curpage = max(1, min($curpage, $maxpage));
		$data = $query->clear('field')
			->addOrderBy('UpdateTime',_ORM_OP_DESC)
			->addField('ArticleId')
			->addField('ArticleUserId')
			->addField('Title')
			->addField('UpdateTime')
			->addField('UpdateUserId')
			->getArray(null,original::PER_PAGE*($curpage-1),original::PER_PAGE);
		
		//获取发布人
		if (!empty($data))
		{
			$useridlist = array();
			foreach($data as $v)
			{
				$useridlist[] = $v['ArticleUserId'];
				$useridlist[] = $v['UpdateUserId'];
			}
			$useridlist = array_unique($useridlist);
			//建立索引
			$userlist = $query->clear()->addTable('User')->addWhere('UserId', $useridlist, _ORM_OP_IN)->getArray();
			$user_lib = array();
			if(!empty($userlist))
			{
				foreach($userlist as $v)
				{
					$user_lib[$v['UserId']] = $v['UserName'];
				}
			}
			//贴到数据上
			foreach($data as &$v)
			{
				$v['ArticleUser'] = $user_lib[$v['ArticleUserId']];
				$v['UpdateUser'] = $user_lib[$v['UpdateUserId']];
			}
		}
		
		//获取模板
		$template = $query->clear()->addTable('Template')->addWhere('Type', 0)->addWhere('GameType', $_SESSION['gameid'])->getArray();
		
		//分页
		$smarty = $this->app->page();
		$pagenav = $smarty->getNav($maxpage, 7, $curpage, '<a href="?page=%d">%d</a>', '<strong>%d</strong>');
		$page_html = '<span class="pages-info">分页 '.$curpage.'/'.$maxpage.'</span>';
		($curpage != 1 && $maxpage > 1) && $page_html .= '<a href="?page=1" title="第一页">&lsaquo;&lsaquo;</a>';
		($curpage > 1) && $page_html .= '<a href="?page='.($curpage-1).'" title="上页">|&lsaquo;</a>';
		$page_html .= $pagenav;
		($curpage < $maxpage) && $page_html .= '<a href="?page='.($curpage+1).'" title="下页">&rsaquo;|</a>';
		($curpage < $maxpage) && $page_html .= '<a href="?page='.$maxpage.'" title="最后页">&rsaquo;&rsaquo;</a>';
				
		$smarty->params['template'] = $right?'news/original.tpl':'news/original_view.tpl';
		$smarty->value('UserId', $_SESSION['uid']);
		$smarty->value('total', $total)->value('data', $data)->value('pagenav', $page_html)->value('tpl', $template);
		$smarty->output();
	}
	
	/**
	 * 审核操作
	 * @return void
	 */
	public function doVerify()
	{
		//判断权限
		if( !in_array($_SESSION['group'],array(2,3,4)) )
		{
			echo json_encode(array('error'=>true, 'msg'=>'你没权限进行审核操作'));
			return;
		}
		
		//获取id
		$id = $_POST['id'];
		if(is_array($id)&&!empty($id))
		{
			//过滤id
			foreach($id as &$v)
			{
				$v = intval($v);
			}
			$query = $this->app->orm()->query();
			$bol = $query->addTable('Article')
				->addWhere('GameType', intval($_SESSION['gameid']))
				->addValue('UpdateTime', date('Y-m-d H:i:s'))
				->addValue('PublishTime', date('Y-m-d H:i:s'))
				->addValue('Status',2)
				->addWhere('ArticleId', $id, _ORM_OP_IN)
				->update();
			if($bol)
			{
				echo json_encode(array('error'=>false, 'msg'=>'审核通过'));
				
				
				//写日志
				$titles = $query->clear()->addTable('Article')
					->addWhere('ArticleId', $id, _ORM_OP_IN)
					->addField('ArticleId')
					->addField('Title')
					->getArray();
				$title_index = array();
				
				foreach($titles as $p)
				{
					$title_index[$p['ArticleId']]=$p['Title'];
				}
				//循环插入日志
				foreach($id as $p)
				{
					$query->clear()->addTable('Log')
						->insert(array(
							'UserId'       => $_SESSION['uid'],
							'ArticleId'      => $p,
							'UserName'     => $_SESSION['name'],
							'ArticleTitle' => $title_index[$p],
							'LogTime'      => date('Y-m-d H:i:s'),
							'GameType'     => $_SESSION['gameid'],
							'Action'       => 4
						));
				}
			}else{
				echo json_encode(array('error'=>true, 'msg'=>'数据库更新失败'));
			}
		}else{
			echo json_encode(array('error'=>true, 'msg'=>'请先选中文章'));
		}
	}
	/**
	 * 删除操作
	 * @return void
	 */
	public function doDelete()
	{
		//判断权限
		if( !in_array($_SESSION['group'],array(2,3,4)) )
		{
			echo json_encode(array('error'=>true, 'msg'=>'你没权限进行删除操作'));
			return;
		}
		
		//获取id
		$id = $_POST['id'];
		if(is_array($id)&&!empty($id))
		{
			//过滤id
			foreach($id as &$v)
			{
				$v = intval($v);
			}
			$query = $this->app->orm()->query();
			$bol = $query->addTable('Article')->addWhere('GameType', intval($_SESSION['gameid']))->addValue('UpdateTime', date('Y-m-d H:i:s'))->addValue('Status',0)->addWhere('ArticleId', $id, _ORM_OP_IN)->update();
			if($bol)
			{
				echo json_encode(array('error'=>false, 'msg'=>'删除成功'));
				
				//删除NodeLink
				$query->clear()->addTable('NodeLink')
					->addWhere('ArticleId', $id, _ORM_OP_IN)
					->delete();
				
				//写日志
				$titles = $query->clear()->addTable('Article')
					->addWhere('ArticleId', $id, _ORM_OP_IN)
					->addField('ArticleId')
					->addField('Title')
					->getArray();
				$title_index = array();
				
				foreach($titles as $p)
				{
					$title_index[$p['ArticleId']]=$p['Title'];
				}
				//循环插入日志
				foreach($id as $p)
				{
					$query->clear()->addTable('Log')
						->insert(array(
							'UserId'       => $_SESSION['uid'],
							'ArticleId'      => $p,
							'UserName'     => $_SESSION['name'],
							'ArticleTitle' => $title_index[$p],
							'GameType'     => $_SESSION['gameid'],
							'LogTime'      => date('Y-m-d H:i:s'),
							'Action'       => 3
						));
				}
			}else{
				echo json_encode(array('error'=>true, 'msg'=>'数据库更新失败'));
			}
		}else{
			echo json_encode(array('error'=>true, 'msg'=>'请先选中文章'));
		}
	}
	
	/**
	 * 预览页面
	 */
	public function doPreview()
	{
		//  取出文章信息
		$id = intval($_GET['id']);
		$tpl = intval($_GET['tpl']);
		if ( empty($id) || empty($tpl) )
		{
			$this->showMsg('参数错误');
			return;
		}
		$query = $this->app->orm()->query();
		
		$article = $query->addTable('Article')
			->addWhere('ArticleId', $id)
			->addWhere('GameType', $_SESSION['gameid'])
			->addWhere('Status', 1)
			->getRow();
		$template = $query->clear()
			->addTable('Template')
			->addWhere('TemplateId', $tpl)
			->getRow();
		if( empty($article) || empty($template) )
		{
			$this->showMsg('参数错误');
			return;
		}
		// 生成临时模板文件
		$template_file = tempnam($this->app->cfg['path']['temp'], "ARTICLE");
		file_put_contents($template_file, $template['Template']);
		
		//
		$smarty = $this->app->page();
		$smarty->value('Title', $article['Title'])
			->value('SubTitle', $article['SubTitle'])
			->value('Date', $article['PublishTime'])
			->value('Content', $article['Content']);
		$smarty->params['template'] = $template_file;
		$smarty->output();
		
		unlink($template_file);
	}
}

$app->run();
?>