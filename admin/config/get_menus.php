<?php
include "menus.cfg.php";

$kefu = array('1-0', '1-1', '1-2', '10-0', '10-1', '16-0', '16-1');

echo serialize($kefu);
exit;

$arr = array();
foreach($cfg['menu'] as $k => $v)
{
	$flag = false;
	foreach ($v['menus'] as $key => $val)
	{
		if ($flag == false)
		{
			$arr[] = $k . '-0';
		}
		$arr[] = $k . '-' . $key;
		$flag = true;
	}
}

echo serialize($arr);
?>