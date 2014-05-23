<?php
/**
 * 发布库
 * @author 庾洋 <yuyangvi@gmail.com>
 * $Id$
 */
$global_allow_group = array(3,4);
require_once('../../common.inc.php');

class release extends Action
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
		$query = $this->app->orm()->query();
		if(intval($_GET['node'])>0)
		{
			$list = $query->addTable('NodeLink')
				->addWhere('NodeId', intval($_GET['node']))
				->addField('ArticleId')
				->getColumn();
		}
		$query->clear()->addTable('Article')
			->addWhere('Status',3)
			->addWhere('GameType', intval($_SESSION['gameid']))
			->addField('*','Count',_ORM_OP_COUNT);
		if(intval($_GET['node'])>0 && empty($list))
		{
			$total = 0;
			$data = array();
		}else{
			if(intval($_GET['node'])>0 &&!empty($list))
				$query->addWhere('ArticleId', $list, _ORM_OP_IN);
			$total = $query->getValue();
			
			$curpage = intval($_GET['page'])?intval($_GET['page']):1;
			$maxpage = max(1,ceil($total/release::PER_PAGE));
			$curpage = max(1, min($curpage, $maxpage));
			$data = $query->clear('field')
				->addField('ArticleId')
				->addField('Title')
				->addField('ArticleUserId')
				->addField('UpdateUserId')
				->addField('PublishTime')
				->addField('Sort')
				->addOrderBy('Sort',_ORM_OP_DESC)
				->addOrderBy('PublishTime',_ORM_OP_DESC)
				->getArray(null,release::PER_PAGE*($curpage-1),release::PER_PAGE);
		}
		$hash_node=array();
		//获取节点信息
		$nodes = $query->clear()->addTable('Node')
			->addWhere('GameType', intval($_SESSION['gameid']))
			->getArray();
		if(count($data)>0)
		{
			//建立节点索引
			if(!empty($nodes))
			{
				foreach($nodes as $v)
				{
					$hash_node[$v['NodeId']] = array('NodeId'=>$v['NodeId'],'Name'=>$v['Name']);
				}
				
				//获取文章id
				$articleid = array();
				foreach($data as $k => $v)
				{
					$articleid[]=$v['ArticleId'];
					// 转换时间, 用于内部预览
					$data[$k]['PublishTime2'] = date("Ymd", strtotime($v['PublishTime']));

				}
				//获取文章需要的节点id
				$hash_nodelink = array();
				$nodelink = $query->clear()->addTable('NodeLink')
					->addWhere('GameType', intval($_SESSION['gameid']))
					->addWhere('ArticleId', $articleid, _ORM_OP_IN)
					->getArray();
				if(count($nodelink)>0)
				{
					//建立联系索引
					foreach($nodelink as $v)
					{
						$hash_nodelink[$v['ArticleId']][] = $hash_node[$v['NodeId']];
					}
					//加到data中
					foreach($data as &$a)
					{
						$a['Node']=$hash_nodelink[$a['ArticleId']];
					}
				}
			}
			
			//获取发布人
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
			foreach($data as &$t)
			{
				$t['ArticleUser'] = $user_lib[$t['ArticleUserId']];
				$t['UpdateUser'] = $user_lib[$t['UpdateUserId']];
			}
		}
		$smarty = $this->app->page();
		$param = '';
		if(intval($_GET['node'])>0)
		{
			$param = 'node='.intval($_GET['node']).'&';
		}
		$pagenav = $smarty->getNav($maxpage, 7, $curpage, '<a href="?'.$param.'page=%d">%d</a>', '<strong>%d</strong>');
		$page_html = '<span class="pages-info">分页 '.$curpage.'/'.$maxpage.'</span>';
		($curpage != 1 && $maxpage > 1) && $page_html .= '<a href="?'.$param.'page=1" title="第一页">&lsaquo;&lsaquo;</a>';
		($curpage > 1) && $page_html .= '<a href="?'.$param.'page='.($curpage-1).'" title="上页">|&lsaquo;</a>';
		$page_html .= $pagenav;
		($curpage < $maxpage) && $page_html .= '<a href="?'.$param.'page='.($curpage+1).'" title="下页">&rsaquo;|</a>';
		($curpage < $maxpage) && $page_html .= '<a href="?'.$param.'page='.$maxpage.'" title="最后页">&rsaquo;&rsaquo;</a>';
		
		$smarty->params['template'] = 'news/release.tpl';
		$smarty->value('total', $total)
			->value('data', $data)
			->value('pagenav', $page_html)
			->value('node', $nodes)
			->value('curnode', intval($_GET['node']));
		$smarty->output();
	}
	
	/**
	 * 撤回操作
	 * @return void
	 */
	public function doBack()
	{
		//获取id
		$id = $_POST['id'];
		if(is_array($id)&&!empty($id))
		{
			//过滤id
			foreach($id as &$a)
			{
				$a = intval($a);
			}
			$query = $this->app->orm()->query();
			$bol = $query->addTable('Article')
				->addValue('UpdateTime', date('Y-m-d H:i:s'))
				->addWhere('GameType', intval($_SESSION['gameid']))
				->addValue('Status',2)
				->addWhere('ArticleId', $id, _ORM_OP_IN)->update();
			if($bol)
			{
				echo json_encode(array('error'=>false, 'msg'=>'撤回成功'));
				
				//写日志
				$titles = $query->clear()->addTable('Article')
					->addWhere('ArticleId', $id, _ORM_OP_IN)
					->addField('ArticleId')
					->addField('UpdateTime')
					->addField('Title')
					->getArray();
				$title_index = array();
				
				//更新节点
				$nodes = $query->clear()->addTable('NodeLink')
					->addWhere('ArticleId', $id, _ORM_OP_IN)
					->addWhere('GameType', $_SESSION['gameid'])
					->addField('NodeId')
					->getColumn();
				if(!empty($nodes))
				{
					$nodes = array_unique($nodes);
					importModule('Manager');
					$manager = new Manager();
					foreach($nodes  as $v)
					{
						$manager->updateNode($v, true);
					}
				}
				
				foreach($titles as $p)
				{
					$title_index[$p['ArticleId']]=$p['Title'];
					
					/*删除静态文件
					$html_file_path = $this->app->cfg['game'][$_SESSION['gameid']]['root'] . 'news/' . date('Ymd', strtotime($p['UpdateTime'])) . '/' . $p['ArticleId'] . '.html';
					unlink($html_file_path);*/
					
					$url = $this->app->cfg['game'][$_SESSION['gameid']]['host'] . 'news/' . date('Ymd', strtotime($p['PublishTime'])) . '/';
					if(!empty($p['SeoKey']))
					{
						$url .= $p['SeoKey'] . '-';
					}

					$url .= $p['ArticleId'] . '.html';
					squid_clear($url);
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
							'Action'       => 7
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
		//获取id
		$id = $_POST['id'];
		if(is_array($id)&&!empty($id))
		{
			//过滤id
			foreach($id as &$a)
			{
				$a = intval($a);
			}
			$query = $this->app->orm()->query();
			$bol = $query->addTable('Article')->addWhere('GameType', intval($_SESSION['gameid']))->addValue('UpdateTime', date('Y-m-d H:i:s'))->addValue('Status',0)->addWhere('ArticleId', $id, _ORM_OP_IN)->update();
			if($bol)
			{
				echo json_encode(array('error'=>false, 'msg'=>'删除成功'));
				
				//删除NodeLink
				$query->clear()->addTable('NodeLink')
					->addWhere('ArticleId', $id, _ORM_OP_IN)
					->addWhere('GameType', intval($_SESSION['gameid']))
					->delete();
				
				//写日志
				$titles = $query->clear()->addTable('Article')
					->addWhere('ArticleId', $id, _ORM_OP_IN)
					->addField('ArticleId')
					->addField('Title')
					->addField('UpdateTime')
					->getArray();
				$title_index = array();
				
				//更新节点
				$nodes = $query->clear()->addTable('NodeLink')
					->addWhere('ArticleId', $id, _ORM_OP_IN)
					->addWhere('GameType', $_SESSION['gameid'])
					->addField('NodeId')
					->getColumn();
				if(!empty($nodes))
				{
					$nodes = array_unique($nodes);
					importModule('Manager');
					$manager = new Manager();
					foreach($nodes  as $v)
					{
						$manager->updateNode($v, true);
					}
				}
				
				foreach($titles as $p)
				{
					$title_index[$p['ArticleId']]=$p['Title'];
					
					//删除静态文件
					/*$html_file_path = $this->app->cfg['game'][$_SESSION['gameid']]['root'] . 'news/' . date('Ymd', strtotime($p['UpdateTime'])) . '/' . $p['ArticleId'] . '.html';
					unlink($html_file_path);*/
					
					$url = $this->app->cfg['game'][$_SESSION['gameid']]['host'] . 'news/' . date('Ymd', strtotime($p['PublishTime'])) . '/';
					if(!empty($p['SeoKey']))
					{
						$url .= $p['SeoKey'] . '-';
					}
					$url .= $p['ArticleId'] . '.html';
					squid_clear($url);
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
	 *
	 * 置顶操作
	 *
	 **/
	public function doTop()
	{
		$id = intval($_GET['id']);
		if(empty($id))
		{
			//跳转页面
			$this->showMsg('文章id不能为空!');
		}
		else
		{
			$s = intval($_GET['s']);
			if($s<2)
			{
				$query = $this->app->orm()->query();
				$query->addTable('Article')
					->addWhere('ArticleId', $id)
					->addWhere('GameType', intval($_SESSION['gameid']))
					->addValue('Sort', $s)
					->addValue('UpdateTime', date('Y-m-d H:i:s'))
					->update();
				$this->sync($id);
				//跳转
				$this->showMsg('文章操作成功!');
			}
		}
	}
	/**
	 * 同步到外网
	 */
	public function doSync()
	{
		$id = intval($_GET['id']);
		$query = $this->app->orm()->query();
		$atc = $query->addTable('Article')
			->addWhere('ArticleId',$id)
			->addWhere('GameType', intval($_SESSION['gameid']))
			->addField('Url')
			->addField('UpdateTime')
			->addField('Title')
			->getRow();
		//$date=date('Ymd',strtotime($atc['UpdateTime']));
		/*
		$file = $this->app->cfg['game'][$_SESSION['gameid']]['root'] . 'news/' . $date. '/' . $id . '.html';

		if (!file_exists($file))
		{
			//重新生成新页面
			$article = $query->clear()->addTable('Article')
				->addWhere('ArticleId',$id)
				->addWhere('GameType', intval($_SESSION['gameid']))
				->getRow();
			//获取模板
			$tpl = $query->clear()->addTable('Template')
				->addField('Template')
				->addWhere('Type', 0)
				->addWhere('TemplateId', $article['TemplateId'])
				->addWhere('GameType', $_SESSION['gameid'])
				->getValue();
			if(empty($tpl))
			{
				$this->showMsg('页面模板不存在,之前的发布无效，请撤回重新发布!');
				return;
			}
			
			//生成临时模板文件
			$template_file = tempnam($this->app->cfg['path']['temp'], "ARTICLE");
			file_put_contents($template_file, $tpl);
			
			//生成页面
			$smarty = $this->app->page();
			$smarty->params['template'] = $template_file;
			$output = $smarty->value('Title', $article['Title'])
				->value('SubTitle', $article['SubTitle'])
				->value('Date', $article['PublishTime'])
				->value('Content', $article['Content'])
				->output(true);
			$html_file_path = $this->app->cfg['game'][$_SESSION['gameid']]['root'] . 'news/' . $date . '/';
			
			//如果没有建立文件夹就建立它
			$dirname = '';
			$folders = explode('/',$html_file_path);
			foreach ($folders as $folder) {
				$dirname .= $folder . '/';					
				if ($folder!='' && $folder!='.' && $folder!='..' && !is_dir($dirname)) {
					mkdir($dirname);
				}
			}
			chmod($html_file_path,0777);
			$html_file_path .= $article['ArticleId'] . '.html';
			//写入指定文件
			file_put_contents($html_file_path, $output);
		}
		*/
		squid_clear($atc['Url']);
		
		//更新时间
		$query->clear()->addTable('Article')
			->addWhere('ArticleId',$id)
			->addWhere('GameType', intval($_SESSION['gameid']))
			->update(array('ServerTime'=>date('Y-m-d H:i:s')));
		//日志
		$query->clear()->addTable('Log')
			->insert(array(
				'UserId'       => $_SESSION['uid'],
				'ArticleId'      => $id,
				'UserName'     => $_SESSION['name'],
				'ArticleTitle' => $atc['Title'],
				'LogTime'      => date('Y-m-d H:i:s'),
				'GameType'     => $_SESSION['gameid'],
				'Action'       => 6
			));
		
		//更新节点
		$nodes = $query->clear()->addTable('NodeLink')
			->addWhere('ArticleId', $id)
			->addWhere('GameType', $_SESSION['gameid'])
			->addField('NodeId')
			->getColumn();
		if(!empty($nodes))
		{
			$nodes = array_unique($nodes);
			importModule('Manager');
			$manager = new Manager();
			foreach($nodes as $v)
			{
				$manager->updateNode($v, true);
			}
		}
		
		$this->showMsg('线上同步完成!');
	}
	
	/**
	 * 更新发布时间
	 * @return json
	 */
	public function doUpdateTime()
	{
		//判断权限
		if( !in_array($_SESSION['group'],array(3,4)) )
		{
			echo json_encode(array('error'=>true, 'msg'=>'你没权限进行审核操作'));
			return;
		}
		
		$id = intval($_POST['id']);
		$time = $_POST['time'].':00';
		//$is_time = strptime($_POST['time'],'Y-m-d H:i:s');
		$is_time = release::checkTime($time);
		if ($is_time === false)
		{
			echo json_encode(array('error'=>true,'msg'=>'时间格式错误'));
			return;
		}
		if(empty($id))
		{
			echo json_encode(array('error'=>true,'msg'=>'选择的文章错误'));
			return;
		}
		$date = date('Ymd', strtotime($time));
		$url = $this->app->cfg['game'][$_SESSION['gameid']]['host'] . 'news/' . $date . '/' . $id . '.html';
		$query = $this->app->orm()->query();
		$bol = $query->clear()->addTable('Article')
			->addWhere('ArticleId', $id)
			->addWhere('GameType', intval($_SESSION['gameid']))
			->addValue('PublishTime', $time)
			->addValue('Url', $url)
			->update();
		if(empty($bol))
			echo json_encode(array('error'=>true,'msg'=>'选择的文章错误'));
		else
		{
			$this->sync($id);
			echo json_encode(array('error'=>false,'msg'=>'时间修改成功','time'=>$time));
		}
	}
	private function sync($id)
	{
		$query = $this->app->orm()->query();
		$atc = $query->addTable('Article')
			->addWhere('ArticleId',$id)
			->addWhere('GameType', intval($_SESSION['gameid']))
			->addField('Url')
			->addField('UpdateTime')
			->addField('Title')
			->getRow();
		squid_clear($atc['Url']);
		$nodes = $query->clear()->addTable('NodeLink')
			->addWhere('ArticleId', $id)
			->addWhere('GameType', $_SESSION['gameid'])
			->addField('NodeId')
			->getColumn();
		if(!empty($nodes))
		{
			$nodes = array_unique($nodes);
			importModule('Manager');
			$manager = new Manager();
			foreach($nodes as $v)
			{
				$manager->updateNode($v, true);
			}
		}
	}
	/**
	 * 预览页面
	 */
	public function doPreview()
	{
		//  取出文章信息
		$id = intval($_GET['id']);
		if ( empty($id) )
		{
			$this->showMsg('没有文章');
			return;
		}
		$query = $this->app->orm()->query();
		
		$article = $query->addTable('Article')
			->addWhere('ArticleId', $id)
			->addWhere('GameType', $_SESSION['gameid'])
			->getRow();
		if($article === false)
		{
			$this->showMsg('没有文章');
			return;
		}
		$template = $query->clear()
			->addTable('Template')
			->addWhere('TemplateId', $article['TemplateId'])
			->addWhere('GameType', $_SESSION['gameid'])
			->getRow();
		if( empty($template) )
		{
			$this->showMsg('没有模板');
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
	
	/**
	 * 检测时间字符串是否合法
	 * @param $str
	 * @return Boolean
	 */
	public static function checkTime($str)
	{
		list($date, $time) = explode(' ', $str);
		list($y, $m, $d) = explode('-', $date);
		if(checkdate($m,$d,$y))
		{
			list($h,$i,$s) = explode(':', $time);
			if( strlen($h)==2 && strlen($i)==2 && strlen($s)==2 )
			{
				if($h>=0 && $h<24 && $i>=0 && $i<60 && $s>=0 && $s<60)
				{
					return true;
				}
			}
		}
		return false;
	}
}
$app->run()
?>