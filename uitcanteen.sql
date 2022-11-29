-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 29, 2022 at 09:24 AM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `uitcanteen`
--

-- --------------------------------------------------------

--
-- Table structure for table `dish`
--

CREATE TABLE `dish` (
  `DishId` int(11) NOT NULL,
  `dishTypeId` int(11) NOT NULL,
  `dishName` varchar(64) NOT NULL,
  `image` varchar(512) NOT NULL,
  `description` text DEFAULT NULL,
  `updateAt` datetime DEFAULT current_timestamp(),
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `dish`
--

INSERT INTO `dish` (`DishId`, `dishTypeId`, `dishName`, `image`, `description`, `updateAt`, `quantity`) VALUES
(1, 1, 'Thịt kho trứng', 'https://drive.google.com/file/d/153iOnbzc9rfiQAsGyEjolJ8KIv0-TPUk/view?usp=sharing', NULL, '2022-11-22 20:45:00', 30),
(2, 1, 'Thịt gà kho sả ớt', 'https://drive.google.com/file/d/14VHsez5I6N-JvVLOjoxHmyuiJF8WkusC/view?usp=share_link', NULL, '2022-11-22 20:45:00', 30),
(3, 1, 'Cá lóc kho tộ', 'https://drive.google.com/file/d/14Y-UMUwG7Yx3VooC7zaIySlIhOkYlbmJ/view?usp=share_link', NULL, '2022-11-22 20:45:00', 30),
(4, 1, 'Thịt heo kho măng', 'https://drive.google.com/file/d/14Z6l54wpZ57IcZxQeMkn0nGc0TZ55QRW/view?usp=share_link', NULL, '2022-11-22 20:45:00', 30),
(5, 1, 'Thịt heo kho củ cải', 'https://drive.google.com/file/d/14aEYRLfPIe2IR69E_aJz-D5yf6ATF9y-/view?usp=share_link', NULL, '2022-11-22 20:45:00', 30),
(6, 1, 'Đậu hũ nhồi thịt', 'https://drive.google.com/file/d/14abxF6ENFgFo3SsXqygv-09B3S8i5V2b/view?usp=share_link', NULL, '2022-11-22 20:45:00', 30),
(7, 1, 'Chả cá sốt mắm tỏi', 'https://drive.google.com/file/d/14dIl6nGMl_t9ty7HfILQUNyBtH9Z3XWd/view?usp=share_link', NULL, '2022-11-22 20:45:00', 30),
(8, 1, 'Trứng chiên thịt', 'https://drive.google.com/file/d/14er4B97SHGy8nDIP1PkvR9gWpIIrmT2D/view?usp=share_link', NULL, '2022-11-22 20:45:00', 30),
(9, 1, 'Bạch tuộc xào sả ớt', 'https://drive.google.com/file/d/14f3W3PH1hjDDyQ2wn1IOXcgforZYyD4O/view?usp=share_link', NULL, '2022-11-22 20:45:00', 30),
(10, 1, 'Đậu hũ sả ớt', 'https://drive.google.com/file/d/14f_Mtmp_FIQhxdDJjd3ZjZDZUkzKkIpT/view?usp=share_link', NULL, '2022-11-22 20:45:00', 30),
(11, 1, 'Nem nướng', 'https://drive.google.com/file/d/14n33WXaQUCieqccSP9sX5Sul6rdyy2tJ/view?usp=share_link', NULL, '2022-11-22 20:45:00', 30),
(12, 1, 'Lòng gà xào thơm', 'https://drive.google.com/file/d/153zqu-ELKGJFDbmia7PErG-UX59QtnBj/view?usp=share_link', NULL, '2022-11-22 20:45:00', 30),
(13, 1, 'Cánh gà chiên nước mắm', 'https://drive.google.com/file/d/14kyQ3u0Nb6W7nFGkntYGVP_MHS-3V-hc/view?usp=share_link', NULL, '2022-11-22 20:45:00', 30),
(14, 1, 'Bò kho', 'https://drive.google.com/file/d/14r9E0nuWD2cwuMkDbuvq8GnTpvDtD4Je/view?usp=share_link', NULL, '2022-11-22 20:45:00', 30),
(15, 1, 'Thịt luộc cà pháo mắm tôm', 'https://drive.google.com/file/d/14rIjdpvmn9pEy-wldmRufQOaRkmUupvW/view?usp=share_link', NULL, '2022-11-22 20:45:00', 30),
(16, 2, 'Khổ qua xào trứng', 'https://drive.google.com/file/d/14tRNPru2lPcNpEEG1YYuggrhPyTsJXlM/view?usp=share_link', NULL, '2022-11-22 20:45:00', 30),
(17, 2, 'Đậu cô ve xào', 'https://drive.google.com/file/d/157esdCeb1P0uwygv4Kj-2o5dP6cEaipq/view?usp=share_link', NULL, '2022-11-22 20:45:00', 30),
(18, 2, 'Cà rốt xào trứng', 'https://drive.google.com/file/d/14uzBdmRNMW06j17VGOfTpTqRAaFde66k/view?usp=share_link', NULL, '2022-11-22 20:45:00', 30),
(19, 2, 'Khoai tây xào tỏi', 'https://drive.google.com/file/d/14xLJXotAb1Z8HY_EAYM9_jQR5BwsF5NX/view?usp=share_link', NULL, '2022-11-22 20:45:00', 30),
(20, 2, 'Su su xào', 'https://drive.google.com/file/d/150DRCC32ikdL2TWiva0yZ22TwW45yWsY/view?usp=share_link', NULL, '2022-11-22 20:45:00', 30),
(21, 2, 'Nộm dưa chuột', 'https://drive.google.com/file/d/151BHV7-B83NFdYdjXtjF7-ImizXOfGqz/view?usp=share_link', NULL, '2022-11-22 20:45:00', 30),
(22, 2, 'Bí đỏ xào tỏi', 'https://drive.google.com/file/d/151i0cVd5aalwpzYN2oBWWEljjV7huh_4/view?usp=share_link', NULL, '2022-11-22 20:45:00', 30),
(23, 2, 'Rau muống xào tỏi', 'https://drive.google.com/file/d/152mgFNQiKgWPMPQBRy2Nrqg0hNPDM1ap/view?usp=share_link', NULL, '2022-11-22 20:45:00', 30);

-- --------------------------------------------------------

--
-- Table structure for table `dish_type`
--

CREATE TABLE `dish_type` (
  `dishTypeId` int(11) NOT NULL,
  `dishTypeName` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `dish_type`
--

INSERT INTO `dish_type` (`dishTypeId`, `dishTypeName`) VALUES
(1, 'Món chính'),
(2, 'Món phụ');

-- --------------------------------------------------------

--
-- Table structure for table `ingredient`
--

CREATE TABLE `ingredient` (
  `ingredientId` int(11) NOT NULL,
  `ingredientName` varchar(64) NOT NULL,
  `ingredientTypeId` int(11) NOT NULL,
  `updateAt` datetime NOT NULL DEFAULT current_timestamp(),
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `ingredient`
--

INSERT INTO `ingredient` (`ingredientId`, `ingredientName`, `ingredientTypeId`, `updateAt`, `quantity`) VALUES
(1, 'Thịt heo', 1, '2022-11-22 20:44:58', 5),
(2, 'Thịt bò', 1, '2022-11-22 20:44:58', 5),
(3, 'Cá biển', 1, '2022-11-22 20:44:58', 5),
(4, 'Thịt gà', 1, '2022-11-22 20:44:59', 5),
(5, 'Trứng', 1, '2022-11-22 20:44:59', 5),
(6, 'Bạch tuộc', 1, '2022-11-22 20:44:59', 5),
(7, 'Chả cá', 1, '2022-11-22 20:44:59', 5),
(8, 'Đậu hũ', 1, '2022-11-22 20:44:59', 5),
(9, 'Khổ qua', 2, '2022-11-22 20:44:59', 5),
(10, 'Cà rốt', 2, '2022-11-22 20:44:59', 5),
(11, 'Bí đỏ', 2, '2022-11-22 20:44:59', 5),
(12, 'Đậu cô ve', 2, '2022-11-22 20:44:59', 5),
(13, 'Dưa chuột', 2, '2022-11-22 20:44:59', 5),
(14, 'Khoai tây', 2, '2022-11-22 20:44:59', 5),
(15, 'Susu', 2, '2022-11-22 20:44:59', 5),
(16, 'Củ cải', 2, '2022-11-22 20:44:59', 5),
(17, 'Rau muống', 2, '2022-11-22 20:44:59', 5),
(18, 'Hành tây', 2, '2022-11-22 20:44:59', 5),
(19, 'Ớt', 3, '2022-11-22 20:44:59', 5),
(20, 'Sả', 3, '2022-11-22 20:44:59', 5),
(21, 'Gừng', 3, '2022-11-22 20:44:59', 5),
(22, 'Tỏi', 3, '2022-11-22 20:44:59', 5),
(23, 'Hành khô', 3, '2022-11-22 20:44:59', 5),
(24, 'Hành lá', 3, '2022-11-22 20:44:59', 5),
(25, 'Nước mắm', 3, '2022-11-22 20:45:00', 5),
(26, 'Tiêu', 3, '2022-11-22 20:45:00', 5);

-- --------------------------------------------------------

--
-- Table structure for table `ingredient_type`
--

CREATE TABLE `ingredient_type` (
  `ingredientTypeId` int(11) NOT NULL,
  `ingredientTypeName` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `ingredient_type`
--

INSERT INTO `ingredient_type` (`ingredientTypeId`, `ingredientTypeName`) VALUES
(1, 'Tươi sống'),
(2, 'Rau củ quả'),
(3, 'Phụ gia');

-- --------------------------------------------------------

--
-- Table structure for table `invoice`
--

CREATE TABLE `invoice` (
  `invoiceId` int(11) NOT NULL,
  `orderId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `total` float NOT NULL,
  `paymentId` int(11) NOT NULL,
  `payAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `order_detail`
--

CREATE TABLE `order_detail` (
  `orderDetailId` int(11) NOT NULL,
  `dishId` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `orderId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `order_status`
--

CREATE TABLE `order_status` (
  `statusOrderId` int(11) NOT NULL,
  `statusOrderName` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `ordr`
--

CREATE TABLE `ordr` (
  `orderId` int(11) NOT NULL,
  `updateAt` datetime DEFAULT current_timestamp(),
  `userId` int(11) NOT NULL,
  `statusOrderId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `paymentId` int(11) NOT NULL,
  `paymentType` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `session_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `expires` int(11) UNSIGNED NOT NULL,
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`session_id`, `expires`, `data`) VALUES
('4oYXyQiij0NlpQMbH8eykcS2OLU7ak68', 1669738351, '{\"cookie\":{\"originalMaxAge\":28800000,\"expires\":\"2022-11-29T16:12:31.067Z\",\"secure\":false,\"httpOnly\":true,\"path\":\"/\",\"sameSite\":true},\"authenticated\":true,\"user\":{\"userId\":1,\"studentId\":null,\"password\":\"123456\",\"email\":\"khanhgamu02@gmail.com\",\"firstName\":null,\"lastName\":null,\"mobile\":null,\"creatAt\":\"2022-11-22T16:25:32.000Z\",\"updateAt\":\"2022-11-22T16:25:32.000Z\"}}'),
('6y61klf5dI8Ylm2X9MV81VVhVO0VAbJO', 1669738046, '{\"cookie\":{\"originalMaxAge\":28800000,\"expires\":\"2022-11-29T16:07:25.862Z\",\"secure\":false,\"httpOnly\":true,\"path\":\"/\",\"sameSite\":true},\"authenticated\":true,\"user\":{\"userId\":1,\"studentId\":null,\"password\":\"123456\",\"email\":\"khanhgamu02@gmail.com\",\"firstName\":null,\"lastName\":null,\"mobile\":null,\"creatAt\":\"2022-11-22T16:25:32.000Z\",\"updateAt\":\"2022-11-22T16:25:32.000Z\"}}'),
('Ancu3gBcDfcBT1uyhINyfZ-wv54G1PIF', 1669737995, '{\"cookie\":{\"originalMaxAge\":28800000,\"expires\":\"2022-11-29T16:06:35.300Z\",\"secure\":false,\"httpOnly\":true,\"path\":\"/\",\"sameSite\":true},\"authenticated\":true,\"user\":{\"userId\":1,\"studentId\":null,\"password\":\"123456\",\"email\":\"khanhgamu02@gmail.com\",\"firstName\":null,\"lastName\":null,\"mobile\":null,\"creatAt\":\"2022-11-22T16:25:32.000Z\",\"updateAt\":\"2022-11-22T16:25:32.000Z\"}}'),
('JiqTDvskQ23PNAE7uP22C-QI6jVfWQxo', 1669738670, '{\"cookie\":{\"originalMaxAge\":28800000,\"expires\":\"2022-11-29T16:17:49.975Z\",\"secure\":false,\"httpOnly\":true,\"path\":\"/\",\"sameSite\":true},\"authenticated\":true,\"user\":{\"userId\":1,\"studentId\":null,\"password\":\"123456\",\"email\":\"khanhgamu02@gmail.com\",\"firstName\":null,\"lastName\":null,\"mobile\":null,\"creatAt\":\"2022-11-22T16:25:32.000Z\",\"updateAt\":\"2022-11-22T16:25:32.000Z\"}}'),
('KGib0vvXEhIPOSuz4koa3IwqN0BSBhbG', 1669736041, '{\"cookie\":{\"originalMaxAge\":28800000,\"expires\":\"2022-11-29T15:34:00.699Z\",\"secure\":false,\"httpOnly\":true,\"path\":\"/\",\"sameSite\":true},\"authenticated\":true,\"user\":{\"userId\":1,\"studentId\":null,\"password\":\"123456\",\"email\":\"khanhgamu02@gmail.com\",\"firstName\":null,\"lastName\":null,\"mobile\":null,\"creatAt\":\"2022-11-22T16:25:32.000Z\",\"updateAt\":\"2022-11-22T16:25:32.000Z\"}}'),
('Qel7p24OcfH-IsKwoOzm0NScadIPjYtW', 1669738417, '{\"cookie\":{\"originalMaxAge\":28800000,\"expires\":\"2022-11-29T16:13:37.173Z\",\"secure\":false,\"httpOnly\":true,\"path\":\"/\",\"sameSite\":true},\"authenticated\":true,\"user\":{\"userId\":1,\"studentId\":null,\"password\":\"123456\",\"email\":\"khanhgamu02@gmail.com\",\"firstName\":null,\"lastName\":null,\"mobile\":null,\"creatAt\":\"2022-11-22T16:25:32.000Z\",\"updateAt\":\"2022-11-22T16:25:32.000Z\"}}'),
('ROKO-K3oqq_8Ba0utsiqv8vonmvSbJeb', 1669738878, '{\"cookie\":{\"originalMaxAge\":28800000,\"expires\":\"2022-11-29T16:21:18.080Z\",\"secure\":false,\"httpOnly\":true,\"path\":\"/\",\"sameSite\":true},\"authenticated\":true,\"user\":{\"userId\":1,\"studentId\":null,\"password\":\"123456\",\"email\":\"khanhgamu02@gmail.com\",\"firstName\":null,\"lastName\":null,\"mobile\":null,\"creatAt\":\"2022-11-22T16:25:32.000Z\",\"updateAt\":\"2022-11-22T16:25:32.000Z\"}}'),
('TGjSK4tALj3Ua-6Z7YYE4m_POBOb8_1q', 1669738682, '{\"cookie\":{\"originalMaxAge\":28800000,\"expires\":\"2022-11-29T16:18:02.012Z\",\"secure\":false,\"httpOnly\":true,\"path\":\"/\",\"sameSite\":true},\"authenticated\":true,\"user\":{\"userId\":1,\"studentId\":null,\"password\":\"123456\",\"email\":\"khanhgamu02@gmail.com\",\"firstName\":null,\"lastName\":null,\"mobile\":null,\"creatAt\":\"2022-11-22T16:25:32.000Z\",\"updateAt\":\"2022-11-22T16:25:32.000Z\"}}'),
('_GvLlW8zLqveNkrfEHKclhUzTzEsPZJj', 1669738121, '{\"cookie\":{\"originalMaxAge\":28800000,\"expires\":\"2022-11-29T16:08:40.775Z\",\"secure\":false,\"httpOnly\":true,\"path\":\"/\",\"sameSite\":true},\"authenticated\":true,\"user\":{\"userId\":1,\"studentId\":null,\"password\":\"123456\",\"email\":\"khanhgamu02@gmail.com\",\"firstName\":null,\"lastName\":null,\"mobile\":null,\"creatAt\":\"2022-11-22T16:25:32.000Z\",\"updateAt\":\"2022-11-22T16:25:32.000Z\"}}'),
('_SEda8a8fIVjdH8MoZOj9PVUoOh-B1c1', 1669738064, '{\"cookie\":{\"originalMaxAge\":28800000,\"expires\":\"2022-11-29T16:07:43.758Z\",\"secure\":false,\"httpOnly\":true,\"path\":\"/\",\"sameSite\":true},\"authenticated\":true,\"user\":{\"userId\":1,\"studentId\":null,\"password\":\"123456\",\"email\":\"khanhgamu02@gmail.com\",\"firstName\":null,\"lastName\":null,\"mobile\":null,\"creatAt\":\"2022-11-22T16:25:32.000Z\",\"updateAt\":\"2022-11-22T16:25:32.000Z\"}}'),
('kicdAQpj_LhjL8kNq-eYZF_avBm-Mn-5', 1669736616, '{\"cookie\":{\"originalMaxAge\":28800000,\"expires\":\"2022-11-29T15:43:35.837Z\",\"secure\":false,\"httpOnly\":true,\"path\":\"/\",\"sameSite\":true},\"authenticated\":true,\"user\":{\"userId\":1,\"studentId\":null,\"password\":\"123456\",\"email\":\"khanhgamu02@gmail.com\",\"firstName\":null,\"lastName\":null,\"mobile\":null,\"creatAt\":\"2022-11-22T16:25:32.000Z\",\"updateAt\":\"2022-11-22T16:25:32.000Z\"}}'),
('yO4u8W9AAeRo7M58IGLVLTvvMpcRIKcA', 1669738504, '{\"cookie\":{\"originalMaxAge\":28800000,\"expires\":\"2022-11-29T16:15:04.402Z\",\"secure\":false,\"httpOnly\":true,\"path\":\"/\",\"sameSite\":true},\"authenticated\":true,\"user\":{\"userId\":1,\"studentId\":null,\"password\":\"123456\",\"email\":\"khanhgamu02@gmail.com\",\"firstName\":null,\"lastName\":null,\"mobile\":null,\"creatAt\":\"2022-11-22T16:25:32.000Z\",\"updateAt\":\"2022-11-22T16:25:32.000Z\"}}');

-- --------------------------------------------------------

--
-- Table structure for table `usr`
--

CREATE TABLE `usr` (
  `userId` int(11) NOT NULL,
  `studentId` int(11) DEFAULT NULL,
  `password` varchar(64) NOT NULL,
  `email` varchar(64) NOT NULL,
  `firstName` varchar(64) DEFAULT NULL,
  `lastName` varchar(64) DEFAULT NULL,
  `mobile` varchar(10) DEFAULT NULL,
  `creatAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updateAt` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `usr`
--

INSERT INTO `usr` (`userId`, `studentId`, `password`, `email`, `firstName`, `lastName`, `mobile`, `creatAt`, `updateAt`) VALUES
(1, NULL, '123456', 'khanhgamu02@gmail.com', NULL, NULL, NULL, '2022-11-22 23:25:32', '2022-11-22 23:25:32'),
(2, NULL, '123456', 'khanhgamu01@gmail.com', NULL, NULL, NULL, '2022-11-26 17:34:03', '2022-11-26 17:34:03'),
(3, NULL, '123456', 'khanhgamu00@gmail.com', NULL, NULL, NULL, '2022-11-26 17:34:33', '2022-11-26 17:34:33'),
(4, NULL, '123456', 'khanhgamu04@gmail.com', NULL, NULL, NULL, '2022-11-26 17:35:02', '2022-11-26 17:35:02'),
(5, NULL, '123456', 'khanhgamu08@gmail.com', NULL, NULL, NULL, '2022-11-29 13:56:55', '2022-11-29 13:56:55');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `dish`
--
ALTER TABLE `dish`
  ADD PRIMARY KEY (`DishId`),
  ADD KEY `dishTypeId` (`dishTypeId`);

--
-- Indexes for table `dish_type`
--
ALTER TABLE `dish_type`
  ADD PRIMARY KEY (`dishTypeId`);

--
-- Indexes for table `ingredient`
--
ALTER TABLE `ingredient`
  ADD PRIMARY KEY (`ingredientId`),
  ADD KEY `ingredientTypeId` (`ingredientTypeId`);

--
-- Indexes for table `ingredient_type`
--
ALTER TABLE `ingredient_type`
  ADD PRIMARY KEY (`ingredientTypeId`);

--
-- Indexes for table `invoice`
--
ALTER TABLE `invoice`
  ADD PRIMARY KEY (`invoiceId`),
  ADD KEY `orderId` (`orderId`),
  ADD KEY `userId` (`userId`),
  ADD KEY `paymentId` (`paymentId`);

--
-- Indexes for table `order_detail`
--
ALTER TABLE `order_detail`
  ADD PRIMARY KEY (`orderDetailId`),
  ADD KEY `dishId` (`dishId`),
  ADD KEY `orderId` (`orderId`);

--
-- Indexes for table `order_status`
--
ALTER TABLE `order_status`
  ADD PRIMARY KEY (`statusOrderId`);

--
-- Indexes for table `ordr`
--
ALTER TABLE `ordr`
  ADD PRIMARY KEY (`orderId`),
  ADD KEY `userId` (`userId`),
  ADD KEY `statusOrderId` (`statusOrderId`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`paymentId`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`session_id`);

--
-- Indexes for table `usr`
--
ALTER TABLE `usr`
  ADD PRIMARY KEY (`userId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `dish`
--
ALTER TABLE `dish`
  MODIFY `DishId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `dish_type`
--
ALTER TABLE `dish_type`
  MODIFY `dishTypeId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `ingredient`
--
ALTER TABLE `ingredient`
  MODIFY `ingredientId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `ingredient_type`
--
ALTER TABLE `ingredient_type`
  MODIFY `ingredientTypeId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `invoice`
--
ALTER TABLE `invoice`
  MODIFY `invoiceId` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_detail`
--
ALTER TABLE `order_detail`
  MODIFY `orderDetailId` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_status`
--
ALTER TABLE `order_status`
  MODIFY `statusOrderId` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ordr`
--
ALTER TABLE `ordr`
  MODIFY `orderId` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `paymentId` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `usr`
--
ALTER TABLE `usr`
  MODIFY `userId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `dish`
--
ALTER TABLE `dish`
  ADD CONSTRAINT `dish_ibfk_1` FOREIGN KEY (`dishTypeId`) REFERENCES `dish_type` (`dishTypeId`);

--
-- Constraints for table `ingredient`
--
ALTER TABLE `ingredient`
  ADD CONSTRAINT `ingredient_ibfk_1` FOREIGN KEY (`ingredientTypeId`) REFERENCES `ingredient_type` (`ingredientTypeId`);

--
-- Constraints for table `invoice`
--
ALTER TABLE `invoice`
  ADD CONSTRAINT `invoice_ibfk_1` FOREIGN KEY (`orderId`) REFERENCES `ordr` (`orderId`),
  ADD CONSTRAINT `invoice_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `usr` (`userId`),
  ADD CONSTRAINT `invoice_ibfk_3` FOREIGN KEY (`paymentId`) REFERENCES `payment` (`paymentId`);

--
-- Constraints for table `order_detail`
--
ALTER TABLE `order_detail`
  ADD CONSTRAINT `order_detail_ibfk_1` FOREIGN KEY (`dishId`) REFERENCES `dish` (`DishId`),
  ADD CONSTRAINT `order_detail_ibfk_2` FOREIGN KEY (`orderId`) REFERENCES `ordr` (`orderId`);

--
-- Constraints for table `ordr`
--
ALTER TABLE `ordr`
  ADD CONSTRAINT `ordr_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `usr` (`userId`),
  ADD CONSTRAINT `ordr_ibfk_2` FOREIGN KEY (`statusOrderId`) REFERENCES `order_status` (`statusOrderId`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
