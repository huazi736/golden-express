<?php
/**
 * 网站入口
 * 
 * @author 苏宁 <snsnsky@gmail.com>
 * 
 * $Id$
 */

require_once('./common.inc.php');

class user extends Action
{
	
	private $uid = 0;
	
	private $nick = null;
	
	private $name = null;
	
	private $db = null;
	
	public function  __construct()
	{
		global $app;
		parent::__construct($app);
		
		if (empty($_SESSION['ep_uid']))
		{
			$app->redirect('index.php');
		}
		
		$this->uid = $_SESSION['ep_uid'];
		$this->nick = $_SESSION['ep_nick'];
		$this->name = $_SESSION['ep_name'];
		$this->db = $app->orm()->query();
	}
	
	/**
	 * 程序入口
	 *
	 */
	public function doDefault()
	{
		$user = $this->db->getRow("select * from user where UserId=" . $this->uid);		
		$services = $this->db->getRow("select * from sn_adminuser where UserId=" . $user['ServiceId']);
		
		$page = $this->app->page();
		$page->value('user', $user);
		$page->value('services', $services);
		$page->output();	
	}
	
	public function doTransport()
	{
		$warehouse_file = $this->app->cfg['path']['conf'] . 'warehouse.cfg.php';
		include $warehouse_file;
	
		$page = $this->app->page();
		$page->params['template'] = 'user/transport.tpl';
		$page->value('warehouse_cfg', $warehouse_cfg);
		$page->output();
	}
	
	public function doTransportList()
	{		
	    
	    $page = max(1, intval($_GET['page']));
		$pagesize = PAGE_SIZE;
		
		$smarty = $this->app->page();
		
		$db = $this->app->orm()->query();
		$count = $db->getValue("select count(*) from transport where UserId='{$this->uid}'");
		$pagemax = max(1, $count / $pagesize);
		
		$this->db->clear();
		$offset = ($page - 1) * $pagesize;
		$trans = $this->db->getArray("select * from transport where UserId='{$this->uid}' order by CreateTime DESC",  $offset, $pagesize);
		$pagehtml = $smarty->getNav($pagemax, 7, $page, '<a href="?do=transportlist&page=%d">%d</a>', '<strong>%d</strong>');

		$smarty->params['template'] = 'user/transportlist.tpl';
		$smarty->value('trans', $trans);
		$smarty->value('pages', $pagehtml);
		$smarty->output();
	}
	
