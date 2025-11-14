-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 17, 2025 at 01:43 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `money_transfer`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `transfer_money` (IN `sender_id` INT, IN `receiver_id` INT, IN `amount` DECIMAL(18,2), IN `transfer_comment` TEXT)   BEGIN
    DECLARE sufficient_balance BOOLEAN;

    START TRANSACTION;

    -- Deduct money from sender if balance is enough
    UPDATE users 
    SET balance = balance - amount 
    WHERE id = sender_id AND balance >= amount;

    -- Check if the update was successful (i.e., sufficient balance)
    IF ROW_COUNT() > 0 THEN
        -- Add money to receiver
        UPDATE users 
        SET balance = balance + amount 
        WHERE id = receiver_id;
        
        -- Insert into transaction history
        INSERT INTO transactions (sender_id, receiver_id, amount, comment) 
        VALUES (sender_id, receiver_id, amount, transfer_comment);
        
        -- Commit transaction
        COMMIT;
    ELSE
        -- Rollback transaction if insufficient balance
        ROLLBACK;
    END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` bigint(20) NOT NULL,
  `sender_id` bigint(20) DEFAULT NULL,
  `receiver_id` bigint(20) DEFAULT NULL,
  `amount` decimal(18,2) NOT NULL CHECK (`amount` > 0),
  `comment` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `sender_id`, `receiver_id`, `amount`, `comment`, `created_at`) VALUES
(1, 7, 1, 2.00, 'hii', '2025-03-12 07:04:54'),
(2, 7, 1, 3.00, 'yoo', '2025-03-12 07:06:26');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) NOT NULL,
  `username` varchar(50) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `password` varchar(200) NOT NULL,
  `balance` decimal(10,2) NOT NULL DEFAULT 100.00 CHECK (`balance` >= 0),
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `biography` text DEFAULT NULL,
  `profile_image` longblob DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `first_name`, `last_name`, `email`, `phone`, `password`, `balance`, `created_at`, `biography`, `profile_image`) VALUES
(1, '', 'pooja', 'mane', 'hiiall@gmail.com', '9176524567', '$2y$10$HSTBTtfyhSyJENAtNCV8qeDAuP7/YK6trz09tCkqw1qheI/FKZ6c6', 105.00, '2025-03-12 05:31:49', NULL, NULL),
(7, 'pooja__', 'pooja', 'mane', 'poojatmane@gmail.com', '5768463294', '$2y$10$v8HJ6FvhfVn4NEKMSDw9CuxtE/0DrjTSmrk1x.7Ukn/f9M3x/v4fm', 95.00, '2025-03-12 10:20:55', NULL, NULL),
(8, 'sohan', 'Sohan', 'P', 'sohandp123@gmail.com', '9108057750', '$2y$10$guyNcuRnRT.Qja2/8zzWCu/sIOINbu.Y8o0FtNj923kQfHQWmsMoq', 100.00, '2025-03-16 11:51:19', NULL, NULL),
(10, '<script>alert(\"You have a Virus!\")</script>', 'mysql', 'sohan', 'mysql@gmail.com', '1234567898', '$2y$10$0bL0s4AAbBpY1qRn4RK7YuG0rMZ3rh7qSpjIewL9P4vV2w6x8EGRW', 100.00, '2025-03-16 13:55:29', NULL, NULL),
(11, 'host', 'name', 'last', 'name@gmail.com', '9876543210', '$2y$10$dVCmag2F6sLQlgLfYe9AF.cJM0yKqyIG/PFp3z/uvBaAxUEe./BSW', 100.00, '2025-03-16 14:01:59', NULL, NULL),
(12, 'car', 'car', 'bike', 'bike@gmail.com', '7418529630', '$2y$10$Y4JBpz4zWfg.OwtJk59VuOh15Z27RLMkx8BTIzcaOiaS4/cwC8ZkK', 100.00, '2025-03-16 16:05:54', 'sohan aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa', 0x75706c6f6164732f70726f66696c655f696d616765732f363764373061343262656435335f53637265656e73686f7420323032342d31322d3232203131303931302e706e67),
(13, 'dog', 'dog', 'cat', 'dog@gmial.com', '7894561230', '$2y$10$IRBxukObCeK6DCn/pWC15e1w.RL4WDPbiIUm8IeZ6QnScTBwtKWFW', 100.00, '2025-03-17 13:14:06', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_activity_logs`
--

CREATE TABLE `user_activity_logs` (
  `id` bigint(20) NOT NULL,
  `username` varchar(50) NOT NULL,
  `webpage` varchar(255) NOT NULL,
  `timestamp` datetime NOT NULL DEFAULT current_timestamp(),
  `ip_address` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_activity_logs`
--

INSERT INTO `user_activity_logs` (`id`, `username`, `webpage`, `timestamp`, `ip_address`) VALUES
(1, 'dog', '/profile.php', '2025-03-17 17:59:01', '::1');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_sender` (`sender_id`),
  ADD KEY `fk_receiver` (`receiver_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `phone` (`phone`);

--
-- Indexes for table `user_activity_logs`
--
ALTER TABLE `user_activity_logs`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `user_activity_logs`
--
ALTER TABLE `user_activity_logs`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `fk_receiver` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_sender` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
