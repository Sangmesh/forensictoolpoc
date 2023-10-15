-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Oct 15, 2023 at 03:01 PM
-- Server version: 10.7.7-MariaDB
-- PHP Version: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `forensictool`
--

-- --------------------------------------------------------

--
-- Table structure for table `authors`
--

CREATE TABLE `authors` (
  `id` int(11) NOT NULL,
  `author_name` varchar(256) NOT NULL,
  `email` varchar(256) NOT NULL,
  `ssno` varchar(256) NOT NULL,
  `created_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `authors`
--

INSERT INTO `authors` (`id`, `author_name`, `email`, `ssno`, `created_date`) VALUES
(1, 'Sangmesh Seege', 's.r.seege@gmail.com', '564734567', '2023-10-14 11:31:08');

-- --------------------------------------------------------

--
-- Table structure for table `metadata`
--

CREATE TABLE `metadata` (
  `id` int(11) NOT NULL,
  `finename` varchar(256) NOT NULL,
  `size` varchar(11) NOT NULL,
  `type` varchar(10) NOT NULL,
  `uploaded_date` date NOT NULL,
  `author_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `metadata`
--

INSERT INTO `metadata` (`id`, `finename`, `size`, `type`, `uploaded_date`, `author_id`) VALUES
(1, '1159948-literary-wallpaper-1920x1080-for-mac', '82', 'jpeg', '2023-10-15', 1),
(2, '1159948-literary-wallpaper-1920x1080-for-mac', '82', 'jpeg', '2023-10-15', 1),
(3, 'PNG_transparency_demonstration_1', '222', 'png', '2023-10-15', 1),
(4, 'Rotating_earth', '978', 'gif', '2023-10-15', 1);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_metadata`
-- (See below for the actual view)
--
CREATE TABLE `vw_metadata` (
`id` int(11)
,`finename` varchar(256)
,`size` varchar(11)
,`type` varchar(10)
,`uploaded_date` date
,`author_name` varchar(256)
,`email` varchar(256)
,`ssno` varchar(256)
);

-- --------------------------------------------------------

--
-- Structure for view `vw_metadata`
--
DROP TABLE IF EXISTS `vw_metadata`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_metadata`  AS SELECT `a`.`id` AS `id`, `a`.`finename` AS `finename`, `a`.`size` AS `size`, `a`.`type` AS `type`, `a`.`uploaded_date` AS `uploaded_date`, `b`.`author_name` AS `author_name`, `b`.`email` AS `email`, `b`.`ssno` AS `ssno` FROM (`metadata` `a` left join `authors` `b` on(`b`.`id` = `a`.`author_id`))  ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `authors`
--
ALTER TABLE `authors`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `metadata`
--
ALTER TABLE `metadata`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `authors`
--
ALTER TABLE `authors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `metadata`
--
ALTER TABLE `metadata`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
