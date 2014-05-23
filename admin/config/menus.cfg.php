<?php

/**
 * 配置文件－－管理配置文件
 * @package main
 * @subpackage configure
 * @author 苏宁 <suning@corp.the9.com>
 * 
 * $Id$
 */

$cfg['menu'] = array(
	'1' => array(
		'name' => '运单管理',
		'expand' => true,
		'menus' => array(
			'1' => array(
				'name' => '提交运单',
				'url' => 'mod/bill/add.php'
			),
			'2' => array(
				'name' => '运单管理',
				'url' => 'mod/bill/manage.php'
			)
		)
	),
	'2' => array(
		'name' => '货运单管理',
		'expand' => true,
		'menus' => array(
			'1' => array(
				'name' => '货运管理',
				'url' => 'mod/transport/manage.php'
			),			
		)
	),
	'5' => array(
		'name' => '新闻管理',
		'expand' => true,
		'menus' => array(
			'1' => array(
				'name' => '新闻发布',
				'url' => 'mod/news/add.php'
			),
			'2' => array(
				'name' => '新闻管理',
				'url' => 'mod/news/manage.php'
			)
		)
	),
	'10' => array(
		'name' => '客户反馈',
		'expand' => true,
		'menus' => array(
			'1' => array(
				'name' => '反馈管理',
				'url' => 'mod/gbook/manage.php'
			)			
		)
	),
	'15' => array(
		'name' => '管理员管理',
		'expand' => true,
		'menus' => array(
			'1' => array(
				'name' => '添加帐号',
				'url' => 'mod/adminuser/add.php'
			),
			'2' => array(
				'name' => '人员管理',
				'url' => 'mod/adminuser/manage.php'
			)
		)
	),	
	'16' => array(
		'name' => '客户管理',
		'expand' => true,
		'menus' => array(
			'1' => array(
				'name' => '客户管理',
				'url' => 'mod/user/manage.php'
			)			
		)
	),
	'20' => array(
		'name' => '服务项目',
		'expand' => true,
		'menus' => array(
			'1' => array(
				'name' => '国际快递',
				'url' => 'mod/help/data.php?sid=1'
			),
			'2' => array(
				'name' => '国际货运',
				'url' => 'mod/help/data.php?sid=2'
			),
			'3' => array(
				'name' => '电子商务',
				'url' => 'mod/help/data.php?sid=3'
			)
		)
	),
	'25' => array(
		'name' => '服务指南',
		'expand' => true,
		'menus' => array(
			'1' => array(
				'name' => '操作流程',
				'url' => 'mod/help/data.php?sid=4'
			),
			'2' => array(
				'name' => '寄件须知',
				'url' => 'mod/help/data.php?sid=5'
			),
			'3' => array(
				'name' => '索赔挂失',
				'url' => 'mod/help/data.php?sid=6'
			)
		)
	),
	'30' => array(
		'name' => '网点加盟',
		'expand' => true,
		'menus' => array(
			'1' => array(
				'name' => '加盟条件',
				'url' => 'mod/help/data.php?sid=7'
			),
			'2' => array(
				'name' => '加盟流程',
				'url' => 'mod/help/data.php?sid=8'
			)			
		)
	),
	'35' => array(
		'name' => '价格查询',
		'expand' => true,
		'menus' => array(
			'1' => array(
				'name' => '价格查询',
				'url' => 'mod/help/data.php?sid=9'
			)					
		)
	),
	'40' => array(
		'name' => '图片幻灯片',
		'expand' => true,
		'menus' => array(
			'1' => array(
				'name' => '图片幻灯片管理',
				'url' => 'mod/index/play.php'
			)
		)
	),
	'45' => array(
		'name' => '关于我们',
		'expand' => true,
		'menus' => array(
			'1' => array(
				'name' => '关于我们',
				'url' => 'mod/help/data.php?sid=10'
			),
			'2' => array(
				'name' => '联系我们',
				'url' => 'mod/help/data.php?sid=11'
			),
			'3' => array(
				'name' => '职业发展',
				'url' => 'mod/help/data.php?sid=12'
			),
			'4' => array(
				'name' => '在线支付',
				'url' => 'mod/help/data.php?sid=13'
			),
			'5' => array(
				'name' => '专业知识',
				'url' => 'mod/help/data.php?sid=14'
			)
		)
	),
	'50' => array(
		'name' => '帮助中心',
		'expand' => true,
		'menus' => array(
			'1' => array(
				'name' => 'FAQ发布管理',
				'url' => 'mod/faq/add.php'
			)			
		)
	)	
);

?>