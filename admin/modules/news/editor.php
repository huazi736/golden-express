<?php
/**
 * 添加/编辑原文
 * @author 庾洋 <yuyangvi@gmail.com>
 * $Id$
 */
$global_allow_group = array(1,2,3,4);
require_once('../../common.inc.php');

class editor extends Action
{
	/**
	 * 程序入口
	 *
	 */
	public function doDefault()
	{
		$smarty = $this->app->page();
		if( ($id = intval($_GET['id']))>0 )
		{
			//编辑文章
			$query=$this->app->orm()->query();
			$result = $query->addTable('Article')
				->addWhere('GameType', $_SESSION['gameid'])
				->addWhere('ArticleId', $id)
				->getRow();
			$result['Thumb'] = $this->app->cfg['url']['root'].'output/'.$this->app->cfg['game'][$_SESSION['gameid']]['key'].'/images/'.date('Ymd',strtotime($result['CreateTime'])).'/thumb'.$result['ArticleId'].'.jpg';
			
			//转换尖括号
			$content = str_replace('<', '&lt;', $result['Content']);
			$result['Content'] = str_replace('>', '&gt;', $content);
			
			$smarty->value('result', $result)->value('refer', $_SERVER['HTTP_REFERER']);
		}
		$smarty->params['template'] = 'news/editor.tpl';
		$smarty->output();
	}

	/**
	 * 编辑后提交
	 */
	public function doEdit()
	{
		$id = intval($_POST['articleid']);
		$title = $_POST['title'];
		$title = trim($title);
		if(empty($title)) 
			$title = '[请尽快补充标题]';
		$subtitle = $_POST['subtitle'];
		$link = $_POST['link'];
		$content = $_POST['FCKeditor1'];
		$desc1   = $_POST['desc1'];
		$desc2   = $_POST['desc2'];
		$desc3   = $_POST['desc3'];
		$key     = $_POST['key'];
		$now = date('Y-m-d H:i:s');
		
		//操作数据库
		$query = $this->app->orm()->query();
		$query = $query->addTable('Article')
			->addValue('Sort', 0)
			->addValue('SeoKey', $key)
			->addValue('Title', $title)
			->addValue('SubTitle', $subtitle)
			->addValue('Link', $link)
			->addValue('Content', $content)
			->addValue('UpdateTime', $now)
			->addValue('UpdateUserId', $_SESSION['uid'])
			->addValue('Desc1', $desc1)
			->addValue('Desc2', $desc2)
			->addValue('Desc3', $desc3);
		if($id>0)//修改
		{
			$action = 2;
			$bol = $query->addWhere('ArticleId', $id)
				->addWhere('GameType', $_SESSION['gameid'])
				->update();
		}
		
		else//添加
		{
			$action = 1;
			$bol = $query->addValue('CreateTime', $now)
				->addValue('ServerTime', '0000-00-00 00:00:00')
				->addValue('PublishTime', '0000-00-00 00:00:00')
				->addValue('GameType', $_SESSION['gameid'])
				->addValue('ArticleUserId', $_SESSION['uid'])
				->addValue('TemplateId', 0)
				->addValue('Status', 1)
				->addValue('Url', '')
				->insert();
		}
		//导航为跳转返回做准备
		$refer = $_POST['refer']?$_POST['refer']:'original.php';
		
		if(!empty($bol))
		{
			//上传封面
			if(empty($id))
				$id = $query->getLastId();
			
			//先写日志
			$query->clear()->addTable('Log')
				->insert(array(
					'UserId'       => $_SESSION['uid'],
					'ArticleId'      => $id,
					'UserName'     => $_SESSION['name'],
					'ArticleTitle' => $title,
					'LogTime'      => date('Y-m-d H:i:s'),
					'GameType'     => $_SESSION['gameid'],
					'Action'       => $action
				));
			//获取生成时间
			$row = $query->clear()->addTable('Article')
				->addWhere('ArticleId', $id)
				->addWhere('GameType', $_SESSION['gameid'])
				->addField('CreateTime')
				->addField('Status')
				->getRow();
			$date = $row['CreateTime'];
			$status = $row['Status'];
			$date = date('Ymd', strtotime($date));
			$imgpath = $this->app->cfg['path']['root'].'output/'.$this->app->cfg['game'][$_SESSION['gameid']]['key'].'/images/'.$date.'/';
			$fileField = $_FILES['pic'];
			
			//无图片上传
			if(empty($fileField))
			{
				$this->app->redirect($refer);
				return;
			}
			//上传成功
			if ($fileField['error'] == UPLOAD_ERR_OK)
			{
				$dirname = '';
				$folders = explode('/',$imgpath);
				foreach ($folders as $folder) {
					$dirname .= $folder . '/';					
					if ($folder!='' && $folder!='.' && $folder!='..' && !is_dir($dirname)) {
						mkdir($dirname);
					}
				}
				chmod($imgpath,0777);
				
				//
				//$ext = substr($fileField['name'],strrpos($fileField['name'],'.'));
				$newFile = 'thumb'.$id.'.jpg';
				//move_uploaded_file不会自己覆盖旧文件
				if (file_exists($imgpath.$newFile))
				{
					unlink($imgpath . $newFile);
				}
				if (move_uploaded_file($fileField['tmp_name'], $imgpath . $newFile)) {
					//上传成功;
					chmod($imgpath . $newFile, 0777);
					//$this->app->redirect('original.php');
				}
				else{
					//上传失败,移动文件失败
					//echo $fileField['tmp_name'], $imgpath . $newFile;
//					/echo '上传失败,移动文件失败';
				}
				$this->app->redirect($refer);
			}
			else
			{
				//上传失败
				echo $fileField['error'];
				$this->app->redirect($refer);
			}
			//已发布的就需要同步
			if($status == 3)
			{
				$atc = $query->clear()->addTable('Article')
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
		}else{
			//数据库失败
			echo '数据库失败';
			$this->app->redirect('editor.php');
		}
	}
}

$app->run();
?>