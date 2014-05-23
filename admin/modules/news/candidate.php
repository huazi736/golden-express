<?php
/**
 * 待发布库
 * @author 庾洋 <yuyangvi@gmail.com>
 * $Id$
 */
$global_allow_group = array(2,3,4);
require_once('../../common.inc.php');

class candidate extends Action
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
		//是否拥有操作权限
		$right = in_array($_SESSION['group'], array(3,4));
		
		//读取数据
		$query = $this->app->orm()->query();
		$total = $query->addTable('Article')
			->addWhere('GameType', intval($_SESSION['gameid']))
			->addWhere('Status',2)
			->addField('*','Count',_ORM_OP_COUNT)
			->getValue();
		
		$curpage = intval($_GET['page'])?intval($_GET['page']):1;
		$maxpage = max(1,ceil($total/candidate::PER_PAGE));
		$curpage = max(1, min($curpage, $maxpage));
		$data = $query->clear('field')
			->addField('ArticleId')
			->addField('Title')
			->addField('PublishTime')
			->addField('ArticleUserId')
			->addOrderBy('PublishTime',_ORM_OP_DESC)
			->getArray(null,candidate::PER_PAGE*($curpage-1),candidate::PER_PAGE);
		$hash_node=array();
		
		//获取节点分组信息
		$nodegroup = $query->clear()->addTable('NodeGroup')
			->addWhere('GameType', intval($_SESSION['gameid']))
			->getArray();
		
		
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
				
				//建立分组node
				if(!empty($nodegroup))//若不为空
				{
					foreach($nodegroup as &$ng)
					{
						$ng['Nodes'] = explode(',', $ng['Nodes']);
						if(!empty($ng['Nodes']))
						{
							foreach($ng['Nodes'] as &$bg)
							{
								$bg = $hash_node[$bg];
							}
						}
					}
				}
				
				//获取文章id
				$articleid = array();
				foreach($data as $v)
				{
					$articleid[]=$v['ArticleId'];
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
					foreach($data as &$v)
					{
						$v['Node']=$hash_nodelink[$v['ArticleId']];
					}
				}
			}
			
			//获取发布人
			$useridlist = array();
			foreach($data as $p)
			{
				$useridlist[] = $p['ArticleUserId'];
			}
			$useridlist = array_unique($useridlist);
			//建立索引
			$userlist = $query->clear()->addTable('User')->addWhere('UserId', $useridlist, _ORM_OP_IN)->getArray();
			$user_lib = array();
			if(!empty($userlist))
			{
				foreach($userlist as $t)
				{
					$user_lib[$t['UserId']] = $t['UserName'];
				}
			}
			//贴到数据上
			foreach($data as &$q)
			{
				$q['ArticleUser'] = $user_lib[$q['ArticleUserId']];
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
		
		$smarty->params['template'] = $right?'news/candidate.tpl':'news/candidate_view.tpl';
		$smarty->value('tpl', $template)
			->value('group', $nodegroup)
			->value('total', $total)
			->value('data', $data)
			->value('pagenav', $page_html)
			->value('node', json_encode($hash_node))
			->value('right', $right)
			->value('nodes', $nodes);
		$smarty->output();
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
		$is_time = candidate::checkTime($time);
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
		$query = $this->app->orm()->query();
		/*
		$time = $query->addTable('Article')
			->addWhere('ArticleId', $id)
			->addWhere('GameType', intval($_SESSION['gameid']))
			->addField('PublishTime')
			->getValue();
		if(!empty($time))
		{
			$ar_time = explode(' ', $time);
			$time = $_POST['time'].' '.$ar_time[1];
		}else{
			echo json_encode(array('error'=>true,'msg'=>'选择的文章错误'.$query->asSql()));
			return;
		}*/
		$bol = $query->clear()->addTable('Article')
			->addWhere('ArticleId', $id)
			->addWhere('GameType', intval($_SESSION['gameid']))
			->addValue('PublishTime', $time)
			->update();
		if(empty($bol))
			echo json_encode(array('error'=>true,'msg'=>'选择的文章错误'));
		else
			echo json_encode(array('error'=>false,'msg'=>'时间修改成功','time'=>$time));
	}
	
	/**
	 * 更新发布节点
	 * 
	 */
	public function doUpdateNode()
	{
	//判断权限
		if( !in_array($_SESSION['group'],array(3,4)) )
		{
			echo json_encode(array('error'=>true, 'msg'=>'你没权限进行节点操作'));
			return;
		}
		
		$id= intval($_POST['id']);
		
		//过滤node
		$node = $_POST['node'];
		if(empty($node))
		{
			$node = array();
		}
		if(!is_array($node))
		{
			echo json_encode(array('error'=>true,'msg'=>'传递的参数错误'));
			return;
		}
		
		//过滤node
		$new = array();
		if(!empty($node))
		{
			foreach($node as $v)
			{
				is_numeric($v) && $new[] = $v;
			}
		}
		
		//获取原来的node
		$query = $this->app->orm()->query();
		$origin = $query->addTable('NodeLink')
			->addWhere('ArticleId', $id)
			->addWhere('GameType', intval($_SESSION['gameid']))
			->addField('NodeId')
			->getColumn();
		
		//比较两者差集
		$lack = array_diff($new, $origin);
		$surplus = array_diff($origin, $new);
		
		//删除多余的
		if(count($surplus)>0)
			$query->clear('field')->addWhere('NodeId', $surplus, _ORM_OP_IN)->delete();
		//添加缺少的
		if(count($lack)>0)
		{
			foreach($lack as $v)
			{
				$value = array('ArticleId'=>$id, 'NodeId'=>$v, 'GameType'=>intval($_SESSION['gameid']));
				$query->clear()->addTable('NodeLink')->insert($value);
			}
		}
		echo json_encode(array('error'=>false,'data'=>$new));
	}
	/**
	 * 发布操作
	 * @return void
	 */
	public function doRelease()
	{
		//判断权限
		if( !in_array($_SESSION['group'],array(3,4)) )
		{
			echo json_encode(array('error'=>true, 'msg'=>'你没权限进行审核操作'));
			return;
		}
		
		//获取id
		$id = $_POST['id'];
		$tpl = $_POST['tpl'];
		//检查参数
		if( !is_array($id) || empty($id) || !is_array($tpl) || empty($tpl) )
		{
			echo json_encode( array('error'=>true,'msg'=>'请先选中文章') );
			return;
		}	
		//过滤id
		foreach($id as &$a)
			$a = intval($a);
		//过滤$tpl
		foreach($tpl as &$b)
			$b = intval($b);
		
		//建立TPL与Article的索引
		$tpl_link = array();
		foreach($tpl as $k => $v)
		{
			$tpl_link[$v][] = $id[$k];
		}
		
		//获取TPL
		$enum_tpl = array_unique($tpl);
		$query = $this->app->orm()->query();
		$db_tpl = $query->addTable('Template')
			->addField('TemplateId')
			->addField('Template')
			->addWhere('Type', 0)
			->addWhere('TemplateId', $enum_tpl, _ORM_OP_IN)
			->addWhere('GameType', $_SESSION['gameid'])
			->getArray();
		if(empty($db_tpl))
		{
			echo json_encode( array('error'=>true,'msg'=>'连接不上数据库') );
			return;
		}
		//建立TPL索引为了检测是否有空的tpl参数
		$tpl_index = array();
		foreach ($db_tpl as $v)
		{
			$tpl_index[$v['TemplateId']] = $v['Template'];
		}
		
		//获取Article
		$db_atc = $query->clear()->addTable('Article')
			->addWhere('ArticleId', $id, _ORM_OP_IN)
			->addWhere('GameType', $_SESSION['gameid'])
			->getArray();
		//建立Article索引,为了检测是否有错误的参数
		$atc_index = array();
		foreach ($db_atc as $v)
		{
			$atc_index[$v['ArticleId']] = $v;
		}
		
		//记录发表失败的id
		$error = array();
		$success = array();
		
		//生成静态页
		$date = date('Ymd');
		
		foreach($enum_tpl as $tid)
		{
			if(empty($tpl_index[$tid]))
			{
				//将该tpl下的所有的文章id记录下
				$error = array_merge($error,$tpl_link[$tid]);
			}else{
				//生成临时模板文件
				$template_file = tempnam($this->app->cfg['path']['temp'], "ARTICLE");
				file_put_contents($template_file, $tpl_index[$tid]);
				
				//循环生成页面
				foreach($tpl_link[$tid] as $aid)
				{
					$count = $query->clear()->addTable('NodeLink')
						->addField('NodeId','Count','count')
						->addWhere('ArticleId', $aid)
						->addWhere('GameType', $_SESSION['gameid'])
						->getValue();
					if(empty($atc_index[$aid])||($count==0))
					{
						//文章不存在或者节点没有设置
						$error[] = $aid;
						
					}else{
						//生成页面内容
						$article = $atc_index[$aid];
						/*
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
						
						*/
						
						//更新数据库
						$date = date('Ymd', strtotime($article['PublishTime']));
						$url = $this->app->cfg['game'][$_SESSION['gameid']]['host'] . 'news/' . $date . '/';
						
						
						if(!empty($article['SeoKey']))
						{
							$url .= $article['SeoKey'] . '-';
						}
							$url .= $article['ArticleId'] . '.html';
							
						squid_clear($url);
						$query->clear()->addTable('Article')
							->addWhere('ArticleId', $aid)
							->update(array(
								'Status' => 3,
								'UpdateTime'=>date('Y-m-d H:i:s'),
								'Url'=>$url,
								'TemplateId'=>$tid
							));
						//写日志
						$query->clear()->addTable('Log')
							->insert(array(
							'UserId'       => $_SESSION['uid'],
							'ArticleId'      => $aid,
							'UserName'     => $_SESSION['name'],
							'ArticleTitle' => $article['Title'],
							'LogTime'      => date('Y-m-d H:i:s'),
							'GameType'     => $_SESSION['gameid'],
							'Action'       => 5
							));
						$success[] = $aid;
					}
				}
				//删除临时文件
				unlink($template_file);
			}
		}
		
		
		//如果没有文章发布成功
		if(empty($success))
		{
			echo json_encode(array('error'=>true, 'msg'=>'没有文章发布成功。请检查提交的文章和模板是否正确,并且设置了正确的节点。'));
			return;
		}else{
			
			//更新节点
			$nodes = $query->clear()->addTable('NodeLink')
				->addWhere('ArticleId', $success, _ORM_OP_IN)
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
					$manager->updateNode($v);
				}
			}
			
			if(empty($error))
				echo json_encode(array('error'=>false, 'msg'=>'文章全部发布成功。'));
			else
				echo json_encode(array('error'=>false, 'msg'=>'有一部分文章没有发布成功。', 'error'=>$error));
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

	/**
	 * 撤回原稿库
	 */
	public function doBack()
	{
		//判断权限
		if (!in_array($_SESSION['group'],array(2,3,4)))
		{
			echo json_encode(array(
				'error' => true, 
				'msg' => '你没权限进行删除操作'
			));
			return;
		}

		$id = $_POST['id'];
		if(!is_array($id) || count($id) < 1)
		{
			echo json_encode(array(
				'error' => true,
				'msg' => '请先选中文章'
			));
			return;
		}

		$db = $this->app->orm()->query();
		$db->addTable('Article');
		$db->addValue('Status', 1);
		$db->addWhere('GameType', intval($_SESSION['gameid']));
		$db->addWhere('ArticleId', $id, _ORM_OP_IN);
		$db->addWhere('Status', 2);
		$rs = $db->update();

		if ($rs)
		{
			echo json_encode(
				array(
					'error'=> false,
					'msg'=> '选中的文章已经全部撤回原稿库!'
				)
			);
			return;
		}

		echo json_encode(
			array(
				'error' => true,
				'msg' => '数据库更新失败!'
			)
		);
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
$app->run();