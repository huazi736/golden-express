<?php
/**
 * 管理模块
 * 
 * 
 * @author 苏宁 <suning@126.com>
 * 
 * $Id$
 */

class AdminMod
{
	public function showList($tableinfo, $page)
	{
		global $app;
		$db = $app->orm()->query();
		
		// 取总数
		$db->addTable(TABLE_PREFIX . $tableinfo['_table']);
		$db->getValue('count()');
		
		
		foreach ($tableinfo as $k => $v)
		{
			if (strpos($v, '_') !== 0)
			{
				$db->addField($k);
			}
		}
		$db->getArray(null, , $tableinfo['_pagesize']);
		
		
	}
	
	public function showAdd()
	{
		
	}
	
	public function showEdit()
	{
		
	}
}

?>