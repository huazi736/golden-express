-- MySQL dump 10.13  Distrib 5.5.3-m3, for unknown-linux-gnu (x86_64)
--
-- Host: localhost    Database: express
-- ------------------------------------------------------
-- Server version	5.5.3-m3-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `address` (
  `AddressId` int(11) NOT NULL AUTO_INCREMENT,
  `UserId` int(11) DEFAULT NULL,
  `ReceiveName` varchar(20) DEFAULT NULL,
  `ReceiveAddr` varchar(200) DEFAULT NULL,
  `Phone` varchar(40) DEFAULT NULL,
  `Post` varchar(20) DEFAULT NULL,
  `CreateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`AddressId`),
  KEY `Idx_address_UserId` (`UserId`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (1,1,'移动','北京中关村','10086','331564','2011-08-12 13:51:34'),(2,1,'联通','上海太平洋',' 10010',' 556685','2011-08-12 13:57:29'),(4,5,'xxx','xxxxxxxxxxxxxxxxxxxxxxxxxxxxx','13999999999999','1111','2011-08-17 10:32:12'),(5,1006,'李局长','海南省海口市琼苑路省府住宅北区14栋 503房','13700498606','500001','2012-04-21 13:16:17'),(6,1009,'李振远','山东省青岛市市南区南京路122号中联广场H栋139室','18653273175','266000','2013-06-26 08:22:52'),(7,1005,'11','11','11','11','2013-06-27 14:11:16'),(8,1005,'22','22','22','22','2013-06-27 14:11:22');
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bill`
--

DROP TABLE IF EXISTS `bill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bill` (
  `BillId` int(11) NOT NULL AUTO_INCREMENT,
  `BillKey` varchar(512) DEFAULT NULL,
  `UserId` int(11) DEFAULT NULL,
  `Type` tinyint(4) DEFAULT '0' COMMENT '0 用户订单 1 系统组用户',
  `FromPhone` varchar(20) DEFAULT NULL,
  `FromName` varchar(20) DEFAULT NULL,
  `FromCompany` varchar(200) DEFAULT NULL,
  `FromAddr` varchar(200) DEFAULT NULL,
  `FromCity` varchar(20) DEFAULT NULL,
  `FromProvince` varchar(20) DEFAULT NULL,
  `FromPost` varchar(15) DEFAULT NULL,
  `FromCountry` varchar(20) DEFAULT NULL,
  `ToName` varchar(20) DEFAULT NULL,
  `ToPhone` varchar(20) DEFAULT NULL,
  `ToCompany` varchar(200) DEFAULT NULL,
  `ToAddr` varchar(200) DEFAULT NULL,
  `ToCity` varchar(20) DEFAULT NULL,
  `ToProvince` varchar(20) DEFAULT NULL,
  `ToPost` varchar(15) DEFAULT NULL,
  `ToCountry` varchar(20) DEFAULT NULL,
  `SendSign` varchar(20) DEFAULT NULL,
  `FromPos` varchar(255) DEFAULT NULL,
  `ToPos` varchar(255) DEFAULT NULL,
  `GoodsNum` int(11) DEFAULT '0',
  `CreateTime` datetime DEFAULT NULL,
  `Status` int(11) DEFAULT '1',
  `TranBill` tinyint(11) DEFAULT '0',
  `TranBillKey` varchar(512) DEFAULT NULL,
  `WarehouseId` int(11) DEFAULT NULL,
  `WarehouseName` varchar(20) DEFAULT NULL,
  `Price` int(11) DEFAULT '0' COMMENT '定价',
  PRIMARY KEY (`BillId`),
  KEY `Idx_bill_BillKey` (`BillKey`(255)) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bill`
--

LOCK TABLES `bill` WRITE;
/*!40000 ALTER TABLE `bill` DISABLE KEYS */;
INSERT INTO `bill` VALUES (2,'',1,0,'10086','移动','中国移动','北京中关村','北京','北京','10000','中国','联通','10010','中国联通','上海太平洋','上海','上海','21000','中国','铁通','中国北京','中国上海',1,'2011-08-12 17:13:05',1,0,NULL,NULL,NULL,0),(3,'',1,0,'88662277','淘宝','淘宝中国','淘宝国际','杭州','浙江','231100','中国','易趣','6655221','易趣中国','中国易趣','北京','北京','10000','中国','网易','北京','上海',2,'2011-08-12 17:38:45',1,0,NULL,NULL,NULL,0),(4,'',1,1,'0105566588','美国','苹果','美国苹果公司','纽约','美国','10110','美国','中国','9999999','盛大','上海盛大公司','上海','上海','21000','中国','第九城市','美国','中国',2,'2011-08-12 18:15:49',0,0,NULL,NULL,NULL,0),(5,'',7,0,'fasdf','231','asdfasd','fasdfasdf','asdfasd','dsafasdf','asdfasdf','asdfasdf','asfd','adfs','a','sdf','asfd','asdf','asfd','asdf','5261','asdf','afsd',1,'2011-08-18 04:19:22',1,0,NULL,NULL,NULL,0),(6,'',7,0,'asdfa','adsfa','asdfa','asdf','asdfa','asdf','asdf','asdf','asdf','asdf','asdf','asdf','asdf','asdf','asdf','asdf','asdf','asdf','asdf',1,'2011-08-18 04:29:43',1,0,NULL,NULL,NULL,0),(7,'',1,0,'66885522','谷歌','Google','西雅图','西雅图','西雅图','52662','美国','百度','5998556','百毒公司','北京中关村','北京','北京','010','北京','百度','纽约仓库','湖南长沙',2,'2011-08-19 00:18:49',1,1,'GH85454521251221',3,'纽约免税仓库',0),(8,'',5,0,'sd','sdsd','sd','sd','sd','sd','sd','d','sdsd','sd','sdsd','sd','d','sd','ds','sd','sd','sss','ddd',1,'2011-08-20 02:44:55',1,1,'1000',1,'芝加哥免费仓库',0),(9,'',6,0,'3157262','alice','fffff','10505','el monte','ca','91731','usa','andy','5647','fffffffs','中国辽宁省沈阳市皇姑区宁山东路12-4-333','沈阳市','宁省','5614','china','fsgsg','lax','cn',1,'2011-08-20 02:47:44',1,1,'45678',1,'芝加哥免费仓库',0),(10,'ABC123',1,1,'1234567','abc','可是可是可是可是','可是可是可是可是','武汉','湖北','111111','中国','小王','11111111','可是可是可是可是','可是可是可是可是','武汉','湖北','11111','中国','乔','武汉','武汉',1,'2012-04-04 22:02:52',1,0,NULL,NULL,NULL,30),(11,'',1000,0,'312','312','3123','123','123','123','123','123','123','123','1123','123','123','123','123','123','123','123','123',1,'2012-04-05 08:39:01',1,0,NULL,NULL,NULL,0),(12,'abcabc',1005,0,'aaa','aaaa','aaa','aaa','aa','aa','aa','aaa','a','aa','a','a','a','a','a','a','a','a','a',1,'2012-04-05 12:47:07',1,0,NULL,NULL,NULL,200),(13,'',1005,0,'b','b','b','b','b','b','b','b','b','b','b','b','b','b','b','b','b','b','b',1,'2012-04-05 12:47:07',1,0,NULL,NULL,NULL,100),(14,'',1006,0,'626-442-8988','Alice Du','Golden Link Express','10505 Valley Blvd., Ste 358','El Monte','CA','91731','USA','王秋月','13901864785','王秋月','虹口区天宝路882号2号楼502','上海市','上海市','200086','中国','Alice Du','LAX','上海市',1,'2012-04-20 07:09:07',1,0,NULL,NULL,NULL,17),(15,'',1006,0,'6263157262','alice','Golden Link Express','7639 Graves Ave,','Rosemead','ca','91770','美国','韩同','13520737740','个人','昌平区，立水桥东小营镇立军路，颐丰圆7号','昌平区','北京','100132','中国','alice','lax','北京',1,'2012-04-21 07:55:57',1,0,NULL,NULL,NULL,0),(16,'TX001335221US',1009,0,'6264428988','kenshe','Gle','10505 Valley blvd','El Monte','CA','91731','USA','李振远','18653273175','','山东省青岛市市南区南京路122号中联广场H栋139室','青岛市','山东省','266000','CHINA','李振远','LAX','青岛市',1,'2013-06-26 08:26:19',3,0,NULL,NULL,NULL,30),(17,'',1,1,'sssssssss','ssss','sssssssssssssss','sssssssssssssssss','sss','sss','sss','ss','sssss','s','sssss','ss','s','s','s','s','s','s','s',1,'2013-06-26 22:22:47',1,0,NULL,NULL,NULL,0),(18,'美国快递单号LA1919 顺风快递单号1818',1005,0,'1','乔磊','aa','aa','LA','1','1','1','乔磊','1','1','1','杭州','1','11','1','11','LA','杭州',1,'2013-06-27 13:25:59',1,0,NULL,NULL,NULL,600),(19,'',1005,0,'1','乔磊','aa','aa','LA','1','1','1','乔磊','1','1','1','杭州','1','11','1','11','LA','杭州',1,'2013-06-27 13:25:59',1,0,NULL,NULL,NULL,0);
/*!40000 ALTER TABLE `bill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data`
--

DROP TABLE IF EXISTS `data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data` (
  `DataId` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) DEFAULT NULL,
  `Content` text,
  `UpdateTime` datetime DEFAULT NULL,
  `Type` varchar(10) DEFAULT '0',
  PRIMARY KEY (`DataId`),
  KEY `Idx_data_Type` (`Type`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data`
--

LOCK TABLES `data` WRITE;
/*!40000 ALTER TABLE `data` DISABLE KEYS */;
INSERT INTO `data` VALUES (1,'国际快递','国际快递','2011-07-31 16:13:37','0'),(2,'国际货运','国际货运\r\n','2011-07-31 16:13:51','0'),(3,'电子商务','电子商务','2011-07-31 15:53:48','0'),(4,'操作流程','<p>\r\n	操作流程</p>\r\n<p>\r\n	<strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 网上注册</strong>：填写账户申请表格，您需要在和我们的客服人员沟通之后，索取一个账户号码，这样当您在最后输入了我公公司为您提供的如果事先没有得到过客服人员提供给你的账户，您也可以申请开户，但是不能马上开通，需要您在填写好账户资料之后和我们的客服人员联络，提供您的email地址，请求开通，这样并可得到我公司的账户号码。</p>\r\n<p>\r\n	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>美国网上购物下单</strong>：下订单时，请填写我公司地址，收件人为您的 名字、加您在我公司的账户号码即：客户姓名+账户号码（lax_08&hellip;）+金链接公司地址；非网上下单的客户可以直接联系我们发fedex的Label取件，发货到洛杉矶总部；洛杉矶当地客户可以直接来金链接总部发货。</p>\r\n<p>\r\n	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>美国收件</strong>：当美国金洛杉矶总部收到您的货物时，会在我们的网站即您的账户里面输入您货物的入库情况，当您看到您的货物在金链接处于到货状态时，您需要在系统里提交新的运单，即通过提价新运单来告诉我们您的货该怎么寄、怎么分包、寄到哪里等；这样我们的客服人员就会根据您提交的新运单，安排分货和打包，再向您核实最后重量和费用；</p>\r\n<p>\r\n	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>付款：</strong>在重量和费用都敲定之后，您需要事先付款，麻烦您通过支付系统交付运费，您在付款时需注明：<strong>姓名</strong>、<strong>账户号码</strong>、<strong>单号</strong>等，以便我们的财务及时的为您的付款销账。<strong>我们的付款方式如下</strong>：</p>\r\n<p>\r\n	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>PayPal</strong> 账户ID： duhy2001616@hotmail.com&nbsp; <strong>&nbsp;支付宝</strong>：<a href=\"mailto:gleexpress2008@gmail.com\">gleexpress2008@gmail.com</a></p>\r\n<p>\r\n	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>汇率</strong>： 本公司目前暂定6.5计算汇率，如有变动另行通知；根据市场变化等居多因素的影响，本公司保留价格随时可能更改的权利，报价的解释权归本公司所有。</p>\r\n<p>\r\n	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>美国发货</strong>：当我公司收到您的运费之后，随即安排发货，您并可以在我们的网站查询包裹。</p>\r\n<p>\r\n	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>&nbsp;网上查询：</strong>当您在金链接的网站输入您的美国国内运单时您就开始了货物的查询，在我公司的网站您可以同时通过3个运单号码对那你的货物进行全程跟踪查询，第一是您的美国国内快递单号、第二是您的金链接运单号、第三是你的货物到达中国时的派送转单号，这三个号码中每一个号码您都可以跟踪查询到底</p>\r\n','2011-08-31 07:35:33','0'),(5,'寄件须知','寄件须知','2011-07-31 16:15:35','0'),(6,'索赔挂失','<p>\r\n	索赔挂失</p>\r\n<p>\r\n	凡属使用本公司国际快递服务的客户，被认为自动接收和遵守本公司的承运条款：</p>\r\n<p>\r\n	&nbsp;&nbsp;&nbsp;&nbsp; <strong>&nbsp;&nbsp;安全条款</strong>：邮寄人清楚的知道包裹或邮件内不允许夹带任何易燃易爆、易腐蚀、放射性、毒性的危险物品、麻醉药物、精神药品、现金、以及法律禁止邮寄的物品；违者将承担相关法律责任。</p>\r\n<p>\r\n	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>保费</strong>：按照5%计算，金卡VIP的保费为2.5%，以一个地址为一票计，保额最高不超过$500美金，电子类产品和高档货物价值超过$500美金的，本公司一律不提供保险，客户需向本公司提供包裹详情单和形式发票。</p>\r\n<p>\r\n	<strong>理赔</strong>：客户在不买保险的情况下，发生丢失或损坏，本公司的赔偿金额最多不超过$100美金，在货物的重量不超过10磅，客户没有在邮寄前主动向本公司提供货物详情单和发票的情况下，对货物的估值以1磅10美金计，最多不超过$100美金的赔偿金；如果客户要求全额赔偿，并且在货物邮寄之前主动向我公司提供货物清单和发票，我公司可以考虑按照客户在邮寄初期，所提供的货物发票价值进行赔偿，但赔偿的方式是采取在我公司邮寄货物并付运费之后，在本公司标准运费的基础上，抵扣20%作为对客户的赔偿；以此方式来累计我公司赔偿客户的全部货值，如果客户终止在我公司运输，则本公司不再履行对此客户的赔偿义务；以上两种赔偿办法只能选其一；</p>\r\n<p>\r\n	<strong>海关罚没</strong>：保费是对运输的过程中发生货物损坏或丢失的担保，但保费不能取代关税、同时也不能非正常报关形式下的运输，而导致的海关扣货和罚没等进行担保；要选择全保险，客户必须不仅购买保险，同时履行正式报关手续，按照海关规定申报和缴纳税金。</p>\r\n<p>\r\n	<strong>收货与货物丢失、损坏的确认</strong>：如果想得到很恰当的理赔处理，客户在收件时需注意检查货物缺损情况，发现异常，如丢失、或者损坏，收件人在第一时间内可做如下处理：</p>\r\n<ol>\r\n	<li value=\"NaN\">\r\n		要求派件公司根据货物签收的实际情况签字。</li>\r\n	<li value=\"NaN\">\r\n		及时在3天之内，向本公司索赔部门和中国派送公司挂失，挂失时需提供美国单号和中国派送公司转单号；</li>\r\n	<li value=\"NaN\">\r\n		申请索赔要求如下：①登录我公司网站索取索赔表格，请严格按照表格格式的要求，认真填写索赔申请表；②客户一定要提供货物的美国运单号和中国配送转单号，③严格按照表格的要求提供所有可能对丢失或者损坏原因有利的图片、发票、签收记录等证据，④对于不按时支付运费的客户本公司有权拒绝理赔。</li>\r\n	<li value=\"NaN\">\r\n		客户在收件时未提出包裹有损坏或丢失，将被视为包裹在完好无缺的情况下签收, 超过30个 工作日才来挂失和索赔的，一律不予受理</li>\r\n	<li value=\"NaN\">\r\n		我司理赔部门在确定客户的包裹确实是丢失之后，即开始受理理赔。</li>\r\n</ol>\r\n<p>\r\n	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>重要声明</strong>：本人认真阅读过，并同意运单背面的安全条款，承诺所寄包裹没有包含安全条款内禁止的货物，本人将会告知收件人，在收件当时，如发现包裹有丢失和破损，会当即让配送员签字证明，同时立即向我公司挂失。</p>\r\n','2011-08-31 06:12:00','0'),(7,'加盟条件','加盟条件','2011-07-31 16:17:47','0'),(8,'加盟流程','加盟流程','2011-07-31 16:17:56','0'),(9,'价格查询','<p>\r\n	价格查询</p>\r\n<p>\r\n	&nbsp;</p>\r\n<table border=\"0\" cellpadding=\"0\" cellspacing=\"1\" style=\"width: 519px\" width=\"519\">\r\n	<tbody>\r\n		<tr>\r\n			<td style=\"width: 11.94%; height: 35px\">\r\n				<p align=\"center\">\r\n					A类</p>\r\n			</td>\r\n			<td style=\"width: 87.52%; height: 35px\">\r\n				<p>\r\n					&nbsp;&nbsp;&nbsp; 衣服、鞋子、包包首磅：$10.00美金续磅：$6.5 美金（不限量 10-15天）<br />\r\n					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $9.00， 美金续磅：$5.00 美金 （限量3-5天）</p>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td style=\"width: 11.94%; height: 35px\">\r\n				<p align=\"center\">\r\n					B类</p>\r\n			</td>\r\n			<td style=\"width: 87.52%; height: 35px\">\r\n				<p>\r\n					　食品、化妆品、保健品 首磅：$10,续磅$6.5 (10-15个工作日不限量)<br />\r\n					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 花旗参，每磅$15，海参 首磅$10，续磅 $8.5（10-15工作日不限量）<br />\r\n					&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 首磅：$9.00， 美金续磅：$5.00 美金 （3-5工作日，限量）</p>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td style=\"width: 11.94%; height: 35px\">\r\n				<p align=\"center\">\r\n					C类</p>\r\n			</td>\r\n			<td style=\"width: 87.52%; height: 35px\">\r\n				<p>\r\n					&nbsp; &nbsp; 高价值饰品、名牌包包、首磅：$10，美金续磅：$8.5美金（10-15工作日，不限量）</p>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td style=\"width: 11.94%; height: 35px\">\r\n				<p align=\"center\">\r\n					D类</p>\r\n			</td>\r\n			<td style=\"width: 87.52%; height: 35px\">\r\n				<p>\r\n					&nbsp;&nbsp; 电子：手机、I Phone、I Pod、相机、电脑等，每磅：$12.5 美金 (10-15天少许通关费)</p>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td style=\"width: 11.94%; height: 35px\">\r\n				<p align=\"center\">\r\n					&nbsp;E类</p>\r\n			</td>\r\n			<td style=\"width: 87.52%; height: 35px\">\r\n				<p>\r\n					&nbsp; 电子：仪器仪表、汽车配件、剃须刀、刮胡刀、二手相机等：首磅$10,续磅$8.5（10至15个工作日不限量）</p>\r\n			</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	<font color=\"#800080\">&nbsp;要询问电子类产品和其它高价值产品的承运价格，以及我们的优惠促销价格，请直接联系我们公司客服。</font><br />\r\n	<span style=\"font-size: 9pt; color: rgb(153,0,153); line-height: 115%\">&nbsp;大客户批发价请Q:1601537642</span></p>\r\n<p class=\"ListParagraph1\" style=\"margin-left: 0in\">\r\n	<span style=\"font-size: 9pt; color: rgb(153,0,153); line-height: 115%\">&nbsp;&nbsp;</span><span style=\"font-size: 9pt; color: rgb(153,0,153); line-height: 115%\">*</span><strong><span lang=\"ZH-CN\" style=\"font-size: 9pt; color: rgb(153,0,153); line-height: 115%; font-family: 宋体\">关于含税价的运费解释</span></strong><span lang=\"ZH-CN\" style=\"font-size: 9pt; color: rgb(153,0,153); line-height: 115%; font-family: 宋体\">：所谓含税，即本公司和海关协商的价格，这样的通关率可能在千分之，如果有千分之</span><span style=\"font-size: 9pt; color: rgb(153,0,153); line-height: 115%\">1</span><span lang=\"ZH-CN\" style=\"font-size: 9pt; color: rgb(153,0,153); line-height: 115%; font-family: 宋体\">的可能是被扣关，或者海关不认可此关税税率，客户还需对所产生的关税负责。</span></p>\r\n<p class=\"ListParagraph1CxSpFirst\" style=\"margin-left: 0in\">\r\n	<span style=\"font-size: 9pt; color: rgb(153,0,153); line-height: 115%; font-family: 宋体\"><span><font color=\"#222222\" face=\"Arial\">&nbsp;</font><strong>海关退运</strong>：遇到海关退运时， 客户需缴交退运的运费。</span></span></p>\r\n<p>\r\n	&nbsp;</p>\r\n','2011-09-13 06:22:03','0'),(10,'关于我们','关于我们','2011-07-31 16:22:09','0'),(11,'联系我们','<p>\r\n	联系我们</p>\r\n<p>\r\n	&nbsp;</p>\r\n<table align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"97%\">\r\n	<!--<tr> \r\n            <td height=\"4\" class=font-hui> 　　　　　　　　　　　　　　　　　金链接 <a href=\"http://www.gleexpress.com\">http://www.gleexpress.com</a> \r\n              　　</td>\r\n          </tr>-->\r\n	<tbody>\r\n		<tr>\r\n			<td class=\"font14-hei\" height=\"8\">\r\n				<p>\r\n					&nbsp;</p>\r\n				<p>\r\n					&nbsp;</p>\r\n				<strong>总部</strong>\r\n				<table align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"margin-top: 5px; margin-bottom: 5px\" width=\"96%\">\r\n					<tbody>\r\n						<tr>\r\n							<td background=\"images/point.gif\" height=\"1\">\r\n								&nbsp;</td>\r\n						</tr>\r\n					</tbody>\r\n				</table>\r\n				<p>\r\n					<font color=\"#000000\"><span style=\"font-weight: bold\"><font size=\"2\"><font face=\"Arial\">地址：10505 Valley Blvd.Suite#358<br />\r\n					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; El Monte&nbsp;CA 91731<br />\r\n					<br />\r\n					&nbsp;Tel:&nbsp;&nbsp;&nbsp;&nbsp;626-442-8988<br />\r\n					&nbsp;</font></font></span></font><font color=\"#000000\"><span style=\"font-weight: bold\"><font size=\"2\"><font face=\"Arial\">Fax:&nbsp; 626-442-8856</font></font></span></font></p>\r\n				<p>\r\n					<font color=\"#000000\"><span style=\"font-weight: bold\"><font size=\"2\"><font face=\"Arial\">&nbsp;中国：400-676-5896 转 899-108-7808#&nbsp;<br />\r\n					&nbsp;&nbsp;</font></font></span></font></p>\r\n				<p>\r\n					&nbsp;<font color=\"#000000\"><span style=\"font-weight: bold\"><font size=\"2\"><font face=\"Arial\">Email:goldenlinkexpress@gmail.com</font></font></span></font></p>\r\n				<p>\r\n					<font color=\"#000000\"><span style=\"font-weight: bold\"><font size=\"2\">在线美国客服：QQ：1601537642<font face=\"Arial\"> &nbsp; 旺旺： smartrainbow<br />\r\n					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 操作：QQ:&nbsp; 1181222827<br />\r\n					&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</font></font></span></font></p>\r\n			</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n<p>\r\n	&nbsp;</p>\r\n','2011-09-13 06:23:10','0'),(12,'职业发展','职业发展','2011-07-31 16:22:27','0'),(13,'在线支付','在线支付','2011-07-31 16:22:39','0'),(14,'专业知识','专业知识','2011-07-31 16:22:58','0'),(16,'','<p>\r\n	我是常见问题1</p>\r\n','2011-08-07 15:03:43','1-1'),(17,'常见问题2','<p>\r\n	常见问题2</p>\r\n','2011-08-07 15:03:24','1-2'),(18,'常见问题3','<p>\r\n	我是常见问题3</p>\r\n','2011-08-07 15:03:53','1-3'),(19,'付款帮助1','<p>\r\n	付款1111</p>\r\n','2011-08-07 15:04:06','2-1'),(20,'付款帮助2','<p>\r\n	付款2</p>\r\n','2011-08-07 15:04:15','2-2'),(21,'付款帮助3','<p>\r\n	付款3</p>\r\n','2011-08-07 15:04:27','2-3');
/*!40000 ALTER TABLE `data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gbook`
--

DROP TABLE IF EXISTS `gbook`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gbook` (
  `GbookId` int(11) NOT NULL AUTO_INCREMENT,
  `Title` varchar(255) DEFAULT NULL,
  `Type` tinyint(4) DEFAULT NULL,
  `Name` varchar(20) DEFAULT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `Phone` varchar(20) DEFAULT NULL,
  `Content` text,
  `CreateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`GbookId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gbook`
--

LOCK TABLES `gbook` WRITE;
/*!40000 ALTER TABLE `gbook` DISABLE KEYS */;
INSERT INTO `gbook` VALUES (1,'阿萨德发送到1',3,'阿斯多夫2','速度啊3','阿萨德阿萨德阿萨德4','啊是的发生地方5','2011-08-05 01:13:59'),(2,'werqwe',1,'qwrewqer','wer','qwre','qwerqwre','2011-08-05 01:15:22'),(3,'dfsvdfv',3,'sdfvdfv','sdfvdfsv','dsfvdfv','dsfvdsfvdsfvdfv','2011-08-05 01:15:24');
/*!40000 ALTER TABLE `gbook` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `goods`
--

DROP TABLE IF EXISTS `goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `goods` (
  `GoodsId` int(11) NOT NULL AUTO_INCREMENT,
  `BillId` int(11) DEFAULT NULL,
  `GoodsKey` varchar(20) DEFAULT NULL,
  `Goods` text,
  `CreateTime` datetime DEFAULT NULL,
  `Type` tinyint(4) DEFAULT '0' COMMENT '0 运单 1 转运',
  PRIMARY KEY (`GoodsId`),
  KEY `Idx_goods_BillId` (`BillId`),
  KEY `Idx_goods_Type` (`Type`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goods`
--

LOCK TABLES `goods` WRITE;
/*!40000 ALTER TABLE `goods` DISABLE KEYS */;
INSERT INTO `goods` VALUES (1,2,'','a:1:{i:1;a:5:{s:3:\"pos\";i:1;s:6:\"weight\";s:3:\"100\";s:4:\"unit\";s:2:\"kg\";s:4:\"bulk\";s:3:\"200\";s:4:\"item\";a:3:{i:0;a:3:{s:3:\"key\";s:6:\"W00001\";s:4:\"info\";s:6:\"石油\";s:5:\"money\";s:4:\"2000\";}i:1;a:3:{s:3:\"key\";s:6:\"W00002\";s:4:\"info\";s:6:\"火柴\";s:5:\"money\";s:3:\"200\";}i:2;a:3:{s:3:\"key\";s:6:\"W00003\";s:4:\"info\";s:6:\"能源\";s:5:\"money\";s:3:\"600\";}}}}','2011-08-12 16:40:01',1),(2,2,'','a:2:{i:1;a:5:{s:3:\"pos\";i:1;s:6:\"weight\";s:3:\"100\";s:4:\"unit\";s:2:\"kg\";s:4:\"bulk\";s:3:\"100\";s:4:\"item\";a:1:{i:0;a:3:{s:3:\"key\";s:7:\"A009922\";s:4:\"info\";s:6:\"光钎\";s:5:\"money\";s:4:\"5200\";}}}i:2;a:5:{s:3:\"pos\";i:2;s:6:\"weight\";s:3:\"200\";s:4:\"unit\";s:2:\"kg\";s:4:\"bulk\";s:3:\"200\";s:4:\"item\";a:1:{i:0;a:3:{s:3:\"key\";s:7:\"A769394\";s:4:\"info\";s:15:\"高级交换机\";s:5:\"money\";s:5:\"10000\";}}}}','2011-08-12 17:13:05',0),(3,3,'','a:2:{i:1;a:5:{s:3:\"pos\";i:1;s:6:\"weight\";s:3:\"100\";s:4:\"unit\";s:2:\"kg\";s:4:\"bulk\";s:1:\"1\";s:4:\"item\";a:2:{i:0;a:3:{s:3:\"key\";s:8:\"G8934889\";s:4:\"info\";s:9:\"ERP软件\";s:5:\"money\";s:5:\"99999\";}i:1;a:3:{s:3:\"key\";s:8:\"G8564558\";s:4:\"info\";s:9:\"服务器\";s:5:\"money\";s:5:\"55555\";}}}i:2;a:5:{s:3:\"pos\";i:2;s:6:\"weight\";s:3:\"200\";s:4:\"unit\";s:2:\"kg\";s:4:\"bulk\";s:3:\"555\";s:4:\"item\";a:1:{i:0;a:3:{s:3:\"key\";s:9:\"H23492342\";s:4:\"info\";s:6:\"水果\";s:5:\"money\";s:3:\"500\";}}}}','2011-08-12 17:38:45',0),(4,4,'','a:2:{i:1;a:5:{s:3:\"pos\";i:1;s:6:\"weight\";s:1:\"1\";s:4:\"unit\";s:2:\"kg\";s:4:\"bulk\";s:1:\"1\";s:4:\"item\";a:3:{i:0;a:3:{s:3:\"key\";s:8:\"K9893483\";s:4:\"info\";s:5:\"iPad2\";s:5:\"money\";s:4:\"4500\";}i:1;a:3:{s:3:\"key\";s:8:\"K9980934\";s:4:\"info\";s:7:\"iPhone4\";s:5:\"money\";s:4:\"4999\";}i:2;a:3:{s:3:\"key\";s:7:\"K672343\";s:4:\"info\";s:4:\"iPod\";s:5:\"money\";s:3:\"599\";}}}i:2;a:5:{s:3:\"pos\";i:2;s:6:\"weight\";s:1:\"1\";s:4:\"unit\";s:2:\"kg\";s:4:\"bulk\";s:1:\"1\";s:4:\"item\";a:1:{i:0;a:3:{s:3:\"key\";s:9:\"G33434454\";s:4:\"info\";s:12:\"苹果MacPro\";s:5:\"money\";s:5:\"10000\";}}}}','2011-08-12 18:15:49',0),(5,3,'','a:2:{i:1;a:5:{s:3:\"pos\";i:1;s:6:\"weight\";s:3:\"100\";s:4:\"unit\";s:2:\"kg\";s:4:\"bulk\";s:2:\"30\";s:4:\"item\";a:1:{i:0;a:3:{s:3:\"key\";s:1:\"1\";s:4:\"info\";s:8:\"shshhshs\";s:5:\"money\";s:3:\"500\";}}}i:2;a:5:{s:3:\"pos\";i:2;s:6:\"weight\";s:2:\"50\";s:4:\"unit\";s:2:\"kg\";s:4:\"bulk\";s:2:\"50\";s:4:\"item\";a:2:{i:0;a:3:{s:3:\"key\";s:1:\"1\";s:4:\"info\";s:6:\"sshhsh\";s:5:\"money\";s:3:\"200\";}i:1;a:3:{s:3:\"key\";s:1:\"2\";s:4:\"info\";s:6:\"sshhhs\";s:5:\"money\";s:3:\"100\";}}}}','2011-08-12 21:46:17',1),(6,4,'','a:1:{i:1;a:5:{s:3:\"pos\";i:1;s:6:\"weight\";s:3:\"123\";s:4:\"unit\";s:2:\"kg\";s:4:\"bulk\";s:3:\"123\";s:4:\"item\";a:1:{i:0;a:3:{s:3:\"key\";s:1:\"1\";s:4:\"info\";s:4:\"ipad\";s:5:\"money\";s:3:\"111\";}}}}','2011-08-13 02:16:24',1),(7,5,'','a:1:{i:1;a:5:{s:3:\"pos\";i:1;s:6:\"weight\";s:3:\"100\";s:4:\"unit\";s:2:\"kg\";s:4:\"bulk\";s:3:\"000\";s:4:\"item\";a:2:{i:0;a:3:{s:3:\"key\";s:7:\"fdadfas\";s:4:\"info\";s:8:\"fadfadsf\";s:5:\"money\";s:8:\"adsfasdf\";}i:1;a:3:{s:3:\"key\";s:5:\"fadsf\";s:4:\"info\";s:6:\"adfasd\";s:5:\"money\";s:8:\"fadsfasd\";}}}}','2011-08-18 04:17:43',1),(8,5,'','a:1:{i:1;a:5:{s:3:\"pos\";i:1;s:6:\"weight\";s:3:\"111\";s:4:\"unit\";s:2:\"kg\";s:4:\"bulk\";s:3:\"000\";s:4:\"item\";a:1:{i:0;a:3:{s:3:\"key\";s:5:\"aasdf\";s:4:\"info\";s:4:\"asdf\";s:5:\"money\";s:4:\"asdf\";}}}}','2011-08-18 04:19:22',0),(9,6,'','a:1:{i:1;a:5:{s:3:\"pos\";i:1;s:6:\"weight\";s:4:\"1111\";s:4:\"unit\";s:2:\"kg\";s:4:\"bulk\";s:3:\"000\";s:4:\"item\";a:1:{i:0;a:3:{s:3:\"key\";s:8:\"asdfasdf\";s:4:\"info\";s:6:\"afdasd\";s:5:\"money\";s:6:\"asdfas\";}}}}','2011-08-18 04:28:51',1),(10,6,'','a:1:{i:1;a:5:{s:3:\"pos\";i:1;s:6:\"weight\";s:1:\"1\";s:4:\"unit\";s:2:\"kg\";s:4:\"bulk\";s:4:\"0.00\";s:4:\"item\";a:2:{i:0;a:3:{s:3:\"key\";s:4:\"asdf\";s:4:\"info\";s:5:\"asdfa\";s:5:\"money\";s:4:\"asdf\";}i:1;a:3:{s:3:\"key\";s:4:\"asdf\";s:4:\"info\";s:4:\"asdf\";s:5:\"money\";s:4:\"asdf\";}}}}','2011-08-18 04:29:43',0),(11,7,'','a:2:{i:1;a:5:{s:3:\"pos\";i:1;s:6:\"weight\";s:2:\"56\";s:4:\"unit\";s:2:\"kg\";s:4:\"bulk\";s:2:\"34\";s:4:\"item\";a:4:{i:0;a:3:{s:3:\"key\";s:7:\"H343434\";s:4:\"info\";s:9:\"显示器\";s:5:\"money\";s:4:\"8000\";}i:1;a:3:{s:3:\"key\";s:7:\"H989233\";s:4:\"info\";s:6:\"主机\";s:5:\"money\";s:5:\"12000\";}i:2;a:3:{s:3:\"key\";s:7:\"H987834\";s:4:\"info\";s:6:\"鼠标\";s:5:\"money\";s:3:\"100\";}i:3;a:3:{s:3:\"key\";s:7:\"H323443\";s:4:\"info\";s:6:\"键盘\";s:5:\"money\";s:3:\"200\";}}}i:2;a:5:{s:3:\"pos\";i:2;s:6:\"weight\";s:2:\"10\";s:4:\"unit\";s:2:\"kg\";s:4:\"bulk\";s:2:\"10\";s:4:\"item\";a:2:{i:0;a:3:{s:3:\"key\";s:7:\"H343434\";s:4:\"info\";s:6:\"被子\";s:5:\"money\";s:3:\"100\";}i:1;a:3:{s:3:\"key\";s:7:\"H424344\";s:4:\"info\";s:6:\"枕头\";s:5:\"money\";s:2:\"20\";}}}}','2011-08-19 00:18:49',0),(12,8,'','a:1:{i:1;a:5:{s:3:\"pos\";i:1;s:6:\"weight\";s:3:\"ddd\";s:4:\"unit\";s:2:\"kg\";s:4:\"bulk\";s:4:\"sdsd\";s:4:\"item\";a:1:{i:0;a:3:{s:3:\"key\";s:2:\"sd\";s:4:\"info\";s:2:\"sd\";s:5:\"money\";s:2:\"sd\";}}}}','2011-08-20 02:44:55',0),(13,9,'','a:1:{i:1;a:5:{s:3:\"pos\";i:1;s:6:\"weight\";s:2:\"50\";s:4:\"unit\";s:2:\"kg\";s:4:\"bulk\";s:6:\"8*9*10\";s:4:\"item\";a:3:{i:0;a:3:{s:3:\"key\";s:6:\"倩碧\";s:4:\"info\";s:26:\"黄油10 口红30 面霜20\";s:5:\"money\";s:3:\"500\";}i:1;a:3:{s:3:\"key\";s:12:\"雅诗兰黛\";s:4:\"info\";s:34:\"面霜10 爽肤水 15  护手霜20\";s:5:\"money\";s:3:\"450\";}i:2;a:3:{s:3:\"key\";s:3:\"fff\";s:4:\"info\";s:3:\"fff\";s:5:\"money\";s:2:\"ff\";}}}}','2011-08-20 02:47:44',0),(14,7,'','a:2:{i:1;a:5:{s:3:\"pos\";i:1;s:6:\"weight\";s:1:\"2\";s:4:\"unit\";s:2:\"lb\";s:4:\"bulk\";s:5:\"2*3*4\";s:4:\"item\";a:4:{i:0;a:3:{s:3:\"key\";s:8:\"cusmetic\";s:4:\"info\";s:18:\"倩碧 口红10只\";s:5:\"money\";s:2:\"50\";}i:1;a:3:{s:3:\"key\";s:6:\"衣服\";s:4:\"info\";s:22:\"上衣 2件 T-恤 5件\";s:5:\"money\";s:2:\"60\";}i:2;a:3:{s:3:\"key\";s:6:\"奶粉\";s:4:\"info\";s:10:\"雅培4罐\";s:5:\"money\";s:2:\"50\";}i:3;a:3:{s:3:\"key\";s:6:\"鞋子\";s:4:\"info\";s:4:\"2双\";s:5:\"money\";s:2:\"50\";}}}i:2;a:5:{s:3:\"pos\";i:2;s:6:\"weight\";s:2:\"30\";s:4:\"unit\";s:2:\"lb\";s:4:\"bulk\";s:5:\"2*3*4\";s:4:\"item\";a:2:{i:0;a:3:{s:3:\"key\";s:12:\"健身器材\";s:4:\"info\";s:4:\"1台\";s:5:\"money\";s:2:\"60\";}i:1;a:3:{s:3:\"key\";s:9:\"呼吸机\";s:4:\"info\";s:1:\"2\";s:5:\"money\";s:3:\"100\";}}}}','2011-09-11 05:56:10',1),(15,10,'','a:1:{i:1;a:5:{s:3:\"pos\";i:1;s:6:\"weight\";s:3:\"100\";s:4:\"unit\";s:2:\"kg\";s:4:\"bulk\";s:3:\"100\";s:4:\"item\";a:1:{i:0;a:3:{s:3:\"key\";s:1:\"1\";s:4:\"info\";s:21:\"1双鞋子 2套衣服\";s:5:\"money\";s:4:\"5000\";}}}}','2012-04-04 22:02:52',0),(16,8,'','a:1:{i:1;a:5:{s:3:\"pos\";i:1;s:6:\"weight\";s:3:\"123\";s:4:\"unit\";s:2:\"kg\";s:4:\"bulk\";s:1:\"0\";s:4:\"item\";a:1:{i:0;a:3:{s:3:\"key\";s:3:\"123\";s:4:\"info\";s:3:\"123\";s:5:\"money\";s:3:\"123\";}}}}','2012-04-05 08:38:40',1),(17,11,'','a:1:{i:1;a:5:{s:3:\"pos\";i:1;s:6:\"weight\";s:3:\"312\";s:4:\"unit\";s:2:\"kg\";s:4:\"bulk\";s:2:\"12\";s:4:\"item\";a:1:{i:0;a:3:{s:3:\"key\";s:3:\"123\";s:4:\"info\";s:3:\"123\";s:5:\"money\";s:3:\"123\";}}}}','2012-04-05 08:39:01',0),(18,9,'','a:1:{i:1;a:5:{s:3:\"pos\";i:1;s:6:\"weight\";s:1:\"0\";s:4:\"unit\";s:2:\"kg\";s:4:\"bulk\";s:1:\"0\";s:4:\"item\";a:1:{i:0;a:3:{s:3:\"key\";s:6:\"123123\";s:4:\"info\";s:6:\"123123\";s:5:\"money\";s:6:\"123123\";}}}}','2012-04-05 12:35:15',1),(19,10,'','a:1:{i:1;a:5:{s:3:\"pos\";i:1;s:6:\"weight\";s:3:\"123\";s:4:\"unit\";s:2:\"kg\";s:4:\"bulk\";s:1:\"0\";s:4:\"item\";a:1:{i:0;a:3:{s:3:\"key\";s:5:\"12312\";s:4:\"info\";s:7:\"3123123\";s:5:\"money\";s:5:\"12312\";}}}}','2012-04-05 12:36:33',1),(20,11,'','a:1:{i:1;a:5:{s:3:\"pos\";i:1;s:6:\"weight\";s:4:\"1222\";s:4:\"unit\";s:2:\"kg\";s:4:\"bulk\";s:3:\"222\";s:4:\"item\";a:1:{i:0;a:3:{s:3:\"key\";s:1:\"1\";s:4:\"info\";s:14:\"shjdhdjjsjdsds\";s:5:\"money\";s:3:\"100\";}}}}','2012-04-05 12:38:13',1),(21,12,'','a:1:{i:1;a:5:{s:3:\"pos\";i:1;s:6:\"weight\";s:1:\"0\";s:4:\"unit\";s:2:\"kg\";s:4:\"bulk\";s:1:\"0\";s:4:\"item\";a:1:{i:0;a:3:{s:3:\"key\";s:4:\"asfd\";s:4:\"info\";s:4:\"asdf\";s:5:\"money\";s:3:\"asf\";}}}}','2012-04-05 12:41:49',1),(22,12,'','a:1:{i:1;a:5:{s:3:\"pos\";i:1;s:6:\"weight\";s:1:\"1\";s:4:\"unit\";s:2:\"kg\";s:4:\"bulk\";s:1:\"1\";s:4:\"item\";a:1:{i:0;a:3:{s:3:\"key\";s:1:\"1\";s:4:\"info\";s:1:\"1\";s:5:\"money\";s:3:\"100\";}}}}','2012-04-05 12:47:07',0),(23,13,'','a:1:{i:1;a:5:{s:3:\"pos\";i:1;s:6:\"weight\";s:1:\"2\";s:4:\"unit\";s:2:\"kg\";s:4:\"bulk\";s:1:\"2\";s:4:\"item\";a:1:{i:0;a:3:{s:3:\"key\";s:1:\"2\";s:4:\"info\";s:1:\"2\";s:5:\"money\";s:1:\"2\";}}}}','2012-04-05 12:47:07',0),(24,13,'','a:1:{i:1;a:5:{s:3:\"pos\";i:1;s:6:\"weight\";s:4:\"2222\";s:4:\"unit\";s:2:\"kg\";s:4:\"bulk\";s:3:\"222\";s:4:\"item\";a:1:{i:0;a:3:{s:3:\"key\";s:1:\"1\";s:4:\"info\";s:5:\"22222\";s:5:\"money\";s:4:\"1111\";}}}}','2012-04-15 22:24:56',1),(25,14,'','a:1:{i:1;a:5:{s:3:\"pos\";i:1;s:6:\"weight\";s:3:\"1.5\";s:4:\"unit\";s:2:\"lb\";s:4:\"bulk\";s:1:\"0\";s:4:\"item\";a:3:{i:0;a:3:{s:3:\"key\";s:1:\"1\";s:4:\"info\";s:11:\"Moroccanoil\";s:5:\"money\";s:2:\"10\";}i:1;a:3:{s:3:\"key\";s:1:\"2\";s:4:\"info\";s:11:\"Moroccanoil\";s:5:\"money\";s:1:\"5\";}i:2;a:3:{s:3:\"key\";s:1:\"3\";s:4:\"info\";s:11:\"Moroccanoil\";s:5:\"money\";s:1:\"5\";}}}}','2012-04-20 06:56:27',1),(26,14,'','a:1:{i:1;a:5:{s:3:\"pos\";i:1;s:6:\"weight\";s:3:\"1.5\";s:4:\"unit\";s:2:\"lb\";s:4:\"bulk\";s:1:\"0\";s:4:\"item\";a:3:{i:0;a:3:{s:3:\"key\";s:1:\"1\";s:4:\"info\";s:11:\"Moroccanoil\";s:5:\"money\";s:2:\"10\";}i:1;a:3:{s:3:\"key\";s:1:\"2\";s:4:\"info\";s:11:\"Moroccanoil\";s:5:\"money\";s:1:\"5\";}i:2;a:3:{s:3:\"key\";s:1:\"3\";s:4:\"info\";s:11:\"Moroccanoil\";s:5:\"money\";s:1:\"5\";}}}}','2012-04-20 07:09:07',0),(27,15,'','a:1:{i:1;a:5:{s:3:\"pos\";i:1;s:6:\"weight\";s:3:\"060\";s:4:\"unit\";s:2:\"lb\";s:4:\"bulk\";s:1:\"0\";s:4:\"item\";a:1:{i:0;a:3:{s:3:\"key\";s:6:\"diaper\";s:4:\"info\";s:12:\"婴儿尿布\";s:5:\"money\";s:3:\"200\";}}}}','2012-04-21 07:39:07',1),(28,16,'','a:1:{i:1;a:5:{s:3:\"pos\";i:1;s:6:\"weight\";s:2:\"60\";s:4:\"unit\";s:2:\"lb\";s:4:\"bulk\";s:1:\"0\";s:4:\"item\";a:1:{i:0;a:3:{s:3:\"key\";s:6:\"diaper\";s:4:\"info\";s:12:\"婴儿尿布\";s:5:\"money\";s:3:\"200\";}}}}','2012-04-21 07:51:30',1),(29,15,'','a:1:{i:1;a:5:{s:3:\"pos\";i:1;s:6:\"weight\";s:2:\"60\";s:4:\"unit\";s:2:\"lb\";s:4:\"bulk\";s:1:\"0\";s:4:\"item\";a:1:{i:0;a:3:{s:3:\"key\";s:6:\"diaper\";s:4:\"info\";s:12:\"婴儿尿布\";s:5:\"money\";s:3:\"200\";}}}}','2012-04-21 07:55:57',0),(30,17,'','a:1:{i:1;a:5:{s:3:\"pos\";i:1;s:6:\"weight\";s:1:\"0\";s:4:\"unit\";s:2:\"kg\";s:4:\"bulk\";s:1:\"0\";s:4:\"item\";a:1:{i:0;a:3:{s:3:\"key\";s:9:\"123456789\";s:4:\"info\";s:4:\"milk\";s:5:\"money\";s:3:\"$50\";}}}}','2013-06-26 08:13:40',1),(31,16,'','a:1:{i:1;a:5:{s:3:\"pos\";i:1;s:6:\"weight\";s:1:\"6\";s:4:\"unit\";s:2:\"lb\";s:4:\"bulk\";s:1:\"0\";s:4:\"item\";a:1:{i:0;a:3:{s:3:\"key\";s:9:\"123456789\";s:4:\"info\";s:4:\"milk\";s:5:\"money\";s:3:\"$50\";}}}}','2013-06-26 08:26:19',0),(32,17,'','a:1:{i:1;a:5:{s:3:\"pos\";i:1;s:6:\"weight\";s:1:\"2\";s:4:\"unit\";s:2:\"kg\";s:4:\"bulk\";s:1:\"2\";s:4:\"item\";a:1:{i:0;a:3:{s:3:\"key\";s:1:\"1\";s:4:\"info\";s:1:\"d\";s:5:\"money\";s:1:\"d\";}}}}','2013-06-26 22:22:47',0),(33,18,'','a:1:{i:1;a:5:{s:3:\"pos\";i:1;s:6:\"weight\";s:3:\"0.5\";s:4:\"unit\";s:2:\"lb\";s:4:\"bulk\";s:1:\"0\";s:4:\"item\";a:2:{i:0;a:3:{s:3:\"key\";s:9:\"123456789\";s:4:\"info\";s:11:\"Bike 配件\";s:5:\"money\";s:2:\"50\";}i:1;a:3:{s:3:\"key\";s:9:\"123456788\";s:4:\"info\";s:10:\"Auto配件\";s:5:\"money\";s:3:\"100\";}}}}','2013-06-27 06:40:43',1),(34,19,'','a:1:{i:1;a:5:{s:3:\"pos\";i:1;s:6:\"weight\";s:1:\"6\";s:4:\"unit\";s:2:\"lb\";s:4:\"bulk\";s:1:\"0\";s:4:\"item\";a:1:{i:0;a:3:{s:3:\"key\";s:2:\"01\";s:4:\"info\";s:9:\"Car Parts\";s:5:\"money\";s:3:\"100\";}}}}','2013-06-27 09:27:23',1),(35,20,'','a:2:{i:1;a:5:{s:3:\"pos\";i:1;s:6:\"weight\";s:3:\"280\";s:4:\"unit\";s:2:\"kg\";s:4:\"bulk\";s:4:\"3000\";s:4:\"item\";a:2:{i:0;a:3:{s:3:\"key\";s:1:\"1\";s:4:\"info\";s:4:\"ipad\";s:5:\"money\";s:4:\"3000\";}i:1;a:3:{s:3:\"key\";s:1:\"2\";s:4:\"info\";s:6:\"iphone\";s:5:\"money\";s:4:\"3000\";}}}i:2;a:5:{s:3:\"pos\";i:2;s:6:\"weight\";s:3:\"400\";s:4:\"unit\";s:2:\"kg\";s:4:\"bulk\";s:3:\"400\";s:4:\"item\";a:1:{i:0;a:3:{s:3:\"key\";s:1:\"1\";s:4:\"info\";s:5:\"ipad4\";s:5:\"money\";s:4:\"3000\";}}}}','2013-06-27 13:15:13',1),(36,18,'','a:1:{i:1;a:5:{s:3:\"pos\";i:1;s:6:\"weight\";s:3:\"300\";s:4:\"unit\";s:2:\"kg\";s:4:\"bulk\";s:4:\"3000\";s:4:\"item\";a:2:{i:0;a:3:{s:3:\"key\";s:1:\"1\";s:4:\"info\";s:4:\"ipad\";s:5:\"money\";s:4:\"3000\";}i:1;a:3:{s:3:\"key\";s:1:\"2\";s:4:\"info\";s:6:\"iphone\";s:5:\"money\";s:4:\"3000\";}}}}','2013-06-27 13:25:59',0),(37,19,'','a:1:{i:1;a:5:{s:3:\"pos\";i:1;s:6:\"weight\";s:3:\"400\";s:4:\"unit\";s:2:\"kg\";s:4:\"bulk\";s:3:\"400\";s:4:\"item\";a:1:{i:0;a:3:{s:3:\"key\";s:1:\"1\";s:4:\"info\";s:5:\"ipad4\";s:5:\"money\";s:4:\"3000\";}}}}','2013-06-27 13:25:59',0),(38,21,'','a:1:{i:1;a:5:{s:3:\"pos\";i:1;s:6:\"weight\";s:2:\"30\";s:4:\"unit\";s:2:\"kg\";s:4:\"bulk\";s:2:\"30\";s:4:\"item\";a:1:{i:0;a:3:{s:3:\"key\";s:1:\"1\";s:4:\"info\";s:6:\"ssddsd\";s:5:\"money\";s:3:\"100\";}}}}','2013-10-28 14:16:11',1),(39,22,'','a:1:{i:1;a:5:{s:3:\"pos\";i:1;s:6:\"weight\";s:3:\"100\";s:4:\"unit\";s:2:\"kg\";s:4:\"bulk\";s:3:\"100\";s:4:\"item\";a:1:{i:0;a:3:{s:3:\"key\";s:1:\"1\";s:4:\"info\";s:10:\"iphone 100\";s:5:\"money\";s:4:\"8000\";}}}}','2013-11-04 17:06:09',1),(40,23,'','a:1:{i:1;a:5:{s:3:\"pos\";i:1;s:6:\"weight\";s:1:\"2\";s:4:\"unit\";s:2:\"lb\";s:4:\"bulk\";s:1:\"0\";s:4:\"item\";a:1:{i:0;a:3:{s:3:\"key\";s:1:\"1\";s:4:\"info\";s:6:\"奶粉\";s:5:\"money\";s:2:\"20\";}}}}','2014-01-30 04:08:59',1);
/*!40000 ALTER TABLE `goods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `news`
--

DROP TABLE IF EXISTS `news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `news` (
  `NewsId` int(11) NOT NULL AUTO_INCREMENT,
  `Title` varchar(255) DEFAULT NULL,
  `Author` varchar(20) DEFAULT NULL,
  `From` varchar(255) DEFAULT NULL,
  `CreateTime` datetime DEFAULT NULL,
  `Top` tinyint(4) DEFAULT '0',
  `Color` varchar(10) DEFAULT NULL,
  `Content` text,
  PRIMARY KEY (`NewsId`),
  KEY `Idx_news_Top` (`Top`),
  KEY `Idx_news_CreateTime` (`CreateTime`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `news`
--

LOCK TABLES `news` WRITE;
/*!40000 ALTER TABLE `news` DISABLE KEYS */;
INSERT INTO `news` VALUES (1,'我是标题1','admin1','新华社1','2011-07-31 15:37:39',1,'red','<p>\r\n	我是<strong>内容啊 哈哈 ck 111</strong></p>\r\n'),(3,'测试拉','测试','测试','2011-06-28 00:00:00',0,'','<p>\r\n	的说法撒旦法阿萨德阿萨德发顺丰爱睡发生阿斯多夫阿萨德</p>\r\n'),(4,'阿萨德发送到','阿斯多夫','速度','2011-07-14 00:00:00',0,'','<p>\r\n	阿斯多夫撒旦打算阿斯多夫3日234234234</p>\r\n'),(5,'图片新闻','admin','本站','2011-08-12 21:18:08',0,'','<p>\r\n	哈哈 好看不~~</p>\r\n<p>\r\n	<img alt=\"\" src=\"/public/upload/images/50_192005.jpg\" style=\"width: 240px; height: 320px;\" /></p>\r\n');
/*!40000 ALTER TABLE `news` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sn_admingroup`
--

DROP TABLE IF EXISTS `sn_admingroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sn_admingroup` (
  `GroupId` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(20) DEFAULT NULL,
  `Data` text,
  PRIMARY KEY (`GroupId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sn_admingroup`
--

LOCK TABLES `sn_admingroup` WRITE;
/*!40000 ALTER TABLE `sn_admingroup` DISABLE KEYS */;
INSERT INTO `sn_admingroup` VALUES (1,'管理员','a:36:{i:0;s:3:\"1-0\";i:1;s:3:\"1-1\";i:2;s:3:\"1-2\";i:3;s:3:\"5-0\";i:4;s:3:\"5-1\";i:5;s:3:\"5-2\";i:6;s:4:\"10-0\";i:7;s:4:\"10-1\";i:8;s:4:\"15-0\";i:9;s:4:\"15-1\";i:10;s:4:\"15-2\";i:11;s:4:\"16-0\";i:12;s:4:\"16-1\";i:13;s:4:\"20-0\";i:14;s:4:\"20-1\";i:15;s:4:\"20-2\";i:16;s:4:\"20-3\";i:17;s:4:\"25-0\";i:18;s:4:\"25-1\";i:19;s:4:\"25-2\";i:20;s:4:\"25-3\";i:21;s:4:\"30-0\";i:22;s:4:\"30-1\";i:23;s:4:\"30-2\";i:24;s:4:\"35-0\";i:25;s:4:\"35-1\";i:26;s:4:\"40-0\";i:27;s:4:\"40-1\";i:28;s:4:\"45-0\";i:29;s:4:\"45-1\";i:30;s:4:\"45-2\";i:31;s:4:\"45-3\";i:32;s:4:\"45-4\";i:33;s:4:\"45-5\";i:34;s:4:\"50-0\";i:35;s:4:\"50-1\";}'),(2,'运营',NULL),(3,'编辑',NULL),(4,'客服','a:7:{i:0;s:3:\"1-0\";i:1;s:3:\"1-1\";i:2;s:3:\"1-2\";i:3;s:4:\"10-0\";i:4;s:4:\"10-1\";i:5;s:4:\"16-0\";i:6;s:4:\"16-1\";}'),(5,'销售',NULL);
/*!40000 ALTER TABLE `sn_admingroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sn_adminuser`
--

DROP TABLE IF EXISTS `sn_adminuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sn_adminuser` (
  `UserId` int(11) NOT NULL AUTO_INCREMENT,
  `GroupId` int(11) DEFAULT '1',
  `Name` varchar(20) DEFAULT NULL,
  `Pass` char(32) DEFAULT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `CreateTime` datetime DEFAULT NULL,
  `Phone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`UserId`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sn_adminuser`
--

LOCK TABLES `sn_adminuser` WRITE;
/*!40000 ALTER TABLE `sn_adminuser` DISABLE KEYS */;
INSERT INTO `sn_adminuser` VALUES (1,0,'admin','21232f297a57a5a743894a0e4a801fc3','snsnsky@gmail.com','2011-04-24 16:09:21',NULL),(2,1,'user','21232f297a57a5a743894a0e4a801fc3','user@126.com','2011-04-24 18:46:49',NULL),(3,4,'lax_01','202cb962ac59075b964b07152d234b70','kefu1@express.com','2011-08-07 16:30:16','885566741'),(4,4,'lax_02','c81e728d9d4c2f636f067f89cc14862c','kefu2@express.com','2011-08-07 16:30:48','6264428856'),(5,4,'lax_03','202cb962ac59075b964b07152d234b70','kefu3@express.com','2011-08-07 16:30:57',''),(7,1,'snsnsky','202cb962ac59075b964b07152d234b70','snsnsky@126.com','2011-08-12 20:50:08','1565555555'),(8,1,'lax_08001','81dc9bdb52d04dc20036dbd8313ed055','alicedu2007@gmail.com','2011-08-27 01:55:43','6263157262'),(9,5,'lax_14','81dc9bdb52d04dc20036dbd8313ed055','alicedcu2007@gmail.com','2011-08-31 08:38:21','6264428988'),(11,4,'lax_04','698d51a19d8a121ce581499d7b701668','goldenlink@gmail.com','2013-07-11 07:34:06','4428988');
/*!40000 ALTER TABLE `sn_adminuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transport`
--

DROP TABLE IF EXISTS `transport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transport` (
  `TransportId` int(11) NOT NULL AUTO_INCREMENT,
  `BillKey` varchar(512) DEFAULT NULL,
  `BillName` varchar(1024) DEFAULT NULL,
  `WarehouseId` int(11) DEFAULT NULL,
  `WarehouseName` varchar(20) DEFAULT NULL,
  `CreateTime` datetime DEFAULT NULL,
  `UserId` int(11) DEFAULT NULL,
  `Status` tinyint(4) DEFAULT '0' COMMENT '0 入库 1出库 2已提交',
  PRIMARY KEY (`TransportId`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transport`
--

LOCK TABLES `transport` WRITE;
/*!40000 ALTER TABLE `transport` DISABLE KEYS */;
INSERT INTO `transport` VALUES (2,'YL8899552',NULL,1,'芝加哥免费仓库','2011-08-12 16:40:01',1,0),(3,'000000001',NULL,1,'芝加哥免费仓库','2011-08-12 21:46:17',5,0),(4,'123',NULL,2,'旧金山收费仓库','2011-08-13 02:16:24',5,0),(5,'6223232',NULL,3,'纽约免税仓库','2011-08-18 04:17:43',7,0),(6,'fasdf',NULL,2,'旧金山收费仓库','2011-08-18 04:28:51',7,0),(7,'12345',NULL,1,'芝加哥免费仓库','2011-09-11 05:56:10',8,0),(8,'123','123',1,'OR 仓库','2012-04-05 08:38:40',1000,0),(9,'123123','123123',1,'OR 仓库','2012-04-05 12:35:15',1000,0),(10,'123123','123123',1,'OR 仓库','2012-04-05 12:36:33',1000,0),(11,'111111111','22222',2,' LA 仓库','2012-04-05 12:38:13',1005,2),(12,'abc','asdf',1,'OR 仓库','2012-04-05 12:41:49',1000,0),(13,'1111111','22222',1,'OR 仓库','2012-04-15 22:24:56',1005,0),(14,'1Z 02Y 54Y 03 9896 5','UPS',2,' LA 仓库','2012-04-20 06:56:27',1006,2),(15,'123456789','fedex',1,'OR 仓库','2012-04-21 07:39:07',1006,2),(16,'123456789','fedex',1,'OR 仓库','2012-04-21 07:51:30',1006,0),(17,'1234','ups',1,'OR 仓库','2013-06-26 08:13:40',1009,2),(18,'9405 5096 9993 9034 6655 82','USPS',2,' LA 仓库','2013-06-27 06:40:43',1009,0),(19,'9461 2096 9993 8571  0327 08','Fedex',2,' LA 仓库','2013-06-27 09:27:23',1009,0),(20,'123456','lianbang',2,' LA 仓库','2013-06-27 13:15:13',1005,2),(21,'111111123232','sffdfdf',2,' LA 仓库','2013-10-28 14:16:11',1005,0),(22,'A929292','ups',2,' LA 仓库','2013-11-04 17:06:09',1005,1),(23,'123456','usps',2,' LA 仓库','2014-01-30 04:08:59',1011,0);
/*!40000 ALTER TABLE `transport` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `UserId` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(20) DEFAULT NULL,
  `Password` char(32) DEFAULT NULL,
  `RealName` varchar(20) DEFAULT NULL,
  `Phone` varchar(20) DEFAULT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `CreateTime` datetime DEFAULT NULL,
  `ServiceId` int(11) DEFAULT '0',
  `LastLoginTime` datetime DEFAULT NULL,
  `Vip` tinyint(4) DEFAULT '0',
  `Price` int(11) DEFAULT '0',
  `Qq` varchar(12) DEFAULT NULL,
  `Adress` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`UserId`)
) ENGINE=InnoDB AUTO_INCREMENT=1013 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1000,'snsnsky','202cb962ac59075b964b07152d234b70','苏宁','15674855551','snsnsky@126.com','2011-07-29 23:49:53',6,NULL,1,10,NULL,NULL),(1003,'snsnsky1','202cb962ac59075b964b07152d234b70','sky1','4477855','sky@express.com','2011-08-07 17:23:32',5,NULL,0,0,NULL,NULL),(1004,'supor','202cb962ac59075b964b07152d234b70','超人','1565555555','snsnsky@express.com','2011-08-12 21:42:02',3,NULL,0,0,NULL,NULL),(1005,'jorlei','fb119cf05dbdbe0441088180d04fab3c','qiaosanshi','13588094715','dearqiao@gmail.com','2011-08-12 21:45:19',3,NULL,0,0,NULL,NULL),(1006,'alice','81dc9bdb52d04dc20036dbd8313ed055','du','6263157262','alicedu2007@gmail.com','2011-08-18 00:50:41',6,NULL,1,100,'1601537642','10505 Valley Blvd.,Ste 358 El monte,CA 91731'),(1007,'goldenlink','f6d161edee8ecef9f2891500b9d5c1e4','goldenlink','6264428988','goldenlinkexpress@gmail.com','2011-08-18 04:16:52',3,NULL,0,0,NULL,NULL),(1008,'','25d55ad283aa400af464c76d713c07ad','alice du','6263157262','gleexpress2008@gmail.com','2011-09-11 02:55:48',3,NULL,0,0,NULL,NULL),(1009,'','46f94c8de14fb36680850768ff1b7f2a','111111','626-442-8988','111111@gmail.com','2012-04-05 23:52:50',0,NULL,1,10,'1181222827','10505 valley blvd'),(1010,'','9822a0b92f8b33af24365e8d37158eb4','杜晓红','6263157262','sales.gle@gmail.com','2013-06-27 15:37:31',3,NULL,0,0,'384968636','6263157262'),(1011,'','61a60170273e74a5be90355ffe8e86ad','aabbcc','123456789','aabbcc@gmail.com','2014-01-30 04:07:27',3,NULL,0,0,'1181222827','10505 valley blvd el monte'),(1012,'','ee197be3e6e76189f408c08e31c0454f','yyc','15205813072','77107307@qq.com','2014-02-26 15:24:02',3,NULL,0,0,'','');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-03-09 22:11:45
