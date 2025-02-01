-- MySQL dump 10.13  Distrib 8.4.0, for Win64 (x86_64)
--
-- Host: localhost    Database: sistema
-- ------------------------------------------------------
-- Server version	8.4.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `cidade` varchar(100) DEFAULT NULL,
  `uf` char(2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'MIGUEL SILVA','PALMAS','TO'),(2,'ARTHUR SANTOS','PALMAS','TO'),(3,'GAEL RODRIGUES','PALMAS','TO'),(4,'THEO JESUS','PALMAS','TO'),(5,'HEITOR GOMES','PALMAS','TO'),(6,'RAVI OLIVEIRA','PALMAS','TO'),(7,'DAVI PEREIRA','PALMAS','TO'),(8,'BERNARDO FERREIRA','PALMAS','TO'),(9,'NOAH SOUZA','PALMAS','TO'),(10,'GABRIEL COSTA','PALMAS','TO'),(11,'SAMUEL DA SILVA','PALMAS','TO'),(12,'PEDRO DE JESUS','PALMAS','TO'),(13,'ANTHONY ROSA','PALMAS','TO'),(14,'ISAAC FERNANDES','PALMAS','TO'),(15,'BENICIO LIMA','PALMAS','TO'),(16,'BENJAMIN ALVES','PALMAS','TO'),(17,'MATHEUS ROCHA','PALMAS','TO'),(18,'LUCAS ANDRADE','PALMAS','TO'),(19,'JOAQUIM NUNES','PALMAS','TO'),(20,'NICOLAS CONCEICAO','PALMAS','TO'),(21,'LUCCA PINTO','PALMAS','TO'),(22,'LORENZO ALMEIDA','PALMAS','TO'),(23,'HENRIQUE CONCEICAO','PALMAS','TO'),(24,'JOAO MIGUEL MARTINS','PALMAS','TO'),(25,'RAFAEL MOTA','PALMAS','TO'),(26,'HENRY DOS SANTOS','PALMAS','TO'),(27,'MURILO FEITOSA','PALMAS','TO'),(28,'LEVI PAIXAO','PALMAS','TO');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produtos`
--

DROP TABLE IF EXISTS `produtos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produtos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(255) NOT NULL,
  `vlr_venda` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produtos`
--

LOCK TABLES `produtos` WRITE;
/*!40000 ALTER TABLE `produtos` DISABLE KEYS */;
INSERT INTO `produtos` VALUES (1,'ARROZ TIO JOAO TIPO 1 5KG',31.99),(2,'FEIJAO CARIOCA CAMIL 1KG',6.50),(3,'ACUCAR UNIAO REFINADO 1KG',3.50),(4,'SAL REFINADO CISNE 1KG',2.50),(5,'OLEO DE SOJA LIZA 900ML',9.79),(6,'MACARRAO NISSIN LAMEN 5 UND',4.50),(7,'LEITE INTEGRAL PARMALAT 1L',7.89),(8,'QUEIJO MUSSARELA ITAMBE 400G',12.99),(9,'MANTEIGA AVIACAO 200G',7.99),(10,'PASTA DE DENTE COLGATE TOTAL 12 90G',5.99),(11,'CARNE BOVINA FRIBOI ALCATRA 1KG',39.99),(12,'FRANGO CONGELADO SEARA 1KG',10.99),(13,'PEIXE SARDINHA PESCADA BRANCA 1KG',15.99),(14,'BANANA PRATA 1KG',4.99),(15,'MACA GALA 1KG',7.99),(16,'LARANJA PERA 1KG',5.99),(17,'PAO FORMA PULLMAN PCT',5.99),(18,'MOLHO DE TOMATE ELEFANTE 340G',3.99),(19,'MAIONESE HELLMANNS 500G',8.99),(20,'REFRIGERANTE COCA COLA 2L',7.99),(21,'CERVEJA SKOL LATA 350ML',2.50),(22,'SORVETE KIBON KIT KAT 1L',14.16),(23,'CHOCOLATE LACTA LATA 150G',6.99),(24,'SHAMPOO SEDA 350ML',8.54),(25,'SABONETE DOVE 90G',2.57),(26,'DETERGENTE YPE 500ML',2.99),(27,'PAPEL HIGIENICO NEVE PACK COM 4 UND',8.20),(28,'DESINFETANTE PINHO SOL 500ML',3.50);
/*!40000 ALTER TABLE `produtos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `venda`
--

DROP TABLE IF EXISTS `venda`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `venda` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_cliente` int DEFAULT NULL,
  `nome_cliente` varchar(255) NOT NULL,
  `data` timestamp NOT NULL,
  `vlr_total` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_id_cliente` (`id_cliente`),
  CONSTRAINT `venda_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `venda`
--

LOCK TABLES `venda` WRITE;
/*!40000 ALTER TABLE `venda` DISABLE KEYS */;
/*!40000 ALTER TABLE `venda` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `venda_item`
--

DROP TABLE IF EXISTS `venda_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `venda_item` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_venda` int DEFAULT NULL,
  `id_produto` int DEFAULT NULL,
  `descricao_produto` varchar(255) NOT NULL,
  `qtde` decimal(10,2) NOT NULL,
  `vlr_unitario` decimal(10,2) NOT NULL,
  `vlr_total` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_id_venda_item` (`id_venda`),
  KEY `idx_id_produto` (`id_produto`),
  CONSTRAINT `venda_item_ibfk_1` FOREIGN KEY (`id_venda`) REFERENCES `venda` (`id`),
  CONSTRAINT `venda_item_ibfk_2` FOREIGN KEY (`id_produto`) REFERENCES `produtos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `venda_item`
--

LOCK TABLES `venda_item` WRITE;
/*!40000 ALTER TABLE `venda_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `venda_item` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-02-01  1:33:16
