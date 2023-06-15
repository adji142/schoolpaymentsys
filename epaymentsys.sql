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

 Date: 15/06/2023 22:51:26
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

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
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

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
INSERT INTO `permission` VALUES (13, 'Pembayaran Siswa', '', ' ', '11', b'0', b'0', 13, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (14, 'Keuangan', '', ' ', '11', b'0', b'1', 14, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (15, 'Serah Terima Uang', '', '', '11', b'0', b'0', 15, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (16, 'Laporan', '', 'fa-file', '0', b'1', b'0', 16, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (17, 'Laporan Pembayaran Siswa', '', '', '16', b'1', b'0', 17, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (18, 'Laporan Keuangan', '', '', '16', b'1', b'0', 18, b'1', NULL, NULL, NULL);

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

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rolename` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES (1, 'Admin');

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
INSERT INTO `tagihanheader` VALUES ('2023060000100', '2023-06-15', '2023-06-15 05:50:03', '2023-07-01', '2023-07-08', '2022-2023', '1', '123', '', NULL, NULL);
INSERT INTO `tagihanheader` VALUES ('2023060000101', '2023-06-15', '2023-06-15 05:50:03', '2023-07-01', '2023-07-08', '2022-2023', '2', '456', '', NULL, NULL);
INSERT INTO `tagihanheader` VALUES ('2023060000110', '2023-06-15', '2023-06-15 05:50:03', '2023-08-01', '2023-08-08', '2022-2023', '1', '123', '', NULL, NULL);
INSERT INTO `tagihanheader` VALUES ('20230600001100', '2023-06-15', '2023-06-15 05:50:03', '2024-05-01', '2024-05-08', '2022-2023', '1', '123', '', NULL, NULL);
INSERT INTO `tagihanheader` VALUES ('20230600001101', '2023-06-15', '2023-06-15 05:50:03', '2024-05-01', '2024-05-08', '2022-2023', '2', '456', '', NULL, NULL);
INSERT INTO `tagihanheader` VALUES ('2023060000111', '2023-06-15', '2023-06-15 05:50:03', '2023-08-01', '2023-08-08', '2022-2023', '2', '456', '', NULL, NULL);
INSERT INTO `tagihanheader` VALUES ('20230600001110', '2023-06-15', '2023-06-15 05:50:03', '2024-06-01', '2024-06-08', '2022-2023', '1', '123', '', NULL, NULL);
INSERT INTO `tagihanheader` VALUES ('20230600001111', '2023-06-15', '2023-06-15 05:50:03', '2024-06-01', '2024-06-08', '2022-2023', '2', '456', '', NULL, NULL);
INSERT INTO `tagihanheader` VALUES ('2023060000120', '2023-06-15', '2023-06-15 05:50:03', '2023-09-01', '2023-09-08', '2022-2023', '1', '123', '', NULL, NULL);
INSERT INTO `tagihanheader` VALUES ('2023060000121', '2023-06-15', '2023-06-15 05:50:03', '2023-09-01', '2023-09-08', '2022-2023', '2', '456', '', NULL, NULL);
INSERT INTO `tagihanheader` VALUES ('2023060000130', '2023-06-15', '2023-06-15 05:50:03', '2023-10-01', '2023-10-08', '2022-2023', '1', '123', '', NULL, NULL);
INSERT INTO `tagihanheader` VALUES ('2023060000131', '2023-06-15', '2023-06-15 05:50:03', '2023-10-01', '2023-10-08', '2022-2023', '2', '456', '', NULL, NULL);
INSERT INTO `tagihanheader` VALUES ('2023060000140', '2023-06-15', '2023-06-15 05:50:03', '2023-11-01', '2023-11-08', '2022-2023', '1', '123', '', NULL, NULL);
INSERT INTO `tagihanheader` VALUES ('2023060000141', '2023-06-15', '2023-06-15 05:50:03', '2023-11-01', '2023-11-08', '2022-2023', '2', '456', '', NULL, NULL);
INSERT INTO `tagihanheader` VALUES ('2023060000150', '2023-06-15', '2023-06-15 05:50:03', '2023-12-01', '2023-12-08', '2022-2023', '1', '123', '', NULL, NULL);
INSERT INTO `tagihanheader` VALUES ('2023060000151', '2023-06-15', '2023-06-15 05:50:03', '2023-12-01', '2023-12-08', '2022-2023', '2', '456', '', NULL, NULL);
INSERT INTO `tagihanheader` VALUES ('2023060000160', '2023-06-15', '2023-06-15 05:50:03', '2024-01-01', '2024-01-08', '2022-2023', '1', '123', '', NULL, NULL);
INSERT INTO `tagihanheader` VALUES ('2023060000161', '2023-06-15', '2023-06-15 05:50:03', '2024-01-01', '2024-01-08', '2022-2023', '2', '456', '', NULL, NULL);
INSERT INTO `tagihanheader` VALUES ('2023060000170', '2023-06-15', '2023-06-15 05:50:03', '2024-02-01', '2024-02-08', '2022-2023', '1', '123', '', NULL, NULL);
INSERT INTO `tagihanheader` VALUES ('2023060000171', '2023-06-15', '2023-06-15 05:50:03', '2024-02-01', '2024-02-08', '2022-2023', '2', '456', '', NULL, NULL);
INSERT INTO `tagihanheader` VALUES ('2023060000180', '2023-06-15', '2023-06-15 05:50:03', '2024-03-01', '2024-03-08', '2022-2023', '1', '123', '', NULL, NULL);
INSERT INTO `tagihanheader` VALUES ('2023060000181', '2023-06-15', '2023-06-15 05:50:03', '2024-03-01', '2024-03-08', '2022-2023', '2', '456', '', NULL, NULL);
INSERT INTO `tagihanheader` VALUES ('2023060000190', '2023-06-15', '2023-06-15 05:50:03', '2024-04-01', '2024-04-08', '2022-2023', '1', '123', '', NULL, NULL);
INSERT INTO `tagihanheader` VALUES ('2023060000191', '2023-06-15', '2023-06-15 05:50:03', '2024-04-01', '2024-04-08', '2022-2023', '2', '456', '', NULL, NULL);

-- ----------------------------
-- Table structure for tjenistagihan
-- ----------------------------
DROP TABLE IF EXISTS `tjenistagihan`;
CREATE TABLE `tjenistagihan`  (
  `KodeTagihan` int(11) NOT NULL AUTO_INCREMENT,
  `NamaTagihan` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `KodePosKeuangan` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`KodeTagihan`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tjenistagihan
-- ----------------------------

-- ----------------------------
-- Table structure for tjurusan
-- ----------------------------
DROP TABLE IF EXISTS `tjurusan`;
CREATE TABLE `tjurusan`  (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `NamaJurusan` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tjurusan
-- ----------------------------
INSERT INTO `tjurusan` VALUES (2, 'Teknik Komputer dan Jaringan');
INSERT INTO `tjurusan` VALUES (3, 'Mesin');

-- ----------------------------
-- Table structure for tkelas
-- ----------------------------
DROP TABLE IF EXISTS `tkelas`;
CREATE TABLE `tkelas`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `NamaKelas` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tkelas
-- ----------------------------
INSERT INTO `tkelas` VALUES (1, 'Kelas 1');
INSERT INTO `tkelas` VALUES (3, 'Kelas 2');
INSERT INTO `tkelas` VALUES (4, 'Kelas 3');

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
  PRIMARY KEY (`NIS`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tsiswa
-- ----------------------------

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
) ENGINE = InnoDB AUTO_INCREMENT = 45 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (14, 'admin', 'admin', 'a9bdd47d7321d4089b3b00561c9c621848bd6f6e2f745a53d54913d613789c23945b66de6ded1eb336a7d526f9349a9d964d6f6c3a40e2ac90b4b16c0121f7895Xg53McbkyQ/NmW60Sf4cu3wJsi/8cyZXxeXV7g6b04=', 'mnl', NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (43, 'operator', 'Operator', 'a9bdd47d7321d4089b3b00561c9c621848bd6f6e2f745a53d54913d613789c23945b66de6ded1eb336a7d526f9349a9d964d6f6c3a40e2ac90b4b16c0121f7895Xg53McbkyQ/NmW60Sf4cu3wJsi/8cyZXxeXV7g6b04=', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (44, 'admin', 'admin', 'a9bdd47d7321d4089b3b00561c9c621848bd6f6e2f745a53d54913d613789c23945b66de6ded1eb336a7d526f9349a9d964d6f6c3a40e2ac90b4b16c0121f7895Xg53McbkyQ/NmW60Sf4cu3wJsi/8cyZXxeXV7g6b04=', 'mnl', NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL);

SET FOREIGN_KEY_CHECKS = 1;
