/*
SQLyog Professional v12.5.1 (32 bit)
MySQL - 10.2.40-MariaDB : Database - epaymentsys
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`epaymentsys` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `epaymentsys`;

/*Table structure for table `bukukas` */

DROP TABLE IF EXISTS `bukukas`;

CREATE TABLE `bukukas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `TglTransaksi` date NOT NULL,
  `TglPencatatan` datetime(6) NOT NULL,
  `KodeAkun` varchar(255) NOT NULL,
  `Keterangan` varchar(255) NOT NULL,
  `UangMasuk` double(16,2) NOT NULL,
  `UangKeluar` double(16,2) NOT NULL,
  `BaseNum` varchar(55) NOT NULL,
  `BaseLine` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `bukukas` */

/*Table structure for table `pembayarandetail` */

DROP TABLE IF EXISTS `pembayarandetail`;

CREATE TABLE `pembayarandetail` (
  `NoTransaksi` varchar(55) NOT NULL,
  `LineNumber` int(11) NOT NULL,
  `KodeItemTagihan` varchar(55) NOT NULL,
  `NamaItemTagihan` varchar(255) NOT NULL,
  `Jumlah` double(16,2) NOT NULL,
  `BaseNum` varchar(55) NOT NULL,
  `BaseLine` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pembayarandetail` */

/*Table structure for table `pembayaranheader` */

DROP TABLE IF EXISTS `pembayaranheader`;

