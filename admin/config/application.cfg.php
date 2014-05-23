<?php
/**
 * 配置文件－－主配置文件
 * @package main
 * @subpackage configure
 * @author 苏宁 <snsnsky@gmail.com>
 * @version 0.1 20071031
 * 
 * $Id: application.cfg.php 226 2009-09-16 09:32:17Z suning $
 */

//调试开关
define('DEBUG', false);

//是否需要进行SESSION处理
define('SESSION', true);

// 表前缀
define('TABLE_PREFIX', 'sn_');

// 分页数
define("PAGE_SIZE", 10);

//设置时区
date_default_timezone_set('Asia/Shanghai');

//初始化配置变量
$cfg = array();

$cfg['path']['conf'] = dirname(__FILE__) . '/';
$cfg['path']['root'] = dirname($cfg['path']['conf']) . '/';

//  加载配置
require_once $cfg['path']['root'] . '/../base.inc.php';

// 基础配置
$cfg['url']['froot'] = BASE_URL;
$cfg['url']['root'] = $cfg['url']['froot'] . 'admin/';


$cfg['footer'] = '金链接后台管理 <span style="color:#FA891B">1.0.0</span>';
$cfg['site']['title'] = '金链接后台管理';


//主数据库，默认连接该数据库
$cfg['db'] = array(
	'params'   => array('driver'=> 'mysql', 'host'=> DGCFG_HOST, 'name'=> DGCFG_NAME, 'user'=> DGCFG_USER, 'password'=> DGCFG_PWD,),
	'options'  => array('persistent'=> false, 'tablePrefix' => '', 'charset' => 'utf8'),
);

//页面信息
$cfg['page'] = array(
	'charset'			=> 'UTF-8',
	'contentType'		=> 'text/html',
	'title'			=> '',
	'cached'			=> true,
	'engine'			=> 'smarty',
	'css'				=> array(),
	'js'				=> array(),
	);


//其他路径
$cfg['path'] = array_merge($cfg['path'], array(
	'lib'				=> $cfg['path']['root'] . 'lib/',
	'class'			=> $cfg['path']['root'] . 'lib/',
	'common'			=> $cfg['path']['root'] . 'lib/',
	'cache'			=> $cfg['path']['root'] . 'cache/',
	'upload'			=> $cfg['path']['root'] . 'public/upload/',
	'fonts'			=> $cfg['path']['root'] . 'public/fonts/',
	'temp'			=> $cfg['path']['root'] . 'public/temp/',
	'module'		=> $cfg['path']['root'] . 'modules/',
	'output'		=> $cfg['path']['root']. 'output/'
	));
    
	
//URL设置
$cfg['url'] = array_merge($cfg['url'], array(
	'js'				=> $cfg['url']['root'] . 'public/js/',
	'css'				=> $cfg['url']['root'] . 'public/css/',
	'images'			=> $cfg['url']['root'] . 'public/images/',
	'theme'			    => $cfg['url']['root'] . 'public/theme/',
	));

    
//Smarty
$cfg['smarty'] = array(
	'template_dir'	=> $cfg['path']['root'] . $cfg['theme']['current'] . 'templates/',
	'compile_dir'		=> $cfg['path']['cache'] . 'smarty/',
	'left_delimiter'	=> '{',
	'right_delimiter'	=> '}',
	);
    
	
//cache
$cfg['cache'] = array(
	'root'			=> $cfg['path']['cache'],  // engine=memcached 时为服务器地址 
	'engine'			=> 'file', //file|memcached
	'port'			=> 11211, //engine=memcached 时才有意义 
	'timeout'			=> 60, //engine=memcached 时才有意义 
	);

?>