<?php

/**
 * Action类
 *
 * @package lib
 * @subpackage core
 * @author 苏宁 <snsnsky@gmail.com>
 */

class Action 
{
	
	/**
	 * 应用程序类
	 * @var Application
	 * @access protected
	 */
	var $app;
	
	/**
	 * 构造函数
	 *
	 * @param Application &$app 应用程序类
	 */
	function __construct(& $app) 
	{
		$this->app = $app;
	}
	
	/**
	 * 默认Action
	 */
	function doDefault() { /* nothing */ }
	
	
	/**
	 * 通过FriePHP进行调试，将调试信息输出到头消息中
	 *
	 * 相关链接：http://www.firephp.org/
	 * 
	 * @return void
	 */
	function debug()
	{
		if (DEBUG)
		{
			$instance = FirePHP::getInstance(true);
			  
			 $args = func_get_args();
			 return call_user_func_array(array($instance,'fb'),$args);
			      
			 return true;				
		}
	}
	
	
	public function output($data)
	{
		echo json_encode($data);
		exit;
	}	
	
	/**
	 * 输出验证输出处理 
	 */
	function doCode() 
	{
		import('util.ValidateCode');
		$img = new ValidateCode();
		
		/** 设置字体文件与临时目录 **/
		$img->font_dir = $this->app->cfg['path']['fonts'];
		$img->temp_dir = $this->app->cfg['path']['temp'];
		
		$img->session_name='VALIDATE_CODE';
		$img->background_color(array('#FEFDCF','#DFFEFF','#FFEEE1','#E1F4FF'));
		$img->grid_color(array('#FAD1AD','#FFD9FB','#D1D1E0'));
		$img->text_color(array('#801D00','#5C0497','#0289B0'));
		$img->overlap_text(false);
		$img->random_y_factor(4);
		$img->string_length(4);
		$img->frame_number(3);
		$img->frame_delay(80);
		$img->generate();
	}
	
	/**
	 * 统一消息提示
	 *
	 * @param string $msg
	 * @param string $url
	 * @param string $pic
	 */
	function showMsg($msg, $url = '', $target = '_self', $pic = 'ok.gif')
	{
		$url =  empty($url) ? $_SERVER['HTTP_REFERER'] : $url;
		if ($url == '')
		{
			$url = '/index.php';
		}
		$smarty = $this->app->page();
		$smarty->value('msg', $msg);
		$smarty->value('url', $url);
		$smarty->value('pic', $pic);
		$smarty->value('target', $target);
		$smarty->params['template'] = 'msg.tpl';
		$smarty->output();
		exit;
	}
	
	/**
	 * 手工检查权限
	 *
	 * @param array $allow_group
	 */
	function loginCheck($allow_group)
	{
		if (!is_array($allow_group))
		{
			$this->showMsg('权限组参数错误');
		}
		if (!in_array($_SESSION['group'], $allow_group))
		{
			$this->showMsg("您已经登录, 但无权限访问此页. 请更换用户后再试!", '/index.php', '_top');
		}
		return true;
	}
	
	
	/**
	 * 验证验证码是否正确
	 *
	 * @param string $code
	 * @return boolean
	 */
	function _checkCode($code)
	{
		return ($code == $_SESSION['VALIDATE_CODE']);
	}	
}
?>