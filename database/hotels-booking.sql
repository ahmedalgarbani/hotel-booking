-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 14, 2025 at 11:06 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hotels-booking`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_group`
--

INSERT INTO `auth_group` (`id`, `name`) VALUES
(1, 'Hotel Managers');

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_group_permissions`
--

INSERT INTO `auth_group_permissions` (`id`, `group_id`, `permission_id`) VALUES
(1, 1, 11),
(2, 1, 12),
(3, 1, 13),
(4, 1, 14),
(8, 1, 23),
(5, 1, 24),
(6, 1, 25),
(7, 1, 26),
(9, 1, 34),
(10, 1, 38),
(11, 1, 43),
(12, 1, 44),
(13, 1, 45),
(14, 1, 46),
(15, 1, 50),
(16, 1, 51),
(17, 1, 52),
(18, 1, 53),
(19, 1, 54),
(20, 1, 55),
(21, 1, 56),
(22, 1, 57),
(23, 1, 58),
(24, 1, 59),
(25, 1, 60),
(26, 1, 61),
(27, 1, 62),
(28, 1, 67),
(29, 1, 68),
(30, 1, 69),
(31, 1, 70),
(32, 1, 71),
(33, 1, 72),
(34, 1, 73),
(35, 1, 74),
(36, 1, 75),
(37, 1, 76),
(38, 1, 77),
(39, 1, 78),
(40, 1, 79),
(41, 1, 80),
(42, 1, 81),
(43, 1, 82),
(47, 1, 115),
(48, 1, 116),
(49, 1, 117),
(50, 1, 118),
(51, 1, 119),
(52, 1, 120),
(53, 1, 121),
(54, 1, 122),
(55, 1, 127),
(44, 1, 128),
(45, 1, 129),
(46, 1, 130),
(56, 1, 131),
(57, 1, 132),
(58, 1, 133),
(59, 1, 134),
(60, 1, 135),
(61, 1, 136),
(62, 1, 137),
(63, 1, 138),
(64, 1, 139),
(65, 1, 140),
(66, 1, 141),
(67, 1, 142),
(70, 1, 149),
(71, 1, 150),
(68, 1, 153),
(69, 1, 154),
(76, 1, 155),
(77, 1, 156),
(78, 1, 157),
(79, 1, 158),
(72, 1, 163),
(73, 1, 164),
(74, 1, 165),
(75, 1, 166),
(80, 1, 175),
(81, 1, 176),
(82, 1, 177),
(83, 1, 178),
(84, 1, 179),
(85, 1, 180),
(86, 1, 181),
(87, 1, 182),
(88, 1, 183),
(89, 1, 184),
(90, 1, 185),
(91, 1, 186),
(92, 1, 187),
(93, 1, 188),
(94, 1, 189),
(95, 1, 190);

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can approve hotel request', 30, 'can_approve_request'),
(6, 'Can reject hotel request', 30, 'can_reject_request'),
(7, 'Can add permission', 31, 'add_permission'),
(8, 'Can change permission', 31, 'change_permission'),
(9, 'Can delete permission', 31, 'delete_permission'),
(10, 'Can view permission', 31, 'view_permission'),
(11, 'Can add group', 4, 'add_group'),
(12, 'Can change group', 4, 'change_group'),
(13, 'Can delete group', 4, 'delete_group'),
(14, 'Can view group', 4, 'view_group'),
(15, 'Can add content type', 32, 'add_contenttype'),
(16, 'Can change content type', 32, 'change_contenttype'),
(17, 'Can delete content type', 32, 'delete_contenttype'),
(18, 'Can view content type', 32, 'view_contenttype'),
(19, 'Can add session', 33, 'add_session'),
(20, 'Can change session', 33, 'change_session'),
(21, 'Can delete session', 33, 'delete_session'),
(22, 'Can view session', 33, 'view_session'),
(23, 'Can add مستخدم', 2, 'add_customuser'),
(24, 'Can change مستخدم', 2, 'change_customuser'),
(25, 'Can delete مستخدم', 2, 'delete_customuser'),
(26, 'Can view مستخدم', 2, 'view_customuser'),
(27, 'Can add سجل النشاط', 34, 'add_activitylog'),
(28, 'Can change سجل النشاط', 34, 'change_activitylog'),
(29, 'Can delete سجل النشاط', 34, 'delete_activitylog'),
(30, 'Can view سجل النشاط', 34, 'view_activitylog'),
(31, 'Can add منطقه', 21, 'add_city'),
(32, 'Can change منطقه', 21, 'change_city'),
(33, 'Can delete منطقه', 21, 'delete_city'),
(34, 'Can view منطقه', 21, 'view_city'),
(35, 'Can add فندق', 18, 'add_hotel'),
(36, 'Can change فندق', 18, 'change_hotel'),
(37, 'Can delete فندق', 18, 'delete_hotel'),
(38, 'Can view فندق', 18, 'view_hotel'),
(39, 'Can add طلب إضافة فندق', 30, 'add_hotelrequest'),
(40, 'Can change طلب إضافة فندق', 30, 'change_hotelrequest'),
(41, 'Can delete طلب إضافة فندق', 30, 'delete_hotelrequest'),
(42, 'Can view طلب إضافة فندق', 30, 'view_hotelrequest'),
(43, 'Can add صورة', 19, 'add_image'),
(44, 'Can change صورة', 19, 'change_image'),
(45, 'Can delete صورة', 19, 'delete_image'),
(46, 'Can view صورة', 19, 'view_image'),
(47, 'Can add الموقع', 22, 'add_location'),
(48, 'Can change الموقع', 22, 'change_location'),
(49, 'Can delete الموقع', 22, 'delete_location'),
(50, 'Can view الموقع', 22, 'view_location'),
(51, 'Can add رقم هاتف', 20, 'add_phone'),
(52, 'Can change رقم هاتف', 20, 'change_phone'),
(53, 'Can delete رقم هاتف', 20, 'delete_phone'),
(54, 'Can view رقم هاتف', 20, 'view_phone'),
(55, 'Can add توفر الغرف', 9, 'add_availability'),
(56, 'Can change توفر الغرف', 9, 'change_availability'),
(57, 'Can delete توفر الغرف', 9, 'delete_availability'),
(58, 'Can view توفر الغرف', 9, 'view_availability'),
(59, 'Can add تصنيف', 6, 'add_category'),
(60, 'Can change تصنيف', 6, 'change_category'),
(61, 'Can delete تصنيف', 6, 'delete_category'),
(62, 'Can view تصنيف', 6, 'view_category'),
(63, 'Can add مراجعة', 35, 'add_review'),
(64, 'Can change مراجعة', 35, 'change_review'),
(65, 'Can delete مراجعة', 35, 'delete_review'),
(66, 'Can view مراجعة', 35, 'view_review'),
(67, 'Can add صورة الغرفة', 7, 'add_roomimage'),
(68, 'Can change صورة الغرفة', 7, 'change_roomimage'),
(69, 'Can delete صورة الغرفة', 7, 'delete_roomimage'),
(70, 'Can view صورة الغرفة', 7, 'view_roomimage'),
(71, 'Can add سعر الغرفة', 8, 'add_roomprice'),
(72, 'Can change سعر الغرفة', 8, 'change_roomprice'),
(73, 'Can delete سعر الغرفة', 8, 'delete_roomprice'),
(74, 'Can view سعر الغرفة', 8, 'view_roomprice'),
(75, 'Can add حالة الغرفة', 10, 'add_roomstatus'),
(76, 'Can change حالة الغرفة', 10, 'change_roomstatus'),
(77, 'Can delete حالة الغرفة', 10, 'delete_roomstatus'),
(78, 'Can view حالة الغرفة', 10, 'view_roomstatus'),
(79, 'Can add نوع الغرفة', 5, 'add_roomtype'),
(80, 'Can change نوع الغرفة', 5, 'change_roomtype'),
(81, 'Can delete نوع الغرفة', 5, 'delete_roomtype'),
(82, 'Can view نوع الغرفة', 5, 'view_roomtype'),
(83, 'Can add hero slider', 36, 'add_heroslider'),
(84, 'Can change hero slider', 36, 'change_heroslider'),
(85, 'Can delete hero slider', 36, 'delete_heroslider'),
(86, 'Can view hero slider', 36, 'view_heroslider'),
(87, 'Can add info box', 37, 'add_infobox'),
(88, 'Can change info box', 37, 'change_infobox'),
(89, 'Can delete info box', 37, 'delete_infobox'),
(90, 'Can view info box', 37, 'view_infobox'),
(91, 'Can add partner', 38, 'add_partner'),
(92, 'Can change partner', 38, 'change_partner'),
(93, 'Can delete partner', 38, 'delete_partner'),
(94, 'Can view partner', 38, 'view_partner'),
(95, 'Can add room type home', 39, 'add_roomtypehome'),
(96, 'Can change room type home', 39, 'change_roomtypehome'),
(97, 'Can delete room type home', 39, 'delete_roomtypehome'),
(98, 'Can view room type home', 39, 'view_roomtypehome'),
(99, 'Can add setting', 40, 'add_setting'),
(100, 'Can change setting', 40, 'change_setting'),
(101, 'Can delete setting', 40, 'delete_setting'),
(102, 'Can view setting', 40, 'view_setting'),
(103, 'Can add social media link', 41, 'add_socialmedialink'),
(104, 'Can change social media link', 41, 'change_socialmedialink'),
(105, 'Can delete social media link', 41, 'delete_socialmedialink'),
(106, 'Can view social media link', 41, 'view_socialmedialink'),
(107, 'Can add team member', 42, 'add_teammember'),
(108, 'Can change team member', 42, 'change_teammember'),
(109, 'Can delete team member', 42, 'delete_teammember'),
(110, 'Can view team member', 42, 'view_teammember'),
(111, 'Can add testimonial', 43, 'add_testimonial'),
(112, 'Can change testimonial', 43, 'change_testimonial'),
(113, 'Can delete testimonial', 43, 'delete_testimonial'),
(114, 'Can view testimonial', 43, 'view_testimonial'),
(115, 'Can add حجز', 13, 'add_booking'),
(116, 'Can change حجز', 13, 'change_booking'),
(117, 'Can delete حجز', 13, 'delete_booking'),
(118, 'Can view حجز', 13, 'view_booking'),
(119, 'Can add تفصيل الحجز', 14, 'add_bookingdetail'),
(120, 'Can change تفصيل الحجز', 14, 'change_bookingdetail'),
(121, 'Can delete تفصيل الحجز', 14, 'delete_bookingdetail'),
(122, 'Can view تفصيل الحجز', 14, 'view_bookingdetail'),
(123, 'Can add ضيف', 44, 'add_guest'),
(124, 'Can change ضيف', 44, 'change_guest'),
(125, 'Can delete ضيف', 44, 'delete_guest'),
(126, 'Can view ضيف', 44, 'view_guest'),
(127, 'Can add extension movement', 15, 'add_extensionmovement'),
(128, 'Can change extension movement', 15, 'change_extensionmovement'),
(129, 'Can delete extension movement', 15, 'delete_extensionmovement'),
(130, 'Can view extension movement', 15, 'view_extensionmovement'),
(131, 'Can add عملة', 27, 'add_currency'),
(132, 'Can change عملة', 27, 'change_currency'),
(133, 'Can delete عملة', 27, 'delete_currency'),
(134, 'Can view عملة', 27, 'view_currency'),
(135, 'Can add طريقة دفع الفندق', 29, 'add_hotelpaymentmethod'),
(136, 'Can change طريقة دفع الفندق', 29, 'change_hotelpaymentmethod'),
(137, 'Can delete طريقة دفع الفندق', 29, 'delete_hotelpaymentmethod'),
(138, 'Can view طريقة دفع الفندق', 29, 'view_hotelpaymentmethod'),
(139, 'Can add طريقة دفع', 28, 'add_paymentoption'),
(140, 'Can change طريقة دفع', 28, 'change_paymentoption'),
(141, 'Can delete طريقة دفع', 28, 'delete_paymentoption'),
(142, 'Can view طريقة دفع', 28, 'view_paymentoption'),
(143, 'Can add دفعة', 45, 'add_payment'),
(144, 'Can change دفعة', 45, 'change_payment'),
(145, 'Can delete دفعة', 45, 'delete_payment'),
(146, 'Can view دفعة', 45, 'view_payment'),
(147, 'Can add مراجعة فندق', 17, 'add_hotelreview'),
(148, 'Can change مراجعة فندق', 17, 'change_hotelreview'),
(149, 'Can delete مراجعة فندق', 17, 'delete_hotelreview'),
(150, 'Can view مراجعة فندق', 17, 'view_hotelreview'),
(151, 'Can add مراجعة غرفة', 16, 'add_roomreview'),
(152, 'Can change مراجعة غرفة', 16, 'change_roomreview'),
(153, 'Can delete مراجعة غرفة', 16, 'delete_roomreview'),
(154, 'Can view مراجعة غرفة', 16, 'view_roomreview'),
(155, 'Can add خدمة فندقية', 12, 'add_hotelservice'),
(156, 'Can change خدمة فندقية', 12, 'change_hotelservice'),
(157, 'Can delete خدمة فندقية', 12, 'delete_hotelservice'),
(158, 'Can view خدمة فندقية', 12, 'view_hotelservice'),
(159, 'Can add عرض', 46, 'add_offer'),
(160, 'Can change عرض', 46, 'change_offer'),
(161, 'Can delete عرض', 46, 'delete_offer'),
(162, 'Can view عرض', 46, 'view_offer'),
(163, 'Can add خدمة نوع الغرفة', 11, 'add_roomtypeservice'),
(164, 'Can change خدمة نوع الغرفة', 11, 'change_roomtypeservice'),
(165, 'Can delete خدمة نوع الغرفة', 11, 'delete_roomtypeservice'),
(166, 'Can view خدمة نوع الغرفة', 11, 'view_roomtypeservice'),
(167, 'Can add blacklisted token', 47, 'add_blacklistedtoken'),
(168, 'Can change blacklisted token', 47, 'change_blacklistedtoken'),
(169, 'Can delete blacklisted token', 47, 'delete_blacklistedtoken'),
(170, 'Can view blacklisted token', 47, 'view_blacklistedtoken'),
(171, 'Can add outstanding token', 48, 'add_outstandingtoken'),
(172, 'Can change outstanding token', 48, 'change_outstandingtoken'),
(173, 'Can delete outstanding token', 48, 'delete_outstandingtoken'),
(174, 'Can view outstanding token', 48, 'view_outstandingtoken'),
(175, 'Can add تصنيف', 25, 'add_category'),
(176, 'Can change تصنيف', 25, 'change_category'),
(177, 'Can delete تصنيف', 25, 'delete_category'),
(178, 'Can view تصنيف', 25, 'view_category'),
(179, 'Can add تعليق', 24, 'add_comment'),
(180, 'Can change تعليق', 24, 'change_comment'),
(181, 'Can delete تعليق', 24, 'delete_comment'),
(182, 'Can view تعليق', 24, 'view_comment'),
(183, 'Can add مقال', 23, 'add_post'),
(184, 'Can change مقال', 23, 'change_post'),
(185, 'Can delete مقال', 23, 'delete_post'),
(186, 'Can view مقال', 23, 'view_post'),
(187, 'Can add وسم', 26, 'add_tag'),
(188, 'Can change وسم', 26, 'change_tag'),
(189, 'Can delete وسم', 26, 'delete_tag'),
(190, 'Can view وسم', 26, 'view_tag'),
(191, 'Can add إشعار', 49, 'add_notifications'),
(192, 'Can change إشعار', 49, 'change_notifications'),
(193, 'Can delete إشعار', 49, 'delete_notifications'),
(194, 'Can view إشعار', 49, 'view_notifications'),
(195, 'Can add المفضلات', 50, 'add_favourites'),
(196, 'Can change المفضلات', 50, 'change_favourites'),
(197, 'Can delete المفضلات', 50, 'delete_favourites'),
(198, 'Can view المفضلات', 50, 'view_favourites'),
(199, 'Can add crontab', 51, 'add_crontabschedule'),
(200, 'Can change crontab', 51, 'change_crontabschedule'),
(201, 'Can delete crontab', 51, 'delete_crontabschedule'),
(202, 'Can view crontab', 51, 'view_crontabschedule'),
(203, 'Can add interval', 52, 'add_intervalschedule'),
(204, 'Can change interval', 52, 'change_intervalschedule'),
(205, 'Can delete interval', 52, 'delete_intervalschedule'),
(206, 'Can view interval', 52, 'view_intervalschedule'),
(207, 'Can add periodic task', 53, 'add_periodictask'),
(208, 'Can change periodic task', 53, 'change_periodictask'),
(209, 'Can delete periodic task', 53, 'delete_periodictask'),
(210, 'Can view periodic task', 53, 'view_periodictask'),
(211, 'Can add periodic task track', 54, 'add_periodictasks'),
(212, 'Can change periodic task track', 54, 'change_periodictasks'),
(213, 'Can delete periodic task track', 54, 'delete_periodictasks'),
(214, 'Can view periodic task track', 54, 'view_periodictasks'),
(215, 'Can add solar event', 55, 'add_solarschedule'),
(216, 'Can change solar event', 55, 'change_solarschedule'),
(217, 'Can delete solar event', 55, 'delete_solarschedule'),
(218, 'Can view solar event', 55, 'view_solarschedule'),
(219, 'Can add clocked', 56, 'add_clockedschedule'),
(220, 'Can change clocked', 56, 'change_clockedschedule'),
(221, 'Can delete clocked', 56, 'delete_clockedschedule'),
(222, 'Can view clocked', 56, 'view_clockedschedule');

-- --------------------------------------------------------

--
-- Table structure for table `blog_category`
--

CREATE TABLE `blog_category` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `blog_comment`
--

CREATE TABLE `blog_comment` (
  `id` bigint(20) NOT NULL,
  `content` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `is_approved` tinyint(1) NOT NULL,
  `author_id` bigint(20) NOT NULL,
  `post_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `blog_post`
