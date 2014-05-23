<?php

/**
 * 智能配置
 * 
 * @author 苏宁 <snsnsky@gmail.com>
 * 
 * $Id$
 */

if ($_SERVER['REMOTE_ADDR'] == '127.0.0.1')
{
	define("DGCFG_HOST", "127.0.0.1");
	define("DGCFG_NAME", "express");
	define("DGCFG_USER", "root");
	define("DGCFG_PWD", "123456");
	define("BASE_URL", "http://local.express.com/");
}
else 
{
	define("DGCFG_HOST", "127.0.0.1");
	define("DGCFG_NAME", "express");
	define("DGCFG_USER", "express");
	define("DGCFG_PWD", "express");
	define("BASE_URL", "http://express.wuhan027.com/");
}

?>