	public function doaddTran()
	{
	    /*
	    $warehouse_file = $this->app->cfg['path']['conf'] . 'warehouse.cfg.php';
		include $warehouse_file;
		
	    $fields = array('FromName', 'FromPhone', 'FromCompany', 'FromAddr', 
			'FromCity', 'FromProvince', 'FromPost', 'FromCountry', 'ToName', 
			'ToPhone', 'ToCompany', 'ToAddr', 'ToCity', 'ToProvince', 'ToPost', 
			'ToCountry', 'SendSign', 'FromPos', 'ToPos', 'TranBillKey', 'WarehouseId');
		$count = count($_POST['boxcount']);
		
		$data = array();
		foreach($fields as $v)
		{
			$data[$v] = trim($_POST[$v]);
		}
		$data['CreateTime'] = date("Y-m-d H:i:s");
		$data['GoodsNum'] = $count;
		$data['Type'] = 0;
		$data['UserId'] = $this->uid;
		$data['Status'] = 1;
		$data['BillKey'] = '';
		$data['TranBill'] = 1;
		$data['WarehouseName'] = $warehouse_cfg[$_POST['WarehouseId']];
		
		$db = $this->db->clear();
		$db->addTable('bill');
		$db->insert($data);
		
		$box_data = array();
		
		for ($i = 1; $i <= $count; $i++)
		{
			$box_data[$i] = array(
				'pos' => $i,
				'weight' => $_POST['weight' . $i],
				'unit' => $_POST['unit' . $i],
				'bulk' => $_POST['bulk' . $i],
				'item' => array()			
			);
			
			foreach ($_POST['key' . $i] as $k => $v)
			{
				$box_data[$i]['item'][] = array(
					'key' => $_POST['key' . $i][$k],
					'info' => $_POST['info' . $i][$k],
					'money' => $_POST['money' . $i][$k]
				);
			}
		}
		
		$box_data = serialize($box_data);
		
		$bid = $db->getLastId();
		
		if ($bid > 0)
		{
			$data = array(
				'BillId' => $bid,
				'Type' => 0,
				'CreateTime' => date("Y-m-d H:i:s"),
				'GoodsKey' => '',
				'Goods' => $box_data
			);
			$db->clear();
			$db->addTable('goods');
			$db->insert($data);
		}
		
		echo '<script>alert("添加成功!")</script>';
		$this->app->redirect('user.php?do=transport');
		*/
	    
		$warehouse_file = $this->app->cfg['path']['conf'] . 'warehouse.cfg.php';
		include $warehouse_file;
		
		$count = count($_POST['boxcount']);	
		$box_data = array();
		
		for ($i = 1; $i <= $count; $i++)
		{
			$box_data[$i] = array(
				'pos' => $i,
				'weight' => $_POST['weight' . $i],
				'unit' => $_POST['unit' . $i],
				'bulk' => $_POST['bulk' . $i],
				'item' => array()			
			);
			
			foreach ($_POST['key' . $i] as $k => $v)
			{
				$box_data[$i]['item'][] = array(
					'key' => $_POST['key' . $i][$k],
					'info' => $_POST['info' . $i][$k],
					'money' => $_POST['money' . $i][$k]
				);
			}
		}
		
		$box_data = serialize($box_data);
		
		$data = array(
			'BillKey' => $_POST['TranBillKey'],
		    'BillName' => $_POST['TranBillName'],
			'WarehouseId' => $_POST['WarehouseId'],
			'WarehouseName' => $warehouse_cfg[$_POST['WarehouseId']],
			'CreateTime' => date("Y-m-d H:i:s"),
			'UserId' => $this->uid
		);
		
		$db = $this->db->clear();
		$db->addTable('transport');
		$db->insert($data);
		
		$tid = $db->getLastId();
		
		if ($tid > 0)
		{
			$data = array(
				'BillId' => $tid,
				'Type' => 1,
				'CreateTime' => date("Y-m-d H:i:s"),
				'GoodsKey' => '',
				'Goods' => $box_data
			);
			$db->clear();
			$db->addTable('goods');
			$db->insert($data);
		}
		
		echo '<script>alert("添加成功!")</script>';
		$this->app->redirect('user.php?do=transportlist');
	}
	
	public function doAddBill()
	{
		$page = $this->app->page();
		$page->params['template'] = 'user/addbill.tpl';
		$page->output();
	}
	
    public function doAddBillFromTransport()
	{
	    $tid = trim($_GET['tid']);
	    $tids = explode(",", $tid);
	    $transport_id = array();
	    foreach ($tids as $v)
	    {
	        $v = intval($v);
	        if ($v > 0)
	        {
	            $transport_id[] = $v;
	        }
	    }
	    
	    if (count($transport_id) > 0)
	    {
	        $db = $this->db->clear();
	        $transport_id_sql = "('" . implode("','", $transport_id) . '\')';
	        $transports = $db->getArray("select * from transport where TransportId in $transport_id_sql and Status != '2' and UserId='{$this->uid}'");
	    }
	    if (count($transports) == 0)
	    {
	        $this->app->redirect("user.php?do=transportlist");
	    }
	    
	    // 获取合法的transport_id
	    $real_transport_id = array();
	    foreach ($transports as $v)
	    {
	        $real_transport_id[] = $v['TransportId'];
	    }	    
	    if (count($real_transport_id) == 0)
	    {
	        $this->app->redirect("user.php?do=transportlist");
	    }
	    $real_transport_id_sql = "('" . implode("','", $real_transport_id) . '\')';         
	    
	    // 获取物品信息
	    $db = $this->db->clear();
	    $goods = $db->getArray("select * from goods where BillId in $real_transport_id_sql and Type='1'");
	    $goods_box = array();
	    $goods_box_pos = 1;
	    foreach ($goods as $v)
	    {
	        $v['Goods'] = unserialize($v['Goods']);
	        foreach ($v['Goods'] as $val)
	        {
	            $val['pos'] = $goods_box_pos;
	            $goods_box[$goods_box_pos] = $val;
	            $goods_box_pos++;
	        }
	    }

		$page = $this->app->page();
		$page->value('transports', $transports);
		$page->value('goods', $goods);
		$page->value('goodsbox', $goods_box);
		$page->params['template'] = 'user/addbillfromtransport.tpl';
		$page->output();
	}
	
