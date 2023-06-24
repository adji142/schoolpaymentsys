/*
 Navicat Premium Data Transfer

 Source Server         : AISServer
 Source Server Type    : MySQL
 Source Server Version : 100240
 Source Host           : localhost:3306
 Source Schema         : epaymentsys

 Target Server Type    : MySQL
 Target Server Version : 100240
 File Encoding         : 65001

 Date: 24/06/2023 12:18:27
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for bukukas
-- ----------------------------
DROP TABLE IF EXISTS `bukukas`;
CREATE TABLE `bukukas`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `TglTransaksi` date NOT NULL,
  `TglPencatatan` datetime(6) NOT NULL,
  `KodeAkun` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Keterangan` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `UangMasuk` double(16, 2) NOT NULL,
  `UangKeluar` double(16, 2) NOT NULL,
  `BaseNum` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `BaseLine` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bukukas
-- ----------------------------
INSERT INTO `bukukas` VALUES (1, '2023-06-25', '2023-06-24 04:35:25.000000', '1001', 'Parsial 1', 250000.00, 0.00, '2023062000001', 0);
INSERT INTO `bukukas` VALUES (2, '2023-06-24', '2023-06-24 06:25:23.000000', '1001', 'asd', 500000.00, 0.00, '2023062000002', 0);
INSERT INTO `bukukas` VALUES (3, '2023-06-24', '2023-06-24 06:25:37.000000', '1001', '', 500000.00, 0.00, '2023062000003', 0);
INSERT INTO `bukukas` VALUES (4, '2023-06-26', '2023-06-24 06:26:43.000000', '1001', '', 250000.00, 0.00, '2023062000004', 0);

-- ----------------------------
-- Table structure for pembayarandetail
-- ----------------------------
DROP TABLE IF EXISTS `pembayarandetail`;
CREATE TABLE `pembayarandetail`  (
  `NoTransaksi` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `LineNumber` int(11) NOT NULL,
  `KodeItemTagihan` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `NamaItemTagihan` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Jumlah` double(16, 2) NOT NULL,
  `BaseNum` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `BaseLine` int(11) NOT NULL
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pembayarandetail
-- ----------------------------
INSERT INTO `pembayarandetail` VALUES ('2023062000001', 0, '2', 'SPP Bulanan', 250000.00, '20230610000104', 0);
INSERT INTO `pembayarandetail` VALUES ('2023062000002', 0, '2', 'SPP Bulanan', 500000.00, '20230610000101', 0);
INSERT INTO `pembayarandetail` VALUES ('2023062000003', 0, '2', 'SPP Bulanan', 500000.00, '20230610000110', 0);
INSERT INTO `pembayarandetail` VALUES ('2023062000004', 0, '2', 'SPP Bulanan', 250000.00, '20230610000104', 0);

-- ----------------------------
-- Table structure for pembayaranheader
-- ----------------------------
DROP TABLE IF EXISTS `pembayaranheader`;
CREATE TABLE `pembayaranheader`  (
  `NoTransaksi` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `TglTransaksi` date NOT NULL,
  `TglPencatatan` datetime(6) NOT NULL,
  `Keterangan` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `CreatedBy` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `CreatedOn` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`NoTransaksi`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pembayaranheader
-- ----------------------------
INSERT INTO `pembayaranheader` VALUES ('2023062000001', '2023-06-25', '2023-06-24 04:35:25.000000', 'Parsial 1', 'admin', '2023-06-24 04:35:25.000000');
INSERT INTO `pembayaranheader` VALUES ('2023062000002', '2023-06-24', '2023-06-24 06:25:23.000000', 'asd', 'admin', '2023-06-24 06:25:23.000000');
INSERT INTO `pembayaranheader` VALUES ('2023062000003', '2023-06-24', '2023-06-24 06:25:37.000000', '', 'admin', '2023-06-24 06:25:37.000000');
INSERT INTO `pembayaranheader` VALUES ('2023062000004', '2023-06-26', '2023-06-24 06:26:43.000000', '', 'admin', '2023-06-24 06:26:43.000000');

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionname` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `link` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `ico` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `menusubmenu` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `multilevel` bit(1) NULL DEFAULT NULL,
  `separator` bit(1) NULL DEFAULT NULL,
  `order` int(255) NULL DEFAULT NULL,
  `status` bit(1) NULL DEFAULT NULL,
  `AllowMobile` bit(1) NULL DEFAULT NULL,
  `MobileRoute` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `MobileLogo` int(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permission
-- ----------------------------
INSERT INTO `permission` VALUES (1, 'Pengaturan User', '', 'fa-adjust', '0', b'1', b'0', 1, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (2, 'Level User', 'role', '', '1', b'0', b'0', 2, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (3, 'User', 'user', '', '1', b'0', b'0', 3, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (4, 'Master Data', '', 'fa-archive', '0', b'1', b'0', 4, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (5, 'Jurusan', 'jurusan', ' ', '4', b'0', b'0', 5, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (6, 'Kelas', 'kelas', '', '4', b'0', b'0', 6, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (7, 'Siswa', 'siswa', '', '4', b'0', b'0', 7, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (8, 'Keuangan', '', ' ', '4', b'0', b'1', 8, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (9, 'Pos Keuangan', 'poskeu', ' ', '4', b'0', b'0', 9, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (10, 'Jenis Tagihan Siswa', 'jenistagihan', '', '4', b'0', b'0', 10, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (11, 'Transaksi', '', 'fa-pencil', '0', b'1', b'0', 11, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (12, 'Tagihan Siswa', 'tagihan', '', '11', b'0', b'0', 12, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (13, 'Pembayaran Siswa', 'pembayaran', ' ', '11', b'0', b'0', 13, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (14, 'Keuangan', '', ' ', '11', b'0', b'1', 14, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (15, 'Buku Kas', 'bukukas', '', '11', b'0', b'0', 15, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (16, 'Laporan', '', 'fa-file', '0', b'1', b'0', 16, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (17, 'Laporan Pembayaran Siswa', 'viewpembayaran', '', '16', b'1', b'0', 17, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (18, 'Laporan Keuangan', 'viewkeuangan', '', '16', b'1', b'0', 18, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (19, 'Profile', 'profile', 'fa-user', '0', b'0', b'0', 19, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (20, 'Tagihan', 'tagihansiswa', 'fa-list', '0', b'0', b'0', 20, b'1', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for permissionrole
-- ----------------------------
DROP TABLE IF EXISTS `permissionrole`;
CREATE TABLE `permissionrole`  (
  `roleid` int(11) NOT NULL,
  `permissionid` int(11) NOT NULL
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permissionrole
-- ----------------------------
INSERT INTO `permissionrole` VALUES (1, 1);
INSERT INTO `permissionrole` VALUES (1, 2);
INSERT INTO `permissionrole` VALUES (1, 3);
INSERT INTO `permissionrole` VALUES (1, 4);
INSERT INTO `permissionrole` VALUES (1, 5);
INSERT INTO `permissionrole` VALUES (1, 6);
INSERT INTO `permissionrole` VALUES (1, 7);
INSERT INTO `permissionrole` VALUES (1, 8);
INSERT INTO `permissionrole` VALUES (1, 9);
INSERT INTO `permissionrole` VALUES (1, 10);
INSERT INTO `permissionrole` VALUES (1, 11);
INSERT INTO `permissionrole` VALUES (1, 12);
INSERT INTO `permissionrole` VALUES (1, 13);
INSERT INTO `permissionrole` VALUES (1, 14);
INSERT INTO `permissionrole` VALUES (1, 15);
INSERT INTO `permissionrole` VALUES (1, 16);
INSERT INTO `permissionrole` VALUES (1, 17);
INSERT INTO `permissionrole` VALUES (1, 18);
INSERT INTO `permissionrole` VALUES (4, 19);
INSERT INTO `permissionrole` VALUES (4, 20);

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rolename` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES (1, 'Admin');
INSERT INTO `roles` VALUES (4, 'Siswa');

-- ----------------------------
-- Table structure for tagihandetail
-- ----------------------------
DROP TABLE IF EXISTS `tagihandetail`;
CREATE TABLE `tagihandetail`  (
  `NoTransaksi` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `LineNumber` int(11) NOT NULL,
  `KodeItemTagihan` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `NamaItemTagihan` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `JumlahTagihan` double(16, 2) NOT NULL,
  `LastUpdatedOn` datetime(0) NULL DEFAULT NULL,
  `LastUpdatedBy` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tagihandetail
-- ----------------------------
INSERT INTO `tagihandetail` VALUES ('20230610000100', 0, '2', 'SPP Bulanan', 500000.00, NULL, NULL);
INSERT INTO `tagihandetail` VALUES ('20230610000101', 0, '2', 'SPP Bulanan', 500000.00, NULL, NULL);
INSERT INTO `tagihandetail` VALUES ('20230610000102', 0, '2', 'SPP Bulanan', 500000.00, NULL, NULL);
INSERT INTO `tagihandetail` VALUES ('20230610000103', 0, '2', 'SPP Bulanan', 500000.00, NULL, NULL);
INSERT INTO `tagihandetail` VALUES ('20230610000104', 0, '2', 'SPP Bulanan', 500000.00, NULL, NULL);
INSERT INTO `tagihandetail` VALUES ('20230610000110', 0, '2', 'SPP Bulanan', 500000.00, NULL, NULL);
INSERT INTO `tagihandetail` VALUES ('20230610000111', 0, '2', 'SPP Bulanan', 500000.00, NULL, NULL);
INSERT INTO `tagihandetail` VALUES ('20230610000112', 0, '2', 'SPP Bulanan', 500000.00, NULL, NULL);
INSERT INTO `tagihandetail` VALUES ('20230610000113', 0, '2', 'SPP Bulanan', 500000.00, NULL, NULL);
INSERT INTO `tagihandetail` VALUES ('20230610000114', 0, '2', 'SPP Bulanan', 500000.00, NULL, NULL);
INSERT INTO `tagihandetail` VALUES ('20230610000120', 0, '2', 'SPP Bulanan', 500000.00, NULL, NULL);
INSERT INTO `tagihandetail` VALUES ('20230610000121', 0, '2', 'SPP Bulanan', 500000.00, NULL, NULL);
INSERT INTO `tagihandetail` VALUES ('20230610000122', 0, '2', 'SPP Bulanan', 500000.00, NULL, NULL);
INSERT INTO `tagihandetail` VALUES ('20230610000123', 0, '2', 'SPP Bulanan', 500000.00, NULL, NULL);
INSERT INTO `tagihandetail` VALUES ('20230610000124', 0, '2', 'SPP Bulanan', 500000.00, NULL, NULL);
INSERT INTO `tagihandetail` VALUES ('20230610000130', 0, '2', 'SPP Bulanan', 500000.00, NULL, NULL);
INSERT INTO `tagihandetail` VALUES ('20230610000131', 0, '2', 'SPP Bulanan', 500000.00, NULL, NULL);
INSERT INTO `tagihandetail` VALUES ('20230610000132', 0, '2', 'SPP Bulanan', 500000.00, NULL, NULL);
INSERT INTO `tagihandetail` VALUES ('20230610000133', 0, '2', 'SPP Bulanan', 500000.00, NULL, NULL);
INSERT INTO `tagihandetail` VALUES ('20230610000134', 0, '2', 'SPP Bulanan', 500000.00, NULL, NULL);
INSERT INTO `tagihandetail` VALUES ('20230610000140', 0, '2', 'SPP Bulanan', 500000.00, NULL, NULL);
INSERT INTO `tagihandetail` VALUES ('20230610000141', 0, '2', 'SPP Bulanan', 500000.00, NULL, NULL);
INSERT INTO `tagihandetail` VALUES ('20230610000142', 0, '2', 'SPP Bulanan', 500000.00, NULL, NULL);
INSERT INTO `tagihandetail` VALUES ('20230610000143', 0, '2', 'SPP Bulanan', 500000.00, NULL, NULL);
INSERT INTO `tagihandetail` VALUES ('20230610000144', 0, '2', 'SPP Bulanan', 500000.00, NULL, NULL);
INSERT INTO `tagihandetail` VALUES ('20230610000150', 0, '2', 'SPP Bulanan', 500000.00, NULL, NULL);
INSERT INTO `tagihandetail` VALUES ('20230610000151', 0, '2', 'SPP Bulanan', 500000.00, NULL, NULL);
INSERT INTO `tagihandetail` VALUES ('20230610000152', 0, '2', 'SPP Bulanan', 500000.00, NULL, NULL);
INSERT INTO `tagihandetail` VALUES ('20230610000153', 0, '2', 'SPP Bulanan', 500000.00, NULL, NULL);
INSERT INTO `tagihandetail` VALUES ('20230610000154', 0, '2', 'SPP Bulanan', 500000.00, NULL, NULL);

-- ----------------------------
-- Table structure for tagihanheader
-- ----------------------------
DROP TABLE IF EXISTS `tagihanheader`;
CREATE TABLE `tagihanheader`  (
  `NoTransaksi` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `TglTransaksi` date NOT NULL,
  `TglPencatatan` datetime(0) NOT NULL,
  `TglTagihan` date NOT NULL,
  `TglJatuhTempo` date NOT NULL,
  `TahunAjaran` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `NISSiswa` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `NamaSiswa` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Keterangan` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `LastUpdatedOn` datetime(0) NULL DEFAULT NULL,
  `LastUpdatedBy` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`NoTransaksi`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tagihanheader
-- ----------------------------
INSERT INTO `tagihanheader` VALUES ('20230610000100', '2023-06-24', '2023-06-24 04:30:19', '2023-07-01', '2023-07-08', '2023-2023', '1185', 'ABI DWI PRADANA', 'test', NULL, NULL);
INSERT INTO `tagihanheader` VALUES ('20230610000101', '2023-06-24', '2023-06-24 04:30:19', '2023-07-01', '2023-07-08', '2023-2023', '1150', 'ADI SAPUTRO', 'test', NULL, NULL);
INSERT INTO `tagihanheader` VALUES ('20230610000102', '2023-06-24', '2023-06-24 04:30:19', '2023-07-01', '2023-07-08', '2023-2023', '1058', 'ADIT HARI RAMADHAN', 'test', NULL, NULL);
INSERT INTO `tagihanheader` VALUES ('20230610000103', '2023-06-24', '2023-06-24 04:30:19', '2023-07-01', '2023-07-08', '2023-2023', '1187', 'ADITYA AGUNG MUSTOFA', 'test', NULL, NULL);
INSERT INTO `tagihanheader` VALUES ('20230610000104', '2023-06-24', '2023-06-24 04:30:19', '2023-07-01', '2023-07-08', '2023-2023', '9999', 'Prasetyo Aji Wibowowo', 'test', NULL, NULL);
INSERT INTO `tagihanheader` VALUES ('20230610000110', '2023-06-24', '2023-06-24 04:30:19', '2023-08-01', '2023-08-08', '2023-2023', '1185', 'ABI DWI PRADANA', 'test', NULL, NULL);
INSERT INTO `tagihanheader` VALUES ('20230610000111', '2023-06-24', '2023-06-24 04:30:19', '2023-08-01', '2023-08-08', '2023-2023', '1150', 'ADI SAPUTRO', 'test', NULL, NULL);
INSERT INTO `tagihanheader` VALUES ('20230610000112', '2023-06-24', '2023-06-24 04:30:19', '2023-08-01', '2023-08-08', '2023-2023', '1058', 'ADIT HARI RAMADHAN', 'test', NULL, NULL);
INSERT INTO `tagihanheader` VALUES ('20230610000113', '2023-06-24', '2023-06-24 04:30:19', '2023-08-01', '2023-08-08', '2023-2023', '1187', 'ADITYA AGUNG MUSTOFA', 'test', NULL, NULL);
INSERT INTO `tagihanheader` VALUES ('20230610000114', '2023-06-24', '2023-06-24 04:30:19', '2023-08-01', '2023-08-08', '2023-2023', '9999', 'Prasetyo Aji Wibowowo', 'test', NULL, NULL);
INSERT INTO `tagihanheader` VALUES ('20230610000120', '2023-06-24', '2023-06-24 04:30:19', '2023-09-01', '2023-09-08', '2023-2023', '1185', 'ABI DWI PRADANA', 'test', NULL, NULL);
INSERT INTO `tagihanheader` VALUES ('20230610000121', '2023-06-24', '2023-06-24 04:30:19', '2023-09-01', '2023-09-08', '2023-2023', '1150', 'ADI SAPUTRO', 'test', NULL, NULL);
INSERT INTO `tagihanheader` VALUES ('20230610000122', '2023-06-24', '2023-06-24 04:30:19', '2023-09-01', '2023-09-08', '2023-2023', '1058', 'ADIT HARI RAMADHAN', 'test', NULL, NULL);
INSERT INTO `tagihanheader` VALUES ('20230610000123', '2023-06-24', '2023-06-24 04:30:19', '2023-09-01', '2023-09-08', '2023-2023', '1187', 'ADITYA AGUNG MUSTOFA', 'test', NULL, NULL);
INSERT INTO `tagihanheader` VALUES ('20230610000124', '2023-06-24', '2023-06-24 04:30:19', '2023-09-01', '2023-09-08', '2023-2023', '9999', 'Prasetyo Aji Wibowowo', 'test', NULL, NULL);
INSERT INTO `tagihanheader` VALUES ('20230610000130', '2023-06-24', '2023-06-24 04:30:19', '2023-10-01', '2023-10-08', '2023-2023', '1185', 'ABI DWI PRADANA', 'test', NULL, NULL);
INSERT INTO `tagihanheader` VALUES ('20230610000131', '2023-06-24', '2023-06-24 04:30:19', '2023-10-01', '2023-10-08', '2023-2023', '1150', 'ADI SAPUTRO', 'test', NULL, NULL);
INSERT INTO `tagihanheader` VALUES ('20230610000132', '2023-06-24', '2023-06-24 04:30:19', '2023-10-01', '2023-10-08', '2023-2023', '1058', 'ADIT HARI RAMADHAN', 'test', NULL, NULL);
INSERT INTO `tagihanheader` VALUES ('20230610000133', '2023-06-24', '2023-06-24 04:30:19', '2023-10-01', '2023-10-08', '2023-2023', '1187', 'ADITYA AGUNG MUSTOFA', 'test', NULL, NULL);
INSERT INTO `tagihanheader` VALUES ('20230610000134', '2023-06-24', '2023-06-24 04:30:19', '2023-10-01', '2023-10-08', '2023-2023', '9999', 'Prasetyo Aji Wibowowo', 'test', NULL, NULL);
INSERT INTO `tagihanheader` VALUES ('20230610000140', '2023-06-24', '2023-06-24 04:30:19', '2023-11-01', '2023-11-08', '2023-2023', '1185', 'ABI DWI PRADANA', 'test', NULL, NULL);
INSERT INTO `tagihanheader` VALUES ('20230610000141', '2023-06-24', '2023-06-24 04:30:19', '2023-11-01', '2023-11-08', '2023-2023', '1150', 'ADI SAPUTRO', 'test', NULL, NULL);
INSERT INTO `tagihanheader` VALUES ('20230610000142', '2023-06-24', '2023-06-24 04:30:19', '2023-11-01', '2023-11-08', '2023-2023', '1058', 'ADIT HARI RAMADHAN', 'test', NULL, NULL);
INSERT INTO `tagihanheader` VALUES ('20230610000143', '2023-06-24', '2023-06-24 04:30:19', '2023-11-01', '2023-11-08', '2023-2023', '1187', 'ADITYA AGUNG MUSTOFA', 'test', NULL, NULL);
INSERT INTO `tagihanheader` VALUES ('20230610000144', '2023-06-24', '2023-06-24 04:30:19', '2023-11-01', '2023-11-08', '2023-2023', '9999', 'Prasetyo Aji Wibowowo', 'test', NULL, NULL);
INSERT INTO `tagihanheader` VALUES ('20230610000150', '2023-06-24', '2023-06-24 04:30:19', '2023-12-01', '2023-12-08', '2023-2023', '1185', 'ABI DWI PRADANA', 'test', NULL, NULL);
INSERT INTO `tagihanheader` VALUES ('20230610000151', '2023-06-24', '2023-06-24 04:30:19', '2023-12-01', '2023-12-08', '2023-2023', '1150', 'ADI SAPUTRO', 'test', NULL, NULL);
INSERT INTO `tagihanheader` VALUES ('20230610000152', '2023-06-24', '2023-06-24 04:30:19', '2023-12-01', '2023-12-08', '2023-2023', '1058', 'ADIT HARI RAMADHAN', 'test', NULL, NULL);
INSERT INTO `tagihanheader` VALUES ('20230610000153', '2023-06-24', '2023-06-24 04:30:19', '2023-12-01', '2023-12-08', '2023-2023', '1187', 'ADITYA AGUNG MUSTOFA', 'test', NULL, NULL);
INSERT INTO `tagihanheader` VALUES ('20230610000154', '2023-06-24', '2023-06-24 04:30:19', '2023-12-01', '2023-12-08', '2023-2023', '9999', 'Prasetyo Aji Wibowowo', 'test', NULL, NULL);

-- ----------------------------
-- Table structure for tjenistagihan
-- ----------------------------
DROP TABLE IF EXISTS `tjenistagihan`;
CREATE TABLE `tjenistagihan`  (
  `KodeTagihan` int(11) NOT NULL AUTO_INCREMENT,
  `NamaTagihan` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `KodePosKeuangan` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`KodeTagihan`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tjenistagihan
-- ----------------------------
INSERT INTO `tjenistagihan` VALUES (2, 'SPP Bulanan', '1001');
INSERT INTO `tjenistagihan` VALUES (3, 'Tagihan Seragam', '1002');

-- ----------------------------
-- Table structure for tjurusan
-- ----------------------------
DROP TABLE IF EXISTS `tjurusan`;
CREATE TABLE `tjurusan`  (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `NamaJurusan` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tjurusan
-- ----------------------------
INSERT INTO `tjurusan` VALUES (1, 'Teknik Kendaraan Ringan');
INSERT INTO `tjurusan` VALUES (2, 'Teknik Komputer dan Jaringan');

-- ----------------------------
-- Table structure for tkelas
-- ----------------------------
DROP TABLE IF EXISTS `tkelas`;
CREATE TABLE `tkelas`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `NamaKelas` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tkelas
-- ----------------------------
INSERT INTO `tkelas` VALUES (1, 'XI');
INSERT INTO `tkelas` VALUES (2, 'XI-1');
INSERT INTO `tkelas` VALUES (3, 'XI-2');
INSERT INTO `tkelas` VALUES (4, 'XII');
INSERT INTO `tkelas` VALUES (5, 'XII-1');
INSERT INTO `tkelas` VALUES (6, 'XII-2');

-- ----------------------------
-- Table structure for tposkeuangan
-- ----------------------------
DROP TABLE IF EXISTS `tposkeuangan`;
CREATE TABLE `tposkeuangan`  (
  `KodePosKeuangan` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `NamaPos` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `JenisPos` int(11) NOT NULL COMMENT '1:Masuk, 0: Keluar',
  PRIMARY KEY (`KodePosKeuangan`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tposkeuangan
-- ----------------------------
INSERT INTO `tposkeuangan` VALUES ('1001', 'Penerimaan SPP', 1);
INSERT INTO `tposkeuangan` VALUES ('1002', 'Penerimaan Seragam', 1);
INSERT INTO `tposkeuangan` VALUES ('1003', 'Gaji Guru', 0);

-- ----------------------------
-- Table structure for tsiswa
-- ----------------------------
DROP TABLE IF EXISTS `tsiswa`;
CREATE TABLE `tsiswa`  (
  `NIS` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `NamaSiswa` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `AlamatSiswa` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `NamaWali` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Kelas` int(11) NOT NULL,
  `Jurusan` int(11) NOT NULL,
  `TempatLahir` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `TglLahir` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `NoTlpSiswa` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `NoTlpWali` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `Email` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `TahunAngkatan` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `SaldoTagihanSiswa` double(16, 0) NULL DEFAULT NULL,
  PRIMARY KEY (`NIS`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tsiswa
-- ----------------------------
INSERT INTO `tsiswa` VALUES ('1058', 'ADIT HARI RAMADHAN', 'Wonorejo, Wonorejo, Kalijambe ', '', 4, 2, 'PURBALINGGA', '2006-10-09', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1059', 'ANANDA SHOFIYATUL NAKHYA', 'Pereng, Pakel, Andong', '', 4, 2, 'Boyolali', '2006-04-28', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1060', 'ANGGITA PUTRI ZULAEKA', 'Kendal, Pulutan, Nogosari', '', 4, 2, 'BOYOLALI', '2005-01-20', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1061', 'AZZAHRA BINTANG PRADANA PUTRI', 'Jetis, Ketitang, Nogosari', '', 4, 2, 'Sragen', '2006-05-03', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1062', 'BELLA AINUR ROFIAH', 'Pakel, Pakel, Andong', '', 4, 2, 'BOYOLALI', '2006-11-25', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1064', 'CHELSEA AFRIYANI', 'Pereng, Pakel, Andong', '', 4, 2, 'Boyolali', '2006-04-29', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1065', 'CHINTYA PUTRI SAMIRA', 'Blumbang, Saren, Kalijambe', '', 4, 2, 'SRAGEN', '2006-11-28', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1066', 'CUT MILA', 'Pulorejo, Pulutan, Nogosari', '', 4, 2, 'CIMAHI', '2006-07-30', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1067', 'ELYANI NURLITA ARISTAWATI', 'Jetak, Gondangrawe, Andong', '', 4, 2, 'Boyolali', '2006-07-05', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1068', 'ERIKA DIAN NUR ANGGRAINI', 'Sendangsari, Wonorejo, Kalijambe', '', 4, 2, 'Sragen', '2005-03-31', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1069', 'FEBRIANI NUR AFIFAH', 'Gumukrejo, Gondangrawe, Andong', '', 4, 2, 'BOYOLALI', '2006-02-12', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1070', 'ISNA ARIYANTI', 'Pereng, Pakel, Andong', '', 4, 2, 'Boyolali', '2006-02-13', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1071', 'LILIK RAHMAWATI', 'Tegalsari, Wonorejo,Kalijambe', '', 4, 2, 'Sragen', '2013-12-31', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1072', 'SUCI ANGGRAINI', 'Guwosari, Jebres, Surakarta', '', 5, 1, 'Sragen', '2006-01-05', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1073', 'ABI PRATAMA NUR DIANSYAH', 'Rejosari, Donoyudan, Kalijambe', '', 5, 1, 'Sragen', '2006-01-12', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1074', 'ADITYA PRATAMA', 'Mencil, Pulutan, Nogosari', '', 5, 1, 'Tangerang', '2006-09-07', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1075', 'AFIN HENDRI PURNOMO', 'Blumbang, Saren, Kalijambe', '', 5, 1, 'SRAGEN', '2006-03-14', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1076', 'AGUS TAUFIKUR ROHMAN', 'Sendangsari, Wonorejo, Kalijambe', '', 5, 1, 'Sragen', '2006-05-03', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1077', 'AHMAD ZAZID BASTOMI', 'Pereng, Pakel, Andong', '', 5, 1, 'BOYOLALI', '2006-01-06', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1078', 'ALFI DAHLIA RAHMAWATI', 'Pereng, Pakel, Andong', '', 5, 1, 'Boyolali', '2007-12-09', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1079', 'AMELIA PUTRI FITRIANI', 'Blagungan, Donoyudan, Kalijambe', '', 5, 1, 'Sragen', '2004-12-18', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1081', 'ARIF RIDWAN', 'Mojosari, Pulutan, Nogosari', '', 5, 1, 'BOYOLALI', '2006-03-10', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1082', 'BAGAS ILHAM FIRMANSYAH', 'Ngleri, Keden, Kalijambe', '', 5, 1, 'Sragen', '2005-10-20', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1084', 'DAVA ABIMANYU PUTRA', 'Mojokembang, Keden, kalijambe', '', 5, 1, 'TANGERANG', '2006-07-21', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1086', 'DHEA RISKA DESTA RINA', 'Krajan, Karangmojo, Klego', '', 5, 1, 'Boyolali', '2006-12-20', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1087', 'FATIR FAUZI SAPUTRA', 'Pereng, Pakel, Andong', '', 5, 1, 'Boyolali', '2006-12-31', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1088', 'FEVI ARTIA NAILA SARI', 'Kedungwaru, geneng, Miri', '', 5, 1, 'Sragen', '2006-02-24', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1090', 'IBNU ARSI ANGGARA', 'Pereng, Pakel, Andong', '', 5, 1, 'BOYOLALI', '2008-12-09', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1091', 'IQRA PUTRA RAMADHANI', 'Duren, Wonorejo, Kalijambe', '', 5, 1, 'Sragen', '2006-10-10', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1092', 'IVAN FREDY PRASETYO', 'Plosorejo, Kalimacan, Kalijambe', '', 5, 1, 'Sragen', '2006-03-18', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1093', 'JUAN DECO IBRAHIM AZIZ', 'Pelem, Geneng, Miri', '', 5, 1, 'BEKASI', '2006-02-13', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1094', 'MUH.HAIKAL YUNUS', 'Sambirembe, Sambirembe, Kalijambe', '', 5, 1, 'Sragen', '2006-02-22', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1095', 'MUHAMMAD AZAM', 'Pakel, Pakel, Andong', '', 5, 1, 'Boyolali', '2006-04-11', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1097', 'MUHAMMAD HAIKAL PAJERI', 'Blagungrejo, Wonorejo, Kalijambe', '', 5, 1, 'SRAGEN', '2006-04-06', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1098', 'MUHAMMAD MUKHLISIN', 'Pereng, Pakel, Andong', '', 5, 1, 'Boyolali', '2006-01-18', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1099', 'MUHAMMAD WAHYUDDIN SUBHAN', 'Pulutan, Pulutan, Nogosari', '', 5, 1, 'Jakarta', '2006-05-16', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1100', 'MUHAMMAD YUDA PRASETYO', 'Blumbang, Saren, Kalijambe', '', 5, 1, 'SRAGEN', '2005-11-13', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1101', 'NABILA SETIAWATI', 'Drugan, Trobayan, Kalijambe', '', 5, 1, 'Sragen', '2005-09-09', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1102', 'NAYLA SASKYA KHAIRANI', 'Blagungan, Donoyudan, Kalijambe', '', 5, 1, 'Sragen', '2006-08-25', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1103', 'NOVA CATUR ARDIANSYAH', 'Alasmalang, Gondangrawe, Andong', '', 5, 1, 'BOYOLALI', '2006-11-24', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1104', 'RAHMAT KHALIL RIYADI', 'Tegalsari, Wonorejo,Kalijambe', '', 5, 1, 'Sragen', '2006-07-19', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1105', 'RIAN ANGGA SAPUTRA', 'Pomahan, pulutan, Nogosari', '', 5, 1, 'BOYOLALI', '2005-12-10', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1106', 'RIO ADJIE PAMUNGKAS', 'Jipangan, Trobayan, Kalijambe', '', 5, 1, 'Jakarta', '2004-11-09', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1107', 'SAFARUDIN', 'Grumbuldowo, Sambirembe, Kalijambe', '', 5, 1, 'Sragen', '2006-03-17', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1108', 'SIGID PRIANTO', 'Pereng, Pakel, Andong', '', 5, 1, 'Boyolali', '2007-02-12', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1109', 'ADITIA DUWI SAPUTRO', 'Cumpleng, Saren, Kalijambe', '', 6, 1, 'Sragen', '2003-10-18', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1110', 'ADITIYA FAHRI AKBAR', 'Randugede, Pulutan, Nogosari', '', 6, 1, 'BOYOLALI', '2005-12-16', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1111', 'AGUS SANTOSO', 'Jayan, Saren, Kalijambe', '', 6, 1, 'Sragen', '2005-05-08', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1112', 'ARDI KURNIAWAN', 'Pomahan, pulutan, Nogosari', '', 6, 1, 'BOYOLALI', '2005-11-10', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1113', 'BAGAS RAFIUD DARAJAD', 'Rejosari, Donoyudan, Kalijambe', '', 6, 1, 'Sragen', '2005-03-29', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1114', 'DANISWARA', 'Tegalsari, Wonorejo,Kalijambe', '', 6, 1, 'Sragen', '2005-09-23', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1115', 'DIKA ARIS WIDIANTO', 'Blagungrejo, Wonorejo, Kalijambe', '', 6, 1, 'SRAGEN', '2005-11-20', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1117', 'EPRIL DWI SATRIYO', 'Pakel, Pakel, Andong', '', 6, 1, 'BOYOLALI', '2005-04-10', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1118', 'FAJAR ICHTIAR NAZIL', 'Wonorejo, Wonorejo, Kalijambe ', '', 6, 1, 'Sragen', '2006-08-31', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1119', 'GIGIH HARTANTO', 'Randugede, Pulutan, Nogosari', '', 6, 1, 'BOYOLALI', '2006-02-19', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1120', 'IKHSAN ZAENAL ARIFIN', 'Butuh, Wonorejo, Kalijambe', '', 6, 1, 'Sragen', '2006-03-07', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1121', 'ILHAM HAPPY HANAFI', 'Tegalrejo, Wonorejo, Kalijambe', '', 6, 1, 'Sragen', '2006-04-13', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1122', 'IRFAN ADITYA PRATAMA', 'Blagungrejo, Wonorejo, Kalijambe', '', 6, 1, 'Sragen', '2005-09-05', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1123', 'IRGITA LEO PUTRA PRATAMA', 'Wonorejo, Wonorejo, Kalijambe ', '', 6, 1, 'Sragen', '2006-07-12', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1124', 'JAGAT ENGGAR KUSUMA', 'Losari, Pulutan, Nogosari', '', 6, 1, 'Boyolali', '2006-09-21', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1125', 'KHAFIDL NUR FAUZAN', 'Kedungwaru, Wonorejo, Kalijambe', '', 6, 1, 'Sragen', '2006-08-21', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1126', 'KHOIRUL RAHMAD RIFAI', 'Cumpleng, Saren, Kalijambe', '', 6, 1, 'Sragen', '2005-07-10', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1127', 'MUHAMMAD KURNIAWAN NUR FATHONI', 'Tegalrejo, Donoyudan, Kalijambe', '', 6, 1, 'Sragen', '2006-01-25', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1128', 'MUHAMMAD RAHMAWAN NUR FAUZI', 'Tegalrejo, Donoyudan, Kalijambe', '', 6, 1, 'Sragen', '2006-01-25', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1129', 'MUHAMMAD ADITYA NUGROHO', 'Randualas, Pulutan, Nogosari', '', 6, 1, 'BOYOLALI', '2005-12-08', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1131', 'MUHAMMAD RIDWAN', 'Mojokembang, Keden, kalijambe', '', 6, 1, 'Sragen', '2006-08-22', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1132', 'MUHAMMAD SIDIQ', 'Loning, Pulutan ,Nogosari', '', 6, 1, 'BOYOLALI', '2005-05-17', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1133', 'NICO EKA ARYANSYAH', 'Rejosari, Donoyudan, Kalijambe', '', 6, 1, 'Sragen', '2006-06-08', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1134', 'NUGROHO SIDIK MAULANA IBRAHIM', 'Jeruk Manis, Wonorejo, Kalijambe', '', 6, 1, 'SRAGEN', '2006-05-17', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1135', 'NUR HARYANTO', 'Mencil, Pulutan, Nogosari', '', 6, 1, 'Boyolali', '2005-12-13', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1136', 'RAFFA AJIE SAPUTRA', 'Tegalsari, Wonorejo,Kalijambe', '', 6, 1, 'Sragen', '2006-11-09', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1137', 'RESNO DANU RAMADANI', 'Gumukrejo, Gondangrawe, Andong', '', 6, 1, 'BOYOLALI', '2006-10-30', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1138', 'ROBI DAMA PRAKOSO', 'Sendangsari, Wonorejo, Kalijambe', '', 6, 1, 'Sragen', '2006-01-21', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1140', 'SRI RANGGA BAYU NUGROHO', 'Butuh, Wonorejo, Kalijambe', '', 6, 1, 'Sragen', '2005-11-28', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1141', 'TRI WINARNO', 'Plosorejo, Pulutan, nogosari', '', 6, 1, 'Karanganyar', '2005-08-16', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1142', 'TRIA ALFATAH', 'Nyaen, Trobayan, Kalijambe', '', 6, 1, 'Sragen', '2005-08-10', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1143', 'YAZID MUHROM AZZACKY', 'Grumbuldowo, Sambirembe, Kalijambe', '', 6, 1, 'SRAGEN', '2006-01-31', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1144', 'YAZIN ISMAEL', 'Beran, Donoyudan, Kalijambe', '', 6, 1, 'Sragen', '2006-02-06', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1145', 'YUSUF NAJARUDIN', 'Gumukrejo, Gondangrawe, Andong', '', 6, 1, 'BOYOLALI', '2006-03-18', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1146', 'YUSUP RAMADANI', 'Mojosari, Pulutan, Nogosari', '-', 0, 0, 'BOYOLALI', '2005-11-01', '081325058258', '', '', '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1147', 'ANGGUN', 'Derepan, Donoyudan, Kalijambe', '', 4, 2, 'SRAGEN', '2006-08-26', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1149', 'AHMAD SAFII MUNANDAR', 'Jetak, Gondangrawe, Andong', '', 5, 1, 'BOYOLALI', '2006-06-15', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1150', 'ADI SAPUTRO', 'Tegalsari, Wonorejo,Kalijambe', '', 2, 1, 'Sragen', '2007-08-19', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1151', 'ALDI PRATAMA', 'Pelem, Geneng, Miri', '', 2, 1, 'Sragen', '2007-02-16', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1152', 'ANDIKA BAYU SEPTIAN', 'Karangnongko, sambirembe, Kalijambe', '', 2, 1, 'Sragen', '2007-09-01', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1153', 'ANGGUN SANGGARWATI', '', '', 2, 1, NULL, NULL, NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1154', 'ARYO AJI WIBOWO', 'Wonorejo, Wonorejo, Kalijambe ', '', 2, 1, 'Sragen', '2007-04-07', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1155', 'BAGUS AJI WICAKSONO', 'Plosorejo, Sempu, Andong', '', 2, 1, 'Boyolali', '2007-06-13', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1156', 'BAYU SAPUTRA', 'Blumbang, Saren, Kalijambe', '', 2, 1, 'Sragen', '2006-11-29', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1157', 'FADILA NURUL HIDAYAH', 'Kedungwaru, Geneng, Miri', '', 2, 1, 'Klaten', '2006-12-26', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1158', 'FAUZI HASAN TRI WIBOWO', 'Tegalrejo, Donoyudan,Kalijambe', '', 2, 1, 'Sragen', '2006-12-20', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1159', 'FIKI FERDIANSYAH', 'Pelem, Geneng, Miri', '', 2, 1, 'Sragen', '2007-08-08', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1160', 'FIRDAUS SAPUTRA KS', 'Plosorejo, Kalimacan, Kalijambe', '', 2, 1, 'Sragen', '2006-09-03', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1161', 'IFTANA FIDWA ARBA', 'Kalijambe, Krikilan, Kalijambe', '', 2, 1, 'Sragen', '2008-01-16', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1162', 'JEFRI AZHAR HAZWAN', 'Beran, Donoyudan, Kalijambe', '', 2, 1, 'Sragen', '2007-07-17', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1163', 'LUKFY AL AZIZ', 'Rejosari, Donoyudan, Kalijambe', '', 2, 1, 'Sragen', '2006-10-03', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1165', 'LUTFIA EKA RAHMA ANDINI', 'Bendosari, Donoyudan, Kalijambe', '', 2, 1, 'Sragen', '2007-04-07', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1167', 'MUHAMMAD HANAFI AL FARIZI', 'Plawar, Saren, Kalijambe', '', 2, 1, 'Sragen', '2007-05-17', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1168', 'MUHAMMAD HUSNI MUBAROK', 'Randusari, Keden, Kalijambe', '', 2, 1, 'Jakarta', '2006-01-11', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1171', 'MUHAMMAD VERY ADITYA', 'Jengglong, Sempu, Andong', '', 2, 1, 'Boyolali', '2007-01-09', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1172', 'NISA DWI PURWANTI', 'Kedungwaru, Geneng, Miri', '', 2, 1, 'Sragen', '2007-05-05', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1173', 'QUROTUL QOIS', 'Mojokembang, Keden, kalijambe', '', 2, 1, 'SRAGEN', '2008-12-23', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1174', 'RAFLY ADE SETYAWAN', 'Jengglong, Sempu, Andong', '', 2, 1, 'BOYOLALI', '2006-12-13', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1175', 'RANGGA WIDYA PUTRA', 'Ngleri, Keden, Kalijambe', '', 2, 1, 'Sragen', '2007-06-26', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1177', 'RIANDA AKBAR SODIQ', 'Karangnongko, sambirembe, Kalijambe', '', 2, 1, 'SRAGEN', '2007-06-30', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1178', 'RIZKI AKBAR ASSIDIK', 'Saren, Saren, Kalijambe', '', 2, 1, 'SRAGEN', '2007-04-15', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1179', 'ROHMAD WAHYU ROMADHON', 'Blagungan, Donoyudan, Kalijambe', '', 2, 1, 'Sragen', '2007-01-14', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1180', 'RYAN RAFA\'EL', 'Keden wetan, Keden, Kalijambe', '', 2, 1, 'SRAGEN', '2006-08-11', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1181', 'SLAMET WAHYU RAMADHAN', 'Wonosari, Sambirembe, Kalijambe', '', 2, 1, 'SRAGEN', '2007-09-17', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1182', 'SYAFRUDIN ZAKI', 'Gondangrawe, Andong', '', 2, 1, 'BOYOLALI', '2007-07-27', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1183', 'YOGA TRI SAPUTRA', 'Sanggrahan, Pulutan, Nogosari', '', 2, 1, 'BOYOLALI', '2007-01-10', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1184', 'ABDUL HAKIM', 'Mojokembang, Keden, kalijambe', '', 3, 1, 'SRAGEN', '2008-05-03', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1185', 'ABI DWI PRADANA', 'Pakel, Pakel, Andong', '', 3, 1, 'Boyolali', '2006-08-01', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1186', 'ADE CANDY SATRIYA', 'Blagungrejo, Wonorejo, Kalijambe', '', 3, 1, 'SRAGEN', '2007-06-22', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1187', 'ADITYA AGUNG MUSTOFA', 'Tegalrejo, Donoyudan, Kalijambe', '', 3, 1, 'SRAGEN', '2006-12-22', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1188', 'ADITYA PAMUNGKAS', 'Nyaen, Trobayan, Kalijambe', '', 3, 1, 'SRAGEN', '2007-08-05', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1189', 'AGU LAKSA KUSUMA MUKTI PRATAMA', 'Muncar, Pakel, Andong', '', 3, 1, 'Boyolali', '2007-01-04', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1190', 'ANDI FEBRIYANTO', 'Jatirejo, Sempu, Andong', '', 3, 1, 'BOYOLALI', '2007-02-22', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1192', 'ARIYA LINTANG SETYAYUDA', 'Pokokrajan, Pulutan, Nogosari', '', 3, 1, 'Boyolali', '2007-05-15', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1193', 'ARIZAL SHOFIYAN SYAH', 'Dawung, Sempu, Andong', '', 3, 1, 'BOYOLALI', '2006-01-04', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1194', 'BAGAS ABDI PRATAMA', 'Keden kulon, Keden, Kalijambe', '', 3, 1, 'SRAGEN', '2007-12-01', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1195', 'DONI EKO PRASETYO', 'Butuh, Wonorejo, Kalijambe', '', 3, 1, 'Sragen', '2007-05-03', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1196', 'EXSEL VALENTINO', 'Sendang, Bukuran, Kalijambe', '', 3, 1, 'SRAGEN', '2008-01-13', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1197', 'FIANDRA HAFIZH SAPUTRA', 'Karangnongko, sambirembe, Kalijambe', '', 3, 1, 'SRAGEN', '2007-07-25', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1198', 'FIKRI SATRIYA DIRGANTARA', '', '', 3, 1, NULL, NULL, NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1199', 'GADING SATRIA KENCANA', 'Blagungrejo, Wonorejo, Kalijambe', '', 3, 1, 'Sragen', '2006-07-14', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1200', 'GALANG PUTRA PRASETYA', '', '', 3, 1, NULL, NULL, NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1201', 'GIBRAN AZRIEL FAHREZA BUDIATAMA', 'Pakel, Pakel, Andong', '', 3, 1, 'SUKOHARJO', '2006-11-10', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1202', 'HIBRA YUDIRA RAHMADANI', 'Kedungwaru, Geneng, Miri', '', 3, 1, 'Sragen', '2007-10-02', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1203', 'ILHAM', 'Gondangrejo, Pulutan, Nogosari', '', 3, 1, 'Jepara', '2006-12-27', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1204', 'ILHAM RIKO PRATAMA', 'Pakel, Pakel, Andong', '', 3, 1, 'BOYOLALI', '2006-07-24', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1205', 'JUNI SAPUTRA', 'Cumpleng, Saren, Kalijambe', '', 3, 1, 'SRAGEN', '2007-06-06', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1206', 'KURNIAWAN DWI YULIANTO', 'Randualas, Pulutan, Nogosari', '', 3, 1, 'KLATEN', '2006-07-24', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1207', 'MUHAMMAD AGUNG HERMAWAN', 'Karangturi, Banaran, Kalijambe', '', 3, 1, 'SRAGEN', '2007-01-18', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1208', 'MUHAMMAD FAJAR KURNIAWAN', 'Pomahan, pulutan, Nogosari', '', 3, 1, 'BOYOLALI', '2007-05-06', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1209', 'OKTA DIKI PRASETYA', 'Kedungwaru, Geneng, Miri', '', 3, 1, 'Sragen', '2006-10-24', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1210', 'RAJIEV GANDHI GIBRAN', 'Rejosari, Donoyudan, Kalijambe', '', 3, 1, 'SRAGEN', '2006-08-29', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1211', 'REZA PUTRA LASMANA MUKTI', 'Butuh, Wonorejo, Kalijambe', '', 3, 1, 'Boyolali', '2007-03-05', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1212', 'RIYAN AJI SAPUTRA', 'Sendangsari, Wonorejo, Kalijambe', '', 3, 1, 'Sragen', '2007-05-04', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1213', 'RIFA PRATAMA RAMADHAN', 'Wonosari, Sambirembe, Kalijambe', '', 3, 1, 'SRAGEN', '2006-10-16', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1214', 'RIO ARIYANTO', 'Grumbuldowo, Sambirembe, Kalijambe', '', 3, 1, 'SURAKARTA', '2009-03-01', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1215', 'SATRIA BAGUS FEBRIYAN', 'Pereng, Pakel, Andong', '', 3, 1, 'Boyolali', '2007-02-01', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1216', 'SHERIL DWI KURNIAWAN', 'Kedungwaru, Geneng, Miri', '', 3, 1, 'Sragen', '2007-03-19', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1217', 'TEGAR DWI ARDIANSYAH', 'Loning, Pulutn ,Nogosari', '', 3, 1, 'BOYOLALI', '2006-06-21', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1218', 'VIUS PAPUNDHOPO', 'Sendangsari, Wonorejo, Kalijambe', '', 3, 1, 'Sragen', '2006-09-08', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1219', 'AISYAH NUR AINI', 'Sanggrahan, Pulutan, Nogosari', '-', 1, 2, 'Boyolali', '2007-11-10', '-', '-', '-', '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1220', 'ASRI JIHAN VEMIGI', 'Ngleri, Keden, Kalijambe', '', 1, 2, 'Sragen', '2006-11-05', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1221', 'ASYIFATUL MUNAWAROH', 'Bendosari, Donoyudan, Kalijambe', '', 1, 2, 'SRAGEN', '2006-10-18', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1222', 'AZZAHRA AISSHAFANI', 'Gumukrejo, Gondangrawe, Andong', '', 1, 2, 'BOYOLALI', '2006-09-11', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1223', 'AZ-ZAHRA OKTA ROMADHONI', 'Ngembat, Beji, Andong', '', 1, 2, 'SURAKARTA', '2006-10-04', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1224', 'DIAH AYU ASHARI', 'Kedungwaru, Wonorejo, Kalijambe', '', 1, 2, 'Sragen', '2007-01-21', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1225', 'FAAT ZUYYIN ERA', 'Kedokan, Klego, Klego', '', 1, 2, 'Boyolali', '2007-07-12', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1226', 'FANESYA AMELIA', 'Pulutan, Pulutan, Nogosari', '', 1, 2, 'BOYOLALI', '2007-02-28', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1227', 'FRISCA DIAN ANGELINA', 'Mencil, Pulutan, Nogosari', '', 1, 2, 'BOYOLALI', '2007-02-09', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1228', 'IQBAL BAGUS SETYADHI', 'Derasan, Sempu, Andong', '', 1, 2, 'BOYOLALI', '2008-05-01', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1229', 'LEOTA PUTRI CESYA ALTA SYAH', 'Bendosari, Donoyudan, Kalijambe', '', 1, 2, 'SRAGEN', '2007-04-01', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1230', 'MIFTAKHUL KHOIRIYAH', 'Rejosari, Donoyudan, Kalijambe', '', 1, 2, 'SRAGEN', '2007-03-25', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1231', 'NABILA FITRIANI', 'Plawar, Saren, Kalijambe', '', 1, 2, 'Jakarta', '2006-11-10', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1232', 'NEFIKA RIA MARETA', 'Beran, Donoyudan, Kalijambe', '', 1, 2, 'Sragen', '2007-03-23', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1233', 'NEYSA AVANDA AFILYANTI', 'Tegalrejo, Donoyudan, Kalijambe', '', 1, 2, 'Sragen', '2007-01-17', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1234', 'RANITA LILI JULITA', 'Randusari, Keden, Kalijambe', '', 1, 2, 'SRAGEN', '2007-07-04', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1235', 'RENDI MAULAN PRATAMA', 'Derasan, Sempu, Andong', '', 1, 2, 'BOYOLALI', '2007-05-18', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1236', 'SABILA FITRIANA', 'Plawar, Saren, Kalijambe', '', 1, 2, 'Jakarta', '2006-11-10', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1237', 'SABILLA ISTIQOMAH', 'Kalangan, Ngembatpadas, Gemolong', '', 1, 2, 'Sragen', '2007-05-05', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1238', 'SELLA SETYANINGSIH', 'Kedungwaru, Wonorejo, Kalijambe', '', 1, 2, 'Sragen', '2006-11-25', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1239', 'LINA FAZA AMELIA', '', '', 2, 1, NULL, NULL, NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1240', 'FELLA ZULFA EKA LESTARI', '', '', 2, 1, NULL, NULL, NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1242', 'AURILIA PUTRI PRAMUDITA', '', '', 1, 2, NULL, NULL, NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('9999', 'Prasetyo Aji Wibowowo', 'Solo', 'lala', 1, 1, 'Solo', '1996-02-29', '081325058258', '', 'prasetyoajiw@gmail.com', '2014', NULL);

-- ----------------------------
-- Table structure for userrole
-- ----------------------------
DROP TABLE IF EXISTS `userrole`;
CREATE TABLE `userrole`  (
  `userid` int(11) NOT NULL,
  `roleid` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`userid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of userrole
-- ----------------------------
INSERT INTO `userrole` VALUES (14, 1);
INSERT INTO `userrole` VALUES (43, 2);
INSERT INTO `userrole` VALUES (45, 4);
INSERT INTO `userrole` VALUES (52, 1);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(75) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nama` varchar(75) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `createdby` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `createdon` datetime(0) NULL DEFAULT NULL,
  `HakAkses` int(255) NULL DEFAULT NULL,
  `token` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `verified` bit(1) NULL DEFAULT NULL,
  `ip` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `browser` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 46 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (14, 'admin', 'admin', 'a9bdd47d7321d4089b3b00561c9c621848bd6f6e2f745a53d54913d613789c23945b66de6ded1eb336a7d526f9349a9d964d6f6c3a40e2ac90b4b16c0121f7895Xg53McbkyQ/NmW60Sf4cu3wJsi/8cyZXxeXV7g6b04=', 'mnl', NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (43, 'operator', 'Operator', 'a9bdd47d7321d4089b3b00561c9c621848bd6f6e2f745a53d54913d613789c23945b66de6ded1eb336a7d526f9349a9d964d6f6c3a40e2ac90b4b16c0121f7895Xg53McbkyQ/NmW60Sf4cu3wJsi/8cyZXxeXV7g6b04=', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (44, 'admin', 'admin', 'a9bdd47d7321d4089b3b00561c9c621848bd6f6e2f745a53d54913d613789c23945b66de6ded1eb336a7d526f9349a9d964d6f6c3a40e2ac90b4b16c0121f7895Xg53McbkyQ/NmW60Sf4cu3wJsi/8cyZXxeXV7g6b04=', 'mnl', NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (45, '9999', 'Prasetyo Aji Wibowowo', 'ed3075dc4c66e529db72d73f6a6e356e4c04015eb77354558be5fce8003c76e2a78757f7404f7a84e775f5f640ccf1260a84355dda6ea0d4a2958b96d977bb93e9tbO6jReRuvyiPyXmm+Im6+T8JPWSdhU6ePGyRdCfg=', 'AUTO', '2023-06-23 15:39:43', NULL, NULL, b'1', NULL, NULL, NULL, NULL);

-- ----------------------------
-- Function structure for fnGetMonthName
-- ----------------------------
DROP FUNCTION IF EXISTS `fnGetMonthName`;
delimiter ;;
CREATE FUNCTION `fnGetMonthName`(`Bulan` int)
 RETURNS varchar(55) CHARSET latin1
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
END
;;
delimiter ;

-- ----------------------------
-- Function structure for f_terbilang
-- ----------------------------
DROP FUNCTION IF EXISTS `f_terbilang`;
delimiter ;;
CREATE FUNCTION `f_terbilang`(angka BIGINT)
 RETURNS text CHARSET latin1
BEGIN
-- @rgiapratama - 2017
    DECLARE v_result TEXT;
    CALL p_terbilang(angka, v_result);
    RETURN REPLACE(v_result,'  ',' ');
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for p_terbilang
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_terbilang`;
delimiter ;;
CREATE PROCEDURE `p_terbilang`(IN angka bigint, OUT retval TEXT)
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
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for vsp_show_buku_kas
-- ----------------------------
DROP PROCEDURE IF EXISTS `vsp_show_buku_kas`;
delimiter ;;
CREATE PROCEDURE `vsp_show_buku_kas`(IN `TglAwal` date,IN `TglAkhir` date)
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
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table pembayarandetail
-- ----------------------------
DROP TRIGGER IF EXISTS `trg_AddBukuKas`;
delimiter ;;
CREATE TRIGGER `trg_AddBukuKas` AFTER INSERT ON `pembayarandetail` FOR EACH ROW BEGIN
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
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table tsiswa
-- ----------------------------
DROP TRIGGER IF EXISTS `trgAddUser`;
delimiter ;;
CREATE TRIGGER `trgAddUser` AFTER INSERT ON `tsiswa` FOR EACH ROW BEGIN
	INSERT into users(username, nama, `password`, CreatedBy, CreatedOn,verified)
	VALUE
	(NEW.NIS,NEW.NamaSiswa,SHA1(NEW.NIS),'AUTO',NOW(),0);
	INSERT into userrole
	SELECT id, 4 FROM users where username = NEW.NIS;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