--

CREATE TABLE `blog_post` (
  `id` bigint(20) NOT NULL,
  `title` varchar(200) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `content` longtext NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `published_at` datetime(6) NOT NULL,
  `is_published` tinyint(1) NOT NULL,
  `views` int(10) UNSIGNED NOT NULL CHECK (`views` >= 0),
  `author_id` bigint(20) NOT NULL,
  `category_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `blog_post_tags`
--

CREATE TABLE `blog_post_tags` (
  `id` bigint(20) NOT NULL,
  `post_id` bigint(20) NOT NULL,
  `tag_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `blog_tag`
--

CREATE TABLE `blog_tag` (
  `id` bigint(20) NOT NULL,
  `name` varchar(50) NOT NULL,
  `created_at` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bookings_booking`
--

CREATE TABLE `bookings_booking` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `check_in_date` datetime(6) DEFAULT NULL,
  `check_out_date` datetime(6) DEFAULT NULL,
  `actual_check_out_date` datetime(6) DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL,
  `status` varchar(10) NOT NULL,
  `account_status` tinyint(1) NOT NULL,
  `rooms_booked` int(10) UNSIGNED NOT NULL CHECK (`rooms_booked` >= 0),
  `created_by_id` bigint(20) DEFAULT NULL,
  `hotel_id` bigint(20) NOT NULL,
  `parent_booking_id` bigint(20) DEFAULT NULL,
  `room_id` bigint(20) NOT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bookings_bookingdetail`
--

CREATE TABLE `bookings_bookingdetail` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `quantity` int(10) UNSIGNED NOT NULL CHECK (`quantity` >= 0),
  `price` decimal(10,2) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `notes` longtext DEFAULT NULL,
  `booking_id` bigint(20) NOT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `hotel_id` bigint(20) NOT NULL,
  `service_id` bigint(20) NOT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bookings_extensionmovement`
--

CREATE TABLE `bookings_extensionmovement` (
  `movement_number` int(11) NOT NULL,
  `original_departure` date NOT NULL,
  `extension_date` date NOT NULL,
  `new_departure` date NOT NULL,
  `reason` varchar(50) NOT NULL,
  `extension_year` int(10) UNSIGNED NOT NULL CHECK (`extension_year` >= 0),
  `duration` int(10) UNSIGNED NOT NULL CHECK (`duration` >= 0),
  `booking_id` bigint(20) NOT NULL,
  `payment_receipt_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bookings_guest`
--

CREATE TABLE `bookings_guest` (
  `id` bigint(20) NOT NULL,
  `name` varchar(150) NOT NULL,
  `phone_number` varchar(14) NOT NULL,
  `id_card_image` varchar(100) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `birthday_date` date DEFAULT NULL,
  `check_in_date` datetime(6) DEFAULT NULL,
  `check_out_date` datetime(6) DEFAULT NULL,
  `booking_id` bigint(20) NOT NULL,
  `hotel_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customer_favourites`
--

CREATE TABLE `customer_favourites` (
  `id` bigint(20) NOT NULL,
  `hotel_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer_favourites`
--

INSERT INTO `customer_favourites` (`id`, `hotel_id`, `user_id`) VALUES
(14, 1, 5);

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
(1, '2025-03-14 22:05:16.313328', '1', 'دفعة #1 لحجز 1', 2, '[{\"changed\": {\"fields\": [\"\\u062d\\u0627\\u0644\\u0629 \\u0627\\u0644\\u062f\\u0641\\u0639\"]}}]', 45, 1),
(2, '2025-03-14 22:05:54.421794', '1', 'Booking #1 - room vip 2025 (4 rooms)', 2, '[{\"changed\": {\"fields\": [\"\\u062d\\u0627\\u0644\\u0629 \\u0627\\u0644\\u062d\\u062c\\u0632\"]}}]', 13, 1),
(3, '2025-03-14 22:06:28.697482', '1', 'Booking #1 - room vip 2025 (4 rooms)', 3, '', 13, 1);

-- --------------------------------------------------------

--
-- Table structure for table `django_celery_beat_clockedschedule`
--

CREATE TABLE `django_celery_beat_clockedschedule` (
  `id` int(11) NOT NULL,
  `clocked_time` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_celery_beat_crontabschedule`
--

CREATE TABLE `django_celery_beat_crontabschedule` (
  `id` int(11) NOT NULL,
  `minute` varchar(240) NOT NULL,
  `hour` varchar(96) NOT NULL,
  `day_of_week` varchar(64) NOT NULL,
  `day_of_month` varchar(124) NOT NULL,
  `month_of_year` varchar(64) NOT NULL,
  `timezone` varchar(63) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_celery_beat_intervalschedule`
--

CREATE TABLE `django_celery_beat_intervalschedule` (
  `id` int(11) NOT NULL,
  `every` int(11) NOT NULL,
  `period` varchar(24) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_celery_beat_periodictask`
--

CREATE TABLE `django_celery_beat_periodictask` (
  `id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `task` varchar(200) NOT NULL,
  `args` longtext NOT NULL,
  `kwargs` longtext NOT NULL,
  `queue` varchar(200) DEFAULT NULL,
  `exchange` varchar(200) DEFAULT NULL,
  `routing_key` varchar(200) DEFAULT NULL,
  `expires` datetime(6) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL,
  `last_run_at` datetime(6) DEFAULT NULL,
  `total_run_count` int(10) UNSIGNED NOT NULL CHECK (`total_run_count` >= 0),
  `date_changed` datetime(6) NOT NULL,
  `description` longtext NOT NULL,
  `crontab_id` int(11) DEFAULT NULL,
  `interval_id` int(11) DEFAULT NULL,
  `solar_id` int(11) DEFAULT NULL,
  `one_off` tinyint(1) NOT NULL,
  `start_time` datetime(6) DEFAULT NULL,
  `priority` int(10) UNSIGNED DEFAULT NULL CHECK (`priority` >= 0),
  `headers` longtext NOT NULL,
  `clocked_id` int(11) DEFAULT NULL,
  `expire_seconds` int(10) UNSIGNED DEFAULT NULL CHECK (`expire_seconds` >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_celery_beat_periodictasks`
--

CREATE TABLE `django_celery_beat_periodictasks` (
  `ident` smallint(6) NOT NULL,
  `last_update` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_celery_beat_solarschedule`
--

CREATE TABLE `django_celery_beat_solarschedule` (
  `id` int(11) NOT NULL,
  `event` varchar(24) NOT NULL,
  `latitude` decimal(9,6) NOT NULL,
  `longitude` decimal(9,6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(4, 'auth', 'group'),
(31, 'auth', 'permission'),
(3, 'auth', 'user'),
(25, 'blog', 'category'),
(24, 'blog', 'comment'),
(23, 'blog', 'post'),
(26, 'blog', 'tag'),
(13, 'bookings', 'booking'),
(14, 'bookings', 'bookingdetail'),
(15, 'bookings', 'extensionmovement'),
(44, 'bookings', 'guest'),
(32, 'contenttypes', 'contenttype'),
(50, 'customer', 'favourites'),
(56, 'django_celery_beat', 'clockedschedule'),
(51, 'django_celery_beat', 'crontabschedule'),
(52, 'django_celery_beat', 'intervalschedule'),
(53, 'django_celery_beat', 'periodictask'),
(54, 'django_celery_beat', 'periodictasks'),
(55, 'django_celery_beat', 'solarschedule'),
(36, 'home', 'heroslider'),
(37, 'home', 'infobox'),
(38, 'home', 'partner'),
(39, 'home', 'roomtypehome'),
(40, 'home', 'setting'),
(41, 'home', 'socialmedialink'),
(42, 'home', 'teammember'),
(43, 'home', 'testimonial'),
(21, 'HotelManagement', 'city'),
(18, 'HotelManagement', 'hotel'),
(30, 'HotelManagement', 'hotelrequest'),
(19, 'HotelManagement', 'image'),
(22, 'HotelManagement', 'location'),
(20, 'HotelManagement', 'phone'),
(49, 'notifications', 'notifications'),
(27, 'payments', 'currency'),
(29, 'payments', 'hotelpaymentmethod'),
(45, 'payments', 'payment'),
(28, 'payments', 'paymentoption'),
(17, 'reviews', 'hotelreview'),
(16, 'reviews', 'roomreview'),
(9, 'rooms', 'availability'),
(6, 'rooms', 'category'),
(35, 'rooms', 'review'),
(7, 'rooms', 'roomimage'),
(8, 'rooms', 'roomprice'),
(10, 'rooms', 'roomstatus'),
(5, 'rooms', 'roomtype'),
(12, 'services', 'hotelservice'),
(46, 'services', 'offer'),
(11, 'services', 'roomtypeservice'),
(33, 'sessions', 'session'),
(47, 'token_blacklist', 'blacklistedtoken'),
(48, 'token_blacklist', 'outstandingtoken'),
(34, 'users', 'activitylog'),
(2, 'users', 'customuser');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2025-03-14 21:38:00.092856'),
(2, 'contenttypes', '0002_remove_content_type_name', '2025-03-14 21:38:00.176555'),
(3, 'auth', '0001_initial', '2025-03-14 21:38:00.442170'),
(4, 'auth', '0002_alter_permission_name_max_length', '2025-03-14 21:38:00.526127'),
(5, 'auth', '0003_alter_user_email_max_length', '2025-03-14 21:38:00.540432'),
(6, 'auth', '0004_alter_user_username_opts', '2025-03-14 21:38:00.553149'),
(7, 'auth', '0005_alter_user_last_login_null', '2025-03-14 21:38:00.565676'),
(8, 'auth', '0006_require_contenttypes_0002', '2025-03-14 21:38:00.571803'),
(9, 'auth', '0007_alter_validators_add_error_messages', '2025-03-14 21:38:00.585353'),
(10, 'auth', '0008_alter_user_username_max_length', '2025-03-14 21:38:00.597979'),
(11, 'auth', '0009_alter_user_last_name_max_length', '2025-03-14 21:38:00.613119'),
(12, 'auth', '0010_alter_group_name_max_length', '2025-03-14 21:38:00.639173'),
(13, 'auth', '0011_update_proxy_permissions', '2025-03-14 21:38:00.651933'),
(14, 'auth', '0012_alter_user_first_name_max_length', '2025-03-14 21:38:00.664445'),
(15, 'auth', '0013_alter_permission_options', '2025-03-14 21:38:00.672289'),
(16, 'auth', '0014_alter_permission_options_alter_user_user_permissions', '2025-03-14 21:38:00.687864'),
(17, 'auth', '0015_alter_user_user_permissions', '2025-03-14 21:38:00.698428'),
(18, 'users', '0001_initial', '2025-03-14 21:38:01.423794'),
(19, 'HotelManagement', '0001_initial', '2025-03-14 21:38:01.612708'),
(20, 'HotelManagement', '0002_initial', '2025-03-14 21:38:03.771012'),
(21, 'admin', '0001_initial', '2025-03-14 21:38:04.053926'),
(22, 'admin', '0002_logentry_remove_auto_add', '2025-03-14 21:38:04.112073'),
(23, 'admin', '0003_logentry_add_action_flag_choices', '2025-03-14 21:38:04.170882'),
(24, 'blog', '0001_initial', '2025-03-14 21:38:04.320565'),
(25, 'blog', '0002_initial', '2025-03-14 21:38:05.048664'),
(26, 'rooms', '0001_initial', '2025-03-14 21:38:05.329863'),
(27, 'services', '0001_initial', '2025-03-14 21:38:05.632870'),
(28, 'services', '0002_initial', '2025-03-14 21:38:06.303675'),
(29, 'rooms', '0002_initial', '2025-03-14 21:38:11.032401'),
(30, 'bookings', '0001_initial', '2025-03-14 21:38:11.466093'),
(31, 'payments', '0001_initial', '2025-03-14 21:38:13.593222'),
(32, 'bookings', '0002_initial', '2025-03-14 21:38:15.749414'),
(33, 'customer', '0001_initial', '2025-03-14 21:38:15.930226'),
(34, 'customer', '0002_initial', '2025-03-14 21:38:16.376891'),
(35, 'django_celery_beat', '0001_initial', '2025-03-14 21:38:16.665897'),
(36, 'django_celery_beat', '0002_auto_20161118_0346', '2025-03-14 21:38:16.763111'),
(37, 'django_celery_beat', '0003_auto_20161209_0049', '2025-03-14 21:38:16.810941'),
(38, 'django_celery_beat', '0004_auto_20170221_0000', '2025-03-14 21:38:16.845823'),
(39, 'django_celery_beat', '0005_add_solarschedule_events_choices', '2025-03-14 21:38:16.872578'),
(40, 'django_celery_beat', '0006_auto_20180322_0932', '2025-03-14 21:38:17.018942'),
(41, 'django_celery_beat', '0007_auto_20180521_0826', '2025-03-14 21:38:17.149662'),
(42, 'django_celery_beat', '0008_auto_20180914_1922', '2025-03-14 21:38:17.310137'),
(43, 'django_celery_beat', '0006_auto_20180210_1226', '2025-03-14 21:38:17.432191'),
(44, 'django_celery_beat', '0006_periodictask_priority', '2025-03-14 21:38:17.514553'),
(45, 'django_celery_beat', '0009_periodictask_headers', '2025-03-14 21:38:17.602992'),
(46, 'django_celery_beat', '0010_auto_20190429_0326', '2025-03-14 21:38:18.037418'),
(47, 'django_celery_beat', '0011_auto_20190508_0153', '2025-03-14 21:38:18.249990'),
(48, 'django_celery_beat', '0012_periodictask_expire_seconds', '2025-03-14 21:38:18.339602'),
(49, 'django_celery_beat', '0013_auto_20200609_0727', '2025-03-14 21:38:18.419069'),
(50, 'django_celery_beat', '0014_remove_clockedschedule_enabled', '2025-03-14 21:38:18.485898'),
(51, 'django_celery_beat', '0015_edit_solarschedule_events_choices', '2025-03-14 21:38:18.539681'),
(52, 'django_celery_beat', '0016_alter_crontabschedule_timezone', '2025-03-14 21:38:18.618671'),
(53, 'django_celery_beat', '0017_alter_crontabschedule_month_of_year', '2025-03-14 21:38:18.686956'),
(54, 'django_celery_beat', '0018_improve_crontab_helptext', '2025-03-14 21:38:18.759656'),
(55, 'django_celery_beat', '0019_alter_periodictasks_options', '2025-03-14 21:38:18.786325'),
(56, 'home', '0001_initial', '2025-03-14 21:38:18.961323'),
(57, 'notifications', '0001_initial', '2025-03-14 21:38:19.010322'),
(58, 'notifications', '0002_initial', '2025-03-14 21:38:19.379529'),
(59, 'payments', '0002_hotelpaymentmethod_deleted_at_and_more', '2025-03-14 21:38:19.631278'),
(60, 'payments', '0003_alter_payment_payment_date', '2025-03-14 21:38:19.794607'),
(61, 'payments', '0004_alter_payment_payment_date', '2025-03-14 21:38:19.929694'),
(62, 'reviews', '0001_initial', '2025-03-14 21:38:19.997481'),
(63, 'reviews', '0002_initial', '2025-03-14 21:38:21.949795'),
(64, 'sessions', '0001_initial', '2025-03-14 21:38:22.020323'),
(65, 'token_blacklist', '0001_initial', '2025-03-14 21:38:22.423510'),
(66, 'token_blacklist', '0002_outstandingtoken_jti_hex', '2025-03-14 21:38:22.576545'),
(67, 'token_blacklist', '0003_auto_20171017_2007', '2025-03-14 21:38:22.854002'),
(68, 'token_blacklist', '0004_auto_20171017_2013', '2025-03-14 21:38:23.095900'),
(69, 'token_blacklist', '0005_remove_outstandingtoken_jti', '2025-03-14 21:38:23.288963'),
(70, 'token_blacklist', '0006_auto_20171017_2113', '2025-03-14 21:38:23.457607'),
(71, 'token_blacklist', '0007_auto_20171017_2214', '2025-03-14 21:38:24.515592'),
(72, 'token_blacklist', '0008_migrate_to_bigautofield', '2025-03-14 21:38:25.108551'),
(73, 'token_blacklist', '0010_fix_migrate_to_bigautofield', '2025-03-14 21:38:25.200707'),
(74, 'token_blacklist', '0011_linearizes_history', '2025-03-14 21:38:25.207413'),
(75, 'token_blacklist', '0012_alter_outstandingtoken_user', '2025-03-14 21:38:25.264578'),
(76, 'payments', '0005_hotelpaymentmethod_description_and_more', '2025-03-14 22:00:58.820083');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('5rdo77dhuopoeymoufxlqe2o762a2fnn', '.eJxVjMEOwiAQRP-FsyEILex69O43kAUWqRpISnsy_rtt0oMe5jLvzbyFp3Upfu08-ymJiziL028XKD657iA9qN6bjK0u8xTkrsiDdnlriV_Xw_07KNTLtjaWaXBWI6E1bKJ1mRAhbMEhOxdGCpm0ijYDK1BjVICkLSjM4NCIzxfWiTdM:1ttD8q:TSOwTkfxhh-cd2l8-5DDqKE5vl8zKl2Kva9bpPpBGW0', '2025-03-28 22:04:32.162846');

-- --------------------------------------------------------

--
-- Table structure for table `home_heroslider`
--

CREATE TABLE `home_heroslider` (
  `id` bigint(20) NOT NULL,
  `image1` varchar(100) NOT NULL,
  `image2` varchar(100) NOT NULL,
  `image3` varchar(100) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` longtext DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `home_infobox`
--

CREATE TABLE `home_infobox` (
  `id` bigint(20) NOT NULL,
  `icon` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `show_at_home` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `home_partner`
--

CREATE TABLE `home_partner` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` longtext NOT NULL,
  `image` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `home_roomtypehome`
--

CREATE TABLE `home_roomtypehome` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `image` varchar(100) NOT NULL,
  `link` varchar(200) DEFAULT NULL,
  `show_at_home` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `home_setting`
--

CREATE TABLE `home_setting` (
  `id` bigint(20) NOT NULL,
  `site_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `description` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `default_currency` varchar(100) NOT NULL,
  `color` varchar(100) NOT NULL,
  `currency_icon` varchar(10) NOT NULL,
  `default_language` varchar(100) NOT NULL,
  `currency_Icon_position` int(11) NOT NULL,
  `logo` varchar(100) DEFAULT NULL,
  `favicon` varchar(100) DEFAULT NULL,
  `footer_logo` varchar(100) DEFAULT NULL,
  `seo_title` varchar(255) NOT NULL,
  `seo_description` longtext NOT NULL,
  `seo_keywords` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `home_socialmedialink`
--

CREATE TABLE `home_socialmedialink` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `link` varchar(255) NOT NULL,
  `icon` varchar(100) NOT NULL,
  `status` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `home_teammember`
--

CREATE TABLE `home_teammember` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `position` varchar(100) NOT NULL,
  `bio` longtext NOT NULL,
  `image` varchar(100) NOT NULL,
  `facebook` varchar(200) DEFAULT NULL,
  `twitter` varchar(200) DEFAULT NULL,
  `instagram` varchar(200) DEFAULT NULL,
  `linkedin` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `home_testimonial`
--

CREATE TABLE `home_testimonial` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `position` varchar(100) NOT NULL,
  `content` longtext NOT NULL,
  `image` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hotelmanagement_city`
--

CREATE TABLE `hotelmanagement_city` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `state` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `country` varchar(255) NOT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `hotelmanagement_city`
--

INSERT INTO `hotelmanagement_city` (`id`, `created_at`, `updated_at`, `deleted_at`, `state`, `slug`, `country`, `created_by_id`, `updated_by_id`) VALUES
(1, '2025-03-01 19:00:28.359582', '2025-03-01 19:00:28.359582', NULL, 'sanaa', 'sanaa', 'yemen', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `hotelmanagement_hotel`
--

CREATE TABLE `hotelmanagement_hotel` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `profile_picture` varchar(100) DEFAULT NULL,
  `description` longtext NOT NULL,
  `business_license_number` varchar(50) DEFAULT NULL,
  `document_path` varchar(100) DEFAULT NULL,
  `is_verified` tinyint(1) NOT NULL,
  `verification_date` datetime(6) DEFAULT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `location_id` bigint(20) NOT NULL,
  `manager_id` bigint(20) DEFAULT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `hotelmanagement_hotel`
--

INSERT INTO `hotelmanagement_hotel` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `slug`, `profile_picture`, `description`, `business_license_number`, `document_path`, `is_verified`, `verification_date`, `created_by_id`, `location_id`, `manager_id`, `updated_by_id`) VALUES
(1, '2025-03-01 19:06:29.271764', '2025-03-07 22:21:49.143958', NULL, 'احمد', 'ahmed-vip', 'hotels/images/image_picker_input.dart.png', 'aggggggggggggggggggg', '1515453432132', 'hotel_documents/2025/03/01/image_picker_input.dart.png', 1, '2025-03-01 19:06:26.000000', 1, 1, 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `hotelmanagement_hotelrequest`
--

CREATE TABLE `hotelmanagement_hotelrequest` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(254) NOT NULL,
  `role` varchar(100) NOT NULL,
  `hotel_name` varchar(100) NOT NULL,
  `description` longtext NOT NULL,
  `profile_picture` varchar(100) NOT NULL,
  `business_license_number` varchar(50) DEFAULT NULL,
  `document_path` varchar(100) DEFAULT NULL,
  `additional_images` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`additional_images`)),
  `country` varchar(100) NOT NULL,
  `state` varchar(100) NOT NULL,
  `city_name` varchar(100) NOT NULL,
  `address` varchar(255) NOT NULL,
  `country_code` varchar(5) NOT NULL,
  `phone_number` varchar(20) NOT NULL,
  `is_approved` tinyint(1) NOT NULL,
  `approved_at` datetime(6) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `approved_by_id` bigint(20) DEFAULT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hotelmanagement_image`
--

CREATE TABLE `hotelmanagement_image` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `image_path` varchar(100) DEFAULT NULL,
  `image_url` varchar(3000) DEFAULT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `hotel_id` bigint(20) NOT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hotelmanagement_location`
--

CREATE TABLE `hotelmanagement_location` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `address` varchar(255) NOT NULL,
  `city_id` bigint(20) NOT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `hotelmanagement_location`
--

INSERT INTO `hotelmanagement_location` (`id`, `created_at`, `updated_at`, `deleted_at`, `address`, `city_id`, `created_by_id`, `updated_by_id`) VALUES
(1, '2025-03-01 19:00:56.470001', '2025-03-01 19:00:56.470001', NULL, 'shomaila', 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `hotelmanagement_phone`
--

CREATE TABLE `hotelmanagement_phone` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `phone_number` varchar(10) NOT NULL,
  `country_code` varchar(5) NOT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `hotel_id` bigint(20) NOT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notifications_notifications`
--

CREATE TABLE `notifications_notifications` (
  `id` bigint(20) NOT NULL,
  `message` longtext NOT NULL,
  `send_time` datetime(6) NOT NULL,
  `status` varchar(50) NOT NULL,
  `notification_type` varchar(50) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `action_url` varchar(255) DEFAULT NULL,
  `sender_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notifications_notifications`
--

INSERT INTO `notifications_notifications` (`id`, `message`, `send_time`, `status`, `notification_type`, `is_active`, `action_url`, `sender_id`, `user_id`) VALUES
(1, 'يرجى إضافة الضيوف لحجزك.', '2025-03-14 22:05:54.421794', '0', '1', 1, '/payments/add_guest/1/', 5, 5);

-- --------------------------------------------------------

--
-- Table structure for table `payments_currency`
--

CREATE TABLE `payments_currency` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `currency_name` varchar(50) NOT NULL,
  `currency_symbol` varchar(10) NOT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `hotel_id` bigint(20) NOT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payments_currency`
--

INSERT INTO `payments_currency` (`id`, `created_at`, `updated_at`, `deleted_at`, `currency_name`, `currency_symbol`, `created_by_id`, `hotel_id`, `updated_by_id`) VALUES
(1, '2025-03-01 19:14:12.848277', '2025-03-01 19:14:12.848277', NULL, 'dollar', '$', 1, 1, 1),
(2, '2025-03-10 14:41:32.412347', '2025-03-10 14:41:32.412347', NULL, 'SAR', 'sa', 8, 1, 6);

-- --------------------------------------------------------

--
-- Table structure for table `payments_hotelpaymentmethod`
--

CREATE TABLE `payments_hotelpaymentmethod` (
  `id` bigint(20) NOT NULL,
  `account_name` varchar(100) NOT NULL,
  `account_number` varchar(50) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `hotel_id` bigint(20) NOT NULL,
  `payment_option_id` bigint(20) NOT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `iban` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payments_hotelpaymentmethod`
--

INSERT INTO `payments_hotelpaymentmethod` (`id`, `account_name`, `account_number`, `is_active`, `created_at`, `updated_at`, `created_by_id`, `hotel_id`, `payment_option_id`, `updated_by_id`, `deleted_at`, `description`, `iban`) VALUES
(1, 'ahmed mohamed ahmed', '111111111', 1, '0000-00-00 00:00:00.000000', '0000-00-00 00:00:00.000000', NULL, 1, 1, NULL, NULL, 'asdsa\r\nasdas\r\nasdsac\r\nczczx', '01111111'),
(2, 'sami saleh', '0006565884', 1, '0000-00-00 00:00:00.000000', '0000-00-00 00:00:00.000000', NULL, 1, 2, NULL, NULL, 'asdasdsa', '00556516'),
(3, 'ahmed alKuraimi', '53153135', 1, '0000-00-00 00:00:00.000000', '0000-00-00 00:00:00.000000', NULL, 1, 3, NULL, NULL, 'dasd\r\n444asd\r\nsadas5das6d5', '0031561615');

-- --------------------------------------------------------

--
-- Table structure for table `payments_payment`
--

CREATE TABLE `payments_payment` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `transfer_image` varchar(100) DEFAULT NULL,
  `payment_status` int(11) NOT NULL,
  `payment_date` datetime(6) NOT NULL,
  `payment_subtotal` decimal(10,2) NOT NULL,
  `payment_totalamount` decimal(10,2) NOT NULL,
  `payment_currency` varchar(10) NOT NULL,
  `payment_type` varchar(10) NOT NULL,
  `payment_note` longtext DEFAULT NULL,
  `payment_discount` decimal(10,2) NOT NULL,
  `booking_id` bigint(20) NOT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `payment_method_id` bigint(20) NOT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payments_paymentoption`
--

CREATE TABLE `payments_paymentoption` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `method_name` varchar(100) NOT NULL,
  `logo` varchar(100) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `currency_id` bigint(20) NOT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payments_paymentoption`
--

INSERT INTO `payments_paymentoption` (`id`, `created_at`, `updated_at`, `deleted_at`, `method_name`, `logo`, `is_active`, `created_by_id`, `currency_id`, `updated_by_id`) VALUES
(1, '0000-00-00 00:00:00.000000', '0000-00-00 00:00:00.000000', NULL, 'al najim', 'payment_logos/najim.jpg', 1, NULL, 1, NULL),
(2, '0000-00-00 00:00:00.000000', '0000-00-00 00:00:00.000000', NULL, 'al akwa', 'payment_logos/akwa.jpg', 1, NULL, 1, NULL),
(3, '0000-00-00 00:00:00.000000', '0000-00-00 00:00:00.000000', NULL, 'kuraimi', 'payment_logos/alkuraimi.png', 1, NULL, 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `reviews_hotelreview`
--

CREATE TABLE `reviews_hotelreview` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `rating_service` smallint(5) UNSIGNED NOT NULL CHECK (`rating_service` >= 0),
  `rating_location` smallint(5) UNSIGNED NOT NULL CHECK (`rating_location` >= 0),
  `rating_value_for_money` smallint(5) UNSIGNED NOT NULL CHECK (`rating_value_for_money` >= 0),
  `rating_cleanliness` smallint(5) UNSIGNED NOT NULL CHECK (`rating_cleanliness` >= 0),
  `review` longtext NOT NULL,
  `status` tinyint(1) NOT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `hotel_id` bigint(20) NOT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reviews_roomreview`
--

CREATE TABLE `reviews_roomreview` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `rating` smallint(5) UNSIGNED NOT NULL CHECK (`rating` >= 0),
  `review` longtext NOT NULL,
  `status` tinyint(1) NOT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `hotel_id` bigint(20) NOT NULL,
  `room_type_id` bigint(20) DEFAULT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rooms_availability`
--

CREATE TABLE `rooms_availability` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `availability_date` date NOT NULL,
  `available_rooms` int(10) UNSIGNED NOT NULL CHECK (`available_rooms` >= 0),
  `notes` longtext DEFAULT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `hotel_id` bigint(20) NOT NULL,
  `room_status_id` bigint(20) NOT NULL,
  `room_type_id` bigint(20) NOT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rooms_availability`
--

INSERT INTO `rooms_availability` (`id`, `created_at`, `updated_at`, `deleted_at`, `availability_date`, `available_rooms`, `notes`, `created_by_id`, `hotel_id`, `room_status_id`, `room_type_id`, `updated_by_id`) VALUES
(10, '2025-03-10 00:51:46.649644', '2025-03-10 23:50:17.566236', NULL, '2025-03-10', 21, 'تم التحديث بسبب تمديد الحجز #52', NULL, 1, 3, 1, NULL),
(11, '2025-03-11 00:04:24.742393', '2025-03-11 13:39:35.591118', NULL, '2025-03-11', 20, 'Updated due to booking #45', NULL, 1, 3, 1, NULL),
(12, '2025-03-14 22:04:23.980885', '2025-03-14 22:04:23.981720', NULL, '2025-03-14', 11, 'Updated due to booking #1', NULL, 1, 3, 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `rooms_category`
--

CREATE TABLE `rooms_category` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `description` longtext DEFAULT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `hotel_id` bigint(20) NOT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rooms_category`
--

INSERT INTO `rooms_category` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `description`, `created_by_id`, `hotel_id`, `updated_by_id`) VALUES
(1, '2025-03-01 19:18:19.935767', '2025-03-01 19:18:46.244395', NULL, 'vip', 'شسيسشيش', NULL, 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `rooms_review`
--

CREATE TABLE `rooms_review` (
  `id` bigint(20) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `rating` int(11) NOT NULL,
  `content` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `hotel_id` bigint(20) NOT NULL,
  `room_type_id` bigint(20) NOT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rooms_roomimage`
--

CREATE TABLE `rooms_roomimage` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `image` varchar(100) NOT NULL,
  `is_main` tinyint(1) NOT NULL,
  `caption` varchar(255) DEFAULT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `hotel_id` bigint(20) NOT NULL,
  `room_type_id` bigint(20) NOT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rooms_roomimage`
--

INSERT INTO `rooms_roomimage` (`id`, `created_at`, `updated_at`, `deleted_at`, `image`, `is_main`, `caption`, `created_by_id`, `hotel_id`, `room_type_id`, `updated_by_id`) VALUES
(1, '2025-03-01 19:22:07.144698', '2025-03-01 19:22:07.144698', NULL, 'room_images/wasell.jpg', 1, 'sssssssss', 2, 1, 1, 2),
(2, '2025-03-01 19:22:24.536866', '2025-03-01 19:22:24.536866', NULL, 'room_images/search.jpg', 0, 'saa', 2, 1, 1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `rooms_roomprice`
--

CREATE TABLE `rooms_roomprice` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `date_from` date NOT NULL,
  `date_to` date NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `is_special_offer` tinyint(1) NOT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `hotel_id` bigint(20) NOT NULL,
  `room_type_id` bigint(20) NOT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
) ;

-- --------------------------------------------------------

--
-- Table structure for table `rooms_roomstatus`
--

CREATE TABLE `rooms_roomstatus` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `code` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` longtext DEFAULT NULL,
  `is_available` tinyint(1) NOT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `hotel_id` bigint(20) NOT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rooms_roomstatus`
--

INSERT INTO `rooms_roomstatus` (`id`, `created_at`, `updated_at`, `deleted_at`, `code`, `name`, `description`, `is_available`, `created_by_id`, `hotel_id`, `updated_by_id`) VALUES
(3, '2025-03-01 19:21:28.992783', '2025-03-01 19:21:28.992783', NULL, 'AVAILABLE', 'Available', 'Default status for available rooms', 1, NULL, 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `rooms_roomtype`
--

CREATE TABLE `rooms_roomtype` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `description` longtext DEFAULT NULL,
  `default_capacity` int(10) UNSIGNED NOT NULL CHECK (`default_capacity` >= 0),
  `max_capacity` int(10) UNSIGNED NOT NULL CHECK (`max_capacity` >= 0),
  `beds_count` int(10) UNSIGNED NOT NULL CHECK (`beds_count` >= 0),
  `rooms_count` int(10) UNSIGNED NOT NULL CHECK (`rooms_count` >= 0),
  `base_price` decimal(10,2) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `category_id` bigint(20) NOT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `hotel_id` bigint(20) NOT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
) ;

--
-- Dumping data for table `rooms_roomtype`
--

INSERT INTO `rooms_roomtype` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `description`, `default_capacity`, `max_capacity`, `beds_count`, `rooms_count`, `base_price`, `is_active`, `category_id`, `created_by_id`, `hotel_id`, `updated_by_id`) VALUES
(1, '2025-03-01 19:21:28.984379', '2025-03-01 19:21:28.984379', NULL, 'room vip 2025', 'asdaskdjhsa', 15, 15, 15, 15, 15.00, 1, 1, 2, 1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `services_hotelservice`
--

CREATE TABLE `services_hotelservice` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `icon` varchar(100) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `hotel_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `services_roomtypeservice`
--

CREATE TABLE `services_roomtypeservice` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `icon` varchar(100) DEFAULT NULL,
  `additional_fee` double NOT NULL,
  `hotel_id` bigint(20) NOT NULL,
  `room_type_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `service_offers`
--

CREATE TABLE `service_offers` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `offer_name` varchar(100) NOT NULL,
  `offer_description` longtext NOT NULL,
  `offer_start_date` date NOT NULL,
  `offer_end_date` date NOT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `hotel_id` bigint(20) NOT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `token_blacklist_blacklistedtoken`
--

CREATE TABLE `token_blacklist_blacklistedtoken` (
  `id` bigint(20) NOT NULL,
  `blacklisted_at` datetime(6) NOT NULL,
  `token_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `token_blacklist_outstandingtoken`
--

CREATE TABLE `token_blacklist_outstandingtoken` (
  `id` bigint(20) NOT NULL,
  `token` longtext NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `expires_at` datetime(6) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `jti` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users_activitylog`
--

CREATE TABLE `users_activitylog` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `table_name` varchar(100) NOT NULL,
  `record_id` int(11) NOT NULL,
  `action` varchar(50) NOT NULL,
  `details` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`details`)),
  `ip_address` char(39) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users_customuser`
--

CREATE TABLE `users_customuser` (
  `id` bigint(20) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `user_type` varchar(20) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `image` varchar(100) NOT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `chield_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users_customuser`
--

INSERT INTO `users_customuser` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `date_joined`, `created_at`, `updated_at`, `user_type`, `phone`, `image`, `gender`, `birth_date`, `is_active`, `chield_id`) VALUES
(1, 'pbkdf2_sha256$600000$U0vBbjamlzvOok3a0NCd9H$yfdwiYcSW6sk7zcuIe57bjYlbTFT/FyTsy43NUeBioc=', '2025-03-14 22:04:32.149314', 1, 'a', '', '', 'a@a.com', 1, '2025-03-01 18:58:44.494009', '2025-03-01 18:58:45.387318', '2025-03-01 18:58:45.387318', '', '', '', NULL, NULL, 1, NULL),
(2, 'pbkdf2_sha256$600000$Pc3oxZPOdBxmUVe2eOAwit$bXxPnP1siQugYTDEr36L4fCYu5YaVTozzRxUUgVsv1g=', NULL, 1, 'b', '', '', 'b@b.com', 1, '2025-03-01 19:05:26.868670', '2025-03-01 19:05:28.022141', '2025-03-01 19:05:48.735234', 'hotel_manager', '', '', NULL, NULL, 1, NULL),
(3, 'pbkdf2_sha256$600000$HDDXD5Lhdd8rcHhLG8UYVl$Q8FJflDelq1YQWUDvzR/2zhtU7X8maa5nF3lcjo0XlA=', '2025-03-01 22:40:14.016174', 0, 'motasem', '', '', 'motasem@motasem.com', 0, '2025-03-01 22:21:39.232835', '2025-03-01 22:21:41.258606', '2025-03-01 22:21:41.258606', 'user', '', '', NULL, NULL, 1, NULL),
(4, 'pbkdf2_sha256$600000$69WafNQFxgQDN0ybf7EQYW$qearY4fO/keI64yiOKwtTlw4JsxM0IK+xRJFrCut2lo=', '2025-03-04 19:13:37.238210', 0, 'kakaka', '', '', 'kakaka@kakaka.kakaka', 0, '2025-03-04 19:06:56.842290', '2025-03-04 19:06:58.774589', '2025-03-04 19:06:58.774589', 'user', '', '', NULL, NULL, 1, NULL),
(5, 'pbkdf2_sha256$600000$wp2FpScP9Phmy67xyNNudv$l8vyvhwQ4ldfSqQMUJueUTXRfzu479WTOV8Nx7qEoNQ=', '2025-03-14 22:04:14.076025', 0, 'mosaa', 'mosa', 'mohamed', 'mosaa@mosaa.com', 0, '2025-03-05 20:10:14.486479', '2025-03-05 20:10:16.220927', '2025-03-11 23:11:54.749987', 'customer', '', 'users/2025/03/12/img27.jpg', NULL, NULL, 1, NULL),
(6, 'pbkdf2_sha256$600000$BbNnejHpZOfDP6VnObjVcz$nhsPttz7Xm4OTIK/zOWG0MrrT6q9PAv0jTWQyIffer0=', '2025-03-05 20:13:43.403102', 0, 'mosaa1', '', '', 'mosaa1@mosaa1.com', 0, '2025-03-05 20:13:41.381311', '2025-03-05 20:13:43.386627', '2025-03-05 20:13:43.386627', 'customer', '', '', NULL, NULL, 1, NULL),
(7, 'pbkdf2_sha256$600000$vUeJuKMqNFAu6egbZVxQ85$uQPUm3C2c/AmXPOaKjFVNqCkRpV44XZB+IcyyRoeX9I=', '2025-03-06 08:09:12.614518', 0, 'asdjsk', '', '', 'asdjsk@asdjsk.com', 0, '2025-03-06 08:09:10.785662', '2025-03-06 08:09:12.595928', '2025-03-06 08:09:12.595928', 'customer', '', '', NULL, NULL, 1, NULL),
(8, 'pbkdf2_sha256$600000$SFyrTCxLhv3sQ1aeRp9210$x4uW6U+Le+bTAvJQf+0aMsQ2WQnBb6/rMu43cIS53vk=', '2025-03-08 23:09:07.660012', 0, 'alslslsl', '', '', 'alslslsl@alslslsl.com', 0, '2025-03-08 23:09:05.884851', '2025-03-08 23:09:07.648169', '2025-03-08 23:09:07.648169', 'customer', '', '', NULL, NULL, 1, NULL),
(9, 'pbkdf2_sha256$600000$YyHz1TprqrLxB9Zn86sIJu$VtH3gk7SGQu97sevo51XO3ovW0MjMaVmvTMX/jtAI54=', '2025-03-11 13:39:22.061710', 0, 'ahmed1555', 'ahmed', 'mohamed', 'ahmed1555@gmail.com', 0, '2025-03-11 13:05:30.020217', '2025-03-11 13:05:30.536114', '2025-03-11 13:05:30.536114', 'customer', '781717609', 'users/2025/03/11/topdoctors.jpg', NULL, NULL, 1, NULL),
(10, 'pbkdf2_sha256$600000$JInLxld88le5EonOREI0JQ$FvAY9r/CHudvTsSBOxEfZob1jwsvvzgpRAWPsDM6szE=', '2025-03-11 13:24:43.650477', 0, 'sakjds888', 'askja', 'kksskks', 'sakjds888@cc.com', 0, '2025-03-11 13:24:32.822351', '2025-03-11 13:24:33.340511', '2025-03-11 13:24:33.340511', 'customer', '123123132132', 'users/2025/03/11/topdoctors_qb7Dipr.jpg', NULL, NULL, 1, NULL),
(11, 'pbkdf2_sha256$600000$RQcyfOrNwaARSe90TzIKBU$90MYq5xmhjWGc+keDWcELY1dkohhCW05pO8C2RgP+xA=', '2025-03-11 14:11:34.650871', 0, 'asjldhask15', 'ajshdkajs', 'aksljdlas', 'asjldhask15@asd.co', 0, '2025-03-11 14:11:32.868092', '2025-03-11 14:11:34.630556', '2025-03-11 14:11:34.630556', 'customer', '21215151515', 'users/2025/03/11/topdoctors_5NSVJtE.jpg', 'Female', '2025-03-09', 1, NULL),
(12, 'pbkdf2_sha256$600000$cyoobnnbnn1veqfofkr18v$Q3A3UVNX8rMFNQOeuwLDAxNV9v68C9+85WPeG58gGsQ=', '2025-03-11 15:03:22.973314', 0, 'ammaralwan', 'ammar', 'alwan', 'ammaralwan@ss.com', 0, '2025-03-11 15:03:07.343237', '2025-03-11 15:03:09.211771', '2025-03-11 15:03:09.211771', 'customer', '781717177', 'users/2025/03/11/terms.jpg', 'Female', '1996-04-18', 1, NULL),
(13, 'pbkdf2_sha256$600000$FqqK1ybDPJVmeLbEpH5xM5$XxlG67Ut3xXs/TN8aC0TcX2qZMHyLlyXteu8KboTH60=', '2025-03-11 15:07:08.449784', 0, 'asdjhasj', 'asjdhjkash', 'asdas', 'sajh@asd.cc', 0, '2025-03-11 15:07:06.624072', '2025-03-11 15:07:08.427732', '2025-03-11 15:07:08.427732', 'customer', '88186541312', 'users/2025/03/11/terms_iJzbCqG.jpg', 'Female', '2003-03-13', 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users_customuser_groups`
--

CREATE TABLE `users_customuser_groups` (
  `id` bigint(20) NOT NULL,
  `customuser_id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users_customuser_user_permissions`
--

CREATE TABLE `users_customuser_user_permissions` (
  `id` bigint(20) NOT NULL,
  `customuser_id` bigint(20) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `blog_category`
--
ALTER TABLE `blog_category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `blog_comment`
--
ALTER TABLE `blog_comment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `blog_comment_author_id_4f11e2e0_fk_users_customuser_id` (`author_id`),
  ADD KEY `blog_comment_post_id_580e96ef_fk_blog_post_id` (`post_id`);

--
-- Indexes for table `blog_post`
--
ALTER TABLE `blog_post`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `blog_post_author_id_dd7a8485_fk_users_customuser_id` (`author_id`),
  ADD KEY `blog_post_category_id_c326dbf8_fk_blog_category_id` (`category_id`);

--
-- Indexes for table `blog_post_tags`
--
ALTER TABLE `blog_post_tags`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `blog_post_tags_post_id_tag_id_4925ec37_uniq` (`post_id`,`tag_id`),
  ADD KEY `blog_post_tags_tag_id_0875c551_fk_blog_tag_id` (`tag_id`);

--
-- Indexes for table `blog_tag`
--
ALTER TABLE `blog_tag`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `bookings_booking`
--
ALTER TABLE `bookings_booking`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bookings_booking_created_by_id_d8a2f432_fk_users_customuser_id` (`created_by_id`),
  ADD KEY `bookings_booking_hotel_id_e1f8132f_fk_HotelManagement_hotel_id` (`hotel_id`),
  ADD KEY `bookings_booking_parent_booking_id_7c358175_fk_bookings_` (`parent_booking_id`),
  ADD KEY `bookings_booking_room_id_6f0fa517_fk_rooms_roomtype_id` (`room_id`),
  ADD KEY `bookings_booking_updated_by_id_6c0bc7d4_fk_users_customuser_id` (`updated_by_id`),
  ADD KEY `bookings_booking_user_id_834dfc23_fk_users_customuser_id` (`user_id`);

--
-- Indexes for table `bookings_bookingdetail`
--
ALTER TABLE `bookings_bookingdetail`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bookings_bookingdeta_booking_id_12740561_fk_bookings_` (`booking_id`),
  ADD KEY `bookings_bookingdeta_created_by_id_a437326b_fk_users_cus` (`created_by_id`),
  ADD KEY `bookings_bookingdeta_hotel_id_1dc4dae4_fk_HotelMana` (`hotel_id`),
  ADD KEY `bookings_bookingdeta_service_id_8dc9681c_fk_services_` (`service_id`),
  ADD KEY `bookings_bookingdeta_updated_by_id_263cc972_fk_users_cus` (`updated_by_id`);

--
-- Indexes for table `bookings_extensionmovement`
--
ALTER TABLE `bookings_extensionmovement`
  ADD PRIMARY KEY (`movement_number`),
  ADD KEY `bookings_extensionmo_booking_id_dd6b5f8f_fk_bookings_` (`booking_id`),
  ADD KEY `bookings_extensionmo_payment_receipt_id_009ef854_fk_payments_` (`payment_receipt_id`);

--
-- Indexes for table `bookings_guest`
--
ALTER TABLE `bookings_guest`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bookings_guest_booking_id_b8c4c07b_fk_bookings_booking_id` (`booking_id`),
  ADD KEY `bookings_guest_hotel_id_333c72e5_fk_HotelManagement_hotel_id` (`hotel_id`);

--
-- Indexes for table `customer_favourites`
--
ALTER TABLE `customer_favourites`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_user_hotel` (`user_id`,`hotel_id`),
  ADD KEY `customer_favourites_hotel_id_8c26062f_fk_HotelMana` (`hotel_id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_users_customuser_id` (`user_id`);

--
-- Indexes for table `django_celery_beat_clockedschedule`
--
ALTER TABLE `django_celery_beat_clockedschedule`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_celery_beat_crontabschedule`
--
ALTER TABLE `django_celery_beat_crontabschedule`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_celery_beat_intervalschedule`
--
ALTER TABLE `django_celery_beat_intervalschedule`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_celery_beat_periodictask`
--
ALTER TABLE `django_celery_beat_periodictask`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `django_celery_beat_p_crontab_id_d3cba168_fk_django_ce` (`crontab_id`),
  ADD KEY `django_celery_beat_p_interval_id_a8ca27da_fk_django_ce` (`interval_id`),
  ADD KEY `django_celery_beat_p_solar_id_a87ce72c_fk_django_ce` (`solar_id`),
  ADD KEY `django_celery_beat_p_clocked_id_47a69f82_fk_django_ce` (`clocked_id`);

--
-- Indexes for table `django_celery_beat_periodictasks`
--
ALTER TABLE `django_celery_beat_periodictasks`
  ADD PRIMARY KEY (`ident`);

--
-- Indexes for table `django_celery_beat_solarschedule`
--
ALTER TABLE `django_celery_beat_solarschedule`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_celery_beat_solar_event_latitude_longitude_ba64999a_uniq` (`event`,`latitude`,`longitude`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indexes for table `home_heroslider`
--
ALTER TABLE `home_heroslider`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `home_infobox`
--
ALTER TABLE `home_infobox`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `home_partner`
--
ALTER TABLE `home_partner`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `home_roomtypehome`
--
ALTER TABLE `home_roomtypehome`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `home_setting`
--
ALTER TABLE `home_setting`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `home_socialmedialink`
--
ALTER TABLE `home_socialmedialink`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `home_teammember`
--
ALTER TABLE `home_teammember`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `home_testimonial`
--
ALTER TABLE `home_testimonial`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hotelmanagement_city`
--
ALTER TABLE `hotelmanagement_city`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `HotelManagement_city_created_by_id_567287e5_fk_users_cus` (`created_by_id`),
  ADD KEY `HotelManagement_city_updated_by_id_5eeb09c7_fk_users_cus` (`updated_by_id`);

--
-- Indexes for table `hotelmanagement_hotel`
--
ALTER TABLE `hotelmanagement_hotel`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD UNIQUE KEY `manager_id` (`manager_id`),
  ADD KEY `HotelManagement_hote_created_by_id_58e7b497_fk_users_cus` (`created_by_id`),
  ADD KEY `HotelManagement_hote_location_id_2f7c61ed_fk_HotelMana` (`location_id`),
  ADD KEY `HotelManagement_hote_updated_by_id_9c63fc69_fk_users_cus` (`updated_by_id`);

--
-- Indexes for table `hotelmanagement_hotelrequest`
--
ALTER TABLE `hotelmanagement_hotelrequest`
  ADD PRIMARY KEY (`id`),
  ADD KEY `HotelManagement_hote_approved_by_id_337f6c49_fk_users_cus` (`approved_by_id`),
  ADD KEY `HotelManagement_hote_created_by_id_f618f76f_fk_users_cus` (`created_by_id`),
  ADD KEY `HotelManagement_hote_updated_by_id_eceb12d5_fk_users_cus` (`updated_by_id`);

--
-- Indexes for table `hotelmanagement_image`
--
ALTER TABLE `hotelmanagement_image`
  ADD PRIMARY KEY (`id`),
  ADD KEY `HotelManagement_imag_created_by_id_779bde56_fk_users_cus` (`created_by_id`),
  ADD KEY `HotelManagement_imag_hotel_id_e97ababf_fk_HotelMana` (`hotel_id`),
  ADD KEY `HotelManagement_imag_updated_by_id_b3d7d0db_fk_users_cus` (`updated_by_id`);

--
-- Indexes for table `hotelmanagement_location`
--
ALTER TABLE `hotelmanagement_location`
  ADD PRIMARY KEY (`id`),
  ADD KEY `HotelManagement_loca_city_id_ae155d2c_fk_HotelMana` (`city_id`),
  ADD KEY `HotelManagement_loca_created_by_id_10ae04e2_fk_users_cus` (`created_by_id`),
  ADD KEY `HotelManagement_loca_updated_by_id_26f3a4d4_fk_users_cus` (`updated_by_id`);

--
-- Indexes for table `hotelmanagement_phone`
--
ALTER TABLE `hotelmanagement_phone`
  ADD PRIMARY KEY (`id`),
  ADD KEY `HotelManagement_phon_created_by_id_34b06bb1_fk_users_cus` (`created_by_id`),
  ADD KEY `HotelManagement_phon_hotel_id_67f340f6_fk_HotelMana` (`hotel_id`),
  ADD KEY `HotelManagement_phon_updated_by_id_114868f0_fk_users_cus` (`updated_by_id`);

--
-- Indexes for table `notifications_notifications`
--
ALTER TABLE `notifications_notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_notifi_sender_id_c6ee4409_fk_users_cus` (`sender_id`),
  ADD KEY `notifications_notifi_user_id_429b0a5e_fk_users_cus` (`user_id`);

--
-- Indexes for table `payments_currency`
--
ALTER TABLE `payments_currency`
  ADD PRIMARY KEY (`id`),
  ADD KEY `payments_currency_created_by_id_69658f49_fk_users_customuser_id` (`created_by_id`),
  ADD KEY `payments_currency_hotel_id_51cc1abb_fk_HotelManagement_hotel_id` (`hotel_id`),
  ADD KEY `payments_currency_updated_by_id_d0a4bce8_fk_users_customuser_id` (`updated_by_id`);

--
-- Indexes for table `payments_hotelpaymentmethod`
--
ALTER TABLE `payments_hotelpaymentmethod`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `payments_hotelpaymentmet_hotel_id_payment_option__4cc203b8_uniq` (`hotel_id`,`payment_option_id`),
  ADD KEY `payments_hotelpaymen_payment_option_id_4b539d55_fk_payments_` (`payment_option_id`),
  ADD KEY `payments_hotelpaymen_updated_by_id_0daaca89_fk_users_cus` (`updated_by_id`),
  ADD KEY `payments_hotelpaymen_created_by_id_4ddb7640_fk_users_cus` (`created_by_id`);

--
-- Indexes for table `payments_payment`
--
ALTER TABLE `payments_payment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `payments_payment_booking_id_2a46974b_fk_bookings_booking_id` (`booking_id`),
  ADD KEY `payments_payment_created_by_id_28f0e284_fk_users_customuser_id` (`created_by_id`),
  ADD KEY `payments_payment_payment_method_id_c909ff25_fk_payments_` (`payment_method_id`),
  ADD KEY `payments_payment_updated_by_id_379a95eb_fk_users_customuser_id` (`updated_by_id`);

--
-- Indexes for table `payments_paymentoption`
--
ALTER TABLE `payments_paymentoption`
  ADD PRIMARY KEY (`id`),
  ADD KEY `payments_paymentopti_created_by_id_e8b0d9da_fk_users_cus` (`created_by_id`),
  ADD KEY `payments_paymentopti_currency_id_9986031a_fk_payments_` (`currency_id`),
  ADD KEY `payments_paymentopti_updated_by_id_29eee1b1_fk_users_cus` (`updated_by_id`);

--
-- Indexes for table `reviews_hotelreview`
--
ALTER TABLE `reviews_hotelreview`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_hotel_user_review` (`hotel_id`,`user_id`),
  ADD KEY `reviews_hotelreview_created_by_id_fbc20ee8_fk_users_cus` (`created_by_id`),
  ADD KEY `reviews_hotelreview_updated_by_id_2fbc72a0_fk_users_cus` (`updated_by_id`),
  ADD KEY `reviews_hotelreview_user_id_b1101c52_fk_users_customuser_id` (`user_id`);

--
-- Indexes for table `reviews_roomreview`
--
ALTER TABLE `reviews_roomreview`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_room_user_review` (`hotel_id`,`room_type_id`,`user_id`),
  ADD KEY `reviews_roomreview_created_by_id_5e598a2a_fk_users_customuser_id` (`created_by_id`),
  ADD KEY `reviews_roomreview_room_type_id_b2e4f814_fk_rooms_roomtype_id` (`room_type_id`),
  ADD KEY `reviews_roomreview_updated_by_id_a7d246e6_fk_users_customuser_id` (`updated_by_id`),
  ADD KEY `reviews_roomreview_user_id_bd90336f_fk_users_customuser_id` (`user_id`);

--
-- Indexes for table `rooms_availability`
--
ALTER TABLE `rooms_availability`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rooms_availability_created_by_id_168a5943_fk_users_customuser_id` (`created_by_id`),
  ADD KEY `rooms_availability_hotel_id_e9028aaa_fk_HotelManagement_hotel_id` (`hotel_id`),
  ADD KEY `rooms_availability_room_status_id_1add85a0_fk_rooms_roo` (`room_status_id`),
  ADD KEY `rooms_availability_room_type_id_ee87e18f_fk_rooms_roomtype_id` (`room_type_id`),
  ADD KEY `rooms_availability_updated_by_id_f8d6a9d2_fk_users_customuser_id` (`updated_by_id`);

--
-- Indexes for table `rooms_category`
--
ALTER TABLE `rooms_category`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_hotel_category` (`hotel_id`,`name`),
  ADD KEY `rooms_category_created_by_id_c539b61c_fk_users_customuser_id` (`created_by_id`),
  ADD KEY `rooms_category_updated_by_id_85bbbd5a_fk_users_customuser_id` (`updated_by_id`);

--
-- Indexes for table `rooms_review`
--
ALTER TABLE `rooms_review`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rooms_review_created_by_id_2fc27bf2_fk_users_customuser_id` (`created_by_id`),
  ADD KEY `rooms_review_hotel_id_b80c4945_fk_HotelManagement_hotel_id` (`hotel_id`),
  ADD KEY `rooms_review_room_type_id_3efa460c_fk_rooms_roomtype_id` (`room_type_id`),
  ADD KEY `rooms_review_updated_by_id_276c8602_fk_users_customuser_id` (`updated_by_id`),
  ADD KEY `rooms_review_user_id_7ce3bdba_fk_users_customuser_id` (`user_id`);

--
-- Indexes for table `rooms_roomimage`
--
ALTER TABLE `rooms_roomimage`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rooms_roomimage_created_by_id_168789df_fk_users_customuser_id` (`created_by_id`),
  ADD KEY `rooms_roomimage_hotel_id_13fbdfad_fk_HotelManagement_hotel_id` (`hotel_id`),
  ADD KEY `rooms_roomimage_room_type_id_d35f7810_fk_rooms_roomtype_id` (`room_type_id`),
  ADD KEY `rooms_roomimage_updated_by_id_c3e3a6e5_fk_users_customuser_id` (`updated_by_id`);

--
-- Indexes for table `rooms_roomprice`
--
ALTER TABLE `rooms_roomprice`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rooms_roomprice_created_by_id_7459c49f_fk_users_customuser_id` (`created_by_id`),
  ADD KEY `rooms_roomprice_hotel_id_bfc064b3_fk_HotelManagement_hotel_id` (`hotel_id`),
  ADD KEY `rooms_roomprice_room_type_id_b8f396b9_fk_rooms_roomtype_id` (`room_type_id`),
  ADD KEY `rooms_roomprice_updated_by_id_20da56f3_fk_users_customuser_id` (`updated_by_id`);

--
-- Indexes for table `rooms_roomstatus`
--
ALTER TABLE `rooms_roomstatus`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_hotel_status_code` (`hotel_id`,`code`),
  ADD KEY `rooms_roomstatus_created_by_id_50bd38ee_fk_users_customuser_id` (`created_by_id`),
  ADD KEY `rooms_roomstatus_updated_by_id_8cedb596_fk_users_customuser_id` (`updated_by_id`);

--
-- Indexes for table `rooms_roomtype`
--
ALTER TABLE `rooms_roomtype`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rooms_roomtype_category_id_3203b18b_fk_rooms_category_id` (`category_id`),
  ADD KEY `rooms_roomtype_created_by_id_42c3bbaa_fk_users_customuser_id` (`created_by_id`),
  ADD KEY `rooms_roomtype_hotel_id_25b4be35_fk_HotelManagement_hotel_id` (`hotel_id`),
  ADD KEY `rooms_roomtype_updated_by_id_b5be2b42_fk_users_customuser_id` (`updated_by_id`);

--
-- Indexes for table `services_hotelservice`
--
ALTER TABLE `services_hotelservice`
  ADD PRIMARY KEY (`id`),
  ADD KEY `services_hotelservic_hotel_id_c67387c9_fk_HotelMana` (`hotel_id`);

--
-- Indexes for table `services_roomtypeservice`
--
ALTER TABLE `services_roomtypeservice`
  ADD PRIMARY KEY (`id`),
  ADD KEY `services_roomtypeser_hotel_id_163e32a7_fk_HotelMana` (`hotel_id`),
  ADD KEY `services_roomtypeser_room_type_id_f15253ec_fk_rooms_roo` (`room_type_id`);

--
-- Indexes for table `service_offers`
--
ALTER TABLE `service_offers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `service_offers_created_by_id_8ca73e25_fk_users_customuser_id` (`created_by_id`),
  ADD KEY `service_offers_hotel_id_d29c1d1e_fk_HotelManagement_hotel_id` (`hotel_id`),
  ADD KEY `service_offers_updated_by_id_42cd54e5_fk_users_customuser_id` (`updated_by_id`);

--
-- Indexes for table `token_blacklist_blacklistedtoken`
--
ALTER TABLE `token_blacklist_blacklistedtoken`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `token_id` (`token_id`);

--
-- Indexes for table `token_blacklist_outstandingtoken`
--
ALTER TABLE `token_blacklist_outstandingtoken`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `token_blacklist_outstandingtoken_jti_hex_d9bdf6f7_uniq` (`jti`),
  ADD KEY `token_blacklist_outs_user_id_83bc629a_fk_users_cus` (`user_id`);

--
-- Indexes for table `users_activitylog`
--
ALTER TABLE `users_activitylog`
  ADD PRIMARY KEY (`id`),
  ADD KEY `users_activ_user_id_e43008_idx` (`user_id`,`created_at`),
  ADD KEY `users_activ_table_n_d89c14_idx` (`table_name`,`record_id`);

--
-- Indexes for table `users_customuser`
--
ALTER TABLE `users_customuser`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `users_customuser_chield_id_8f3dc45a_fk_users_customuser_id` (`chield_id`);

--
-- Indexes for table `users_customuser_groups`
--
ALTER TABLE `users_customuser_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_customuser_groups_customuser_id_group_id_76b619e3_uniq` (`customuser_id`,`group_id`),
  ADD KEY `users_customuser_groups_group_id_01390b14_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `users_customuser_user_permissions`
--
ALTER TABLE `users_customuser_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_customuser_user_pe_customuser_id_permission_7a7debf6_uniq` (`customuser_id`,`permission_id`),
  ADD KEY `users_customuser_use_permission_id_baaa2f74_fk_auth_perm` (`permission_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=96;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=223;

--
-- AUTO_INCREMENT for table `blog_category`
--
ALTER TABLE `blog_category`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `blog_comment`
--
ALTER TABLE `blog_comment`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `blog_post`
--
ALTER TABLE `blog_post`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `blog_post_tags`
--
ALTER TABLE `blog_post_tags`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `blog_tag`
--
ALTER TABLE `blog_tag`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bookings_booking`
--
ALTER TABLE `bookings_booking`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `bookings_bookingdetail`
--
ALTER TABLE `bookings_bookingdetail`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bookings_extensionmovement`
--
ALTER TABLE `bookings_extensionmovement`
  MODIFY `movement_number` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bookings_guest`
--
ALTER TABLE `bookings_guest`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customer_favourites`
--
ALTER TABLE `customer_favourites`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `django_celery_beat_clockedschedule`
--
ALTER TABLE `django_celery_beat_clockedschedule`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_celery_beat_crontabschedule`
--
ALTER TABLE `django_celery_beat_crontabschedule`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_celery_beat_intervalschedule`
--
ALTER TABLE `django_celery_beat_intervalschedule`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_celery_beat_periodictask`
--
ALTER TABLE `django_celery_beat_periodictask`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_celery_beat_solarschedule`
--
ALTER TABLE `django_celery_beat_solarschedule`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77;

--
-- AUTO_INCREMENT for table `home_heroslider`
--
ALTER TABLE `home_heroslider`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `home_infobox`
--
ALTER TABLE `home_infobox`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `home_partner`
--
ALTER TABLE `home_partner`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `home_roomtypehome`
--
ALTER TABLE `home_roomtypehome`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `home_setting`
--
ALTER TABLE `home_setting`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `home_socialmedialink`
--
ALTER TABLE `home_socialmedialink`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `home_teammember`
--
ALTER TABLE `home_teammember`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `home_testimonial`
--
ALTER TABLE `home_testimonial`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hotelmanagement_city`
--
ALTER TABLE `hotelmanagement_city`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `hotelmanagement_hotel`
--
ALTER TABLE `hotelmanagement_hotel`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `hotelmanagement_hotelrequest`
--
ALTER TABLE `hotelmanagement_hotelrequest`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hotelmanagement_image`
--
ALTER TABLE `hotelmanagement_image`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hotelmanagement_location`
--
ALTER TABLE `hotelmanagement_location`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `hotelmanagement_phone`
--
ALTER TABLE `hotelmanagement_phone`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notifications_notifications`
--
ALTER TABLE `notifications_notifications`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `payments_currency`
--
ALTER TABLE `payments_currency`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `payments_hotelpaymentmethod`
--
ALTER TABLE `payments_hotelpaymentmethod`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `payments_payment`
--
ALTER TABLE `payments_payment`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `payments_paymentoption`
--
ALTER TABLE `payments_paymentoption`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `reviews_hotelreview`
--
ALTER TABLE `reviews_hotelreview`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reviews_roomreview`
--
ALTER TABLE `reviews_roomreview`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rooms_availability`
--
ALTER TABLE `rooms_availability`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `rooms_category`
--
ALTER TABLE `rooms_category`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `rooms_review`
--
ALTER TABLE `rooms_review`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rooms_roomimage`
--
ALTER TABLE `rooms_roomimage`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `rooms_roomprice`
--
ALTER TABLE `rooms_roomprice`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rooms_roomstatus`
--
ALTER TABLE `rooms_roomstatus`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `rooms_roomtype`
--
ALTER TABLE `rooms_roomtype`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `services_hotelservice`
--
ALTER TABLE `services_hotelservice`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `services_roomtypeservice`
--
ALTER TABLE `services_roomtypeservice`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `service_offers`
--
ALTER TABLE `service_offers`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `token_blacklist_blacklistedtoken`
--
ALTER TABLE `token_blacklist_blacklistedtoken`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `token_blacklist_outstandingtoken`
--
ALTER TABLE `token_blacklist_outstandingtoken`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users_activitylog`
--
ALTER TABLE `users_activitylog`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users_customuser`
--
ALTER TABLE `users_customuser`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `users_customuser_groups`
--
ALTER TABLE `users_customuser_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users_customuser_user_permissions`
--
ALTER TABLE `users_customuser_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `blog_comment`
--
ALTER TABLE `blog_comment`
  ADD CONSTRAINT `blog_comment_author_id_4f11e2e0_fk_users_customuser_id` FOREIGN KEY (`author_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `blog_comment_post_id_580e96ef_fk_blog_post_id` FOREIGN KEY (`post_id`) REFERENCES `blog_post` (`id`);

--
-- Constraints for table `blog_post`
--
ALTER TABLE `blog_post`
  ADD CONSTRAINT `blog_post_author_id_dd7a8485_fk_users_customuser_id` FOREIGN KEY (`author_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `blog_post_category_id_c326dbf8_fk_blog_category_id` FOREIGN KEY (`category_id`) REFERENCES `blog_category` (`id`);

--
-- Constraints for table `blog_post_tags`
--
ALTER TABLE `blog_post_tags`
  ADD CONSTRAINT `blog_post_tags_post_id_a1c71c8a_fk_blog_post_id` FOREIGN KEY (`post_id`) REFERENCES `blog_post` (`id`),
  ADD CONSTRAINT `blog_post_tags_tag_id_0875c551_fk_blog_tag_id` FOREIGN KEY (`tag_id`) REFERENCES `blog_tag` (`id`);

--
-- Constraints for table `bookings_booking`
--
ALTER TABLE `bookings_booking`
  ADD CONSTRAINT `bookings_booking_created_by_id_d8a2f432_fk_users_customuser_id` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `bookings_booking_hotel_id_e1f8132f_fk_HotelManagement_hotel_id` FOREIGN KEY (`hotel_id`) REFERENCES `hotelmanagement_hotel` (`id`),
  ADD CONSTRAINT `bookings_booking_parent_booking_id_7c358175_fk_bookings_` FOREIGN KEY (`parent_booking_id`) REFERENCES `bookings_booking` (`id`),
  ADD CONSTRAINT `bookings_booking_room_id_6f0fa517_fk_rooms_roomtype_id` FOREIGN KEY (`room_id`) REFERENCES `rooms_roomtype` (`id`),
  ADD CONSTRAINT `bookings_booking_updated_by_id_6c0bc7d4_fk_users_customuser_id` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `bookings_booking_user_id_834dfc23_fk_users_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_customuser` (`id`);

--
-- Constraints for table `bookings_bookingdetail`
--
ALTER TABLE `bookings_bookingdetail`
  ADD CONSTRAINT `bookings_bookingdeta_booking_id_12740561_fk_bookings_` FOREIGN KEY (`booking_id`) REFERENCES `bookings_booking` (`id`),
  ADD CONSTRAINT `bookings_bookingdeta_created_by_id_a437326b_fk_users_cus` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `bookings_bookingdeta_hotel_id_1dc4dae4_fk_HotelMana` FOREIGN KEY (`hotel_id`) REFERENCES `hotelmanagement_hotel` (`id`),
  ADD CONSTRAINT `bookings_bookingdeta_service_id_8dc9681c_fk_services_` FOREIGN KEY (`service_id`) REFERENCES `services_roomtypeservice` (`id`),
  ADD CONSTRAINT `bookings_bookingdeta_updated_by_id_263cc972_fk_users_cus` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- Constraints for table `bookings_extensionmovement`
--
ALTER TABLE `bookings_extensionmovement`
  ADD CONSTRAINT `bookings_extensionmo_booking_id_dd6b5f8f_fk_bookings_` FOREIGN KEY (`booking_id`) REFERENCES `bookings_booking` (`id`),
  ADD CONSTRAINT `bookings_extensionmo_payment_receipt_id_009ef854_fk_payments_` FOREIGN KEY (`payment_receipt_id`) REFERENCES `payments_payment` (`id`);

--
-- Constraints for table `bookings_guest`
--
ALTER TABLE `bookings_guest`
  ADD CONSTRAINT `bookings_guest_booking_id_b8c4c07b_fk_bookings_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `bookings_booking` (`id`),
  ADD CONSTRAINT `bookings_guest_hotel_id_333c72e5_fk_HotelManagement_hotel_id` FOREIGN KEY (`hotel_id`) REFERENCES `hotelmanagement_hotel` (`id`);

--
-- Constraints for table `customer_favourites`
--
ALTER TABLE `customer_favourites`
  ADD CONSTRAINT `customer_favourites_hotel_id_8c26062f_fk_HotelMana` FOREIGN KEY (`hotel_id`) REFERENCES `hotelmanagement_hotel` (`id`),
  ADD CONSTRAINT `customer_favourites_user_id_b1b2dc31_fk_users_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_customuser` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_users_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_customuser` (`id`);

--
-- Constraints for table `django_celery_beat_periodictask`
--
ALTER TABLE `django_celery_beat_periodictask`
  ADD CONSTRAINT `django_celery_beat_p_clocked_id_47a69f82_fk_django_ce` FOREIGN KEY (`clocked_id`) REFERENCES `django_celery_beat_clockedschedule` (`id`),
  ADD CONSTRAINT `django_celery_beat_p_crontab_id_d3cba168_fk_django_ce` FOREIGN KEY (`crontab_id`) REFERENCES `django_celery_beat_crontabschedule` (`id`),
  ADD CONSTRAINT `django_celery_beat_p_interval_id_a8ca27da_fk_django_ce` FOREIGN KEY (`interval_id`) REFERENCES `django_celery_beat_intervalschedule` (`id`),
  ADD CONSTRAINT `django_celery_beat_p_solar_id_a87ce72c_fk_django_ce` FOREIGN KEY (`solar_id`) REFERENCES `django_celery_beat_solarschedule` (`id`);

--
-- Constraints for table `hotelmanagement_city`
--
ALTER TABLE `hotelmanagement_city`
  ADD CONSTRAINT `HotelManagement_city_created_by_id_567287e5_fk_users_cus` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `HotelManagement_city_updated_by_id_5eeb09c7_fk_users_cus` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- Constraints for table `hotelmanagement_hotel`
--
ALTER TABLE `hotelmanagement_hotel`
  ADD CONSTRAINT `HotelManagement_hote_created_by_id_58e7b497_fk_users_cus` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `HotelManagement_hote_location_id_2f7c61ed_fk_HotelMana` FOREIGN KEY (`location_id`) REFERENCES `hotelmanagement_location` (`id`),
  ADD CONSTRAINT `HotelManagement_hote_updated_by_id_9c63fc69_fk_users_cus` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `HotelManagement_hotel_manager_id_1bbe4f12_fk_users_customuser_id` FOREIGN KEY (`manager_id`) REFERENCES `users_customuser` (`id`);

--
-- Constraints for table `hotelmanagement_hotelrequest`
--
ALTER TABLE `hotelmanagement_hotelrequest`
  ADD CONSTRAINT `HotelManagement_hote_approved_by_id_337f6c49_fk_users_cus` FOREIGN KEY (`approved_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `HotelManagement_hote_created_by_id_f618f76f_fk_users_cus` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `HotelManagement_hote_updated_by_id_eceb12d5_fk_users_cus` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- Constraints for table `hotelmanagement_image`
--
ALTER TABLE `hotelmanagement_image`
  ADD CONSTRAINT `HotelManagement_imag_created_by_id_779bde56_fk_users_cus` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `HotelManagement_imag_hotel_id_e97ababf_fk_HotelMana` FOREIGN KEY (`hotel_id`) REFERENCES `hotelmanagement_hotel` (`id`),
  ADD CONSTRAINT `HotelManagement_imag_updated_by_id_b3d7d0db_fk_users_cus` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- Constraints for table `hotelmanagement_location`
--
ALTER TABLE `hotelmanagement_location`
  ADD CONSTRAINT `HotelManagement_loca_city_id_ae155d2c_fk_HotelMana` FOREIGN KEY (`city_id`) REFERENCES `hotelmanagement_city` (`id`),
  ADD CONSTRAINT `HotelManagement_loca_created_by_id_10ae04e2_fk_users_cus` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `HotelManagement_loca_updated_by_id_26f3a4d4_fk_users_cus` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- Constraints for table `hotelmanagement_phone`
--
ALTER TABLE `hotelmanagement_phone`
  ADD CONSTRAINT `HotelManagement_phon_created_by_id_34b06bb1_fk_users_cus` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `HotelManagement_phon_hotel_id_67f340f6_fk_HotelMana` FOREIGN KEY (`hotel_id`) REFERENCES `hotelmanagement_hotel` (`id`),
  ADD CONSTRAINT `HotelManagement_phon_updated_by_id_114868f0_fk_users_cus` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- Constraints for table `notifications_notifications`
--
ALTER TABLE `notifications_notifications`
  ADD CONSTRAINT `notifications_notifi_sender_id_c6ee4409_fk_users_cus` FOREIGN KEY (`sender_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `notifications_notifi_user_id_429b0a5e_fk_users_cus` FOREIGN KEY (`user_id`) REFERENCES `users_customuser` (`id`);

--
-- Constraints for table `payments_currency`
--
ALTER TABLE `payments_currency`
  ADD CONSTRAINT `payments_currency_created_by_id_69658f49_fk_users_customuser_id` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `payments_currency_hotel_id_51cc1abb_fk_HotelManagement_hotel_id` FOREIGN KEY (`hotel_id`) REFERENCES `hotelmanagement_hotel` (`id`),
  ADD CONSTRAINT `payments_currency_updated_by_id_d0a4bce8_fk_users_customuser_id` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- Constraints for table `payments_hotelpaymentmethod`
--
ALTER TABLE `payments_hotelpaymentmethod`
  ADD CONSTRAINT `payments_hotelpaymen_created_by_id_4ddb7640_fk_users_cus` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `payments_hotelpaymen_hotel_id_ce0a1829_fk_HotelMana` FOREIGN KEY (`hotel_id`) REFERENCES `hotelmanagement_hotel` (`id`),
  ADD CONSTRAINT `payments_hotelpaymen_payment_option_id_4b539d55_fk_payments_` FOREIGN KEY (`payment_option_id`) REFERENCES `payments_paymentoption` (`id`),
  ADD CONSTRAINT `payments_hotelpaymen_updated_by_id_0daaca89_fk_users_cus` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- Constraints for table `payments_payment`
--
ALTER TABLE `payments_payment`
  ADD CONSTRAINT `payments_payment_booking_id_2a46974b_fk_bookings_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `bookings_booking` (`id`),
  ADD CONSTRAINT `payments_payment_created_by_id_28f0e284_fk_users_customuser_id` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `payments_payment_payment_method_id_c909ff25_fk_payments_` FOREIGN KEY (`payment_method_id`) REFERENCES `payments_hotelpaymentmethod` (`id`),
  ADD CONSTRAINT `payments_payment_updated_by_id_379a95eb_fk_users_customuser_id` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- Constraints for table `payments_paymentoption`
--
ALTER TABLE `payments_paymentoption`
  ADD CONSTRAINT `payments_paymentopti_created_by_id_e8b0d9da_fk_users_cus` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `payments_paymentopti_currency_id_9986031a_fk_payments_` FOREIGN KEY (`currency_id`) REFERENCES `payments_currency` (`id`),
  ADD CONSTRAINT `payments_paymentopti_updated_by_id_29eee1b1_fk_users_cus` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- Constraints for table `reviews_hotelreview`
--
ALTER TABLE `reviews_hotelreview`
  ADD CONSTRAINT `reviews_hotelreview_created_by_id_fbc20ee8_fk_users_cus` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `reviews_hotelreview_hotel_id_6819d0d9_fk_HotelMana` FOREIGN KEY (`hotel_id`) REFERENCES `hotelmanagement_hotel` (`id`),
  ADD CONSTRAINT `reviews_hotelreview_updated_by_id_2fbc72a0_fk_users_cus` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `reviews_hotelreview_user_id_b1101c52_fk_users_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_customuser` (`id`);

--
-- Constraints for table `reviews_roomreview`
--
ALTER TABLE `reviews_roomreview`
  ADD CONSTRAINT `reviews_roomreview_created_by_id_5e598a2a_fk_users_customuser_id` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `reviews_roomreview_hotel_id_5aff88ca_fk_HotelManagement_hotel_id` FOREIGN KEY (`hotel_id`) REFERENCES `hotelmanagement_hotel` (`id`),
  ADD CONSTRAINT `reviews_roomreview_room_type_id_b2e4f814_fk_rooms_roomtype_id` FOREIGN KEY (`room_type_id`) REFERENCES `rooms_roomtype` (`id`),
  ADD CONSTRAINT `reviews_roomreview_updated_by_id_a7d246e6_fk_users_customuser_id` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `reviews_roomreview_user_id_bd90336f_fk_users_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_customuser` (`id`);

--
-- Constraints for table `rooms_availability`
--
ALTER TABLE `rooms_availability`
  ADD CONSTRAINT `rooms_availability_created_by_id_168a5943_fk_users_customuser_id` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `rooms_availability_hotel_id_e9028aaa_fk_HotelManagement_hotel_id` FOREIGN KEY (`hotel_id`) REFERENCES `hotelmanagement_hotel` (`id`),
  ADD CONSTRAINT `rooms_availability_room_status_id_1add85a0_fk_rooms_roo` FOREIGN KEY (`room_status_id`) REFERENCES `rooms_roomstatus` (`id`),
  ADD CONSTRAINT `rooms_availability_room_type_id_ee87e18f_fk_rooms_roomtype_id` FOREIGN KEY (`room_type_id`) REFERENCES `rooms_roomtype` (`id`),
  ADD CONSTRAINT `rooms_availability_updated_by_id_f8d6a9d2_fk_users_customuser_id` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- Constraints for table `rooms_category`
--
ALTER TABLE `rooms_category`
  ADD CONSTRAINT `rooms_category_created_by_id_c539b61c_fk_users_customuser_id` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `rooms_category_hotel_id_606560bc_fk_HotelManagement_hotel_id` FOREIGN KEY (`hotel_id`) REFERENCES `hotelmanagement_hotel` (`id`),
  ADD CONSTRAINT `rooms_category_updated_by_id_85bbbd5a_fk_users_customuser_id` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- Constraints for table `rooms_review`
--
ALTER TABLE `rooms_review`
  ADD CONSTRAINT `rooms_review_created_by_id_2fc27bf2_fk_users_customuser_id` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `rooms_review_hotel_id_b80c4945_fk_HotelManagement_hotel_id` FOREIGN KEY (`hotel_id`) REFERENCES `hotelmanagement_hotel` (`id`),
  ADD CONSTRAINT `rooms_review_room_type_id_3efa460c_fk_rooms_roomtype_id` FOREIGN KEY (`room_type_id`) REFERENCES `rooms_roomtype` (`id`),
  ADD CONSTRAINT `rooms_review_updated_by_id_276c8602_fk_users_customuser_id` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `rooms_review_user_id_7ce3bdba_fk_users_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_customuser` (`id`);

--
-- Constraints for table `rooms_roomimage`
--
ALTER TABLE `rooms_roomimage`
  ADD CONSTRAINT `rooms_roomimage_created_by_id_168789df_fk_users_customuser_id` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `rooms_roomimage_hotel_id_13fbdfad_fk_HotelManagement_hotel_id` FOREIGN KEY (`hotel_id`) REFERENCES `hotelmanagement_hotel` (`id`),
  ADD CONSTRAINT `rooms_roomimage_room_type_id_d35f7810_fk_rooms_roomtype_id` FOREIGN KEY (`room_type_id`) REFERENCES `rooms_roomtype` (`id`),
  ADD CONSTRAINT `rooms_roomimage_updated_by_id_c3e3a6e5_fk_users_customuser_id` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- Constraints for table `rooms_roomprice`
--
ALTER TABLE `rooms_roomprice`
  ADD CONSTRAINT `rooms_roomprice_created_by_id_7459c49f_fk_users_customuser_id` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `rooms_roomprice_hotel_id_bfc064b3_fk_HotelManagement_hotel_id` FOREIGN KEY (`hotel_id`) REFERENCES `hotelmanagement_hotel` (`id`),
  ADD CONSTRAINT `rooms_roomprice_room_type_id_b8f396b9_fk_rooms_roomtype_id` FOREIGN KEY (`room_type_id`) REFERENCES `rooms_roomtype` (`id`),
  ADD CONSTRAINT `rooms_roomprice_updated_by_id_20da56f3_fk_users_customuser_id` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- Constraints for table `rooms_roomstatus`
--
ALTER TABLE `rooms_roomstatus`
  ADD CONSTRAINT `rooms_roomstatus_created_by_id_50bd38ee_fk_users_customuser_id` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `rooms_roomstatus_hotel_id_121c26cc_fk_HotelManagement_hotel_id` FOREIGN KEY (`hotel_id`) REFERENCES `hotelmanagement_hotel` (`id`),
  ADD CONSTRAINT `rooms_roomstatus_updated_by_id_8cedb596_fk_users_customuser_id` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- Constraints for table `rooms_roomtype`
--
ALTER TABLE `rooms_roomtype`
  ADD CONSTRAINT `rooms_roomtype_category_id_3203b18b_fk_rooms_category_id` FOREIGN KEY (`category_id`) REFERENCES `rooms_category` (`id`),
  ADD CONSTRAINT `rooms_roomtype_created_by_id_42c3bbaa_fk_users_customuser_id` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `rooms_roomtype_hotel_id_25b4be35_fk_HotelManagement_hotel_id` FOREIGN KEY (`hotel_id`) REFERENCES `hotelmanagement_hotel` (`id`),
  ADD CONSTRAINT `rooms_roomtype_updated_by_id_b5be2b42_fk_users_customuser_id` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- Constraints for table `services_hotelservice`
--
ALTER TABLE `services_hotelservice`
  ADD CONSTRAINT `services_hotelservic_hotel_id_c67387c9_fk_HotelMana` FOREIGN KEY (`hotel_id`) REFERENCES `hotelmanagement_hotel` (`id`);

--
-- Constraints for table `services_roomtypeservice`
--
ALTER TABLE `services_roomtypeservice`
  ADD CONSTRAINT `services_roomtypeser_hotel_id_163e32a7_fk_HotelMana` FOREIGN KEY (`hotel_id`) REFERENCES `hotelmanagement_hotel` (`id`),
  ADD CONSTRAINT `services_roomtypeser_room_type_id_f15253ec_fk_rooms_roo` FOREIGN KEY (`room_type_id`) REFERENCES `rooms_roomtype` (`id`);

--
-- Constraints for table `service_offers`
--
ALTER TABLE `service_offers`
  ADD CONSTRAINT `service_offers_created_by_id_8ca73e25_fk_users_customuser_id` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `service_offers_hotel_id_d29c1d1e_fk_HotelManagement_hotel_id` FOREIGN KEY (`hotel_id`) REFERENCES `hotelmanagement_hotel` (`id`),
  ADD CONSTRAINT `service_offers_updated_by_id_42cd54e5_fk_users_customuser_id` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- Constraints for table `token_blacklist_blacklistedtoken`
--
ALTER TABLE `token_blacklist_blacklistedtoken`
  ADD CONSTRAINT `token_blacklist_blacklistedtoken_token_id_3cc7fe56_fk` FOREIGN KEY (`token_id`) REFERENCES `token_blacklist_outstandingtoken` (`id`);

--
-- Constraints for table `token_blacklist_outstandingtoken`
--
ALTER TABLE `token_blacklist_outstandingtoken`
  ADD CONSTRAINT `token_blacklist_outs_user_id_83bc629a_fk_users_cus` FOREIGN KEY (`user_id`) REFERENCES `users_customuser` (`id`);

--
-- Constraints for table `users_activitylog`
--
ALTER TABLE `users_activitylog`
  ADD CONSTRAINT `users_activitylog_user_id_4eb4b36f_fk_users_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_customuser` (`id`);

--
-- Constraints for table `users_customuser`
--
ALTER TABLE `users_customuser`
  ADD CONSTRAINT `users_customuser_chield_id_8f3dc45a_fk_users_customuser_id` FOREIGN KEY (`chield_id`) REFERENCES `users_customuser` (`id`);

--
-- Constraints for table `users_customuser_groups`
--
ALTER TABLE `users_customuser_groups`
  ADD CONSTRAINT `users_customuser_gro_customuser_id_958147bf_fk_users_cus` FOREIGN KEY (`customuser_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `users_customuser_groups_group_id_01390b14_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `users_customuser_user_permissions`
--
ALTER TABLE `users_customuser_user_permissions`
  ADD CONSTRAINT `users_customuser_use_customuser_id_5771478b_fk_users_cus` FOREIGN KEY (`customuser_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `users_customuser_use_permission_id_baaa2f74_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
