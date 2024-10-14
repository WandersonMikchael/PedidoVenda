CREATE DATABASE  IF NOT EXISTS `wkpedidovenda` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `wkpedidovenda`;
-- MySQL dump 10.13  Distrib 5.6.23, for Win64 (x86_64)
--
-- Host: localhost    Database: wkpedidovenda
-- ------------------------------------------------------
-- Server version	5.6.24-log

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
-- Table structure for table `itenspedido`
--

DROP TABLE IF EXISTS `itenspedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `itenspedido` (
  `Autoincrem` int(11) NOT NULL AUTO_INCREMENT,
  `NumeroPedido` int(11) DEFAULT NULL,
  `CodigoProduto` int(11) DEFAULT NULL,
  `Quantidade` int(11) DEFAULT NULL,
  `ValorUnitario` decimal(10,2) DEFAULT NULL,
  `ValorTotal` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`Autoincrem`),
  KEY `NumeroPedido` (`NumeroPedido`),
  KEY `CodigoProduto` (`CodigoProduto`),
  CONSTRAINT `itenspedido_ibfk_1` FOREIGN KEY (`NumeroPedido`) REFERENCES `pedidos` (`NumeroPedido`),
  CONSTRAINT `itenspedido_ibfk_2` FOREIGN KEY (`CodigoProduto`) REFERENCES `produtos` (`Codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `itenspedido`
--

LOCK TABLES `itenspedido` WRITE;
/*!40000 ALTER TABLE `itenspedido` DISABLE KEYS */;
INSERT INTO `itenspedido` VALUES (9,4,15,2,150.00,300.00),(10,4,3,2,30.00,60.00),(11,4,2,2,20.00,40.00),(12,4,15,81,150.00,12150.00),(13,4,1,2,15.00,30.00),(14,4,3,2,30.00,60.00),(15,4,1,14,10.00,140.00),(16,5,16,6,160.00,960.00),(17,6,16,6,160.00,960.00),(18,7,5,1,50.00,50.00),(19,7,6,85,60.00,5100.00),(20,8,16,6,160.00,960.00),(21,11,5,6,50.00,280.00);
/*!40000 ALTER TABLE `itenspedido` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-14 10:50:40
