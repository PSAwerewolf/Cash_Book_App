-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 28, 2024 at 07:48 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cashbook_user`
--

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `shop_id` int(50) NOT NULL,
  `user_id` int(50) NOT NULL,
  `user_password` varchar(255) NOT NULL,
  `productDB_username` varchar(255) NOT NULL,
  `productDB_password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`shop_id`, `user_id`, `user_password`, `productDB_username`, `productDB_password`) VALUES
(1, 101, 'passUser101', 'prodDBUser1', 'securePass1'),
(1, 102, 'passUser102', 'prodDBUser1', 'securePass1'),
(1, 103, 'passUser103', 'prodDBUser1', 'securePass1'),
(2, 201, 'passUser201', 'prodDBUser2', 'securePass2'),
(2, 202, 'passUser202', 'prodDBUser2', 'securePass2'),
(3, 301, 'passUser301', 'prodDBUser3', 'securePass3'),
(3, 302, 'passUser302', 'prodDBUser3', 'securePass3'),
(4, 401, 'passUser401', 'prodDBUser4', 'securePass4'),
(4, 402, 'passUser402', 'prodDBUser4', 'securePass4'),
(4, 403, 'passUser403', 'prodDBUser4', 'securePass4'),
(5, 501, 'passUser501', 'prodDBUser5', 'securePass5'),
(1000, 100, 'user@123', 'root', '\' \'');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`shop_id`,`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
