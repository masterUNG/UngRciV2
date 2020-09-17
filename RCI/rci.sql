-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Sep 17, 2020 at 03:51 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `rci`
--

-- --------------------------------------------------------

--
-- Table structure for table `location`
--

CREATE TABLE `location` (
  `id` int(11) NOT NULL,
  `Name` text COLLATE utf8_unicode_ci NOT NULL,
  `DateTime` text COLLATE utf8_unicode_ci NOT NULL,
  `Lat` text COLLATE utf8_unicode_ci NOT NULL,
  `Lng` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `location`
--

INSERT INTO `location` (`id`, `Name`, `DateTime`, `Lat`, `Lng`) VALUES
(3, 'ฉัตรชัย', '16-09-2020 14:55', '13.785491', '100.573439'),
(4, 'อึ่ง ผู้ซื้อ', '16-09-2020 14:58', '13.647603', '100.320767'),
(6, 'อึ่ง ผู้ซื้อ', '16-09-2020 15:01', '13.646736', '100.320284'),
(7, 'มนัส', '16-09-2020 15:01', '13.646697', '100.31981'),
(9, 'armuser', '16-09-2020 15:01', '13.647603', '100.320767'),
(10, 'อึ่ง ผู้ซื้อ', '16-09-2020 15:03', '13.647615', '100.320808'),
(11, 'armuser', '16-09-2020 15:25', '13.647603', '100.320767'),
(12, 'อึ่ง ผู้ซื้อ', '16-09-2020 15:45', '13.647615', '100.320808'),
(13, 'armuser', '17-09-2020 09:53', '13.6476174', '100.3200695'),
(14, 'อึ่ง ผู้ซื้อ', '17-09-2020 11:32', '13.6476114', '100.3200879');

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `id` int(11) NOT NULL,
  `xvalue` text NOT NULL,
  `yvalue` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`id`, `xvalue`, `yvalue`) VALUES
(1, '0', '15'),
(2, '10', '25'),
(3, '20', '36'),
(4, '30', '25'),
(5, '40', '50'),
(6, '50', '100'),
(7, '60', '75'),
(8, '70', '30');

-- --------------------------------------------------------

--
-- Table structure for table `userung`
--

CREATE TABLE `userung` (
  `id` int(11) NOT NULL,
  `Type` text COLLATE utf8_unicode_ci NOT NULL,
  `Name` text COLLATE utf8_unicode_ci NOT NULL,
  `User` text COLLATE utf8_unicode_ci NOT NULL,
  `Password` text COLLATE utf8_unicode_ci NOT NULL,
  `CreateDate` text COLLATE utf8_unicode_ci NOT NULL,
  `Address` text COLLATE utf8_unicode_ci NOT NULL,
  `Phone` text COLLATE utf8_unicode_ci NOT NULL,
  `Gendel` text COLLATE utf8_unicode_ci NOT NULL,
  `Education` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `userung`
--

INSERT INTO `userung` (`id`, `Type`, `Name`, `User`, `Password`, `CreateDate`, `Address`, `Phone`, `Gendel`, `Education`) VALUES
(1, 'User', 'jee1', 'mjee1', '123456', '$dateTimeString', '$address', '$phone', '$gender', '$educateString'),
(2, 'User', 'ฉัตรชัย', 'chatchai', '111111', '$dateTimeString', '$address', '$phone', '$gender', '$educateString'),
(4, 'User', 'armuser', 'arm1', '1234', '', 'Address', 'Phone', 'Gendel', 'Education'),
(5, 'Shop', 'jee2', 'mjee2', '123456', '', '', '', '', ''),
(6, 'User', 'มนัส', 'manat1', 'manat1', '', '', '', '', ''),
(8, 'Shop', 'MR1 Shop', 'mr1', '111111', '09-07-2020', 'มหาชัย เทส', '222222222', 'Male', 'มัธยมต้น'),
(9, 'Shop', 'มนัส', 'manat2', 'manat2', '09-07-2020', 'ทดสอบ', '1', 'Male', 'ป.ตรี'),
(10, 'Shop', 'armshop', 'arm2', '1234', '09/07/2020', 'กรุงเทพ', '085-1801230', 'Male', 'ปริญญาโท'),
(11, 'User', 'อึ่ง ผู้ซื้อ', 'unguser', '123456', '', '', '', '', ''),
(13, 'User', 'นพ', 'nop1', 'nop1', 'xx', 'xx', 'xx', 'xx', 'xx'),
(14, 'Shop', 'อึ่ง ร้าน', 'ungshop', '123456', '09/July/2020', '123 บางนา กรุงเทพ', '12345678', 'Male', 'ปริญาเอก'),
(15, 'Shoper', 'นพ', 'nop2', 'nop2', '', '', '', '', ''),
(16, 'Shop', 'fff', 'mastershop', 'drff', '', '', '', '', ''),
(17, 'Shop', 'สาสส', '1111', 'าสสส', '', '', '', '', ''),
(18, 'Shop', 'mjee', 'mjee', '123456', '18/05/2002', 'addressd', '02323', 'ชาย', 'aaaa'),
(19, 'User', 'พัช', 'พัช1', 'พัช1', 'xx', 'ผมเป็นลิเกคนจน บ้านอยู่ฝังธนท้าพระ', 'ผมเป็นลิเกนะจ๊ะบ้านอยู่ท้าพระฝังธน', 'xx', 'xx'),
(20, 'Shoper', 'พัช', 'พัช2', 'พัช2', '', '', '', '', ''),
(21, 'Shop', 'test', 'test', 'test', '', '', '', '', '');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `location`
--
ALTER TABLE `location`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `userung`
--
ALTER TABLE `userung`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `location`
--
ALTER TABLE `location`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `userung`
--
ALTER TABLE `userung`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
