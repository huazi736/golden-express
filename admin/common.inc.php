<?php

/**
 * 应用初始化程序
 * 
 * @package core
 * @subpackage common
 * @author 苏宁 <snsnsky@gmail.com>
 * 
 * $Id: common.inc.php 84 2009-07-30 02:04:47Z suning $
 */

require_once(dirname(__FILE__) . '/' . 'config/application.cfg.php');
require_once($cfg['path']['conf'] . 'menus.cfg.php');
require_once($cfg['path']['lib'] . 'base.inc.php');
$cfg['path']['current'] = dirname($_SERVER['SCRIPT_FILENAME']) . '/';

header('Content-type: ' . $cfg['page']['contentType'] . '; charset=' . $cfg['page']['charset']);

if (DEBUG)
{
	// import('core.FirePHP');
}

if (SESSION)
{
	session_start();
}
	
// 初始化application
$app = new Application();

?>