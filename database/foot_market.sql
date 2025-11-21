-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Nov 21, 2025 at 02:34 PM
-- Server version: 8.3.0
-- PHP Version: 8.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `foot_market`
--

-- --------------------------------------------------------

--
-- Table structure for table `clubs`
--

DROP TABLE IF EXISTS `clubs`;
CREATE TABLE IF NOT EXISTS `clubs` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `country` varchar(50) DEFAULT NULL,
  `founded_year` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `clubs`
--

INSERT INTO `clubs` (`id`, `name`, `country`, `founded_year`) VALUES
(1, 'FC Barcelona', 'Spain', 1899),
(2, 'FK Crvena Zvezda', 'Serbia', 1945),
(3, 'Wolverhampton Wanderers FC', 'England', 1877),
(9, 'Slobodan Igrac', 'Internacionalno', 2000),
(10, 'Penzionisan', 'Internacionalno', 2000);

-- --------------------------------------------------------

--
-- Table structure for table `favorite_players`
--

DROP TABLE IF EXISTS `favorite_players`;
CREATE TABLE IF NOT EXISTS `favorite_players` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `player_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `player_id` (`player_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `favorite_players`
--

INSERT INTO `favorite_players` (`id`, `user_id`, `player_id`) VALUES
(2, 8, 32),
(12, 11, 13),
(14, 12, 12);

-- --------------------------------------------------------

--
-- Table structure for table `players`
--

DROP TABLE IF EXISTS `players`;
CREATE TABLE IF NOT EXISTS `players` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `position` enum('GK','DF','MF','FW') NOT NULL,
  `age` int DEFAULT NULL,
  `market_value` decimal(15,2) DEFAULT NULL,
  `club_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `club_id` (`club_id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `players`
--

INSERT INTO `players` (`id`, `name`, `position`, `age`, `market_value`, `club_id`) VALUES
(11, 'Joan García', 'GK', 23, 5000000.00, 1),
(12, 'Lamine Yamal', 'FW', 17, 200000000.00, 3),
(13, 'Dani Olmo', 'MF', 27, 40000000.00, 1),
(14, 'Ferran Torres', 'FW', 24, 40000000.00, 1),
(15, 'Robert Lewandowski', 'FW', 36, 20000000.00, 1),
(16, 'Omri Glazer', 'GK', 18, 4000000.00, 2),
(17, 'Rodrigão', 'DF', 29, 3000000.00, 2),
(18, 'Miloš Veljković', 'DF', 29, 3000000.00, 2),
(19, 'Milson', 'FW', 26, 6000000.00, 2),
(20, 'Egor Prutsev', 'MF', 22, 1500000.00, 3),
(21, 'José Sá', 'GK', 32, 7000000.00, 3),
(22, 'Hee-chan Hwang', 'FW', 29, 12000000.00, 3),
(23, 'Santiago Bueno', 'DF', 26, 10000000.00, 3),
(24, 'David Møller Wolfe', 'DF', 23, 9000000.00, 3),
(25, 'Jackson Tchatchoua', 'DF', 23, 8000000.00, 3),
(32, 'Andrija Tepavac', 'FW', 21, 500000.00, 2),
(33, 'Andres Iniesta', 'MF', 40, 1.00, 10),
(34, 'Darko Lazović', 'MF', 35, 500000.00, 9);

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
CREATE TABLE IF NOT EXISTS `roles` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`) VALUES
(1, 'ADMIN'),
(2, 'MANAGER');

-- --------------------------------------------------------

--
-- Table structure for table `transfers`
--

DROP TABLE IF EXISTS `transfers`;
CREATE TABLE IF NOT EXISTS `transfers` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `player_id` bigint NOT NULL,
  `from_club_id` bigint DEFAULT NULL,
  `to_club_id` bigint DEFAULT NULL,
  `transfer_fee` decimal(15,2) DEFAULT NULL,
  `transfer_date` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `player_id` (`player_id`),
  KEY `from_club_id` (`from_club_id`),
  KEY `to_club_id` (`to_club_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `transfers`