    public function dosaveBillFromTransport()
	{	    
		$fields = array('FromName', 'FromPhone', 'FromCompany', 'FromAddr', 
			'FromCity', 'FromProvince', 'FromPost', 'FromCountry', 'ToName', 
			'ToPhone', 'ToCompany', 'ToAddr', 'ToCity', 'ToProvince', 'ToPost', 
			'ToCountry', 'SendSign', 'FromPos', 'ToPos');
		$count = count($_POST['boxcount']);
		
		// 标记状态
		$TransportId = $_POST['TransportId'];
		$db = $this->db->clear();
		$db->addTable('transport');
		$db->addValue('Status', 2);
		$db->addWhere('Status', 2, _ORM_OP_NEQ);
		$db->addWhere('UserId', $this->uid);
		$db->addWhere('TransportId', $TransportId, _ORM_OP_IN);
		$db->update();
		
		$data = array();
		foreach($fields as $v)
		{
			$data[$v] = trim($_POST[$v]);
		}
		$data['CreateTime'] = date("Y-m-d H:i:s");
		$data['GoodsNum'] = 1;
		$data['Type'] = 0;
		$data['UserId'] = $this->uid;
		$data['Status'] = 1;
		$data['BillKey'] = '';
		
		for ($i = 1; $i <= $count; $i++)
		{
		    $db = $this->db->clear();
    		$db->addTable('bill');
    		$db->insert($data);
    		$bid = $db->getLastId();
    		
    		$box_data = array();
    		
		    $box_data['1'] = array(
				'pos' => 1,
				'weight' => $_POST['weight' . $i],
				'unit' => $_POST['unit' . $i],
				'bulk' => $_POST['bulk' . $i],
				'item' => array()			
			);
			
			foreach ($_POST['key' . $i] as $k => $v)
			{
				$box_data['1']['item'][] = array(
					'key' => $_POST['key' . $i][$k],
					'info' => $_POST['info' . $i][$k],
					'money' => $_POST['money' . $i][$k]
				);
			}
			
			$box_data = serialize($box_data); 	

    		if ($bid > 0)
    		{
    			$data2 = array(
    				'BillId' => $bid,
    				'Type' => 0,
    				'CreateTime' => date("Y-m-d H:i:s"),
    				'GoodsKey' => '',
    				'Goods' => $box_data
    			);
    			$db->clear();
    			$db->addTable('goods');
    			$db->insert($data2);
    		}
    		
		}
		
		echo '<script>alert("添加成功!")</script>';
		$this->app->redirect('user.php?do=bill');
		
	}
	
	public function doexplodeBill()
	{
	    $num = intval($_GET['num']);
	    $tid = intval($_GET['tid']);
	    
	    $num = max(2, $num);
	    $num = min(10, $num);
	    
	    $db = $this->db->clear();
	    $transport = $db->getRow("select * from transport where TransportId='{$tid}' and Status != '2' and UserId='{$this->uid}'");
	    if (empty($transport['TransportId']))
	    {
	        $this->app->redirect('user.php?do=transportlist');
	    }
	    
	    // 获取物品信息
	    $db = $this->db->clear();
	    $goods = $db->getRow("select * from goods where BillId='{$transport['TransportId']}' and Type='1'");
	    if (!empty($goods['GoodsId']))
	    {
	         $goods['Goods'] = unserialize($goods['Goods']);
	    }
	    	    
	    $page = $this->app->page();
	    $page->value('num', $num);
	    $page->value('nums', range(1, $num));
	    $page->value('good', $goods);
	    $page->value('transport', $transport);
		$page->params['template'] = 'user/addbillfromexplode.tpl';
		$page->output();
	}
	
