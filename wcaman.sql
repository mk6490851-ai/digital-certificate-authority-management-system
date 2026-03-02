-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 05, 2025 at 11:46 AM
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
-- Database: `wcaman`
--

-- --------------------------------------------------------

--
-- Table structure for table `audit_logs`
--

CREATE TABLE `audit_logs` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `action` varchar(100) NOT NULL,
  `details` text NOT NULL,
  `timestamp` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `audit_logs`
--

INSERT INTO `audit_logs` (`id`, `username`, `action`, `details`, `timestamp`) VALUES
(28, 'moazam', 'USER_LOGIN', 'User moazam logged in', '2025-09-29 17:11:22'),
(29, 'moazam', 'SUPPORT_MESSAGE_SENT', 'User moazam sent support message (ID=6): \"hello\"', '2025-09-29 17:12:24'),
(30, 'moazam', 'USER_LOGOUT', 'USER moazam logged out', '2025-09-29 17:13:12'),
(31, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-09-29 17:13:54'),
(32, 'ali', 'SUPPORT_MESSAGE_REPLIED', 'Manager ali replied to moazam\'s message (ID=6): \"hi\"', '2025-09-29 17:16:48'),
(33, 'omer', 'STAFF_LOGIN', 'Staff omer logged in (ADMIN)', '2025-09-29 17:18:22'),
(34, 'omer', 'USER_ADDED', 'Admin omer added new USER: kashan', '2025-09-29 17:20:17'),
(35, 'omer', 'USER_ADDED', 'Admin omer added new ADMIN: test', '2025-09-29 17:24:17'),
(36, 'omer', 'USER_LOGOUT', 'ADMIN omer logged out', '2025-09-29 17:26:10'),
(37, 'omer', 'STAFF_LOGIN', 'Staff omer logged in (ADMIN)', '2025-09-30 00:06:48'),
(38, 'omer', 'USER_LOGOUT', 'ADMIN omer logged out', '2025-09-30 00:07:54'),
(39, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-09-30 00:08:07'),
(40, 'omer', 'STAFF_LOGIN', 'Staff omer logged in (ADMIN)', '2025-09-30 00:16:08'),
(41, 'omer', 'USER_LOGOUT', 'ADMIN omer logged out', '2025-09-30 00:16:58'),
(42, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-09-30 00:21:54'),
(43, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-09-30 14:22:09'),
(44, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-09-30 15:11:32'),
(45, 'ali', 'LOGIN', 'CA_MANAGER logged in', '2025-09-30 15:37:16'),
(46, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-09-30 15:47:16'),
(47, 'moazam', 'USER_LOGIN', 'User moazam logged in', '2025-10-01 12:27:06'),
(48, 'moazam', 'USER_LOGOUT', 'USER moazam logged out', '2025-10-01 12:27:35'),
(49, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-01 12:28:35'),
(50, 'omer', 'STAFF_LOGIN', 'Staff omer logged in (ADMIN)', '2025-10-01 12:30:46'),
(51, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-01 16:33:39'),
(52, 'ali', 'USER_LOGOUT', 'CA_MANAGER ali logged out', '2025-10-01 16:33:45'),
(53, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-01 16:42:21'),
(54, 'ali', 'USER_LOGOUT', 'CA_MANAGER ali logged out', '2025-10-01 16:45:55'),
(55, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-01 16:54:01'),
(56, 'ali', 'USER_LOGOUT', 'CA_MANAGER ali logged out', '2025-10-01 16:56:58'),
(57, 'omer', 'STAFF_LOGIN', 'Staff omer logged in (ADMIN)', '2025-10-01 16:57:37'),
(58, 'omer', 'USER_ADDED', 'Admin omer added new CA_MANAGER: ayan', '2025-10-01 17:20:53'),
(59, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-01 23:48:15'),
(60, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-02 02:09:52'),
(61, 'ali', 'USER_LOGOUT', 'CA_MANAGER ali logged out', '2025-10-02 02:11:31'),
(62, 'kashan', 'USER_LOGIN', 'User kashan logged in', '2025-10-03 16:24:06'),
(63, 'kashan', 'REQUEST_SUBMITTED', 'User kashan submitted a new certificate request (subject=uit.com.pk)', '2025-10-03 16:24:40'),
(64, 'kashan', 'USER_LOGOUT', 'USER kashan logged out', '2025-10-03 16:25:00'),
(65, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-03 16:25:32'),
(66, 'ali', 'REQUEST_REJECTED', 'Manager ali rejected certificate request (id=10, subject=uit.com.pk, user=kashan)', '2025-10-03 16:26:29'),
(67, 'kashan', 'USER_LOGIN', 'User kashan logged in', '2025-10-03 16:38:10'),
(68, 'kashan', 'REQUEST_SUBMITTED', 'User kashan submitted a new certificate request (subject=vuit.vom)', '2025-10-03 16:38:31'),
(69, 'kashan', 'USER_LOGOUT', 'USER kashan logged out', '2025-10-03 16:38:38'),
(70, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-03 16:39:20'),
(71, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-03 17:06:05'),
(72, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-03 17:18:41'),
(73, 'kashan', 'USER_LOGIN', 'User kashan logged in', '2025-10-03 18:29:54'),
(74, 'kashan', 'USER_LOGOUT', 'USER kashan logged out', '2025-10-03 18:30:19'),
(75, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-03 18:30:48'),
(76, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-03 19:23:21'),
(77, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-03 19:41:38'),
(78, 'ali', 'CERT_REVOKED', 'Manager ali revoked certificate (Serial=182221698960449267078727901481657097241, Owner=vuit.vom)', '2025-10-03 19:42:17'),
(79, 'ali', 'USER_LOGOUT', 'CA_MANAGER ali logged out', '2025-10-03 21:19:09'),
(80, 'omer', 'STAFF_LOGIN', 'Staff omer logged in (ADMIN)', '2025-10-03 21:19:21'),
(81, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-03 22:45:04'),
(82, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-03 22:48:25'),
(83, 'kashan', 'USER_LOGIN', 'User kashan logged in', '2025-10-03 22:56:52'),
(84, 'kashan', 'REQUEST_SUBMITTED', 'User kashan submitted a new certificate request (subject=kashan)', '2025-10-03 22:57:12'),
(85, 'kashan', 'USER_LOGOUT', 'USER kashan logged out', '2025-10-03 22:57:37'),
(86, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-03 22:58:10'),
(87, 'ali', 'CERT_ISSUED', 'Manager ali issued a certificate (subject=kashan) for user kashan', '2025-10-03 22:58:53'),
(88, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-03 23:36:44'),
(89, 'ali', 'USER_LOGOUT', 'CA_MANAGER ali logged out', '2025-10-03 23:39:55'),
(90, 'kashan', 'USER_LOGIN', 'User kashan logged in', '2025-10-03 23:41:07'),
(91, 'kashan', 'REQUEST_SUBMITTED', 'User kashan submitted a new certificate request (subject=amigo.chigo)', '2025-10-03 23:41:32'),
(92, 'kashan', 'USER_LOGOUT', 'USER kashan logged out', '2025-10-03 23:41:47'),
(93, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-03 23:42:16'),
(94, 'ali', 'REQUEST_REJECTED', 'Manager ali rejected certificate request (id=13, subject=amigo.chigo, user=kashan)', '2025-10-03 23:45:11'),
(95, 'moazam', 'USER_LOGIN', 'User moazam logged in', '2025-10-04 00:13:28'),
(96, 'moazam', 'REQUEST_SUBMITTED', 'User moazam submitted a new certificate request (subject=webinar)', '2025-10-04 00:13:56'),
(97, 'moazam', 'USER_LOGOUT', 'USER moazam logged out', '2025-10-04 00:14:06'),
(98, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-04 00:14:39'),
(99, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-04 00:17:46'),
(100, 'ali', 'CERT_ISSUED', 'Manager ali issued a certificate (subject=webinar) for user moazam', '2025-10-04 00:17:57'),
(101, 'moazam', 'USER_LOGIN', 'User moazam logged in', '2025-10-04 01:07:53'),
(102, 'moazam', 'REQUEST_SUBMITTED', 'User moazam submitted a new certificate request (subject=koka)', '2025-10-04 01:08:04'),
(103, 'moazam', 'USER_LOGOUT', 'USER moazam logged out', '2025-10-04 01:08:24'),
(104, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-04 01:08:56'),
(105, 'ali', 'CERT_ISSUED', 'Manager ali issued a certificate (subject=koka) for user moazam', '2025-10-04 01:09:07'),
(106, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-04 16:21:21'),
(107, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-04 16:32:58'),
(108, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-04 16:32:59'),
(109, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-04 16:36:48'),
(110, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-04 16:41:58'),
(111, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-04 16:50:12'),
(112, 'ali', 'CERT_RENEWED', 'Manager ali renewed certificate (Serial=245362692888380830870050200721757054066, Owner=webinar)', '2025-10-04 16:50:19'),
(113, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-04 17:04:23'),
(114, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-04 17:08:41'),
(115, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-04 17:15:50'),
(116, 'ali', 'CERT_RENEWED', 'Manager ali renewed certificate (Serial=39584062002171689863097345991664668391, Owner=amigo.chigo)', '2025-10-04 17:16:14'),
(117, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-04 17:24:08'),
(118, 'ali', 'CERT_RENEWED', 'Manager ali renewed certificate (OldFile=webinar.crt, NewFile=webinar-renewed.crt, Owner=webinar)', '2025-10-04 17:24:28'),
(119, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-04 17:30:17'),
(120, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-04 17:34:42'),
(121, 'ali', 'CERT_REVOKED', 'Manager ali revoked certificate (Serial=161171122146187726352603081179611555014, Owner=koka)', '2025-10-04 17:35:12'),
(122, 'ali', 'CERT_REVOKED', 'Manager ali revoked certificate (Serial=286577672582991943331015845535355849282, Owner=webinar)', '2025-10-04 17:52:27'),
(123, 'ali', 'USER_LOGOUT', 'CA_MANAGER ali logged out', '2025-10-04 17:53:16'),
(124, 'osama', 'USER_REGISTERED', 'New user registered: osama', '2025-10-04 17:54:21'),
(125, 'osama', 'USER_LOGIN', 'User osama logged in', '2025-10-04 17:54:43'),
(126, 'osama', 'REQUEST_SUBMITTED', 'User osama submitted a new certificate request (subject=osama)', '2025-10-04 17:54:56'),
(127, 'osama', 'USER_LOGOUT', 'USER osama logged out', '2025-10-04 17:55:02'),
(128, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-04 17:55:35'),
(129, 'ali', 'CERT_ISSUED', 'Manager ali issued a certificate (subject=osama) for user osama', '2025-10-04 17:55:47'),
(130, 'ali', 'USER_LOGOUT', 'CA_MANAGER ali logged out', '2025-10-04 18:11:52'),
(131, 'moazam', 'USER_LOGIN', 'User moazam logged in', '2025-10-04 22:06:45'),
(132, 'moazam', 'CERT_DOWNLOADED', 'User moazam downloaded certificate (File=koka.crt, ID=63)', '2025-10-04 22:07:27'),
(133, 'moazam', 'REQUEST_SUBMITTED', 'User moazam submitted a new certificate request (subject=Ali)', '2025-10-04 22:12:41'),
(134, 'moazam', 'USER_LOGOUT', 'USER moazam logged out', '2025-10-04 22:12:49'),
(135, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-04 22:13:16'),
(136, 'ali', 'CERT_ISSUED', 'Manager ali issued a certificate (subject=Ali) for user moazam', '2025-10-04 22:13:25'),
(137, 'ali', 'USER_LOGOUT', 'CA_MANAGER ali logged out', '2025-10-04 22:19:14'),
(138, 'moazam', 'USER_LOGIN', 'User moazam logged in', '2025-10-04 22:20:34'),
(139, 'moazam', 'REQUEST_SUBMITTED', 'User moazam submitted a new certificate request (subject=Ali)', '2025-10-04 22:20:50'),
(140, 'moazam', 'USER_LOGOUT', 'USER moazam logged out', '2025-10-04 22:21:12'),
(141, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-04 22:21:39'),
(142, 'ali', 'CERT_ISSUED', 'Manager ali issued a certificate (subject=Ali) for user moazam', '2025-10-04 22:21:48'),
(143, 'moazam', 'USER_LOGIN', 'User moazam logged in', '2025-10-05 14:01:03'),
(144, 'moazam', 'REQUEST_SUBMITTED', 'User moazam submitted a new certificate request (subject=hamza)', '2025-10-05 14:01:31'),
(145, 'moazam', 'USER_LOGOUT', 'USER moazam logged out', '2025-10-05 14:01:40'),
(146, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-05 14:02:14'),
(147, 'ali', 'USER_LOGOUT', 'CA_MANAGER ali logged out', '2025-10-05 14:04:53'),
(148, 'moazam', 'USER_LOGIN', 'User moazam logged in', '2025-10-05 14:05:14'),
(149, 'moazam', 'REQUEST_SUBMITTED', 'User moazam submitted a new certificate request (subject=hamza)', '2025-10-05 14:07:10'),
(150, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-05 14:07:48'),
(151, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-05 14:16:52'),
(152, 'ali', 'CERT_ISSUED', 'Manager ali issued certificate for Request #20 (subject=hamza, user=moazam)', '2025-10-05 14:17:02'),
(153, 'ali', 'USER_LOGOUT', 'CA_MANAGER ali logged out', '2025-10-05 14:17:09'),
(154, 'moazam', 'USER_LOGIN', 'User moazam logged in', '2025-10-05 14:17:47'),
(155, 'moazam', 'USER_LOGOUT', 'USER moazam logged out', '2025-10-05 14:20:48'),
(156, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-05 14:21:14'),
(157, 'ali', 'CERT_REVOKED', 'Manager ali revoked certificate (Serial=39346076704678038140165112394159664841, Owner=Ali)', '2025-10-05 14:21:45'),
(158, 'omer', 'STAFF_LOGIN', 'Staff omer logged in (ADMIN)', '2025-10-05 14:26:43'),
(159, 'omer', 'USER_LOGOUT', 'ADMIN omer logged out', '2025-10-05 14:51:31'),
(160, 'moazam', 'USER_LOGIN', 'User moazam logged in', '2025-10-05 14:51:55'),
(161, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-06 13:36:54'),
(162, 'ali', 'USER_LOGOUT', 'CA_MANAGER ali logged out', '2025-10-06 13:37:03'),
(163, 'omer', 'STAFF_LOGIN', 'Staff omer logged in (ADMIN)', '2025-10-06 13:37:39'),
(164, 'omer', 'USER_LOGOUT', 'ADMIN omer logged out', '2025-10-06 13:40:17'),
(165, 'zaki', 'USER_REGISTERED', 'New user registered: zaki', '2025-10-06 13:42:26'),
(166, 'zaki', 'USER_LOGIN', 'User zaki logged in', '2025-10-06 13:42:48'),
(167, 'zaki', 'REQUEST_SUBMITTED', 'User zaki submitted a new certificate request (subject=zaki)', '2025-10-06 13:44:27'),
(168, 'zaki', 'SUPPORT_MESSAGE_SENT', 'User zaki sent support message (ID=7): \"plz approve my certificate\"', '2025-10-06 13:45:44'),
(169, 'zaki', 'USER_LOGOUT', 'USER zaki logged out', '2025-10-06 13:46:02'),
(170, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-06 13:47:27'),
(171, 'ali', 'CERT_ISSUED', 'Manager ali issued certificate for Request #21 (subject=zaki, user=zaki)', '2025-10-06 13:47:49'),
(172, 'ali', 'SUPPORT_MESSAGE_REPLIED', 'Manager ali replied to zaki\'s message (ID=7): \"your certificate is approved\"', '2025-10-06 13:49:47'),
(173, 'ali', 'USER_LOGOUT', 'CA_MANAGER ali logged out', '2025-10-06 13:54:28'),
(174, 'zaki', 'USER_LOGIN', 'User zaki logged in', '2025-10-06 13:55:07'),
(175, 'zaki', 'CERT_DOWNLOADED', 'User zaki downloaded certificate (File=zaki.crt, ID=79)', '2025-10-06 13:55:54'),
(176, 'zaki', 'USER_LOGOUT', 'USER zaki logged out', '2025-10-06 13:56:52'),
(177, 'omer', 'STAFF_LOGIN', 'Staff omer logged in (ADMIN)', '2025-10-06 13:59:21'),
(178, 'zaki', 'PASSWORD_RESET', 'User zaki reset their password', '2025-10-07 13:28:44'),
(179, 'zaki', 'USER_LOGIN', 'zaki logged in successfully', '2025-10-07 13:29:19'),
(180, 'mkhan', 'STAFF_REGISTERED', 'New staff registered: mkhan (ADMIN)', '2025-10-07 15:16:51'),
(181, 'mkhan', 'STAFF_PASSWORD_RESET_REQUEST', 'Password reset email sent to mk6490851@gmail.com', '2025-10-07 15:17:15'),
(182, 'mkhan', 'STAFF_PASSWORD_RESET_REQUEST', 'Password reset email sent to mk6490851@gmail.com', '2025-10-07 15:21:49'),
(183, 'mkhan', 'STAFF_PASSWORD_RESET_REQUEST', 'Password reset email sent to mk6490851@gmail.com', '2025-10-07 16:01:34'),
(184, 'mkhan', 'STAFF_PASSWORD_RESET_SUCCESS', 'Staff mkhan reset their password successfully', '2025-10-07 16:02:39'),
(185, 'mkhan', 'STAFF_LOGIN', 'Staff mkhan logged in (ADMIN)', '2025-10-07 16:03:47'),
(186, 'hasan', 'STAFF_REGISTERED', 'New staff registered: hasan (CA_MANAGER)', '2025-10-07 16:31:31'),
(187, 'hasan', 'STAFF_PASSWORD_RESET_REQUEST', 'Password reset email sent to moazamk06@gmail.com', '2025-10-07 16:32:00'),
(188, 'hasan', 'STAFF_PASSWORD_RESET_REQUEST', 'Password reset email sent to moazamk06@gmail.com', '2025-10-07 16:48:53'),
(189, 'zaki', 'STAFF_REGISTERED', 'New staff registered: zaki (ADMIN)', '2025-10-07 17:19:05'),
(190, 'zaki', 'STAFF_LOGIN', 'Staff zaki logged in (ADMIN)', '2025-10-07 17:19:24'),
(191, 'zaki', 'USER_LOGOUT', 'zaki logged out', '2025-10-07 17:19:57'),
(192, 'zaki', 'STAFF_PASSWORD_RESET_REQUEST', 'Password reset email sent to zaki@auhtech.com', '2025-10-07 17:20:52'),
(193, 'hasan', 'STAFF_PASSWORD_RESET_REQUEST', 'Password reset email sent to moazamk06@gmail.com', '2025-10-07 17:58:14'),
(194, 'bc200408672@vu.edu.pk', 'STAFF_OTP_SENT', 'OTP sent to bc200408672@vu.edu.pk', '2025-10-07 22:09:46'),
(195, 'bc200408672@vu.edu.pk', 'STAFF_OTP_SENT', 'OTP sent to bc200408672@vu.edu.pk', '2025-10-07 22:09:49'),
(199, 'Usman', 'STAFF_REGISTERED', 'New staff registered: Usman (ADMIN)', '2025-10-07 22:11:26'),
(200, 'Usman', 'STAFF_LOGIN', 'Staff Usman logged in (ADMIN)', '2025-10-07 22:12:50'),
(201, 'Usman', 'USER_LOGOUT', 'Usman logged out', '2025-10-07 22:20:25'),
(202, 'mkashankhan2004@gmail.com', 'STAFF_OTP_SENT', 'OTP sent to mkashankhan2004@gmail.com', '2025-10-07 23:23:55'),
(205, 'hafsa6591@gmail.com', 'STAFF_OTP_SENT', 'OTP sent to hafsa6591@gmail.com', '2025-10-08 09:50:54'),
(206, 'hafsa', 'STAFF_REGISTERED', 'New staff registered: hafsa (ADMIN)', '2025-10-08 09:51:39'),
(207, 'hafsa', 'STAFF_PASSWORD_RESET_REQUEST', 'Password reset email sent to hafsa6591@gmail.com', '2025-10-08 09:52:14'),
(210, 'hafsa', 'STAFF_LOGIN', 'Staff hafsa logged in (ADMIN)', '2025-10-08 10:11:59'),
(211, 'hafsa', 'USER_LOGOUT', 'hafsa logged out', '2025-10-08 10:18:00'),
(213, 'far.ja1976@gmail.com', 'STAFF_OTP_SENT', 'OTP sent to far.ja1976@gmail.com', '2025-10-08 10:21:25'),
(214, 'farhat', 'STAFF_REGISTERED', 'New staff registered: farhat (ADMIN)', '2025-10-08 10:23:10'),
(215, 'farhat', 'STAFF_PASSWORD_RESET_REQUEST', 'Password reset email sent to far.ja1976@gmail.com', '2025-10-08 10:24:02'),
(216, 'moazam', 'USER_LOGIN', 'moazam logged in successfully', '2025-10-08 12:29:06'),
(217, 'moazam', 'USER_LOGIN', 'moazam logged in successfully', '2025-10-08 13:18:14'),
(218, 'moazam', 'USER_DASHBOARD_VIEWED', 'User opened dashboard', '2025-10-08 13:18:14'),
(219, 'moazam', 'USER_DASHBOARD_VIEWED', 'User opened dashboard', '2025-10-08 13:25:22'),
(220, 'moazam', 'USER_DASHBOARD_VIEWED', 'User opened dashboard', '2025-10-08 13:25:52'),
(221, 'moazam', 'USER_DASHBOARD_VIEWED', 'User opened dashboard', '2025-10-08 13:39:49'),
(222, 'moazam', 'USER_DASHBOARD_VIEWED', 'User opened dashboard', '2025-10-08 13:40:14'),
(223, 'moazam', 'USER_DASHBOARD_VIEWED', 'User opened dashboard', '2025-10-08 13:43:25'),
(224, 'moazam', 'USER_DASHBOARD_VIEWED', 'User opened dashboard', '2025-10-08 13:46:56'),
(225, 'moazam', 'USER_DASHBOARD_VIEWED', 'User opened dashboard', '2025-10-08 13:46:58'),
(226, 'moazam', 'USER_DASHBOARD_VIEWED', 'User opened dashboard', '2025-10-08 13:49:48'),
(227, 'moazam', 'USER_DASHBOARD_VIEWED', 'User opened dashboard', '2025-10-08 13:50:32'),
(228, 'moazam', 'USER_DASHBOARD_VIEWED', 'User opened dashboard', '2025-10-08 13:51:56'),
(229, 'moazam', 'USER_DASHBOARD_VIEWED', 'User opened dashboard', '2025-10-08 13:52:18'),
(230, 'moazam', 'USER_DASHBOARD_VIEWED', 'User opened dashboard', '2025-10-08 13:53:29'),
(231, 'moazam', 'USER_DASHBOARD_VIEWED', 'User opened dashboard', '2025-10-08 13:56:36'),
(232, 'moazam', 'USER_DASHBOARD_VIEWED', 'User opened dashboard', '2025-10-08 13:57:58'),
(233, 'zaki', 'STAFF_LOGIN', 'Staff zaki logged in (ADMIN)', '2025-10-08 14:41:15'),
(234, 'zaki', 'ADMIN_DASHBOARD_VIEWED', 'Admin opened dashboard', '2025-10-08 14:41:15'),
(235, 'zaki', 'USER_LOGOUT', 'zaki logged out', '2025-10-08 14:42:15'),
(236, 'zakikhan7980@gmail.com', 'STAFF_OTP_SENT', 'OTP sent to zakikhan7980@gmail.com', '2025-10-08 14:45:32'),
(237, 'Z1', 'STAFF_REGISTERED', 'New staff registered: Z1 (CA_MANAGER)', '2025-10-08 14:46:14'),
(238, 'Z1', 'STAFF_LOGIN', 'Staff Z1 logged in (CA_MANAGER)', '2025-10-08 14:46:37'),
(239, 'Z1', 'MANAGER_DASHBOARD_VIEWED', 'Manager opened dashboard', '2025-10-08 14:46:37'),
(240, 'moazam', 'USER_LOGIN', 'moazam logged in successfully', '2025-10-08 14:53:13'),
(241, 'moazam', 'USER_DASHBOARD_VIEWED', 'User opened dashboard', '2025-10-08 14:53:13'),
(242, 'moazam', 'USER_DASHBOARD_VIEWED', 'User opened dashboard', '2025-10-08 14:54:07'),
(243, 'moazam', 'REQUEST_SUBMITTED', 'User moazam submitted a new certificate request (subject=AUH)', '2025-10-08 14:59:55'),
(244, 'moazam', 'USER_DASHBOARD_VIEWED', 'User opened dashboard', '2025-10-08 14:59:55'),
(245, 'moazam', 'USER_LOGOUT', 'moazam logged out', '2025-10-08 15:00:15'),
(246, 'Z1', 'STAFF_LOGIN', 'Staff Z1 logged in (CA_MANAGER)', '2025-10-08 15:01:21'),
(247, 'Z1', 'MANAGER_DASHBOARD_VIEWED', 'Manager opened dashboard', '2025-10-08 15:01:21'),
(248, 'Z1', 'STAFF_LOGIN', 'Staff Z1 logged in (CA_MANAGER)', '2025-10-08 15:06:00'),
(249, 'Z1', 'MANAGER_DASHBOARD_VIEWED', 'Manager opened dashboard', '2025-10-08 15:06:00'),
(250, 'Z1', 'CERT_ISSUED', 'Manager Z1 issued a certificate (subject=AUH) for user moazam', '2025-10-08 15:06:27'),
(251, 'Z1', 'MANAGER_DASHBOARD_VIEWED', 'Manager opened dashboard', '2025-10-08 15:06:27'),
(252, 'moazam', 'USER_LOGIN', 'moazam logged in successfully', '2025-10-08 15:19:53'),
(253, 'moazam', 'USER_DASHBOARD_VIEWED', 'User opened dashboard', '2025-10-08 15:19:53'),
(254, 'moazam', 'REQUEST_SUBMITTED', 'User moazam submitted a new certificate request (subject=XYZ)', '2025-10-08 15:20:56'),
(255, 'moazam', 'USER_DASHBOARD_VIEWED', 'User opened dashboard', '2025-10-08 15:20:56'),
(256, 'moazam', 'USER_LOGOUT', 'moazam logged out', '2025-10-08 15:21:24'),
(257, 'Z1', 'STAFF_LOGIN', 'Staff Z1 logged in (CA_MANAGER)', '2025-10-08 15:21:59'),
(258, 'Z1', 'MANAGER_DASHBOARD_VIEWED', 'Manager opened dashboard', '2025-10-08 15:21:59'),
(259, 'Z1', 'CERT_ISSUED', 'Manager Z1 issued a certificate (subject=XYZ) for user moazam', '2025-10-08 15:22:12'),
(260, 'Z1', 'MANAGER_DASHBOARD_VIEWED', 'Manager opened dashboard', '2025-10-08 15:22:12'),
(261, 'moazam', 'USER_LOGIN', 'moazam logged in successfully', '2025-10-08 15:30:59'),
(262, 'moazam', 'USER_DASHBOARD_VIEWED', 'User opened dashboard', '2025-10-08 15:30:59'),
(263, 'moazam', 'REQUEST_SUBMITTED', 'User moazam submitted a new certificate request (subject=240)', '2025-10-08 15:31:30'),
(264, 'moazam', 'USER_DASHBOARD_VIEWED', 'User opened dashboard', '2025-10-08 15:31:30'),
(265, 'moazam', 'USER_LOGOUT', 'moazam logged out', '2025-10-08 15:31:49'),
(266, 'Z1', 'STAFF_LOGIN', 'Staff Z1 logged in (CA_MANAGER)', '2025-10-08 15:32:25'),
(267, 'Z1', 'MANAGER_DASHBOARD_VIEWED', 'Manager opened dashboard', '2025-10-08 15:32:26'),
(268, 'Z1', 'CERT_ISSUED', 'Manager Z1 issued certificate for Request #24 (subject=240, user=moazam)', '2025-10-08 15:32:39'),
(269, 'Z1', 'MANAGER_DASHBOARD_VIEWED', 'Manager opened dashboard', '2025-10-08 15:32:39'),
(270, 'Z1', 'USER_LOGOUT', 'Z1 logged out', '2025-10-08 15:33:05'),
(271, 'moazam', 'USER_LOGIN', 'moazam logged in successfully', '2025-10-08 15:33:24'),
(272, 'moazam', 'USER_DASHBOARD_VIEWED', 'User opened dashboard', '2025-10-08 15:33:24'),
(273, 'moazam', 'USER_LOGOUT', 'moazam logged out', '2025-10-08 15:34:04'),
(274, 'Z1', 'STAFF_PASSWORD_RESET_REQUEST', 'Password reset email sent to zakikhan7980@gmail.com', '2025-10-08 15:34:53'),
(275, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-08 21:08:31'),
(276, 'ali', 'MANAGER_DASHBOARD_VIEWED', 'Manager opened dashboard', '2025-10-08 21:08:31'),
(277, 'mk6490851@gmail.com', 'STAFF_OTP_SENT', 'OTP sent to mk6490851@gmail.com', '2025-10-08 22:28:53'),
(278, 'mkhan', 'STAFF_REGISTERED', 'New staff registered: mkhan (ADMIN)', '2025-10-08 22:29:30'),
(279, 'mkhan', 'STAFF_PASSWORD_RESET_REQUEST', 'Password reset email sent to mk6490851@gmail.com', '2025-10-08 22:29:57'),
(280, 'mkhan', 'STAFF_PASSWORD_RESET_SUCCESS', 'Staff mkhan reset their password successfully', '2025-10-08 22:30:53'),
(281, 'mkhan', 'STAFF_LOGIN', 'Staff mkhan logged in (ADMIN)', '2025-10-08 22:31:29'),
(282, 'hafsa', 'STAFF_PASSWORD_RESET_REQUEST', 'Password reset email sent to hafsa6591@gmail.com', '2025-10-09 12:00:30'),
(283, 'hafsa', 'STAFF_PASSWORD_RESET_SUCCESS', 'Staff hafsa reset their password successfully', '2025-10-09 12:04:14'),
(284, 'hafsa', 'STAFF_LOGIN', 'Staff hafsa logged in (ADMIN)', '2025-10-09 12:06:58'),
(285, 'hafsa', 'USER_LOGOUT', 'ADMIN hafsa logged out', '2025-10-09 12:29:36'),
(286, 'hafsa', 'STAFF_PASSWORD_RESET_REQUEST', 'Password reset email sent to hafsa6591@gmail.com', '2025-10-09 12:29:56'),
(287, 'hafsa', 'STAFF_PASSWORD_RESET_SUCCESS', 'Staff hafsa reset their password successfully', '2025-10-09 12:31:39'),
(288, 'hafsa', 'STAFF_LOGIN', 'Staff hafsa logged in (ADMIN)', '2025-10-09 12:32:34'),
(289, 'hafsa', 'USER_LOGOUT', 'ADMIN hafsa logged out', '2025-10-09 12:34:24'),
(290, 'moazam', 'USER_LOGIN', 'User moazam logged in', '2025-10-09 12:35:20'),
(291, 'moazam', 'USER_LOGIN', 'User moazam logged in', '2025-10-09 12:37:00'),
(292, 'farhat', 'STAFF_PASSWORD_RESET_REQUEST', 'Password reset email sent to far.ja1976@gmail.com', '2025-10-09 12:39:02'),
(293, 'farhat', 'STAFF_PASSWORD_RESET_SUCCESS', 'Staff farhat reset their password successfully', '2025-10-09 12:40:33'),
(294, 'farhat', 'STAFF_LOGIN', 'Staff farhat logged in (ADMIN)', '2025-10-09 12:43:02'),
(295, 'farhat', 'USER_LOGOUT', 'ADMIN farhat logged out', '2025-10-09 12:47:21'),
(296, 'hafsa', 'STAFF_PASSWORD_RESET_REQUEST', 'Password reset email sent to hafsa6591@gmail.com', '2025-10-09 13:01:52'),
(297, 'hafsa', 'STAFF_PASSWORD_RESET_SUCCESS', 'Staff hafsa reset their password successfully', '2025-10-09 13:02:48'),
(298, 'farhat', 'STAFF_PASSWORD_RESET_REQUEST', 'Password reset email sent to far.ja1976@gmail.com', '2025-10-09 13:04:55'),
(299, 'farhat', 'STAFF_PASSWORD_RESET_SUCCESS', 'Staff farhat reset their password successfully', '2025-10-09 13:05:39'),
(300, 'farhat', 'STAFF_LOGIN', 'Staff farhat logged in (ADMIN)', '2025-10-09 13:06:33'),
(301, 'farhat', 'STAFF_PASSWORD_RESET_REQUEST', 'Password reset email sent to far.ja1976@gmail.com', '2025-10-09 13:13:49'),
(302, 'hafsa', 'STAFF_PASSWORD_RESET_REQUEST', 'Password reset email sent to hafsa6591@gmail.com', '2025-10-09 13:17:48'),
(303, 'hafsa', 'STAFF_PASSWORD_RESET_SUCCESS', 'Staff hafsa reset their password successfully', '2025-10-09 13:18:28'),
(304, 'hafsa', 'STAFF_PASSWORD_RESET_REQUEST', 'Password reset email sent to hafsa6591@gmail.com', '2025-10-09 13:19:15'),
(305, 'hafsa', 'STAFF_PASSWORD_RESET_SUCCESS', 'Staff hafsa reset their password successfully', '2025-10-09 13:19:40'),
(306, 'hafsa', 'STAFF_PASSWORD_RESET_REQUEST', 'Password reset email sent to hafsa6591@gmail.com', '2025-10-09 13:25:45'),
(307, 'hafsa', 'STAFF_PASSWORD_RESET_SUCCESS', 'Staff hafsa reset their password successfully', '2025-10-09 13:26:09'),
(308, 'omer', 'STAFF_LOGIN', 'Staff omer logged in (ADMIN)', '2025-10-09 14:11:14'),
(309, 'omer', 'USER_LOGOUT', 'ADMIN omer logged out', '2025-10-09 14:23:20'),
(310, 'mkhan', 'STAFF_PASSWORD_RESET_REQUEST', 'Password reset email sent to mk6490851@gmail.com', '2025-10-09 14:26:02'),
(311, 'mkhan', 'STAFF_PASSWORD_RESET_SUCCESS', 'Staff mkhan reset their password successfully', '2025-10-09 14:26:32'),
(312, 'mkhan', 'STAFF_LOGIN', 'Staff mkhan logged in (ADMIN)', '2025-10-09 14:26:48'),
(313, 'mkhan', 'USER_LOGOUT', 'ADMIN mkhan logged out', '2025-10-09 14:29:00'),
(314, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-09 14:29:15'),
(315, 'Z1', 'STAFF_PASSWORD_RESET_REQUEST', 'Password reset email sent to zakikhan7980@gmail.com', '2025-10-09 16:57:27'),
(316, 'Z1', 'STAFF_PASSWORD_RESET_SUCCESS', 'Staff Z1 reset their password successfully', '2025-10-09 16:58:28'),
(317, 'Z1', 'STAFF_LOGIN', 'Staff Z1 logged in (CA_MANAGER)', '2025-10-09 16:58:51'),
(318, 'Z1', 'USER_LOGOUT', 'CA_MANAGER Z1 logged out', '2025-10-09 16:59:40'),
(319, 'moazam', 'USER_LOGIN', 'User moazam logged in', '2025-10-09 17:00:36'),
(320, 'moazam', 'SUPPORT_MESSAGE_SENT', 'User moazam sent support message (ID=8): \"Hello g\"', '2025-10-09 17:02:13'),
(321, 'moazam', 'SUPPORT_MESSAGE_SENT', 'User moazam sent support message (ID=9): \"Hello 123\"', '2025-10-09 17:03:08'),
(322, 'moazam', 'USER_LOGOUT', 'USER moazam logged out', '2025-10-09 17:03:41'),
(323, 'Z1', 'STAFF_PASSWORD_RESET_REQUEST', 'Password reset email sent to zakikhan7980@gmail.com', '2025-10-09 17:09:47'),
(324, 'omer', 'STAFF_LOGIN', 'Staff omer logged in (ADMIN)', '2025-10-09 17:11:14'),
(325, 'Z1', 'STAFF_PASSWORD_RESET_REQUEST', 'Password reset email sent to zakikhan7980@gmail.com', '2025-10-09 17:15:09'),
(326, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-09 17:15:59'),
(327, 'ali', 'USER_LOGOUT', 'CA_MANAGER ali logged out', '2025-10-09 17:19:33'),
(328, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-09 17:20:08'),
(329, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-09 17:20:37'),
(330, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-09 17:21:18'),
(331, 'ali', 'SUPPORT_MESSAGE_REPLIED', 'Manager ali replied to moazam\'s message (ID=9): \"Hhhhhh\"', '2025-10-09 17:22:02'),
(332, 'ali', 'SUPPORT_MESSAGE_REPLIED', 'Manager ali replied to moazam\'s message (ID=2): \"Hhhhhhhjh\"', '2025-10-09 17:22:22'),
(333, 'ali', 'SUPPORT_MESSAGE_REPLIED', 'Manager ali replied to moazam\'s message (ID=2): \"Hhhhhhhjh\"', '2025-10-09 17:22:24'),
(334, 'ali', 'USER_LOGOUT', 'CA_MANAGER ali logged out', '2025-10-09 17:22:47'),
(335, 'kashan', 'PASSWORD_RESET', 'User kashan reset their password', '2025-10-09 22:44:50'),
(336, 'kashan', 'USER_LOGIN', 'User kashan logged in', '2025-10-09 22:45:21'),
(337, 'kashan', 'REQUEST_SUBMITTED', 'User kashan submitted a new certificate request (subject=test@example..com)', '2025-10-09 22:45:43'),
(338, 'kashan', 'USER_LOGOUT', 'USER kashan logged out', '2025-10-09 22:46:11'),
(339, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-09 22:46:44'),
(340, 'moazam', 'USER_LOGIN', 'User moazam logged in', '2025-10-09 22:47:55'),
(341, 'zaki', 'USER_REGISTERED', 'New user registered: zaki', '2025-10-09 23:35:46'),
(342, 'zaki', 'USER_LOGIN', 'User zaki logged in', '2025-10-09 23:36:07'),
(343, 'zaki', 'USER_LOGIN', 'User zaki logged in', '2025-10-09 23:43:41'),
(344, 'zaki', 'USER_LOGIN', 'User zaki logged in', '2025-10-09 23:48:03'),
(345, 'omer', 'STAFF_LOGIN', 'Staff omer logged in (ADMIN)', '2025-10-11 00:55:44'),
(346, 'omer', 'USER_DELETED', 'Admin omer deleted user/staff: test', '2025-10-11 00:56:11'),
(347, 'moazam', 'USER_LOGIN', 'User moazam logged in', '2025-10-11 01:07:23'),
(348, 'mk6490851@gmail.com', 'STAFF_OTP_SENT', 'OTP sent to mk6490851@gmail.com', '2025-10-11 01:30:08'),
(349, 'haseeb', 'STAFF_REGISTERED', 'New staff registered: haseeb (ADMIN)', '2025-10-11 01:31:06'),
(350, 'haseeb', 'STAFF_LOGIN', 'Staff haseeb logged in (ADMIN)', '2025-10-11 01:31:38'),
(351, 'haseeb', 'STAFF_PASSWORD_RESET_REQUEST', 'Password reset email sent to mk6490851@gmail.com', '2025-10-11 01:33:00'),
(352, 'Z1', 'STAFF_PASSWORD_RESET_REQUEST', 'Password reset email sent to zakikhan7980@gmail.com', '2025-10-11 12:50:21'),
(353, 'farhat', 'USER_REGISTERED', 'New user registered: farhat', '2025-10-11 13:17:42'),
(354, 'farhat', 'USER_LOGIN', 'User farhat logged in', '2025-10-11 13:18:01'),
(355, 'moazam', 'USER_LOGIN', 'User moazam logged in', '2025-10-12 13:32:32'),
(356, 'moazam', 'USER_LOGOUT', 'USER moazam logged out', '2025-10-12 13:33:08'),
(357, 'omer', 'STAFF_LOGIN', 'Staff omer logged in (ADMIN)', '2025-10-12 13:34:36'),
(358, 'moazam', 'USER_LOGIN', 'User moazam logged in', '2025-10-14 13:06:19'),
(359, 'T1', 'STAFF_REGISTERED', 'New staff registered: T1 (CA_MANAGER)', '2025-10-18 13:44:15'),
(360, 'T1', 'STAFF_LOGIN', 'Staff T1 logged in (CA_MANAGER)', '2025-10-18 13:44:48'),
(361, 'T1', 'CERT_ISSUED', 'Manager T1 issued certificate for Request #25 (subject=test@example..com, user=kashan)', '2025-10-18 13:45:15'),
(362, 'T1', 'CERT_REVOKED', 'Manager T1 revoked certificate (Serial=39868992300637750251484700113855551747, Owner=test@example..com)', '2025-10-18 13:48:23'),
(363, 'T1', 'USER_LOGOUT', 'CA_MANAGER T1 logged out', '2025-10-18 13:50:15'),
(364, 'moazam', 'USER_LOGIN', 'User moazam logged in', '2025-10-18 13:52:15'),
(365, 'moazam', 'USER_LOGOUT', 'USER moazam logged out', '2025-10-18 13:52:59'),
(366, 'omer', 'STAFF_LOGIN', 'Staff omer logged in (ADMIN)', '2025-10-18 13:53:35'),
(367, 'omer', 'USER_LOGOUT', 'ADMIN omer logged out', '2025-10-18 13:54:49'),
(368, 'omer', 'STAFF_LOGIN', 'Staff omer logged in (ADMIN)', '2025-10-18 13:57:05'),
(369, 'omer', 'USER_DELETED', 'Admin omer deleted user/staff: kashan', '2025-10-18 13:57:39'),
(370, 'omer', 'USER_ADDED', 'Admin omer added new USER: kashan', '2025-10-18 13:58:37'),
(371, 'omer', 'USER_LOGOUT', 'ADMIN omer logged out', '2025-10-18 13:58:52'),
(372, 'kashan', 'USER_LOGIN', 'User kashan logged in', '2025-10-18 13:59:23'),
(373, 'kashan', 'USER_LOGIN', 'User kashan logged in', '2025-10-18 14:13:14'),
(374, 'moazam', 'USER_LOGIN', 'User moazam logged in', '2025-10-20 15:53:02'),
(375, 'moazam', 'USER_LOGOUT', 'USER moazam logged out', '2025-10-20 16:30:12'),
(376, 'omer', 'STAFF_LOGIN', 'Staff omer logged in (ADMIN)', '2025-10-20 16:34:25'),
(377, 'omer', 'USER_LOGOUT', 'ADMIN omer logged out', '2025-10-20 17:24:16'),
(378, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-20 17:24:41'),
(379, 'omer', 'STAFF_LOGIN', 'Staff omer logged in (ADMIN)', '2025-10-23 17:27:54'),
(380, 'omer', 'USER_LOGOUT', 'ADMIN omer logged out', '2025-10-23 17:29:49'),
(381, 'zaki', 'USER_LOGIN', 'User zaki logged in', '2025-10-23 17:38:35'),
(382, 'haseeb', 'STAFF_PASSWORD_RESET_REQUEST', 'Password reset email sent to mk6490851@gmail.com', '2025-10-23 19:00:25'),
(383, 'haseeb', 'STAFF_PASSWORD_RESET_REQUEST', 'Password reset email sent to mk6490851@gmail.com', '2025-10-23 19:02:29'),
(384, 'haseeb', 'STAFF_LOGIN', 'Staff haseeb logged in (ADMIN)', '2025-10-23 19:04:07'),
(385, 'haseeb', 'USER_LOGOUT', 'ADMIN haseeb logged out', '2025-10-23 19:04:56'),
(386, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-23 19:05:51'),
(387, 'moazam', 'USER_LOGIN', 'User moazam logged in', '2025-10-23 19:08:30'),
(388, 'zaid', 'USER_REGISTERED', 'New user registered: zaid', '2025-10-24 15:38:33'),
(389, 'Zaid', 'STAFF_REGISTERED', 'New staff registered: Zaid (CA_MANAGER)', '2025-10-24 15:43:21'),
(390, 'Zaid', 'STAFF_LOGIN', 'Staff Zaid logged in (CA_MANAGER)', '2025-10-24 15:48:30'),
(391, 'Zaid', 'USER_LOGOUT', 'CA_MANAGER Zaid logged out', '2025-10-24 15:51:04'),
(392, 'zaid', 'USER_REGISTERED', 'New user registered: zaid', '2025-10-24 15:51:58'),
(393, 'zaid', 'USER_LOGIN', 'User zaid logged in', '2025-10-24 15:52:50'),
(394, 'zaid', 'REQUEST_SUBMITTED', 'User zaid submitted a new certificate request (subject=zaid)', '2025-10-24 15:53:42'),
(395, 'zaid', 'USER_LOGOUT', 'USER zaid logged out', '2025-10-24 15:54:45'),
(396, 'Zaid', 'STAFF_LOGIN', 'Staff Zaid logged in (CA_MANAGER)', '2025-10-24 15:55:16'),
(397, 'Zaid', 'CERT_ISSUED', 'Manager Zaid issued certificate for Request #26 (subject=zaid, user=zaid)', '2025-10-24 15:55:29'),
(398, 'Zaid', 'STAFF_LOGIN', 'Staff Zaid logged in (CA_MANAGER)', '2025-10-24 16:52:40'),
(399, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-28 15:56:16'),
(400, 'ali', 'SUPPORT_MESSAGE_REPLIED', 'Manager ali replied to moazam\'s message (ID=9): \"hi 123\"', '2025-10-28 15:56:39'),
(401, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-28 16:52:50'),
(402, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-28 23:25:37'),
(403, 'ali', 'USER_LOGOUT', 'CA_MANAGER ali logged out', '2025-10-28 23:28:27'),
(404, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-28 23:28:43'),
(405, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-29 00:16:14'),
(406, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-29 00:25:05'),
(407, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-29 00:37:04'),
(408, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-29 18:10:47'),
(409, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-29 18:25:23'),
(410, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-10-29 18:46:57'),
(411, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-11-01 18:25:25'),
(412, 'ali', 'USER_LOGOUT', 'CA_MANAGER ali logged out', '2025-11-01 18:27:09'),
(413, 'moazam', 'USER_LOGIN', 'User moazam logged in', '2025-11-01 18:29:46'),
(414, 'moazam', 'CERT_DOWNLOADED', 'User moazam downloaded certificate (File=240.crt, ID=87)', '2025-11-01 18:30:26'),
(415, 'moazam', 'REQUEST_SUBMITTED', 'User moazam submitted a new certificate request (subject=RKC)', '2025-11-01 18:31:02'),
(416, 'moazam', 'USER_LOGOUT', 'USER moazam logged out', '2025-11-01 18:31:48'),
(417, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-11-01 18:32:14'),
(418, 'ali', 'CERT_ISSUED', 'Manager ali issued certificate for Request #27 (subject=RKC, user=moazam)', '2025-11-01 18:38:06'),
(419, 'ali', 'USER_LOGOUT', 'CA_MANAGER ali logged out', '2025-11-01 18:39:17'),
(420, 'moazam', 'USER_LOGIN', 'User moazam logged in', '2025-11-01 18:40:34'),
(421, 'moazam', 'CERT_DOWNLOADED', 'User moazam downloaded certificate (File=RKC.crt, ID=90)', '2025-11-01 18:40:40'),
(422, 'moazam', 'USER_LOGOUT', 'USER moazam logged out', '2025-11-01 18:50:35'),
(423, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-11-01 18:51:09'),
(424, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-11-01 19:50:38'),
(425, 'Rafi', 'STAFF_REGISTERED', 'New staff registered: Rafi (ADMIN)', '2025-11-01 20:08:16'),
(426, 'Rafi', 'STAFF_PASSWORD_RESET_REQUEST', 'Password reset email sent to raficml11@gmail.com', '2025-11-01 20:09:51'),
(427, 'Rafi', 'STAFF_LOGIN', 'Staff Rafi logged in (ADMIN)', '2025-11-01 20:12:27'),
(428, 'Rafi', 'STAFF_LOGIN', 'Staff Rafi logged in (ADMIN)', '2025-11-01 20:12:39'),
(429, 'Rafi', 'STAFF_LOGIN', 'Staff Rafi logged in (ADMIN)', '2025-11-01 20:12:56'),
(430, 'Rafi', 'STAFF_LOGIN', 'Staff Rafi logged in (ADMIN)', '2025-11-01 20:13:43'),
(431, 'Rafi', 'USER_LOGOUT', 'ADMIN Rafi logged out', '2025-11-01 20:14:41'),
(432, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-11-05 15:25:56'),
(433, 'ali', 'CERT_RENEWED', 'Manager ali renewed certificate (OldFile=zaid.crt, NewFile=zaid-renewed.crt, Owner=zaid)', '2025-11-05 15:27:15'),
(434, 'ali', 'STAFF_LOGIN', 'Staff ali logged in (CA_MANAGER)', '2025-11-05 15:43:07');

-- --------------------------------------------------------

--
-- Table structure for table `ca`
--

CREATE TABLE `ca` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `issuer` varchar(255) NOT NULL,
  `fingerprint` varchar(255) NOT NULL,
  `serial` varchar(255) NOT NULL,
  `expiryOn` datetime NOT NULL,
  `createdOn` datetime NOT NULL,
  `status` enum('ACTIVE','EXPIRED','REVOKED') DEFAULT 'ACTIVE'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ca`
--

INSERT INTO `ca` (`id`, `name`, `issuer`, `fingerprint`, `serial`, `expiryOn`, `createdOn`, `status`) VALUES
(31, 'MyCA Root CA', 'MyCA Root CA', 'dca792175172362c2b7fa5e25ad11263565525f3df74ae82333de981ac0a78cc', '90205729217954135952087758823254733775', '2035-08-23 13:35:01', '2025-08-25 13:35:01', 'ACTIVE'),
(32, 'MyCA Intermediate CA', 'MyCA Root CA', '552e4c331e79f7a752dd7367db1ceb8a4a276ba3ff9228c6049bbd5c5f50bbd3', '77981225117627781387048755267522495095', '2035-08-23 13:35:02', '2025-08-25 13:35:02', 'ACTIVE');

-- --------------------------------------------------------

--
-- Table structure for table `certificates`
--

CREATE TABLE `certificates` (
  `id` int(11) NOT NULL,
  `fileName` varchar(255) NOT NULL,
  `owner` varchar(100) NOT NULL,
  `status` enum('ACTIVE','EXPIRED','RENEWED','REVOKED') NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `issuer` varchar(255) NOT NULL,
  `serial` varchar(100) NOT NULL,
  `issued_at` datetime DEFAULT NULL,
  `request_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `certificates`
--

INSERT INTO `certificates` (`id`, `fileName`, `owner`, `status`, `expiryDate`, `issuer`, `serial`, `issued_at`, `request_id`) VALUES
(52, 'localhost.crt', '127.0.0.1', 'EXPIRED', '2025-09-24 18:49:10', 'MyCA Intermediate CA', '227293806784191790545742775031638928250', '2025-08-25 18:48:10', NULL),
(53, 'myip.crt', '192.168.100.17', 'EXPIRED', '2025-09-24 18:49:20', 'MyCA Intermediate CA', '3630624866698835262812165291848800342', '2025-08-25 18:48:20', NULL),
(54, 'user.crt', 'user', 'EXPIRED', '2025-10-02 23:48:39', 'MyCA Intermediate CA', '39626244894923875928320067276418125261', '2025-09-02 23:47:39', NULL),
(56, 'wacman.crt', 'wacman.com', 'EXPIRED', '2025-09-24 18:49:29', 'MyCA Intermediate CA', '204225292045074178765082251523312570026', '2025-08-25 18:48:29', NULL),
(57, 'vuit.vom.crt', 'vuit.vom', 'REVOKED', '2025-11-02 19:40:25', 'MyCA Intermediate CA', '182221698960449267078727901481657097241', '2025-10-03 19:39:25', NULL),
(62, 'webinar-renewed.crt', 'webinar', 'RENEWED', '2025-11-03 17:24:18', 'MyCA Intermediate CA', '171087786604050989853880837641437815351', '2025-10-04 00:16:56', NULL),
(65, 'webinar-renewed.crt', 'webinar', 'ACTIVE', '2025-11-03 16:50:19', 'MyCA Intermediate CA', '245362692888380830870050200721757054066', '2025-10-04 16:49:19', NULL),
(68, 'webinar-renewed.crt', 'webinar', 'ACTIVE', '2025-11-03 17:09:41', 'MyCA Intermediate CA', '219312655016672638912854438435457538506', '2025-10-04 17:08:41', NULL),
(70, 'webinar-renewed.crt', 'webinar', 'REVOKED', '2025-11-03 17:24:18', 'MyCA Intermediate CA', '286577672582991943331015845535355849282', '2025-10-04 17:23:18', NULL),
(71, 'osama.crt', 'osama', 'RENEWED', '2025-10-11 06:08:02', 'MyCA Intermediate CA', '247492678048262985118068848525305212366', '2025-10-04 17:55:47', NULL),
(74, 'Ali.crt', 'moazam', 'EXPIRED', '2025-10-24 16:31:42', 'MyCA Intermediate CA', '39346076704678038140165112394159664841', '2025-10-04 22:21:48', NULL),
(77, 'hamza.crt', 'moazam', 'EXPIRED', '2025-10-24 00:00:00', 'MyCA Intermediate CA', '325272425415140482420230057871851032174', '2025-10-05 14:17:02', 20),
(79, 'zaki.crt', 'zaki', 'EXPIRED', '2025-10-19 13:40:08', 'MyCA Intermediate CA', '115678234904228622144195356785177125463', '2025-10-06 13:47:49', 21),
(80, 'localhost.crt', '127.0.0.1', 'ACTIVE', '2025-10-19 15:12:52', 'MyCA Intermediate CA', '332600824777121716894092093509085689186', '2025-09-19 15:11:52', NULL),
(81, 'moazam.crt', 'moazam', 'EXPIRED', '2025-10-09 00:00:00', 'MyCA Intermediate CA', '255310171979115884462559627211488572713', '2025-09-19 16:30:42', NULL),
(82, 'myip.crt', '192.168.100.17', 'ACTIVE', '2025-10-19 16:28:40', 'MyCA Intermediate CA', '278797226597426737070297492808649081000', '2025-09-19 16:27:40', NULL),
(83, 'studentid.crt', 'bc200408672', 'ACTIVE', '2025-10-19 16:34:09', 'MyCA Intermediate CA', '268770107473098214377906120097451441313', '2025-09-19 16:33:09', NULL),
(84, 'wcaman.crt', 'wcaman.com', 'ACTIVE', '2025-10-19 16:29:54', 'MyCA Intermediate CA', '321591081431248782003270893467264165624', '2025-09-19 16:28:54', NULL),
(85, 'AUH.crt', 'moazam', 'EXPIRED', '2025-10-25 11:51:17', 'MyCA Intermediate CA', '281032190678127173447889149548630851660', '2025-10-08 15:06:27', NULL),
(86, 'XYZ.crt', 'farhat', 'EXPIRED', '2025-10-11 01:22:10', 'MyCA Intermediate CA', '323788544042005249775335793696453290749', '2025-10-08 15:22:12', NULL),
(87, '240.crt', 'moazam', 'EXPIRED', '2025-11-07 15:32:39', 'MyCA Intermediate CA', '182117653158629406021596628825151055176', '2025-10-08 15:32:39', 24),
(88, 'test@example..com.crt', 'kashan', 'EXPIRED', '2025-10-19 13:45:15', 'MyCA Intermediate CA', '39868992300637750251484700113855551747', '2025-10-18 13:45:15', 25),
(89, 'zaid-renewed.crt', 'zaid', 'RENEWED', '2025-12-05 15:27:15', 'MyCA Intermediate CA', '142464515215332169472739344601269761922', '2025-10-24 15:55:29', 26),
(90, 'RKC.crt', 'moazam', 'ACTIVE', '2025-12-01 18:38:06', 'MyCA Intermediate CA', '325445998825520929298536958485410403566', '2025-11-01 18:38:06', 27),
(91, 'zaid-renewed.crt', 'zaid', 'ACTIVE', '2025-12-05 15:27:15', 'MyCA Intermediate CA', '52055765654553780565033636741768142299', '2025-11-05 15:26:15', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `requests`
--

CREATE TABLE `requests` (
  `id` int(11) NOT NULL,
  `user` varchar(100) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `status` enum('PENDING','ACCEPTED','REJECTED') DEFAULT 'PENDING',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `requests`
--

INSERT INTO `requests` (`id`, `user`, `subject`, `status`, `created_at`) VALUES
(4, 'user1', 'CN=user1.example.com', 'REJECTED', '2025-09-18 08:46:55'),
(5, 'user2', 'CN=user2.example.com', 'REJECTED', '2025-09-18 08:46:55'),
(6, 'manager1', 'CN=manager1.example.com', 'ACCEPTED', '2025-09-18 08:46:55'),
(7, 'user3', 'CN=user3.example.com', 'ACCEPTED', '2025-09-18 08:46:55'),
(8, 'user4', 'CN=user4.example.com', 'REJECTED', '2025-09-18 08:46:55'),
(9, 'user5', 'CN=user5.example.com', 'REJECTED', '2025-09-18 08:46:55'),
(10, 'kashan', 'uit.com.pk', 'REJECTED', '2025-10-03 11:24:40'),
(11, 'kashan', 'vuit.vom', 'ACCEPTED', '2025-10-03 11:38:31'),
(12, 'kashan', 'kashan', 'ACCEPTED', '2025-10-03 17:57:12'),
(13, 'kashan', 'amigo.chigo', 'REJECTED', '2025-10-03 18:41:32'),
(14, 'moazam', 'webinar', 'ACCEPTED', '2025-10-03 19:13:56'),
(16, 'osama', 'osama', 'ACCEPTED', '2025-10-04 12:54:56'),
(18, 'moazam', 'Ali', 'ACCEPTED', '2025-10-04 17:20:50'),
(20, 'moazam', 'hamza', 'ACCEPTED', '2025-10-05 09:07:10'),
(21, 'zaki', 'zaki', 'ACCEPTED', '2025-10-06 08:44:27'),
(22, 'moazam', 'AUH', 'ACCEPTED', '2025-10-08 09:59:55'),
(23, 'moazam', 'XYZ', 'ACCEPTED', '2025-10-08 10:20:56'),
(24, 'moazam', '240', 'ACCEPTED', '2025-10-08 10:31:30'),
(25, 'kashan', 'test@example..com', 'ACCEPTED', '2025-10-09 17:45:43'),
(26, 'zaid', 'zaid', 'ACCEPTED', '2025-10-24 10:53:42'),
(27, 'moazam', 'RKC', 'ACCEPTED', '2025-11-01 13:31:02');

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('ADMIN','CA_MANAGER') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `reset_token` varchar(255) DEFAULT NULL,
  `reset_expires` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`id`, `username`, `phone`, `email`, `password`, `role`, `created_at`, `reset_token`, `reset_expires`) VALUES
(1, 'ali', '032342560440', 'ali@gmail.com', '$2a$10$LBfMqj1oe0/uviJwRgMl3.G8ydOsuWbhDd.FcjJbaN6A.I6QLOoeG', 'CA_MANAGER', '2025-09-16 21:16:25', NULL, NULL),
(2, 'omer', '038686324483', 'omer@gmail.com', '$2a$10$DQjLvjJneqqSbfh7GUqjmeMH6.0zaQx7Nv2rg1c7Wyhz4US97.EKC', 'ADMIN', '2025-09-17 03:55:13', NULL, NULL),
(7, 'ayan', '33445465763', 'an@gmail.com', '$2a$10$dc4HCqSLoqGB1SH47aelaOsX0SIR7FM0Jo7uqnx.cF18V.HICbZ76', 'CA_MANAGER', '2025-10-01 12:20:53', NULL, NULL),
(10, 'zaki', '03007864634', 'zaki@auhtech.com', '$2a$10$gP.gZWAz0oQK433GpG7hW.tIi06whY3.ZYcXd3PSJ45ihMyXzgkN.', 'ADMIN', '2025-10-07 12:19:05', '260d557dcfa2b2095bf5c31f902a4f215f1b92ac31900696e0957903e183bfb4', '2025-10-07 18:20:46'),
(11, 'Usman', '038575787847', 'bc200408672@vu.edu.pk', '$2a$10$7K9yWlrpGeakkFJyrf1r8.taBCv9jP/0nZ3x0ERsZbVxbteInkxcK', 'ADMIN', '2025-10-07 17:11:26', NULL, NULL),
(12, 'hafsa', '038686324483', 'hafsa6591@gmail.com', '$2a$10$cx0q4Fw3HOoCOyzWBRf.i.79ESb1l3BxWh1/V51X3J3sLMZS/Nh2K', 'ADMIN', '2025-10-08 04:51:39', NULL, NULL),
(13, 'farhat', '038686324483', 'far.ja1976@gmail.com', '$2a$10$lEAH/Sp83qdvUNwvKoWyRuh1Nul3hIontubf3mJmWMIfdFyTdZfFy', 'ADMIN', '2025-10-08 05:23:10', '2f985ffb7d6268ed99f1138d9e6991d6c2d86adbb054d41a55f10d4f82e40c24', '2025-10-09 14:13:42'),
(14, 'Z1', '03007864634', 'zakikhan7980@gmail.com', '$2a$10$M4.oA9IwAEcESGCPxaXtfORpNS7YVgQMBCLweJWZMQmDlUEmkPLGa', 'CA_MANAGER', '2025-10-08 09:46:14', '50c9627f1ba2242475f32b85b4f04583a8fb960ccf6e705e5b2cdaf6b7d50c67', '2025-10-11 13:50:14'),
(17, 'haseeb', '038686324483', 'mk6490851@gmail.com', '$2a$10$jqbgtN7iOzOmDmDz5t/QyOM6sc1JrkE3mcvs70p.sQmhBNSmY8B1O', 'ADMIN', '2025-10-10 20:31:06', NULL, NULL),
(18, 'T1', '03007864634', 'zakiuddinkhan@hotmail.com', '$2a$10$VuUK/gcNhMHBcmJrqkTgnekSUoRHeuwwyPHGV/LX4hJgEtty.VCK.', 'CA_MANAGER', '2025-10-18 08:44:15', NULL, NULL),
(19, 'Zaid', '038686324483', 'zk9841413@gmail.com', '$2a$10$k3g6BSgykzIRwQNqfoa5teByggbncVbh02mRz71nIBWBFERLi3.UG', 'CA_MANAGER', '2025-10-24 10:43:21', NULL, NULL),
(20, 'Rafi', '03077442554', 'raficml11@gmail.com', '$2a$10$EZ3Uuw/6mwKQTrOXC1p7COerWxNVhFCmkJYRvv9/b63/Sho4ZwB.q', 'ADMIN', '2025-11-01 15:08:16', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `staff_otps`
--

CREATE TABLE `staff_otps` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `otp` varchar(10) NOT NULL,
  `expires_at` datetime NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `staff_otps`
--

INSERT INTO `staff_otps` (`id`, `email`, `otp`, `expires_at`, `created_at`) VALUES
(5, 'bc200408672@vu.edu.pk', '393195', '2025-10-07 23:09:45', '2025-10-07 17:09:45'),
(6, 'mkashankhan2004@gmail.com', '586571', '2025-10-08 00:23:48', '2025-10-07 18:23:48'),
(8, 'hasa6591@gmail.com', '410358', '2025-10-08 10:50:18', '2025-10-08 04:50:18'),
(13, 'far.ja1976@gmail.com', '380192', '2025-10-08 11:21:19', '2025-10-08 05:21:19'),
(14, 'zakikhan7980@gmail.com', '899822', '2025-10-08 15:45:25', '2025-10-08 09:45:25'),
(16, 'mk6490851@gmail.com', '530728', '2025-10-11 02:30:01', '2025-10-10 20:30:01'),
(17, 'zakiuddinkhan@hotmail.com', '323274', '2025-10-18 14:42:57', '2025-10-18 08:42:57'),
(18, 'zk9841413@gmail.com', '138253', '2025-10-24 16:42:12', '2025-10-24 10:42:12'),
(19, 'raficml@gmail.com', '758385', '2025-11-01 21:05:52', '2025-11-01 15:05:52'),
(20, 'raficml11@gmail.com', '599244', '2025-11-01 21:07:09', '2025-11-01 15:07:09');

-- --------------------------------------------------------

--
-- Table structure for table `support_messages`
--

CREATE TABLE `support_messages` (
  `id` int(11) NOT NULL,
  `user` varchar(100) NOT NULL,
  `message` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `reply` text DEFAULT NULL,
  `replied_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `support_messages`
--

INSERT INTO `support_messages` (`id`, `user`, `message`, `created_at`, `reply`, `replied_at`) VALUES
(2, 'moazam', 'revoke my certificate', '2025-09-20 13:09:25', 'Hhhhhhhjh', '2025-10-09 12:22:24'),
(3, 'moazam', 'renew my certificate', '2025-09-20 13:09:46', 'ook.check renewed', '2025-09-20 13:12:08'),
(4, 'moazam', 'im leaving', '2025-09-20 14:07:49', 'ok  what shod ii do', '2025-09-20 14:20:18'),
(5, 'moazam', 'hi . hello . how are you', '2025-09-20 16:30:31', 'hi', '2025-09-24 09:16:58'),
(6, 'moazam', 'hello', '2025-09-29 12:12:24', 'hi', '2025-09-29 12:16:48'),
(7, 'zaki', 'plz approve my certificate', '2025-10-06 08:45:44', 'your certificate is approved', '2025-10-06 08:49:47'),
(8, 'moazam', 'Hello g', '2025-10-09 12:02:13', NULL, '2025-10-09 12:02:13'),
(9, 'moazam', 'Hello 123', '2025-10-09 12:03:08', 'hi 123', '2025-10-28 10:56:39');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('USER') DEFAULT 'USER',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `phone`, `email`, `password`, `role`, `created_at`) VALUES
(1, 'moazam', '03174486477', 'mk6490851@gmail.com', '$2a$10$Ya7PmXp9dFS5fNnHkwjg.e2aTtTIq7a6GKRXFxZs6rl7WkSya5cPm', 'USER', '2025-09-16 20:07:44'),
(12, 'osama', '03174486477', 'ak@gmail.com', '$2a$10$8uC58NjJhAoeL0zgAbHgKOU6UCisqMTyMf.GuCURlQGCDbHUpY./m', 'USER', '2025-10-04 12:54:21'),
(14, 'zaki', '03007864634', 'zakikhan7980@gmail.com', '$2a$10$TfFMnyouTHyVVxqjvWJ5kOOm47f.Q/g9Uq30SlgvfDyC0VJ.YWrQ.', 'USER', '2025-10-09 18:35:46'),
(15, 'farhat', '03124263232', 'far.ja1976@gmail.com', '$2a$10$fjN4dcqxJRKVv4jG14g9EOq9oOosPsKbstJQonGT.AwzdV79KQc5i', 'USER', '2025-10-11 08:17:42'),
(16, 'kashan', '03174486477', 'mkashankhan2004@gmail.com', '$2a$10$rtSnvU3Xuu5s0Q2.7Cxz7OlC3.a8hC1M4J/yIuZgvZQtD1VGfPmcW', 'USER', '2025-10-19 08:58:37'),
(18, 'zaid', '038575787847', 'zk9841413@gmail.com', '$2a$10$YCigDJ5pfpvYpkrdWnCiRuu2zdGNnJjDt.7vA3b59uWj7i6n9y.c2', 'USER', '2025-10-24 10:51:58');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ca`
--
ALTER TABLE `ca`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `certificates`
--
ALTER TABLE `certificates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `serial` (`serial`),
  ADD KEY `fk_cert_request` (`request_id`);

--
-- Indexes for table `requests`
--
ALTER TABLE `requests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `staff_otps`
--
ALTER TABLE `staff_otps`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `support_messages`
--
ALTER TABLE `support_messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=435;

--
-- AUTO_INCREMENT for table `ca`
--
ALTER TABLE `ca`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `certificates`
--
ALTER TABLE `certificates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=92;

--
-- AUTO_INCREMENT for table `requests`
--
ALTER TABLE `requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `staff`
--
ALTER TABLE `staff`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `staff_otps`
--
ALTER TABLE `staff_otps`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `support_messages`
--
ALTER TABLE `support_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `certificates`
--
ALTER TABLE `certificates`
  ADD CONSTRAINT `fk_cert_request` FOREIGN KEY (`request_id`) REFERENCES `requests` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