--

INSERT INTO `transfers` (`id`, `player_id`, `from_club_id`, `to_club_id`, `transfer_fee`, `transfer_date`) VALUES
(1, 12, 1, 3, 50000000.00, '2025-10-25'),
(3, 32, 9, 2, 5000.00, '2017-10-19'),
(4, 20, 2, 1, 100000000.00, '2025-10-22'),
(7, 20, 1, 3, 2500000.00, '2025-11-19');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  KEY `fk_user_role` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `role_id`) VALUES
(6, 'manager1', 'manager1@gmail.com', '$2a$10$XwgqiwHA3YGeiiZnzinC/.28UmJA1XXM/BJdMLY4MVMJsTqhE/.hS', 2),
(7, 'kavinter', 'ilijaerak@gmail.com', '$2a$10$SzzWvyN6oqDSynkRy8dLqeRGzdo8Qh.xnJ7YtjDXYWuUUiweNwaUq', 1),
(8, 'manager2', 'manager2@gmail.com', '$2a$10$8LpEZTDe/8wMAuz34EfTW.HdIjfsZMZSiGVyWFivZoa3iEO1.gQBy', 2),
(9, 'kavinter1', 'ilijaerak11@gmail.com', '$2a$10$gv7bWKDxPDfQ3oCBCSVeGe3Kv4YbTPJjPopqQypZ4AzC5wFf.t83u', 1),
(10, 'kavinter123', 'kavinter123@gmail.com', '$2a$10$vaABD0fK1Q87WczBVtS6E.UZjzHM4gvj0yokXt3pGYs/uh0lTEE5u', 1),
(11, 'erakmanager', 'managererak@gmail.com', '$2a$10$uXYAaid1o8Ocmz0kSFHIw.agHrXkiBDFwcfQdjiRvt0/9oDqOHf6G', 2),
(12, 'ilija123', 'ilija123@gmail.com', '$2a$10$s/8gaSRnfhl0xng/Afn5F.xZoXLeKZ5ZmeFEavn0hm6hXRNoOgbse', 2);

-- --------------------------------------------------------

--
-- Table structure for table `watchlist`
--

DROP TABLE IF EXISTS `watchlist`;
CREATE TABLE IF NOT EXISTS `watchlist` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `player_id` bigint DEFAULT NULL,
  `club_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `player_id` (`player_id`),
  KEY `club_id` (`club_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `watchlist`
--

INSERT INTO `watchlist` (`id`, `user_id`, `player_id`, `club_id`) VALUES
(3, 6, 13, 1),
(6, 8, 24, 3),
(7, 8, 20, 1),
(8, 11, 11, 1),
(9, 11, 13, 1),
(10, 11, 12, 3),
(11, 11, 14, 1),
(12, 12, 11, 1),
(13, 12, 12, 3);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `favorite_players`
--
ALTER TABLE `favorite_players`
  ADD CONSTRAINT `favorite_players_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `favorite_players_ibfk_2` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `players`
--
ALTER TABLE `players`
  ADD CONSTRAINT `players_ibfk_1` FOREIGN KEY (`club_id`) REFERENCES `clubs` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `transfers`
--
ALTER TABLE `transfers`
  ADD CONSTRAINT `transfers_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `transfers_ibfk_2` FOREIGN KEY (`from_club_id`) REFERENCES `clubs` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `transfers_ibfk_3` FOREIGN KEY (`to_club_id`) REFERENCES `clubs` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `fk_user_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `watchlist`
--
ALTER TABLE `watchlist`
  ADD CONSTRAINT `watchlist_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `watchlist_ibfk_2` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `watchlist_ibfk_3` FOREIGN KEY (`club_id`) REFERENCES `clubs` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
