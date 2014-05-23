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

class play extends Action
{
	public function doDefault()
	{		
		$cfg_file = $this->app->cfg['path']['conf'] . 'index.cfg.conf';
		$cfg_data = array();
		if (file_exists($cfg_file))
		{
			$cfg_data = unserialize(file_get_contents($cfg_file));
			if (!is_array($cfg_data))
			{
				$cfg_data = array();
			}
		}
		$smarty = $this->app->page();		
		$smarty->value('play', $cfg_data);
		$smarty->output();		
	}
		
	public function doSave()
	{
		$save_root = dirname($this->app->cfg['path']['root']) . '/public/index/';
		
		$cfg_file = $this->app->cfg['path']['conf'] . 'index.cfg.conf';
		$cfg_data = array();
		if (file_exists($cfg_file))
		{
			$cfg_data = unserialize(file_get_contents($cfg_file));
			if (!is_array($cfg_data))
			{
				$cfg_data = array();
			}
		}
		
		$new_data = array();
		
		for ($i = 0; $i < 4; $i++)
		{
			$new_data[$i] = array();
			if ($_FILES['file']['error'][$i] == 0)
			{
				move_uploaded_file($_FILES['file']['tmp_name'][$i], $save_root . $i . '.jpg');
				$new_data[$i]['img'] = '/public/index/' . $i . '.jpg';
			}
			else 
			{
				if (!empty($cfg_data[$i]['img']))
				{
					$new_data[$i]['img'] = $cfg_data[$i]['img'];
				}
				else
				{
					$new_data[$i]['img'] = '';
				}	
			
			}
			$new_data[$i]['title'] = $_POST['title'][$i];
			$new_data[$i]['link'] = $_POST['link'][$i];
		}
		
		file_put_contents($cfg_file, serialize($new_data));
		
		$this->showMsg('幻灯片更新成功');
	}
}

$app->run();
?>