	public function dosaveExplodeBill()
	{
	    $fields = array('FromName', 'FromPhone', 'FromCompany', 'FromAddr', 
			'FromCity', 'FromProvince', 'FromPost', 'FromCountry', 'ToName', 
			'ToPhone', 'ToCompany', 'ToAddr', 'ToCity', 'ToProvince', 'ToPost', 
			'ToCountry', 'SendSign', 'FromPos', 'ToPos');
		$count = count($_POST['boxcount']);
		$pos = intval($_POST['pos']);
		
		// 标记状态
		$TransportId = $_POST['transport'];
		$db = $this->db->clear();
		$db->addTable('transport');
		$db->addValue('Status', 2);
		$db->addWhere('Status', 2, _ORM_OP_NEQ);
		$db->addWhere('UserId', $this->uid);
		$db->addWhere('TransportId', $TransportId);
		$db->update();
		
		$data = array();
		foreach($fields as $v)
		{
			$data[$v] = trim($_POST[$v]);
		}
		$data['CreateTime'] = date("Y-m-d H:i:s");
		$data['GoodsNum'] = 1;
		$data['Type'] = 0;
		$data['UserId'] = $this->uid;
		$data['Status'] = 1;
		$data['BillKey'] = '';
		
		for ($i = 1; $i <= $count; $i++)
		{
		    $db = $this->db->clear();
    		$db->addTable('bill');
    		$db->insert($data);
    		$bid = $db->getLastId();
    		
    		$box_data = array();
    		
		    $box_data['1'] = array(
				'pos' => 1,
				'weight' => $_POST['weight' . $i],
				'unit' => $_POST['unit' . $i],
				'bulk' => $_POST['bulk' . $i],
				'item' => array()			
			);
			
			foreach ($_POST['key' . $i] as $k => $v)
			{
				$box_data['1']['item'][] = array(
					'key' => $_POST['key' . $i][$k],
					'info' => $_POST['info' . $i][$k],
					'money' => $_POST['money' . $i][$k]
				);
			}
			
			$box_data = serialize($box_data); 	

    		if ($bid > 0)
    		{
    			$data2 = array(
    				'BillId' => $bid,
    				'Type' => 0,
    				'CreateTime' => date("Y-m-d H:i:s"),
    				'GoodsKey' => '',
    				'Goods' => $box_data
    			);
    			$db->clear();
    			$db->addTable('goods');
    			$db->insert($data2);
    		}
    		
		}
		
		echo '<script>parent.submit_next(' . $pos . ')</script>';
	}
	
	public function dosaveBill()
	{	    
		$fields = array('FromName', 'FromPhone', 'FromCompany', 'FromAddr', 
			'FromCity', 'FromProvince', 'FromPost', 'FromCountry', 'ToName', 
			'ToPhone', 'ToCompany', 'ToAddr', 'ToCity', 'ToProvince', 'ToPost', 
			'ToCountry', 'SendSign', 'FromPos', 'ToPos');
		$count = count($_POST['boxcount']);
		
		$data = array();
		foreach($fields as $v)
		{
			$data[$v] = trim($_POST[$v]);
		}
		$data['CreateTime'] = date("Y-m-d H:i:s");
		$data['GoodsNum'] = 1;
		$data['Type'] = 0;
		$data['UserId'] = $this->uid;
		$data['Status'] = 1;
		$data['BillKey'] = '';
		
		for ($i = 1; $i <= $count; $i++)
		{
		    $db = $this->db->clear();
    		$db->addTable('bill');
    		$db->insert($data);
    		$bid = $db->getLastId();
    		
    		$box_data = array();
    		
		    $box_data['1'] = array(
				'pos' => 1,
				'weight' => $_POST['weight' . $i],
				'unit' => $_POST['unit' . $i],
				'bulk' => $_POST['bulk' . $i],
				'item' => array()			
			);
			
			foreach ($_POST['key' . $i] as $k => $v)
			{
				$box_data['1']['item'][] = array(
					'key' => $_POST['key' . $i][$k],
					'info' => $_POST['info' . $i][$k],
					'money' => $_POST['money' . $i][$k]
				);
			}
			
			$box_data = serialize($box_data); 	

    		if ($bid > 0)
    		{
    			$data2 = array(
    				'BillId' => $bid,
    				'Type' => 0,
    				'CreateTime' => date("Y-m-d H:i:s"),
    				'GoodsKey' => '',
    				'Goods' => $box_data
    			);
    			$db->clear();
    			$db->addTable('goods');
    			$db->insert($data2);
    		}
    		
		}
		
		echo '<script>alert("添加成功!")</script>';
		$this->app->redirect('user.php?do=bill');
		
	}
	
