<?php
/**
 * CMS 用户管理
 * 
 * 
 * @author 苏宁 <suning@corp.the9.com>
 * 
 * $Id: user.php 362 2009-12-08 03:15:24Z suning $
 */

$global_allow_group = array(4);
require_once('../../common.inc.php');

class user extends Action
{
	/**
	 * 程序入口
	 *
	 */
	public function doDefault()
	{
		$smarty = $this->app->page();
		$smarty->params['template'] = 'admin/add_user.tpl';
		if ($_SESSION['uid'] == 1)
		{
			$smarty->value('gamelist', $this->app->cfg['game']);
		}
		else 
		{
			$smarty->value('gamelist', array($this->app->cfg['game'][$_SESSION['gameid']]));
		}
		$smarty->output();
	}
	
	/**
	 * 添加用户
	 *
	 */
	public function doAddUser()
	{		
		extract($_POST, EXTR_SKIP);
		if (empty($username) || empty($password))
		{
			$this->showMsg('用户名密码必须填写!');
		}
		if (!is_array($game_group) || count($game_group) < 1)
		{
			$this->showMsg('必须选择一个游戏!');
		}
		$username = trim($username);
		$password = md5(trim($password));
		
		// 检查用户是否存在
		$db = $this->app->orm()->query();		
		$db->addTable('User');
		$db->addField('UserId');
		$db->addWhere('UserName', $username);
		$uid = $db->getValue();
		if (!empty($uid))
		{
			$this->showMsg('用户名已经存在, 要修改用户权限请直接编辑用户!');
		}
		
		// 生成新的group属性
		$groups = array();
		if ($_SESSION['uid'] == 1)
		{
			// 是管理员
			foreach ($game_group as $v)
			{
				if (isset($this->app->cfg['game'][$v]))
				{
					$g_key ='group' . $v;
					$gid = isset($$g_key) && isset($this->app->cfg['admin_group'][$$g_key]) ? $$g_key : 1;
					$groups[$v] = $gid;
				}
			}			
		}
		else 
		{
			// 不是管理员
			$g_key = 'group' . $_SESSION['gameid'];
			$gid = isset($$g_key) && isset($this->app->cfg['admin_group'][$$g_key]) ? $$g_key : 1;
			$groups = array(
				$_SESSION['gameid'] => $gid
			);
		}		
		
		$phone = isset($phone) ? $phone : '';
		$email = isset($email) ? $email : '';
		$db->clear();
		$db->addTable('User');
		$db->addValue('UserName', $username);
		$db->addValue('Password', $password);
		$db->addValue('Phone', $phone);
		$db->addValue('Email', $email);
		$db->addValue('GameGroup', serialize($groups));
		$db->addValue('CreateTime', date("Y-m-d H:i:s"));
		$rs = $db->insert();
		if ($rs)
		{
			$this->showMsg('用户添加成功!');
		}
		$this->showMsg('添加失败!');
	}
	
	/**
	 * 管理用户
	 *
	 */
	public function doManagerUser()
	{
		$db = $this->app->orm()->query();		
		$db->addTable('User');
		$db->addField('*');
		$data = $db->getArray();
		is_array($data) || $data = array();
		
		foreach ($data as & $v)
		{
			$v['GameGroup'] = unserialize($v['GameGroup']);
		}
		
		$smarty = $this->app->page();
		$smarty->params['template'] = 'admin/manager_user.tpl';
		$smarty->value('userlist', $data);
		$smarty->value('admin_group', $this->app->cfg['admin_group']);
		$smarty->value('game_gourp', $this->app->cfg['game']);
		$smarty->output();
	}
	
	/**
	 * 编辑用户
	 *
	 */
	public function doEditUser()
	{
		$uid = intval($_GET['uid']);
		$user_info = $this->getUserInfo($uid);
		if ($user_info == false)
		{
			exit;
		}
		$smarty = $this->app->page();
		$smarty->params['template'] = 'admin/edit_user.tpl';
		$smarty->value('user', $user_info);
		$smarty->value('admin', $_SESSION['uid'] == 1);
		$smarty->value('gameid', $_SESSION['gameid']);		
		$smarty->value('uid', $uid);
		$smarty->output();
	}
	
	/**
	 * 编辑用户信息
	 *
	 */
	public function doEditUserInfo()
	{
		$uid = intval($_POST['uid']);
		$user_info = $this->getUserInfo($uid);
		if ($user_info == false)
		{
			exit('0');
		}
		if ($uid == 1)
		{
			$this->showMsg('超级管理员不能编辑!');
		}
		
		extract($_POST, EXTR_SKIP);
		
		is_array($game_group) || $game_group = array();
		
		// 生成新的group属性
		$groups = array();
		if ($_SESSION['uid'] == 1)
		{
			// 是管理员
			foreach ($game_group as $v)
			{
				if (isset($this->app->cfg['game'][$v]))
				{
					$g_key ='group' . $v;
					$gid = isset($$g_key) && isset($this->app->cfg['admin_group'][$$g_key]) ? $$g_key : 1;
					$groups[$v] = $gid;
				}
			}
			$user_info['GameGroup'] = $groups;
		}
		else 
		{
			// 不是管理员
			$g_key = 'group' . $_SESSION['gameid'];
			$gid = isset($$g_key) && isset($this->app->cfg['admin_group'][$$g_key]) ? $$g_key : 1;
			if (in_array($_SESSION['gameid'], $game_group))
			{
				$user_info['GameGroup'][$_SESSION['gameid']] = $gid;
			}
			else 
			{
				unset($user_info['GameGroup'][$_SESSION['gameid']]);
			}
			if (count($user_info['GameGroup']) == 0)
			{
				$user_info['GameGroup'] = array();
			}
		}	
		
		$db = $this->app->orm()->query();
		$db->addTable('User');
		if (!empty($password))
		{
			$db->addValue('Password', md5($password));
		}
		$db->addValue('Email', $email);
		$db->addValue('Phone', $phone);
		$db->addValue('GameGroup', serialize($user_info['GameGroup']));
		$db->addWhere('UserId', $uid);
		$db->update();
		$this->showMsg('修改成功', '/modules/admin/user.php?do=ManagerUser');	
	}
	
	
	/**
	 * 删除用户
	 *
	 */
	public function doDelUser()
	{
		$uid = intval($_GET['uid']);
		$user_info = $this->getUserInfo($uid);
		
		if ($user_info == false)
		{
			exit;
		}
		if ($uid == 1)
		{
			$this->showMsg('超级管理员不能被删除!');
		}
		if ($_SESSION['uid'] != 1) 
		{
			$this->showMsg('超级管理员才能删除用户!');			
		}
		
		$db = $this->app->orm()->query();
		$db->addTable('User');
		$db->addWhere('UserId', $uid);
		$rs = $db->delete();
		$this->showMsg('删除成功!');	
	}
	
	/**
	 * 根据用户ID取用户信息
	 *
	 * @param integer $uid
	 */
	private function getUserInfo($uid)
	{
		$db = $this->app->orm()->query();
		$db->addTable('User');
		$db->addWhere('UserId', $uid);
		$rs = $db->getRow();
		if (isset($rs['UserId']))
		{
			$rs['GameGroup'] = unserialize($rs['GameGroup']);
			return $rs;
		}
		return false;		
	}
}
$app->run();

?>