-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 28, 2024 at 07:47 PM
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
-- Database: `cashbook_product`
--

-- --------------------------------------------------------

--
-- Table structure for table `expense_category`
--

CREATE TABLE `expense_category` (
  `id` int(50) NOT NULL,
  `expense_desc` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `expense_category`
--

INSERT INTO `expense_category` (`id`, `expense_desc`) VALUES
(1, 'Utilities'),
(2, 'Rent'),
(3, 'Office Supplies'),
(4, 'Travel'),
(5, 'Marketing'),
(6, 'Salaries'),
(7, 'Maintenance'),
(8, 'Insurance'),
(9, 'Professional Services'),
(10, 'Miscellaneous'),
(16, 'Cleaning'),
(17, 'Stationary'),
(18, 'Snaks'),
(19, 'Tax'),
(35, 'Files'),
(36, 'Glasses');

-- --------------------------------------------------------

--
-- Table structure for table `product_items`
--

CREATE TABLE `product_items` (
  `id` int(11) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `unit_price` double(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `product_items`
--

INSERT INTO `product_items` (`id`, `product_name`, `unit_price`) VALUES
(16, 'Apple', 50.52),
(17, 'Banana', 0.30),
(18, 'Orange', 150.60),
(19, 'Milk', 1.20),
(20, 'Bread', 1.00),
(21, 'Eggs', 2.00),
(22, 'Cheese', 2.50),
(23, 'Chicken Breast', 3.50),
(24, 'Rice', 0.80),
(25, 'Pasta', 1.50),
(26, 'Olive Oil', 4.00),
(27, 'Tomato Sauce', 1.80),
(28, 'Flour', 1.10),
(29, 'Sugar', 0.90),
(30, 'Salt', 0.40),
(31, 'Water 5L', 320.50),
(32, 'Coca Kola 1.5 L', 275.30),
(33, 'Wheat Flour ', 178.60),
(34, 'Corn Flour', 250.00),
(35, 'Water', 450.00);

-- --------------------------------------------------------

--
-- Table structure for table `product_sales`
--

CREATE TABLE `product_sales` (
  `id` int(255) NOT NULL,
  `product_name` text NOT NULL,
  `total_price` double(10,2) NOT NULL,
  `added_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `product_sales`
--

INSERT INTO `product_sales` (`id`, `product_name`, `total_price`, `added_date`) VALUES
(1, 'Product A', 100.00, '2023-07-01 00:00:00'),
(2, 'Product B', 150.00, '2022-07-02 00:00:00'),
(3, 'Product C', 201.00, '2024-07-01 00:00:00'),
(4, 'Product D', 250.00, '2024-07-04 00:00:00'),
(5, 'Product E', 300.00, '2024-07-05 00:00:00'),
(6, 'Product F', 351.00, '2024-07-06 00:00:00'),
(7, 'Product G', 400.00, '2024-07-07 00:00:00'),
(8, 'Product H', 451.00, '2024-07-08 00:00:00'),
(9, 'Product I', 500.00, '2024-07-09 00:00:00'),
(10, 'Product J', 550.00, '2024-08-22 00:00:00'),
(12, 'Product Z', 250.50, '2024-08-21 00:00:00'),
(15, 'Banana', 2500.00, '2024-08-27 13:58:16'),
(16, 'Orange', 3500.00, '2024-08-27 14:19:05'),
(17, 'Coca Kola 1.5 L', 2600.00, '2024-08-28 14:19:11');

-- --------------------------------------------------------

--
-- Table structure for table `shop_expense`
--

CREATE TABLE `shop_expense` (
  `id` int(11) NOT NULL,
  `expense_desc` text NOT NULL,
  `total_amount` double(10,2) NOT NULL,
  `added_date` datetime NOT NULL DEFAULT current_timestamp(),
  `user_id` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `shop_expense`
--

INSERT INTO `shop_expense` (`id`, `expense_desc`, `total_amount`, `added_date`, `user_id`) VALUES
(1, 'Office Supplies', 150.00, '2024-07-01 00:00:00', 1),
(2, 'Utility Bills', 300.00, '2024-07-05 00:00:00', 2),
(3, 'Internet Subscription', 100.00, '2024-07-10 00:00:00', 3),
(4, 'Advertising', 200.00, '2024-07-15 00:00:00', 1),
(5, 'Equipment Repair', 500.00, '2024-07-20 00:00:00', 2),
(6, 'Travel Expenses', 250.00, '2024-07-25 00:00:00', 4),
(7, 'Software Licenses', 350.00, '2024-07-29 00:00:00', 3),
(8, 'Employee Training', 400.00, '2024-08-01 00:00:00', 5),
(9, 'Maintenance', 300.00, '2024-08-05 00:00:00', 4),
(10, 'Office Rent', 1200.00, '2024-08-28 00:00:00', 1),
(11, 'Apple', 500.00, '2024-08-27 00:00:00', 1),
(12, 'Expense', 2600.00, '2024-08-28 00:00:00', 101);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `expense_category`
--
ALTER TABLE `expense_category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_items`
--
ALTER TABLE `product_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_sales`
--
ALTER TABLE `product_sales`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `shop_expense`
--
ALTER TABLE `shop_expense`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `expense_category`
--
ALTER TABLE `expense_category`
  MODIFY `id` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `product_items`
--
ALTER TABLE `product_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `product_sales`
--
ALTER TABLE `product_sales`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `shop_expense`
--
ALTER TABLE `shop_expense`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
