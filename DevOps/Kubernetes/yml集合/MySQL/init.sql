CREATE database `dbname`;

DROP TABLE IF EXISTS `dbname`.`demo`;
CREATE TABLE `dbname`.`demo` (
                                 `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
                                 `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '账号',
                                 `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '密码',
                                 `creater` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'admin' COMMENT '创建人',
                                 `updater` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'admin' COMMENT '更新人',
                                 `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                 `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                 PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

TRUNCATE `dbname`.`demo`;

INSERT INTO `dbname`.`demo` (`id`, `username`, `password`, `creater`, `updater`, `create_time`, `update_time`) VALUES (1, '用户1', '00001', 'admin', 'admin', '2023-09-03 04:07:12', '2023-09-03 04:07:12');
INSERT INTO `dbname`.`demo` (`id`, `username`, `password`, `creater`, `updater`, `create_time`, `update_time`) VALUES (2, '用户2', '00002', 'admin', 'admin', '2023-09-03 04:07:12', '2023-09-03 04:07:12');
INSERT INTO `dbname`.`demo` (`id`, `username`, `password`, `creater`, `updater`, `create_time`, `update_time`) VALUES (3, '用户3', '00003', 'admin', 'admin', '2023-09-03 04:07:12', '2023-09-03 04:07:12');
INSERT INTO `dbname`.`demo` (`id`, `username`, `password`, `creater`, `updater`, `create_time`, `update_time`) VALUES (4, '用户4', '00004', 'admin', 'admin', '2023-09-03 04:07:12', '2023-09-03 04:07:12');
INSERT INTO `dbname`.`demo` (`id`, `username`, `password`, `creater`, `updater`, `create_time`, `update_time`) VALUES (5, '用户5', '00005', 'admin', 'admin', '2023-09-03 04:07:12', '2023-09-03 04:07:12');
INSERT INTO `dbname`.`demo` (`id`, `username`, `password`, `creater`, `updater`, `create_time`, `update_time`) VALUES (6, '用户6', '00006', 'admin', 'admin', '2023-09-03 04:07:12', '2023-09-03 04:07:12');
INSERT INTO `dbname`.`demo` (`id`, `username`, `password`, `creater`, `updater`, `create_time`, `update_time`) VALUES (7, '用户7', '00007', 'admin', 'admin', '2023-09-03 04:07:12', '2023-09-03 04:07:12');
INSERT INTO `dbname`.`demo` (`id`, `username`, `password`, `creater`, `updater`, `create_time`, `update_time`) VALUES (8, '用户8', '00008', 'admin', 'admin', '2023-09-03 04:07:12', '2023-09-03 04:07:12');
INSERT INTO `dbname`.`demo` (`id`, `username`, `password`, `creater`, `updater`, `create_time`, `update_time`) VALUES (9, '用户9', '00009', 'admin', 'admin', '2023-09-03 04:07:12', '2023-09-03 04:07:12');
INSERT INTO `dbname`.`demo` (`id`, `username`, `password`, `creater`, `updater`, `create_time`, `update_time`) VALUES (10, '用户10', '000010', 'admin', 'admin', '2023-09-03 04:07:12', '2023-09-03 04:07:12');
INSERT INTO `dbname`.`demo` (`id`, `username`, `password`, `creater`, `updater`, `create_time`, `update_time`) VALUES (11, '用户11', '000011', 'admin', 'admin', '2023-09-03 04:07:12', '2023-09-03 04:07:12');
INSERT INTO `dbname`.`demo` (`id`, `username`, `password`, `creater`, `updater`, `create_time`, `update_time`) VALUES (12, '用户12', '000012', 'admin', 'admin', '2023-09-03 04:07:12', '2023-09-03 04:07:12');
INSERT INTO `dbname`.`demo` (`id`, `username`, `password`, `creater`, `updater`, `create_time`, `update_time`) VALUES (13, '用户13', '000013', 'admin', 'admin', '2023-09-03 04:07:12', '2023-09-03 04:07:12');
INSERT INTO `dbname`.`demo` (`id`, `username`, `password`, `creater`, `updater`, `create_time`, `update_time`) VALUES (14, '用户14', '000014', 'admin', 'admin', '2023-09-03 04:07:12', '2023-09-03 04:07:12');
INSERT INTO `dbname`.`demo` (`id`, `username`, `password`, `creater`, `updater`, `create_time`, `update_time`) VALUES (15, '用户15', '000015', 'admin', 'admin', '2023-09-03 04:07:12', '2023-09-03 04:07:12');
INSERT INTO `dbname`.`demo` (`id`, `username`, `password`, `creater`, `updater`, `create_time`, `update_time`) VALUES (16, '用户16', '000016', 'admin', 'admin', '2023-09-03 04:07:12', '2023-09-03 04:07:12');
INSERT INTO `dbname`.`demo` (`id`, `username`, `password`, `creater`, `updater`, `create_time`, `update_time`) VALUES (17, '用户17', '000017', 'admin', 'admin', '2023-09-03 04:07:12', '2023-09-03 04:07:12');
INSERT INTO `dbname`.`demo` (`id`, `username`, `password`, `creater`, `updater`, `create_time`, `update_time`) VALUES (18, '用户18', '000018', 'admin', 'admin', '2023-09-03 04:07:12', '2023-09-03 04:07:12');
INSERT INTO `dbname`.`demo` (`id`, `username`, `password`, `creater`, `updater`, `create_time`, `update_time`) VALUES (19, '用户19', '000019', 'admin', 'admin', '2023-09-03 04:07:12', '2023-09-03 04:07:12');
INSERT INTO `dbname`.`demo` (`id`, `username`, `password`, `creater`, `updater`, `create_time`, `update_time`) VALUES (20, '用户20', '000020', 'admin', 'admin', '2023-09-03 04:07:12', '2023-09-03 04:07:12');