	public function doBill()
	{
		$bill_file = $this->app->cfg['path']['conf'] . 'bill.cfg.php';
		include $bill_file;
				
		$smarty = $this->app->page();
		$db = $this->app->orm()->query();
		
		$search_type_allow = array('BillId', 'BillKey');
		if (in_array($_GET['search_type'], $search_type_allow))
		{
		    $search_txt = mysql_escape_string(trim($_GET['id']));
		    $pagehtml = null;
		    $bills = $db->getArray("select * from bill where UserId='{$this->uid}' and Type=0 and {$_GET[search_type]}='$search_txt'");
		    $smarty->value('searchmod', true);
		}
		else 
		{
    		$page = max(1, intval($_GET['page']));
    		$pagesize = PAGE_SIZE;
    		
    		
    		$count = $db->getValue("select count(*) from bill where UserId='{$this->uid}' and Type=0");
    		$pagemax = max(1, ceil($count / $pagesize));
    		
    		$offset = ($page - 1) * $pagesize;
    		$bills = $db->getArray("select * from bill where UserId='{$this->uid}' and Type=0 order by CreateTime DESC", $offset, $pagesize);
    		
    		$pagehtml = $smarty->getNav($pagemax, 7, $page, '<a href="?do=bill&page=%d">%d</a>', '<strong>%d</strong>');
    		$smarty->value('searchmod', false);
		}
		
		$smarty->value('bills', $bills);
		$smarty->value('pages', $pagehtml);
		$smarty->value('bill_cfg', $bill_status_cfg);
		
		$smarty->params['template'] = 'user/bill.tpl';

		$smarty->output();
	}
	
	public function doInfo()
	{
		$user = $this->db->getRow("select * from user where UserId=" . $this->uid);
		
		$page = $this->app->page();
		$page->params['template'] = 'user/info.tpl';
		$page->value('user', $user);
		$page->output();
	}
	
	public function doupdateInfo()
	{
		$fields = array('RealName', 'Phone', 'Adress', 'Qq');
		$data = array();
		foreach ($fields as $v)
		{
			$data[$v] = $_POST[$v];
		}
		$_SESSION['ep_name'] = $data['RealName'];
		$this->db->clear();
		$this->db->addTable('user');
		$this->db->addWhere('UserId', $this->uid);
		$this->db->update($data);
	}
	
	public function doAddr()
	{
		$addrs = $this->db->getArray("select * from address where UserId='{$this->uid}' order by CreateTime DESC");
		
		$page = $this->app->page();
		$page->params['template'] = 'user/addr.tpl';
		$page->value('addrs', $addrs);
		$page->output();
	}
	
	public function dodelAddr()
	{
		$aid = intval($_GET['aid']);
		if ($aid > 0)
		{
			$this->db->exec("delete from address where UserId='{$this->uid}' and AddressId='{$aid}' limit 1");
		}
		$this->app->redirect('user.php?do=Addr');
	}
	
	public function doAddAddr()
	{
		$fields = array('ReceiveName', 'ReceiveAddr', 'Phone', 'Post');
		$data = array();
		
		foreach ($fields as $v)
		{
			$data[$v] = $_POST[$v];
		}
		$data['UserId'] = $this->uid;
		$data['CreateTime'] = date("Y-m-d H:i:s");
		
		$this->db->clear();
		$this->db->addTable('address');
		$this->db->insert($data);
	}
	
	public function doPassword()
	{
		$page = $this->app->page();
		$page->params['template'] = 'user/password.tpl';
		$page->output();
	}
	
	public function doChangePwd()
	{
		extract($_POST, EXTR_SKIP);
		$errormsg = "修改失败, 原始密码不正确";
		if (trim($pwd1) == '' || $pwd1 != $pwd2)
		{
			$errormsg = '两此输入密码不一致';
		}
		else
		{
			$oldpwd = md5($oldpwd);
			$pwd1 = md5($pwd1);
			$this->db->exec("update user set Password='{$pwd1}' where UserId='{$this->uid}' and Password='{$oldpwd}' limit 1");
			if ($this->db->getAffectRows() == 1)
			{
				$errormsg  = '<script>alert("密码修改成功, 请重新登录!"); location = "login.php?do=Logout"</script>';
			}
		}
		
		$page = $this->app->page();
		$page->value('errormsg', $errormsg);
		$page->params['template'] = 'user/password.tpl';
		$page->output();
	}
	
}
$app->run();

?>