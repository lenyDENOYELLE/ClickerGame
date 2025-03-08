-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Feb 17, 2025 at 11:28 PM
-- Server version: 8.0.41-0ubuntu0.22.04.1
-- PHP Version: 8.1.2-1ubuntu2.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `test`
--

-- --------------------------------------------------------

--
-- Table structure for table `buy`
--

CREATE TABLE `buy` (
  `id_player` int NOT NULL,
  `id_enhancement` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `buy`
--

INSERT INTO `buy` (`id_player`, `id_enhancement`) VALUES
(1, 1),
(2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `Enemy`
--

CREATE TABLE `Enemy` (
  `level` int NOT NULL,
  `name` varchar(50) NOT NULL,
  `total_life` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Enemy`
--

INSERT INTO `Enemy` (`level`, `name`, `total_life`) VALUES
(1, 'blue slime', 10),
(2, 'green slime', 20),
(3, 'red slime', 30),
(4, 'yellow slime', 40),
(5, 'king slime', 50);

-- --------------------------------------------------------

--
-- Table structure for table `Enhancement`
--

CREATE TABLE `Enhancement` (
  `id_enhancement` int NOT NULL,
  `experience_cost` int NOT NULL,
  `boost_value` int NOT NULL,
  `id_type` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Enhancement`
--

INSERT INTO `Enhancement` (`id_enhancement`, `experience_cost`, `boost_value`, `id_type`) VALUES
(1, 0, 1, 1),
(2, 50, 2, 1),
(3, 0, 1, 2),
(4, 50, 2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `Player`
--

CREATE TABLE `Player` (
  `id_player` int NOT NULL,
  `pseudo` varchar(50) NOT NULL,
  `total_experience` int NOT NULL,
  `id_ennemy` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Player`
--

INSERT INTO `Player` (`id_player`, `pseudo`, `total_experience`, `id_ennemy`) VALUES
(1, 'OmegaZell', 0, 1),
(2, 'Sparadrap', 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `Type_enhancement`
--

CREATE TABLE `Type_enhancement` (
  `id_type` int NOT NULL,
  `name_type` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Type_enhancement`
--

INSERT INTO `Type_enhancement` (`id_type`, `name_type`) VALUES
(1, 'dps'),
(2, 'exp');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `buy`
--
ALTER TABLE `buy`
  ADD PRIMARY KEY (`id_player`,`id_enhancement`),
  ADD KEY `buy_Enhancement0_FK` (`id_enhancement`);

--
-- Indexes for table `Enemy`
--
ALTER TABLE `Enemy`
  ADD PRIMARY KEY (`level`);

--
-- Indexes for table `Enhancement`
--
ALTER TABLE `Enhancement`
  ADD PRIMARY KEY (`id_enhancement`),
  ADD KEY `Enhancement_Type_enhancement_FK` (`id_type`);

--
-- Indexes for table `Player`
--
ALTER TABLE `Player`
  ADD PRIMARY KEY (`id_player`),
  ADD KEY `Player_Level_ennemy_FK` (`id_ennemy`);

--
-- Indexes for table `Type_enhancement`
--
ALTER TABLE `Type_enhancement`
  ADD PRIMARY KEY (`id_type`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Enemy`
--
ALTER TABLE `Enemy`
  MODIFY `level` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `Enhancement`
--
ALTER TABLE `Enhancement`
  MODIFY `id_enhancement` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `Player`
--
ALTER TABLE `Player`
  MODIFY `id_player` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `Type_enhancement`
--
ALTER TABLE `Type_enhancement`
  MODIFY `id_type` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `buy`
--
ALTER TABLE `buy`
  ADD CONSTRAINT `buy_Enhancement0_FK` FOREIGN KEY (`id_enhancement`) REFERENCES `Enhancement` (`id_enhancement`),
  ADD CONSTRAINT `buy_Player_FK` FOREIGN KEY (`id_player`) REFERENCES `Player` (`id_player`);

--
-- Constraints for table `Enhancement`
--
ALTER TABLE `Enhancement`
  ADD CONSTRAINT `Enhancement_Type_enhancement_FK` FOREIGN KEY (`id_type`) REFERENCES `Type_enhancement` (`id_type`);

--
-- Constraints for table `Player`
--
ALTER TABLE `Player`
  ADD CONSTRAINT `Player_Level_ennemy_FK` FOREIGN KEY (`id_ennemy`) REFERENCES `Enemy` (`level`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