CREATE TABLE `pembayaranheader` (
  `NoTransaksi` varchar(55) NOT NULL,
  `TglTransaksi` date NOT NULL,
  `TglPencatatan` datetime(6) NOT NULL,
  `Keterangan` varchar(255) NOT NULL,
  `CreatedBy` varchar(255) DEFAULT NULL,
  `CreatedOn` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`NoTransaksi`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pembayaranheader` */

/*Table structure for table `permission` */

DROP TABLE IF EXISTS `permission`;

CREATE TABLE `permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionname` varchar(255) DEFAULT NULL,
  `link` varchar(255) DEFAULT NULL,
  `ico` varchar(255) DEFAULT NULL,
  `menusubmenu` varchar(255) DEFAULT NULL,
  `multilevel` bit(1) DEFAULT NULL,
  `separator` bit(1) DEFAULT NULL,
  `order` int(255) DEFAULT NULL,
  `status` bit(1) DEFAULT NULL,
  `AllowMobile` bit(1) DEFAULT NULL,
  `MobileRoute` varchar(255) DEFAULT NULL,
  `MobileLogo` int(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Data for the table `permission` */

insert  into `permission`(`id`,`permissionname`,`link`,`ico`,`menusubmenu`,`multilevel`,`separator`,`order`,`status`,`AllowMobile`,`MobileRoute`,`MobileLogo`) values 
(1,'Pengaturan User','','fa-adjust','0','','\0',1,'',NULL,NULL,NULL),
(2,'Level User','role','','1','\0','\0',2,'',NULL,NULL,NULL),
(3,'User','user','','1','\0','\0',3,'',NULL,NULL,NULL),
(4,'Master Data','','fa-archive','0','','\0',4,'',NULL,NULL,NULL),
(5,'Jurusan','jurusan',' ','4','\0','\0',5,'',NULL,NULL,NULL),
(6,'Kelas','kelas','','4','\0','\0',6,'',NULL,NULL,NULL),
(7,'Siswa','siswa','','4','\0','\0',7,'',NULL,NULL,NULL),
(8,'Keuangan','',' ','4','\0','',8,'',NULL,NULL,NULL),
(9,'Pos Keuangan','poskeu',' ','4','\0','\0',9,'',NULL,NULL,NULL),
(10,'Jenis Tagihan Siswa','jenistagihan','','4','\0','\0',10,'',NULL,NULL,NULL),
(11,'Transaksi','','fa-pencil','0','','\0',11,'',NULL,NULL,NULL),
(12,'Tagihan Siswa','tagihan','','11','\0','\0',12,'',NULL,NULL,NULL),
(13,'Pembayaran Siswa','pembayaran',' ','11','\0','\0',13,'',NULL,NULL,NULL),
(14,'Keuangan','',' ','11','\0','',14,'',NULL,NULL,NULL),
(15,'Buku Kas','bukukas','','11','\0','\0',15,'',NULL,NULL,NULL),
(16,'Laporan','','fa-file','0','','\0',16,'',NULL,NULL,NULL),
(17,'Laporan Pembayaran Siswa','viewpembayaran','','16','','\0',17,'',NULL,NULL,NULL),
(18,'Laporan Keuangan','viewkeuangan','','16','','\0',18,'',NULL,NULL,NULL),
(19,'Profile','profile','fa-user','0','\0','\0',19,'',NULL,NULL,NULL),
(20,'Tagihan','tagihansiswa','fa-list','0','\0','\0',20,'',NULL,NULL,NULL);

/*Table structure for table `permissionrole` */

DROP TABLE IF EXISTS `permissionrole`;

CREATE TABLE `permissionrole` (
  `roleid` int(11) NOT NULL,
  `permissionid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Data for the table `permissionrole` */

insert  into `permissionrole`(`roleid`,`permissionid`) values 
(1,1),
(1,2),
(1,3),
(1,4),
(1,5),
(1,6),
(1,7),
(1,8),
(1,9),
(1,10),
(1,11),
(1,12),
(1,13),
(1,14),
(1,15),
(1,16),
(1,17),
(1,18),
(4,19),
(4,20),
(5,11),
(5,12),
(5,13),
(5,16),
(5,17);

/*Table structure for table `roles` */

DROP TABLE IF EXISTS `roles`;

CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rolename` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Data for the table `roles` */

insert  into `roles`(`id`,`rolename`) values 
(1,'Admin'),
(4,'Siswa'),
(5,'Tata Usaha');

/*Table structure for table `tagihandetail` */

DROP TABLE IF EXISTS `tagihandetail`;

CREATE TABLE `tagihandetail` (
  `NoTransaksi` varchar(55) NOT NULL,
  `LineNumber` int(11) NOT NULL,
  `KodeItemTagihan` varchar(55) NOT NULL,
  `NamaItemTagihan` varchar(255) NOT NULL,
  `JumlahTagihan` double(16,2) NOT NULL,
  `LastUpdatedOn` datetime DEFAULT NULL,
  `LastUpdatedBy` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Data for the table `tagihandetail` */

/*Table structure for table `tagihanheader` */

DROP TABLE IF EXISTS `tagihanheader`;

CREATE TABLE `tagihanheader` (
  `NoTransaksi` varchar(55) NOT NULL,
  `TglTransaksi` date NOT NULL,
  `TglPencatatan` datetime NOT NULL,
  `TglTagihan` date NOT NULL,
  `TglJatuhTempo` date NOT NULL,
  `TahunAjaran` varchar(55) NOT NULL,
  `NISSiswa` varchar(55) NOT NULL,
  `NamaSiswa` varchar(55) NOT NULL,
  `Keterangan` varchar(255) NOT NULL,
  `LastUpdatedOn` datetime DEFAULT NULL,
  `LastUpdatedBy` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`NoTransaksi`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Data for the table `tagihanheader` */

/*Table structure for table `tjenistagihan` */

DROP TABLE IF EXISTS `tjenistagihan`;

CREATE TABLE `tjenistagihan` (
  `KodeTagihan` int(11) NOT NULL AUTO_INCREMENT,
  `NamaTagihan` varchar(100) NOT NULL,
  `KodePosKeuangan` varchar(55) NOT NULL,
  PRIMARY KEY (`KodeTagihan`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Data for the table `tjenistagihan` */

insert  into `tjenistagihan`(`KodeTagihan`,`NamaTagihan`,`KodePosKeuangan`) values 
(2,'SPP Bulanan','1001'),
(3,'Tagihan Seragam','1002'),
(4,'Tagihan Buku LKS','1004');

/*Table structure for table `tjurusan` */

DROP TABLE IF EXISTS `tjurusan`;

CREATE TABLE `tjurusan` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `NamaJurusan` varchar(255) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Data for the table `tjurusan` */

insert  into `tjurusan`(`id`,`NamaJurusan`) values 
(1,'Teknik Kendaraan Ringan'),
(2,'Teknik Komputer dan Jaringan');

/*Table structure for table `tkelas` */

DROP TABLE IF EXISTS `tkelas`;

CREATE TABLE `tkelas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `NamaKelas` varchar(255) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Data for the table `tkelas` */

insert  into `tkelas`(`id`,`NamaKelas`) values 
(1,'XI'),
(2,'XI-1'),
(3,'XI-2'),
(4,'XII'),
(5,'XII-1'),
(6,'XII-2');

/*Table structure for table `tposkeuangan` */

DROP TABLE IF EXISTS `tposkeuangan`;

CREATE TABLE `tposkeuangan` (
  `KodePosKeuangan` varchar(55) NOT NULL,
  `NamaPos` varchar(100) NOT NULL,
  `JenisPos` int(11) NOT NULL COMMENT '1:Masuk, 0: Keluar',
  PRIMARY KEY (`KodePosKeuangan`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Data for the table `tposkeuangan` */

insert  into `tposkeuangan`(`KodePosKeuangan`,`NamaPos`,`JenisPos`) values 
('1001','Penerimaan SPP',1),
('1002','Penerimaan Seragam',1),
('1003','Gaji Guru',0),
('1004','Penerimaan Uang Buku LKS',1),
('1005','Pengeluaran Sosial',0);

/*Table structure for table `tsiswa` */

DROP TABLE IF EXISTS `tsiswa`;

CREATE TABLE `tsiswa` (
  `NIS` varchar(55) NOT NULL,
  `NamaSiswa` varchar(255) NOT NULL,
  `AlamatSiswa` varchar(255) NOT NULL,
  `NamaWali` varchar(255) NOT NULL,
  `Kelas` int(11) NOT NULL,
  `Jurusan` int(11) NOT NULL,
  `TempatLahir` varchar(55) DEFAULT NULL,
  `TglLahir` varchar(255) DEFAULT NULL,
  `NoTlpSiswa` varchar(55) DEFAULT NULL,
  `NoTlpWali` varchar(55) DEFAULT NULL,
  `Email` varchar(55) DEFAULT NULL,
  `TahunAngkatan` varchar(5) NOT NULL,
  `SaldoTagihanSiswa` double(16,0) DEFAULT NULL,
  PRIMARY KEY (`NIS`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Data for the table `tsiswa` */

/*Table structure for table `userrole` */

DROP TABLE IF EXISTS `userrole`;

CREATE TABLE `userrole` (
  `userid` int(11) NOT NULL,
  `roleid` int(11) DEFAULT NULL,
  PRIMARY KEY (`userid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Data for the table `userrole` */

insert  into `userrole`(`userid`,`roleid`) values 
(14,1),
(43,2),
(45,4),
(46,5),
(47,4),
(48,4),
(49,4),
(52,1);

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(75) DEFAULT NULL,
  `nama` varchar(75) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `createdby` varchar(255) DEFAULT NULL,
  `createdon` datetime DEFAULT NULL,
  `HakAkses` int(255) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `verified` bit(1) DEFAULT NULL,
  `ip` varchar(255) DEFAULT NULL,
  `browser` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Data for the table `users` */

insert  into `users`(`id`,`username`,`nama`,`password`,`createdby`,`createdon`,`HakAkses`,`token`,`verified`,`ip`,`browser`,`email`,`phone`) values 
(14,'admin','admin','a9bdd47d7321d4089b3b00561c9c621848bd6f6e2f745a53d54913d613789c23945b66de6ded1eb336a7d526f9349a9d964d6f6c3a40e2ac90b4b16c0121f7895Xg53McbkyQ/NmW60Sf4cu3wJsi/8cyZXxeXV7g6b04=','mnl',NULL,1,NULL,NULL,NULL,NULL,NULL,NULL),
(43,'operator','Operator','a9bdd47d7321d4089b3b00561c9c621848bd6f6e2f745a53d54913d613789c23945b66de6ded1eb336a7d526f9349a9d964d6f6c3a40e2ac90b4b16c0121f7895Xg53McbkyQ/NmW60Sf4cu3wJsi/8cyZXxeXV7g6b04=',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(44,'admin','admin','a9bdd47d7321d4089b3b00561c9c621848bd6f6e2f745a53d54913d613789c23945b66de6ded1eb336a7d526f9349a9d964d6f6c3a40e2ac90b4b16c0121f7895Xg53McbkyQ/NmW60Sf4cu3wJsi/8cyZXxeXV7g6b04=','mnl',NULL,1,NULL,NULL,NULL,NULL,NULL,NULL),
(46,'bety','Bety','b2df567113e2e92a4324189e6ed3de1aee38afad02b62bef041b80dd7a41dd94a39205823c9d223c3f00e16496bf2f7655efa1b129da9d959cee9d48f864a04aOSXowO1yH4v8XhRAxvTkdtoYwj02moauuyjl0VAE15g=',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',NULL);

/* Trigger structure for table `pembayarandetail` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `trg_AddBukuKas` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `trg_AddBukuKas` AFTER INSERT ON `pembayarandetail` FOR EACH ROW BEGIN
	INSERT INTO bukukas
	SELECT 
		0,
		c.TglTransaksi,
		c.TglPencatatan,
		b.KodePosKeuangan,
		c.Keterangan,
		a.Jumlah,
		0,
		a.NoTransaksi,
		a.LineNumber
	FROM pembayarandetail a
	LEFT JOIN tjenistagihan b on a.KodeItemTagihan = b.KodeTagihan
	LEFT JOIN pembayaranheader c on a.NoTransaksi = c.NoTransaksi
	WHERE a.NoTransaksi = NEW.NoTransaksi;
END */$$


DELIMITER ;

/* Trigger structure for table `tsiswa` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `trgAddUser` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `trgAddUser` AFTER INSERT ON `tsiswa` FOR EACH ROW BEGIN
	INSERT into users(username, nama, `password`, CreatedBy, CreatedOn,verified)
	VALUE
	(NEW.NIS,NEW.NamaSiswa,SHA1(NEW.NIS),'AUTO',NOW(),0);
	INSERT into userrole
	SELECT id, 4 FROM users where username = NEW.NIS;
END */$$


DELIMITER ;

/* Function  structure for function  `fnGetMonthName` */

/*!50003 DROP FUNCTION IF EXISTS `fnGetMonthName` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `fnGetMonthName`(`Bulan` int) RETURNS varchar(55) CHARSET latin1
BEGIN
	#Routine body goes here...
	SET @NamaBulan = '';
	SET @NamaBulan = (SELECT CASE WHEN Bulan = 1 THEN 'Januari' ELSE 
		CASE WHEN Bulan = 2 THEN 'Februari' ELSE 
			CASE WHEN Bulan = 3 THEN 'Maret' ELSE 
				CASE WHEN Bulan = 4 THEN 'April' ELSE 
					CASE WHEN Bulan = 5 THEN 'Mei' ELSE 
						CASE WHEN Bulan = 6 THEN 'Juni' ELSE 
							CASE WHEN Bulan = 7 THEN 'Juli' ELSE 
								CASE WHEN Bulan = 8 THEN 'Agustus' ELSE 
									CASE WHEN Bulan = 9 THEN 'September' ELSE 
										CASE WHEN Bulan = 10 THEN 'Oktober' ELSE 
											CASE WHEN Bulan = 11 THEN 'November' ELSE 
												CASE WHEN Bulan = 12 THEN 'Desember' ELSE '' END
											END
										END
									END
								END
							END
						END 
					END
				END
			END
		END
	END);
	RETURN @NamaBulan;
END */$$
DELIMITER ;

/* Function  structure for function  `f_terbilang` */

/*!50003 DROP FUNCTION IF EXISTS `f_terbilang` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `f_terbilang`(angka BIGINT) RETURNS text CHARSET latin1
BEGIN
-- @rgiapratama - 2017
    DECLARE v_result TEXT;
    CALL p_terbilang(angka, v_result);
    RETURN REPLACE(v_result,'  ',' ');
END */$$
DELIMITER ;

/* Procedure structure for procedure `p_terbilang` */

/*!50003 DROP PROCEDURE IF EXISTS  `p_terbilang` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `p_terbilang`(IN angka bigint, OUT retval TEXT)
BEGIN
  -- @rgiapratama - 2017
    DECLARE tmp1 TEXT;
    DECLARE tmp2 TEXT;
     
    SET max_sp_recursion_depth := 20;
 
    IF(angka = 0) THEN
        SET retval = '';
  ELSEIF(angka < 12) THEN
        SET retval = ELT(angka,'satu','dua','tiga','empat','lima','enam','tujuh','delapan','sembilan','sepuluh','sebelas');
  ELSEIF (angka < 20) THEN
        CALL p_terbilang((angka-10),tmp1);
        SET retval = CONCAT(tmp1,' belas');
  ELSEIF (angka < 100) THEN
        CALL p_terbilang(FLOOR(angka/10),tmp1);
        CALL p_terbilang((angka%10),tmp2);
        SET retval = CONCAT(tmp1,' puluh ',tmp2);
  ELSEIf (angka < 200) THEN
        CALL p_terbilang((angka-100),tmp1);
        SET retval = CONCAT('seratus ',tmp1);
  ELSEIF (angka < 1000) THEN
        CALL p_terbilang(FLOOR(angka/100),tmp1);
        CALL p_terbilang((angka%100),tmp2);
        SET retval = CONCAT(tmp1,' ratus ',tmp2);
  ELSEIF (angka < 2000) THEN
        CALL p_terbilang((angka-1000),tmp1);
        SET retval = CONCAT('seribu ',tmp1);
  ELSEIF (angka < 1000000) THEN
        CALL p_terbilang(FLOOR(angka/1000),tmp1);
        CALL p_terbilang((angka%1000),tmp2);
        SET retval = CONCAT(tmp1,' ribu ',tmp2);
  ELSEIF (angka < 1000000000) THEN
        CALL p_terbilang(FLOOR(angka/1000000),tmp1);
        CALL p_terbilang((angka%1000000),tmp2);
        SET retval = CONCAT(tmp1,' juta ',tmp2);
  ELSEIF (angka < 1000000000000) THEN
        CALL p_terbilang(FLOOR(angka/1000000000),tmp1);
        CALL p_terbilang((angka%1000000000),tmp2);
        SET retval = CONCAT(tmp1,' milyar ',tmp2);
  ELSE SET retval = 'GIA';
  END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `vsp_show_buku_kas` */

/*!50003 DROP PROCEDURE IF EXISTS  `vsp_show_buku_kas` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `vsp_show_buku_kas`(IN `TglAwal` date,IN `TglAkhir` date)
BEGIN
	SELECT * FROM (
		SELECT 
			'99'							KodeAkun,
			'SALDO AWAL'			NamaPos,
			''								Reff,
			'2023-06-01'			TglTransaksi,
			'2023-06-01' 			TglPencatatan,
			''								Keterangan,
			COALESCE(SUM(a.UangMasuk - a.UangKeluar),0) SaldoAwal,
			0 Pemasukan,
			0 Pengeluaran
		FROM bukukas a
		LEFT JOIN tposkeuangan b on a.KodeAkun = b.KodePosKeuangan
		WHERE a.TglTransaksi < TglAwal
		UNION ALL
		SELECT 
			a.KodeAkun,
			d.NamaPos,
			a.BaseNum,
			a.TglTransaksi,
			a.TglPencatatan,
			CONCAT(d.NamaPos, ' - ', COALESCE(e.NamaSiswa,''), ' Bulan ', fnGetMonthName(MONTH(a.TglTransaksi)),' ', YEAR(a.TglTransaksi),' # ', a.Keterangan) Keterangan,
			0 SaldoAwal,
			a.UangMasuk,
			a.UangKeluar
		FROM bukukas a
		LEFT JOIN pembayarandetail b on a.BaseNum = b.NoTransaksi and a.BaseLine = b.LineNumber
		LEFT JOIN tagihandetail c on c.NoTransaksi = b.BaseNum and c.LineNumber = b.BaseLine
		LEFT JOIN tposkeuangan d on a.KodeAkun = d.KodePosKeuangan
		LEFT JOIN tagihanheader e on c.NoTransaksi = e.NoTransaksi
		WHERE a.TglTransaksi BETWEEN TglAwal AND TglAkhir
	)x ORDER BY x.TglPencatatan;
END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
