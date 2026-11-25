# Creating Database
CREATE DATABASE Mercado;

USE Mercado;

# Creating Tables
DROP TABLE IF EXISTS `cliente`;

CREATE TABLE `cliente` (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) DEFAULT NULL,
  `telefone` decimal(15,0) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
);

LOCK TABLES `cliente` WRITE;

INSERT INTO `cliente` VALUES (1,'DANIEL ',123),(2,'JOSE',321),(3,'JOAO',222),(4,'CILENE',333),(5,'JESSICA',1122),(6,'MARCELO',NULL),(7,'ANA',NULL),(8,'MARIANA',NULL),(9,'DANIELA',NULL),(10,'SILVANA',NULL);

UNLOCK TABLES;

DROP TABLE IF EXISTS `grupo`;

CREATE TABLE `grupo` (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
);

LOCK TABLES `grupo` WRITE;

INSERT INTO `grupo` VALUES (1,'ACOUGUE'),(2,'PADARIA'),(3,'BEBIBAS'),(4,'HIGIENE'),(5,'HORTIFRUTI');

UNLOCK TABLES;

DROP TABLE IF EXISTS `pedido`;

CREATE TABLE `pedido` (
  `numero_pedido` int NOT NULL AUTO_INCREMENT,
  `data_emissao` date DEFAULT NULL,
  `hora_emissao` time DEFAULT NULL,
  `codigo_cliente` int DEFAULT NULL,
  PRIMARY KEY (`numero_pedido`),
  KEY `codigo_cliente` (`codigo_cliente`),
  CONSTRAINT `pedido_ibfk_1` FOREIGN KEY (`codigo_cliente`) REFERENCES `cliente` (`codigo`)
);

LOCK TABLES `pedido` WRITE;

INSERT INTO `pedido` VALUES (1,'2019-01-01','09:01:00',1),(2,'2019-01-02','09:11:00',3),(3,'2019-01-02','09:21:00',7),(4,'2019-01-06','10:11:00',2),(5,'2019-01-07','10:01:00',6),(6,'2019-01-07','12:01:00',4),(7,'2019-01-12','13:01:00',5),(8,'2019-01-16','14:01:00',1),(9,'2019-02-01','09:01:00',3),(10,'2019-02-02','09:11:00',1),(11,'2019-03-02','09:21:00',8),(12,'2019-03-06','10:11:00',7),(13,'2019-04-07','10:01:00',6),(14,'2019-04-07','12:01:00',5),(15,'2019-04-12','13:01:00',4),(16,'2019-06-16','14:01:00',2);

UNLOCK TABLES;

DROP TABLE IF EXISTS `pedido_item`;

CREATE TABLE `pedido_item` (
  `id_item` int NOT NULL AUTO_INCREMENT,
  `nro_pedido` int NOT NULL,
  `codigo_produto` int DEFAULT NULL,
  `quantidade` decimal(10,3) DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `cancelado` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`id_item`,`nro_pedido`),
  KEY `pedido_item_ibfk_1` (`nro_pedido`),
  CONSTRAINT `pedido_item_ibfk_1` FOREIGN KEY (`nro_pedido`) REFERENCES `pedido` (`numero_pedido`)
);

LOCK TABLES `pedido_item` WRITE;

INSERT INTO `pedido_item` VALUES (1,1,3,2.000,11.60,'N'),(2,1,4,1.000,3.90,'N'),(3,1,7,1.000,58.00,'N'),(4,2,4,1.000,3.90,'N'),(5,2,7,2.000,116.00,'N'),(6,2,3,3.000,17.40,'N'),(7,2,1,1.000,3.20,'N'),(8,3,4,1.000,3.90,'N'),(9,3,7,2.000,116.00,'N'),(10,4,3,3.000,17.40,'N'),(11,4,1,1.000,3.20,'N'),(12,5,2,1.000,38.00,'N'),(13,5,1,2.000,6.40,'N'),(14,6,2,3.000,114.00,'N'),(15,7,1,1.000,3.20,'N'),(16,8,2,1.000,38.00,'N'),(17,9,4,2.000,7.80,'N'),(18,9,8,3.000,39.00,'N'),(19,9,7,2.000,116.00,'N'),(20,10,2,1.000,38.00,'N'),(21,10,4,2.000,7.80,'N'),(22,11,8,3.000,39.00,'N'),(23,12,7,2.000,116.00,'N'),(24,13,2,1.000,38.00,'N'),(25,14,4,2.000,7.80,'N'),(26,15,8,3.000,39.00,'N'),(27,16,7,2.000,116.00,'N');

UNLOCK TABLES;

DROP TABLE IF EXISTS `pedido_pagamento`;

CREATE TABLE `pedido_pagamento` (
  `id_pgto` int NOT NULL AUTO_INCREMENT,
  `nro_pedido` int NOT NULL,
  `Tipo` varchar(10) DEFAULT NULL,
  `Recebido` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id_pgto`,`nro_pedido`),
  KEY `pedido_pagamento_ibfk_1` (`nro_pedido`),
  CONSTRAINT `pedido_pagamento_ibfk_1` FOREIGN KEY (`nro_pedido`) REFERENCES `pedido` (`numero_pedido`)
);

LOCK TABLES `pedido_pagamento` WRITE;

INSERT INTO `pedido_pagamento` VALUES (1,1,'DINHEIRO',73.50),(2,2,'DINHEIRO',140.50),(3,3,'CHEQUE',119.90),(4,4,'CREDITO',10.30),(5,4,'DEBITO',10.30),(6,5,'DEBITO',44.40),(7,6,'CHEQUE',114.00),(8,7,'DINHEIRO',3.20),(9,8,'CREDITO',38.00),(10,9,'DEBITO',162.80),(11,10,'DINHEIRO',45.80),(12,11,'DEBITO',39.00),(13,12,'CREDITO',116.00),(14,13,'CREDIARIO',38.00),(15,14,'DEBITO',7.80),(16,15,'CREDIARIO',39.00),(17,16,'DEBITO',116.00);

UNLOCK TABLES;

DROP TABLE IF EXISTS `produto`;

CREATE TABLE `produto` (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(45) DEFAULT NULL,
  `custo` decimal(9,2) DEFAULT NULL,
  `estoque_atual` decimal(9,3) DEFAULT NULL,
  `cod_grupo` int DEFAULT NULL,
  PRIMARY KEY (`codigo`),
  KEY `fk_produto_1_idx` (`cod_grupo`),
  CONSTRAINT `fk_produto_1` FOREIGN KEY (`cod_grupo`) REFERENCES `grupo` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

LOCK TABLES `produto` WRITE;

INSERT INTO `produto` VALUES (1,'PAO',3.20,2.000,2),(2,'PICANHA',38.00,0.000,1),(3,'CERVEJA',5.80,0.000,3),(4,'REFRIGERANTE',3.90,2.000,3),(5,'COSTELA',13.00,0.000,1),(6,'LASANHA CONGELADA',16.00,0.000,NULL),(7,'BACALHAU',58.00,0.000,NULL),(8,'DESODORANTE',13.00,0.000,4),(9,'BOLO DE FUBA',5.00,0.000,2);

UNLOCK TABLES;
