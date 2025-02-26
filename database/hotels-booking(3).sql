-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 27, 2025 at 12:31 AM
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
-- Table structure for table `additional_services`
--

CREATE TABLE `additional_services` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `services_id` bigint(20) DEFAULT NULL,
  `shoppingcartitem_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `additional_services`
--

INSERT INTO `additional_services` (`id`, `services_id`, `shoppingcartitem_id`) VALUES
(1, 1, 22),
(2, 1, 23),
(3, 1, 24),
(4, 1, 25),
(5, 1, 29),
(6, 1, 30),
(7, 1, 32),
(8, 1, 34),
(9, 1, 35),
(10, 1, 36),
(11, 1, 39);

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
(1, 'Hotel Managers'),
(2, 'Hotel Staff');

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
(4, 1, 23),
(1, 1, 24),
(2, 1, 25),
(3, 1, 26),
(8, 1, 79),
(5, 1, 80),
(6, 1, 81),
(7, 1, 82),
(9, 1, 83),
(10, 1, 84),
(11, 1, 85),
(12, 1, 86);

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
(5, 'Can approve hotel request', 6, 'can_approve_request'),
(6, 'Can reject hotel request', 6, 'can_reject_request'),
(7, 'Can add permission', 7, 'add_permission'),
(8, 'Can change permission', 7, 'change_permission'),
(9, 'Can delete permission', 7, 'delete_permission'),
(10, 'Can view permission', 7, 'view_permission'),
(11, 'Can add group', 8, 'add_group'),
(12, 'Can change group', 8, 'change_group'),
(13, 'Can delete group', 8, 'delete_group'),
(14, 'Can view group', 8, 'view_group'),
(15, 'Can add content type', 9, 'add_contenttype'),
(16, 'Can change content type', 9, 'change_contenttype'),
(17, 'Can delete content type', 9, 'delete_contenttype'),
(18, 'Can view content type', 9, 'view_contenttype'),
(19, 'Can add session', 10, 'add_session'),
(20, 'Can change session', 10, 'change_session'),
(21, 'Can delete session', 10, 'delete_session'),
(22, 'Can view session', 10, 'view_session'),
(23, 'Can add مستخدم', 2, 'add_customuser'),
(24, 'Can change مستخدم', 2, 'change_customuser'),
(25, 'Can delete مستخدم', 2, 'delete_customuser'),
(26, 'Can view مستخدم', 2, 'view_customuser'),
(27, 'Can add سجل النشاط', 11, 'add_activitylog'),
(28, 'Can change سجل النشاط', 11, 'change_activitylog'),
(29, 'Can delete سجل النشاط', 11, 'delete_activitylog'),
(30, 'Can view سجل النشاط', 11, 'view_activitylog'),
(31, 'Can add منطقه', 12, 'add_city'),
(32, 'Can change منطقه', 12, 'change_city'),
(33, 'Can delete منطقه', 12, 'delete_city'),
(34, 'Can view منطقه', 12, 'view_city'),
(35, 'Can add فندق', 13, 'add_hotel'),
(36, 'Can change فندق', 13, 'change_hotel'),
(37, 'Can delete فندق', 13, 'delete_hotel'),
(38, 'Can view فندق', 13, 'view_hotel'),
(39, 'Can add طلب إضافة فندق', 6, 'add_hotelrequest'),
(40, 'Can change طلب إضافة فندق', 6, 'change_hotelrequest'),
(41, 'Can delete طلب إضافة فندق', 6, 'delete_hotelrequest'),
(42, 'Can view طلب إضافة فندق', 6, 'view_hotelrequest'),
(43, 'Can add صورة', 14, 'add_image'),
(44, 'Can change صورة', 14, 'change_image'),
(45, 'Can delete صورة', 14, 'delete_image'),
(46, 'Can view صورة', 14, 'view_image'),
(47, 'Can add الموقع', 15, 'add_location'),
(48, 'Can change الموقع', 15, 'change_location'),
(49, 'Can delete الموقع', 15, 'delete_location'),
(50, 'Can view الموقع', 15, 'view_location'),
(51, 'Can add رقم هاتف', 16, 'add_phone'),
(52, 'Can change رقم هاتف', 16, 'change_phone'),
(53, 'Can delete رقم هاتف', 16, 'delete_phone'),
(54, 'Can view رقم هاتف', 16, 'view_phone'),
(55, 'Can add توفر الغرف', 17, 'add_availability'),
(56, 'Can change توفر الغرف', 17, 'change_availability'),
(57, 'Can delete توفر الغرف', 17, 'delete_availability'),
(58, 'Can view توفر الغرف', 17, 'view_availability'),
(59, 'Can add تصنيف', 18, 'add_category'),
(60, 'Can change تصنيف', 18, 'change_category'),
(61, 'Can delete تصنيف', 18, 'delete_category'),
(62, 'Can view تصنيف', 18, 'view_category'),
(63, 'Can add مراجعة', 19, 'add_review'),
(64, 'Can change مراجعة', 19, 'change_review'),
(65, 'Can delete مراجعة', 19, 'delete_review'),
(66, 'Can view مراجعة', 19, 'view_review'),
(67, 'Can add صورة الغرفة', 20, 'add_roomimage'),
(68, 'Can change صورة الغرفة', 20, 'change_roomimage'),
(69, 'Can delete صورة الغرفة', 20, 'delete_roomimage'),
(70, 'Can view صورة الغرفة', 20, 'view_roomimage'),
(71, 'Can add سعر الغرفة', 21, 'add_roomprice'),
(72, 'Can change سعر الغرفة', 21, 'change_roomprice'),
(73, 'Can delete سعر الغرفة', 21, 'delete_roomprice'),
(74, 'Can view سعر الغرفة', 21, 'view_roomprice'),
(75, 'Can add حالة الغرفة', 22, 'add_roomstatus'),
(76, 'Can change حالة الغرفة', 22, 'change_roomstatus'),
(77, 'Can delete حالة الغرفة', 22, 'delete_roomstatus'),
(78, 'Can view حالة الغرفة', 22, 'view_roomstatus'),
(79, 'Can add نوع الغرفة', 4, 'add_roomtype'),
(80, 'Can change نوع الغرفة', 4, 'change_roomtype'),
(81, 'Can delete نوع الغرفة', 4, 'delete_roomtype'),
(82, 'Can view نوع الغرفة', 4, 'view_roomtype'),
(83, 'Can add حجز', 5, 'add_booking'),
(84, 'Can change حجز', 5, 'change_booking'),
(85, 'Can delete حجز', 5, 'delete_booking'),
(86, 'Can view حجز', 5, 'view_booking'),
(87, 'Can add تفصيل الحجز', 23, 'add_bookingdetail'),
(88, 'Can change تفصيل الحجز', 23, 'change_bookingdetail'),
(89, 'Can delete تفصيل الحجز', 23, 'delete_bookingdetail'),
(90, 'Can view تفصيل الحجز', 23, 'view_bookingdetail'),
(91, 'Can add حالة الحجز', 24, 'add_bookingstatus'),
(92, 'Can change حالة الحجز', 24, 'change_bookingstatus'),
(93, 'Can delete حالة الحجز', 24, 'delete_bookingstatus'),
(94, 'Can view حالة الحجز', 24, 'view_bookingstatus'),
(95, 'Can add ضيف', 25, 'add_guest'),
(96, 'Can change ضيف', 25, 'change_guest'),
(97, 'Can delete ضيف', 25, 'delete_guest'),
(98, 'Can view ضيف', 25, 'view_guest'),
(99, 'Can add عملة', 26, 'add_currency'),
(100, 'Can change عملة', 26, 'change_currency'),
(101, 'Can delete عملة', 26, 'delete_currency'),
(102, 'Can view عملة', 26, 'view_currency'),
(103, 'Can add طريقة دفع الفندق', 27, 'add_hotelpaymentmethod'),
(104, 'Can change طريقة دفع الفندق', 27, 'change_hotelpaymentmethod'),
(105, 'Can delete طريقة دفع الفندق', 27, 'delete_hotelpaymentmethod'),
(106, 'Can view طريقة دفع الفندق', 27, 'view_hotelpaymentmethod'),
(107, 'Can add فاتورة دفع', 28, 'add_payment'),
(108, 'Can change فاتورة دفع', 28, 'change_payment'),
(109, 'Can delete فاتورة دفع', 28, 'delete_payment'),
(110, 'Can view فاتورة دفع', 28, 'view_payment'),
(111, 'Can add طريقة دفع', 29, 'add_paymentoption'),
(112, 'Can change طريقة دفع', 29, 'change_paymentoption'),
(113, 'Can delete طريقة دفع', 29, 'delete_paymentoption'),
(114, 'Can view طريقة دفع', 29, 'view_paymentoption'),
(115, 'Can add مراجعة فندق', 30, 'add_hotelreview'),
(116, 'Can change مراجعة فندق', 30, 'change_hotelreview'),
(117, 'Can delete مراجعة فندق', 30, 'delete_hotelreview'),
(118, 'Can view مراجعة فندق', 30, 'view_hotelreview'),
(119, 'Can add عرض', 31, 'add_offer'),
(120, 'Can change عرض', 31, 'change_offer'),
(121, 'Can delete عرض', 31, 'delete_offer'),
(122, 'Can view عرض', 31, 'view_offer'),
(123, 'Can add مراجعة غرفة', 32, 'add_roomreview'),
(124, 'Can change مراجعة غرفة', 32, 'change_roomreview'),
(125, 'Can delete مراجعة غرفة', 32, 'delete_roomreview'),
(126, 'Can view مراجعة غرفة', 32, 'view_roomreview'),
(127, 'Can add عرض', 33, 'add_offer'),
(128, 'Can change عرض', 33, 'change_offer'),
(129, 'Can delete عرض', 33, 'delete_offer'),
(130, 'Can view عرض', 33, 'view_offer'),
(131, 'Can add خدمة نوع الغرفة', 34, 'add_roomtypeservice'),
(132, 'Can change خدمة نوع الغرفة', 34, 'change_roomtypeservice'),
(133, 'Can delete خدمة نوع الغرفة', 34, 'delete_roomtypeservice'),
(134, 'Can view خدمة نوع الغرفة', 34, 'view_roomtypeservice'),
(135, 'Can add خدمة فندقية', 35, 'add_hotelservice'),
(136, 'Can change خدمة فندقية', 35, 'change_hotelservice'),
(137, 'Can delete خدمة فندقية', 35, 'delete_hotelservice'),
(138, 'Can view خدمة فندقية', 35, 'view_hotelservice'),
(139, 'Can add blacklisted token', 36, 'add_blacklistedtoken'),
(140, 'Can change blacklisted token', 36, 'change_blacklistedtoken'),
(141, 'Can delete blacklisted token', 36, 'delete_blacklistedtoken'),
(142, 'Can view blacklisted token', 36, 'view_blacklistedtoken'),
(143, 'Can add outstanding token', 37, 'add_outstandingtoken'),
(144, 'Can change outstanding token', 37, 'change_outstandingtoken'),
(145, 'Can delete outstanding token', 37, 'delete_outstandingtoken'),
(146, 'Can view outstanding token', 37, 'view_outstandingtoken'),
(147, 'Can add تصنيف', 38, 'add_category'),
(148, 'Can change تصنيف', 38, 'change_category'),
(149, 'Can delete تصنيف', 38, 'delete_category'),
(150, 'Can view تصنيف', 38, 'view_category'),
(151, 'Can add تعليق', 39, 'add_comment'),
(152, 'Can change تعليق', 39, 'change_comment'),
(153, 'Can delete تعليق', 39, 'delete_comment'),
(154, 'Can view تعليق', 39, 'view_comment'),
(155, 'Can add مقال', 40, 'add_post'),
(156, 'Can change مقال', 40, 'change_post'),
(157, 'Can delete مقال', 40, 'delete_post'),
(158, 'Can view مقال', 40, 'view_post'),
(159, 'Can add إشعار', 41, 'add_notifications'),
(160, 'Can change إشعار', 41, 'change_notifications'),
(161, 'Can delete إشعار', 41, 'delete_notifications'),
(162, 'Can view إشعار', 41, 'view_notifications'),
(163, 'Can add shopping cart', 42, 'add_shoppingcart'),
(164, 'Can change shopping cart', 42, 'change_shoppingcart'),
(165, 'Can delete shopping cart', 42, 'delete_shoppingcart'),
(166, 'Can view shopping cart', 42, 'view_shoppingcart'),
(167, 'Can add shopping cart item', 43, 'add_shoppingcartitem'),
(168, 'Can change shopping cart item', 43, 'change_shoppingcartitem'),
(169, 'Can delete shopping cart item', 43, 'delete_shoppingcartitem'),
(170, 'Can view shopping cart item', 43, 'view_shoppingcartitem');

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
-- Table structure for table `bookings_booking`
--

CREATE TABLE `bookings_booking` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `check_in_date` datetime(6) DEFAULT NULL,
  `check_out_date` datetime(6) DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `hotel_id` bigint(20) NOT NULL,
  `room_id` bigint(20) NOT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `status_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bookings_booking`
--

INSERT INTO `bookings_booking` (`id`, `created_at`, `updated_at`, `deleted_at`, `check_in_date`, `check_out_date`, `amount`, `created_by_id`, `hotel_id`, `room_id`, `updated_by_id`, `user_id`, `status_id`) VALUES
(3, '2025-02-26 23:06:51.537318', '2025-02-26 23:19:46.714279', NULL, '2025-02-26 23:06:37.000000', '2025-02-27 23:06:41.000000', 1000.00, NULL, 1, 3, NULL, 8, 1),
(4, '2025-02-26 23:20:40.242440', '2025-02-26 23:22:46.928224', NULL, '2025-02-26 23:20:27.000000', '2025-02-27 23:20:29.000000', 123.00, NULL, 1, 3, NULL, 9, 1),
(5, '2025-02-26 23:26:03.828258', '2025-02-26 23:28:33.438903', NULL, '2025-02-26 23:25:40.000000', '2025-02-28 23:25:56.000000', 500.00, NULL, 1, 3, NULL, 9, 2);

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
  `notes` longtext DEFAULT NULL,
  `booking_id` bigint(20) NOT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `hotel_id` bigint(20) NOT NULL,
  `service_id` bigint(20) NOT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bookings_bookingstatus`
--

CREATE TABLE `bookings_bookingstatus` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `booking_status_name` varchar(50) NOT NULL,
  `status_code` int(11) NOT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bookings_bookingstatus`
--

INSERT INTO `bookings_bookingstatus` (`id`, `created_at`, `updated_at`, `deleted_at`, `booking_status_name`, `status_code`, `created_by_id`, `updated_by_id`) VALUES
(1, '2025-02-26 22:42:22.247790', '2025-02-26 22:42:22.247790', NULL, 'complete', 0, NULL, NULL),
(2, '2025-02-26 22:42:30.205040', '2025-02-26 22:42:30.205040', NULL, 'cancel', 1, NULL, NULL),
(3, '2025-02-26 22:42:46.859735', '2025-02-26 22:42:46.859735', NULL, 'pending', 2, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `bookings_guest`
--

CREATE TABLE `bookings_guest` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `name` varchar(150) NOT NULL,
  `phone_number` varchar(14) NOT NULL,
  `id_card_number` varchar(30) NOT NULL,
  `account_id` bigint(20) DEFAULT NULL,
  `booking_id` bigint(20) NOT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `hotel_id` bigint(20) NOT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
(1, '2025-02-25 13:09:18.614258', '3', 'جناح - 30.00 (2025-02-25 إلى 2026-02-25)', 2, '[{\"changed\": {\"fields\": [\"\\u0627\\u0644\\u0633\\u0639\\u0631\"]}}]', 21, 6),
(2, '2025-02-25 14:19:59.968116', '1', 'ماء', 1, '[{\"added\": {}}]', 34, 6),
(3, '2025-02-25 19:53:27.877326', '3', 'جناح - 40.00 (2025-02-25 إلى 2026-02-25)', 2, '[{\"changed\": {\"fields\": [\"\\u0627\\u0644\\u0633\\u0639\\u0631\"]}}]', 21, 6),
(4, '2025-02-26 22:42:22.249820', '1', 'complete (0)', 1, '[{\"added\": {}}]', 24, 9),
(5, '2025-02-26 22:42:30.211388', '2', 'cancel (1)', 1, '[{\"added\": {}}]', 24, 9),
(6, '2025-02-26 22:42:46.861772', '3', 'pending (2)', 1, '[{\"added\": {}}]', 24, 9),
(7, '2025-02-26 22:43:13.840052', '1', 'Booking #1 - جناح (Grand Hotel)', 1, '[{\"added\": {}}]', 5, 9),
(8, '2025-02-26 22:44:16.319006', '3', 'Availability object (3)', 2, '[{\"changed\": {\"fields\": [\"\\u0639\\u062f\\u062f \\u0627\\u0644\\u063a\\u0631\\u0641 \\u0627\\u0644\\u0645\\u062a\\u0648\\u0641\\u0631\\u0629\"]}}]', 17, 9),
(9, '2025-02-26 22:44:38.652985', '1', 'Booking #1 - جناح (Grand Hotel)', 2, '[{\"changed\": {\"fields\": [\"\\u062d\\u0627\\u0644\\u0629 \\u0627\\u0644\\u062d\\u062c\\u0632\"]}}]', 5, 9),
(10, '2025-02-26 22:47:16.034657', '1', 'Booking #1 - جناح (Grand Hotel)', 2, '[{\"changed\": {\"fields\": [\"\\u062d\\u0627\\u0644\\u0629 \\u0627\\u0644\\u062d\\u062c\\u0632\"]}}]', 5, 9),
(11, '2025-02-26 22:56:58.964094', '1', 'Booking #1 - جناح (Grand Hotel)', 2, '[{\"changed\": {\"fields\": [\"\\u062d\\u0627\\u0644\\u0629 \\u0627\\u0644\\u062d\\u062c\\u0632\"]}}]', 5, 9),
(12, '2025-02-26 23:02:23.940489', '1', 'Booking #1 - جناح (Grand Hotel)', 2, '[{\"changed\": {\"fields\": [\"\\u062d\\u0627\\u0644\\u0629 \\u0627\\u0644\\u062d\\u062c\\u0632\"]}}]', 5, 9),
(13, '2025-02-26 23:02:37.998558', '1', 'Booking #1 - جناح (Grand Hotel)', 2, '[{\"changed\": {\"fields\": [\"\\u062d\\u0627\\u0644\\u0629 \\u0627\\u0644\\u062d\\u062c\\u0632\"]}}]', 5, 9),
(14, '2025-02-26 23:04:14.128664', '2', 'Booking #2 - جناح (Grand Hotel)', 1, '[{\"added\": {}}]', 5, 9),
(15, '2025-02-26 23:05:22.227479', '2', 'Booking #2 - جناح (Grand Hotel)', 2, '[{\"changed\": {\"fields\": [\"\\u062d\\u0627\\u0644\\u0629 \\u0627\\u0644\\u062d\\u062c\\u0632\"]}}]', 5, 9),
(16, '2025-02-26 23:05:35.571352', '2', 'Booking #2 - جناح (Grand Hotel)', 2, '[{\"changed\": {\"fields\": [\"\\u062d\\u0627\\u0644\\u0629 \\u0627\\u0644\\u062d\\u062c\\u0632\"]}}]', 5, 9),
(17, '2025-02-26 23:06:20.736015', '2', 'Booking #2 - جناح (Grand Hotel)', 3, '', 5, 9),
(18, '2025-02-26 23:06:26.848537', '1', 'Booking #1 - جناح (Grand Hotel)', 3, '', 5, 9),
(19, '2025-02-26 23:06:51.548210', '3', 'Booking #3 - جناح (Grand Hotel)', 1, '[{\"added\": {}}]', 5, 9),
(20, '2025-02-26 23:08:06.685301', '3', 'Booking #3 - جناح (Grand Hotel)', 2, '[{\"changed\": {\"fields\": [\"\\u062d\\u0627\\u0644\\u0629 \\u0627\\u0644\\u062d\\u062c\\u0632\"]}}]', 5, 9),
(21, '2025-02-26 23:08:23.051271', '3', 'Booking #3 - جناح (Grand Hotel)', 2, '[{\"changed\": {\"fields\": [\"\\u062d\\u0627\\u0644\\u0629 \\u0627\\u0644\\u062d\\u062c\\u0632\"]}}]', 5, 9),
(22, '2025-02-26 23:08:59.635185', '3', 'Booking #3 - جناح (Grand Hotel)', 2, '[{\"changed\": {\"fields\": [\"\\u062d\\u0627\\u0644\\u0629 \\u0627\\u0644\\u062d\\u062c\\u0632\"]}}]', 5, 9),
(23, '2025-02-26 23:09:13.763119', '3', 'Booking #3 - جناح (Grand Hotel)', 2, '[{\"changed\": {\"fields\": [\"\\u062d\\u0627\\u0644\\u0629 \\u0627\\u0644\\u062d\\u062c\\u0632\"]}}]', 5, 9),
(24, '2025-02-26 23:11:42.813007', '3', 'Booking #3 - جناح (Grand Hotel)', 2, '[{\"changed\": {\"fields\": [\"\\u062d\\u0627\\u0644\\u0629 \\u0627\\u0644\\u062d\\u062c\\u0632\"]}}]', 5, 9),
(25, '2025-02-26 23:12:00.155188', '3', 'Booking #3 - جناح (Grand Hotel)', 2, '[{\"changed\": {\"fields\": [\"\\u062d\\u0627\\u0644\\u0629 \\u0627\\u0644\\u062d\\u062c\\u0632\"]}}]', 5, 9),
(26, '2025-02-26 23:19:46.728403', '3', 'Booking #3 - جناح (Grand Hotel)', 2, '[]', 5, 9),
(27, '2025-02-26 23:20:40.248281', '4', 'Booking #4 - جناح (Grand Hotel)', 1, '[{\"added\": {}}]', 5, 9),
(28, '2025-02-26 23:20:54.288167', '4', 'Booking #4 - جناح (Grand Hotel)', 2, '[{\"changed\": {\"fields\": [\"\\u062d\\u0627\\u0644\\u0629 \\u0627\\u0644\\u062d\\u062c\\u0632\"]}}]', 5, 9),
(29, '2025-02-26 23:21:34.087706', '4', 'Booking #4 - جناح (Grand Hotel)', 2, '[{\"changed\": {\"fields\": [\"\\u062d\\u0627\\u0644\\u0629 \\u0627\\u0644\\u062d\\u062c\\u0632\"]}}]', 5, 9),
(30, '2025-02-26 23:21:46.931652', '4', 'Booking #4 - جناح (Grand Hotel)', 2, '[{\"changed\": {\"fields\": [\"\\u062d\\u0627\\u0644\\u0629 \\u0627\\u0644\\u062d\\u062c\\u0632\"]}}]', 5, 9),
(31, '2025-02-26 23:22:10.227411', '4', 'Booking #4 - جناح (Grand Hotel)', 2, '[{\"changed\": {\"fields\": [\"\\u062d\\u0627\\u0644\\u0629 \\u0627\\u0644\\u062d\\u062c\\u0632\"]}}]', 5, 9),
(32, '2025-02-26 23:22:23.302407', '4', 'Booking #4 - جناح (Grand Hotel)', 2, '[{\"changed\": {\"fields\": [\"\\u062d\\u0627\\u0644\\u0629 \\u0627\\u0644\\u062d\\u062c\\u0632\"]}}]', 5, 9),
(33, '2025-02-26 23:22:37.005808', '4', 'Booking #4 - جناح (Grand Hotel)', 2, '[{\"changed\": {\"fields\": [\"\\u062d\\u0627\\u0644\\u0629 \\u0627\\u0644\\u062d\\u062c\\u0632\"]}}]', 5, 9),
(34, '2025-02-26 23:22:46.935120', '4', 'Booking #4 - جناح (Grand Hotel)', 2, '[{\"changed\": {\"fields\": [\"\\u062d\\u0627\\u0644\\u0629 \\u0627\\u0644\\u062d\\u062c\\u0632\"]}}]', 5, 9),
(35, '2025-02-26 23:26:03.833856', '5', 'Booking #5 - جناح (Grand Hotel)', 1, '[{\"added\": {}}]', 5, 9),
(36, '2025-02-26 23:26:11.918945', '2', 'Availability object (2)', 2, '[{\"changed\": {\"fields\": [\"\\u0639\\u062f\\u062f \\u0627\\u0644\\u063a\\u0631\\u0641 \\u0627\\u0644\\u0645\\u062a\\u0648\\u0641\\u0631\\u0629\"]}}]', 17, 9),
(37, '2025-02-26 23:26:22.384732', '5', 'Booking #5 - جناح (Grand Hotel)', 2, '[{\"changed\": {\"fields\": [\"\\u062d\\u0627\\u0644\\u0629 \\u0627\\u0644\\u062d\\u062c\\u0632\"]}}]', 5, 9),
(38, '2025-02-26 23:27:56.903048', '5', 'Booking #5 - جناح (Grand Hotel)', 2, '[{\"changed\": {\"fields\": [\"\\u062d\\u0627\\u0644\\u0629 \\u0627\\u0644\\u062d\\u062c\\u0632\"]}}]', 5, 9),
(39, '2025-02-26 23:28:20.624485', '5', 'Booking #5 - جناح (Grand Hotel)', 2, '[{\"changed\": {\"fields\": [\"\\u062d\\u0627\\u0644\\u0629 \\u0627\\u0644\\u062d\\u062c\\u0632\"]}}]', 5, 9),
(40, '2025-02-26 23:28:33.456414', '5', 'Booking #5 - جناح (Grand Hotel)', 2, '[{\"changed\": {\"fields\": [\"\\u062d\\u0627\\u0644\\u0629 \\u0627\\u0644\\u062d\\u062c\\u0632\"]}}]', 5, 9);

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
(8, 'auth', 'group'),
(7, 'auth', 'permission'),
(3, 'auth', 'user'),
(38, 'blog', 'category'),
(39, 'blog', 'comment'),
(40, 'blog', 'post'),
(5, 'bookings', 'booking'),
(23, 'bookings', 'bookingdetail'),
(24, 'bookings', 'bookingstatus'),
(25, 'bookings', 'guest'),
(9, 'contenttypes', 'contenttype'),
(12, 'HotelManagement', 'city'),
(13, 'HotelManagement', 'hotel'),
(6, 'HotelManagement', 'hotelrequest'),
(14, 'HotelManagement', 'image'),
(15, 'HotelManagement', 'location'),
(16, 'HotelManagement', 'phone'),
(41, 'notifications', 'notifications'),
(26, 'payments', 'currency'),
(27, 'payments', 'hotelpaymentmethod'),
(28, 'payments', 'payment'),
(29, 'payments', 'paymentoption'),
(30, 'reviews', 'hotelreview'),
(31, 'reviews', 'offer'),
(32, 'reviews', 'roomreview'),
(17, 'rooms', 'availability'),
(18, 'rooms', 'category'),
(19, 'rooms', 'review'),
(20, 'rooms', 'roomimage'),
(21, 'rooms', 'roomprice'),
(22, 'rooms', 'roomstatus'),
(4, 'rooms', 'roomtype'),
(35, 'services', 'hotelservice'),
(33, 'services', 'offer'),
(34, 'services', 'roomtypeservice'),
(10, 'sessions', 'session'),
(42, 'ShoppingCart', 'shoppingcart'),
(43, 'ShoppingCart', 'shoppingcartitem'),
(36, 'token_blacklist', 'blacklistedtoken'),
(37, 'token_blacklist', 'outstandingtoken'),
(11, 'users', 'activitylog'),
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
(1, 'contenttypes', '0001_initial', '2025-02-25 00:45:19.648223'),
(2, 'contenttypes', '0002_remove_content_type_name', '2025-02-25 00:45:19.742599'),
(3, 'auth', '0001_initial', '2025-02-25 00:45:20.041421'),
(4, 'auth', '0002_alter_permission_name_max_length', '2025-02-25 00:45:20.096396'),
(5, 'auth', '0003_alter_user_email_max_length', '2025-02-25 00:45:20.110298'),
(6, 'auth', '0004_alter_user_username_opts', '2025-02-25 00:45:20.121825'),
(7, 'auth', '0005_alter_user_last_login_null', '2025-02-25 00:45:20.142044'),
(8, 'auth', '0006_require_contenttypes_0002', '2025-02-25 00:45:20.147025'),
(9, 'auth', '0007_alter_validators_add_error_messages', '2025-02-25 00:45:20.162982'),
(10, 'auth', '0008_alter_user_username_max_length', '2025-02-25 00:45:20.178504'),
(11, 'auth', '0009_alter_user_last_name_max_length', '2025-02-25 00:45:20.194087'),
(12, 'auth', '0010_alter_group_name_max_length', '2025-02-25 00:45:20.238446'),
(13, 'auth', '0011_update_proxy_permissions', '2025-02-25 00:45:20.249793'),
(14, 'auth', '0012_alter_user_first_name_max_length', '2025-02-25 00:45:20.261801'),
(15, 'users', '0001_initial', '2025-02-25 00:45:21.082066'),
(16, 'HotelManagement', '0001_initial', '2025-02-25 00:45:21.366069'),
(17, 'HotelManagement', '0002_initial', '2025-02-25 00:45:23.275479'),
(18, 'admin', '0001_initial', '2025-02-25 00:45:23.436606'),
(19, 'admin', '0002_logentry_remove_auto_add', '2025-02-25 00:45:23.457670'),
(20, 'admin', '0003_logentry_add_action_flag_choices', '2025-02-25 00:45:23.492601'),
(21, 'blog', '0001_initial', '2025-02-25 00:45:23.577066'),
(22, 'blog', '0002_initial', '2025-02-25 00:45:23.912071'),
(23, 'services', '0001_initial', '2025-02-25 00:45:24.055833'),
(24, 'rooms', '0001_initial', '2025-02-25 00:45:24.204875'),
(25, 'bookings', '0001_initial', '2025-02-25 00:45:24.296980'),
(26, 'bookings', '0002_initial', '2025-02-25 00:45:25.785846'),
(27, 'notifications', '0001_initial', '2025-02-25 00:45:25.811104'),
(28, 'notifications', '0002_initial', '2025-02-25 00:45:26.051984'),
(29, 'payments', '0001_initial', '2025-02-25 00:45:26.140061'),
(30, 'payments', '0002_initial', '2025-02-25 00:45:26.981748'),
(31, 'reviews', '0001_initial', '2025-02-25 00:45:27.059960'),
(32, 'reviews', '0002_initial', '2025-02-25 00:45:28.705846'),
(33, 'rooms', '0002_initial', '2025-02-25 00:45:32.481207'),
(34, 'services', '0002_initial', '2025-02-25 00:45:33.037216'),
(35, 'sessions', '0001_initial', '2025-02-25 00:45:33.100031'),
(36, 'token_blacklist', '0001_initial', '2025-02-25 00:45:33.365145'),
(37, 'token_blacklist', '0002_outstandingtoken_jti_hex', '2025-02-25 00:45:33.450894'),
(38, 'token_blacklist', '0003_auto_20171017_2007', '2025-02-25 00:45:33.531464'),
(39, 'token_blacklist', '0004_auto_20171017_2013', '2025-02-25 00:45:33.670293'),
(40, 'token_blacklist', '0005_remove_outstandingtoken_jti', '2025-02-25 00:45:33.755838'),
(41, 'token_blacklist', '0006_auto_20171017_2113', '2025-02-25 00:45:33.937712'),
(42, 'token_blacklist', '0007_auto_20171017_2214', '2025-02-25 00:45:34.582664'),
(43, 'token_blacklist', '0008_migrate_to_bigautofield', '2025-02-25 00:45:35.580970'),
(44, 'token_blacklist', '0010_fix_migrate_to_bigautofield', '2025-02-25 00:45:35.729451'),
(45, 'token_blacklist', '0011_linearizes_history', '2025-02-25 00:45:35.738422'),
(46, 'token_blacklist', '0012_alter_outstandingtoken_user', '2025-02-25 00:45:35.823693'),
(47, 'ShoppingCart', '0001_initial', '2025-02-25 12:04:00.484927'),
(48, 'ShoppingCart', '0002_rename_price_shoppingcartitem_total_price', '2025-02-25 12:08:56.792568'),
(49, 'ShoppingCart', '0003_alter_shoppingcartitem_item_type', '2025-02-25 12:10:44.034213'),
(50, 'ShoppingCart', '0004_remove_shoppingcartitem_item_id', '2025-02-25 12:12:54.937598');

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
('9uxdkno7cshpaf9cpjonz1tu6wmnn5ue', '.eJxVjEEOwiAQRe_C2hBmBAGX7j0DGZipVA1NSrsy3l2bdKHb_977L5VoXWpau8xpZHVWJ3X43TKVh7QN8J3abdJlass8Zr0peqddXyeW52V3_w4q9fqtA0WPJhoPBZ1hw4NAAUJvnEQbrENhZDuUkG2EzEfkzJ4gkAk5OlDvD8_RN5g:1tmj9J:b_OJab0bY4Sl-_DtPyiETKo91BWeudXJAEUoZej9M7Y', '2025-03-11 00:50:13.587074'),
('ghbwg3mlkd4hdw8ht67vnm1gt0jd8h31', '.eJxVjMsOwiAQRf-FtSGlPKZ06d5vIANMLWrAQJtojP-uTbrQ7T3nnhdzuC6zWxtVlyIbmWGH381juFLeQLxgPhceSl5q8nxT-E4bP5VIt-Pu_gVmbPP3TVb1xiNE3StvpLG9QPAA5IOWhAARpAiDVRPqTlsJIUxCCSvFgEp5u0UbtZZKdvS4p_pkY_f-AHY0PpM:1tn0bC:Jpm0x7IveznkAqV7e4ndYyHM94FEy3uIfryMBoKHtO0', '2025-03-11 19:28:10.206029'),
('rlcvc1ff89rc6ni30dhafiguga645jm0', '.eJxVjEEOwiAQAP_C2RBKKbQ9evcNZJfdWtRAU9pEY_y7IelBrzOTeQsP-zb7vfDqI4lROHH6ZQjhzqkKukG6Zhly2taIsibysEVeMvHjfLR_gxnKXLd9aGliojAAKtQGetDUYKucbsAaVLrrwHWutWwRJudCMJNBC3oAMlCnhUuJOXl-LnF9iVF9vr8AP-0:1tnEOD:bCEpfhCtin3pBo4VS9m7uW4GB20RKT2EqsE0A5IMXkU', '2025-03-12 10:11:41.775343'),
('t8iemr1otyvvx1lov7e76izu0kft7prf', '.eJxVjMsOwiAURP-FtSFcKC-X7vsN5PKSqoGktCvjv1uSLnQ5Z87Mmzjct-L2nla3RHIlllx-mcfwTHUU8YH13mhodVsXT4dCz7bTucX0up3u30HBXsaaWamYRMFATooBt5PJXOhkECAI6RNoI4XMmRl2MKW5QQQD_sgeNPl8AaBDNhQ:1tnPb3:Yp1wgaMIsbgEr1PGoDqB4u1PfBUtVkCbLo3PKMHU21Q', '2025-03-12 22:09:41.115728');

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
(1, '2025-02-25 00:47:44.222564', '2025-02-25 00:47:44.222564', NULL, 'الرياض', '', 'المملكة العربية السعودية', NULL, NULL);

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
  `manager_id` bigint(20) DEFAULT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL,
  `location_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `hotelmanagement_hotel`
--

INSERT INTO `hotelmanagement_hotel` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `slug`, `profile_picture`, `description`, `business_license_number`, `document_path`, `is_verified`, `verification_date`, `created_by_id`, `manager_id`, `updated_by_id`, `location_id`) VALUES
(1, '2025-02-25 00:47:49.598195', '2025-02-25 00:47:49.605094', NULL, 'Grand Hotel', 'grand-hotel', 'hotels/images/app-store.png', 'A wonderful grand hotel experience', NULL, '', 1, '2025-02-25 00:47:49.593580', NULL, 3, NULL, 1),
(2, '2025-02-25 00:47:49.641881', '2025-02-25 00:47:49.652474', NULL, 'فندق الفخامة', 'luxury-resort', 'hotels/images/ammarcv.png', 'A wonderful luxury resort experience', NULL, '', 1, '2025-02-25 00:47:49.636736', NULL, 2, NULL, 1),
(3, '2025-02-25 00:47:49.688099', '2025-02-25 00:47:49.696125', NULL, 'فندق الأعمال', 'business-inn', 'hotels/images/ammarcv.png', 'A wonderful business inn experience', NULL, '', 1, '2025-02-25 00:47:49.684099', NULL, NULL, NULL, 1),
(4, '2025-02-25 00:47:49.734109', '2025-02-25 00:47:49.740100', NULL, 'فندق العائلة', 'family-stay', 'hotels/images/ammarcv.png', 'A wonderful family stay experience', NULL, '', 1, '2025-02-25 00:47:49.727097', NULL, NULL, NULL, 1),
(5, '2025-02-25 00:47:49.773788', '2025-02-25 00:47:49.780989', NULL, 'منتجع الشاطئ', 'beach-resort', 'hotels/images/ammarcv_nhvqoMS.png', 'A wonderful beach resort experience', NULL, '', 1, '2025-02-25 00:47:49.767800', NULL, NULL, NULL, 1);

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

--
-- Dumping data for table `hotelmanagement_image`
--

INSERT INTO `hotelmanagement_image` (`id`, `created_at`, `updated_at`, `deleted_at`, `image_path`, `image_url`, `created_by_id`, `hotel_id`, `updated_by_id`) VALUES
(1, '2025-02-25 00:47:49.612097', '2025-02-25 00:47:49.612097', NULL, 'hotels/images/car-img.jpg', NULL, NULL, 1, NULL),
(2, '2025-02-25 00:47:49.622698', '2025-02-25 00:47:49.623700', NULL, 'hotels/images/car-img.jpg', NULL, NULL, 1, NULL),
(3, '2025-02-25 00:47:49.628706', '2025-02-25 00:47:49.628706', NULL, 'hotels/images/ammarcv_nhvqoMS.png', NULL, NULL, 1, NULL),
(4, '2025-02-25 00:47:49.658474', '2025-02-25 00:47:49.658474', NULL, 'hotels/images/ammarcv.png', NULL, NULL, 2, NULL),
(5, '2025-02-25 00:47:49.669874', '2025-02-25 00:47:49.669874', NULL, 'hotels/images/alamo.png', NULL, NULL, 2, NULL),
(6, '2025-02-25 00:47:49.675494', '2025-02-25 00:47:49.675494', NULL, 'hotels/images/alamo.png', NULL, NULL, 2, NULL),
(7, '2025-02-25 00:47:49.706096', '2025-02-25 00:47:49.706096', NULL, 'hotels/images/ammarcv.png', NULL, NULL, 3, NULL),
(8, '2025-02-25 00:47:49.711098', '2025-02-25 00:47:49.711098', NULL, 'hotels/images/app-store.png', NULL, NULL, 3, NULL),
(9, '2025-02-25 00:47:49.721097', '2025-02-25 00:47:49.721097', NULL, 'hotels/images/app-store.png', NULL, NULL, 3, NULL),
(10, '2025-02-25 00:47:49.747102', '2025-02-25 00:47:49.747102', NULL, 'hotels/images/alamo.png', NULL, NULL, 4, NULL),
(11, '2025-02-25 00:47:49.755098', '2025-02-25 00:47:49.755098', NULL, 'hotels/images/app-store.png', NULL, NULL, 4, NULL),
(12, '2025-02-25 00:47:49.760108', '2025-02-25 00:47:49.760108', NULL, 'hotels/images/alamo.png', NULL, NULL, 4, NULL),
(13, '2025-02-25 00:47:49.786986', '2025-02-25 00:47:49.786986', NULL, 'hotels/images/ammarcv_nhvqoMS.png', NULL, NULL, 5, NULL),
(14, '2025-02-25 00:47:49.795669', '2025-02-25 00:47:49.795669', NULL, 'hotels/images/car-img.jpg', NULL, NULL, 5, NULL),
(15, '2025-02-25 00:47:49.801184', '2025-02-25 00:47:49.801184', NULL, 'hotels/images/ammarcv_nhvqoMS.png', NULL, NULL, 5, NULL);

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
(1, '2025-02-25 00:47:44.233565', '2025-02-25 00:47:44.233565', NULL, 'وسط مدينة الرياض', 1, NULL, NULL);

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
  `sender_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
(1, '2025-02-25 00:47:58.675565', '2025-02-25 00:47:58.675565', NULL, 'ريال سعودي', 'SAR', NULL, 1, NULL),
(2, '2025-02-25 00:47:58.685569', '2025-02-25 00:47:58.685569', NULL, 'دولار أمريكي', 'USD', NULL, 1, NULL),
(3, '2025-02-25 00:47:58.699840', '2025-02-25 00:47:58.699840', NULL, 'ريال سعودي', 'SAR', NULL, 2, NULL),
(4, '2025-02-25 00:47:58.710307', '2025-02-25 00:47:58.710307', NULL, 'دولار أمريكي', 'USD', NULL, 2, NULL),
(5, '2025-02-25 00:47:58.724694', '2025-02-25 00:47:58.724694', NULL, 'ريال سعودي', 'SAR', NULL, 3, NULL),
(6, '2025-02-25 00:47:58.737524', '2025-02-25 00:47:58.737524', NULL, 'دولار أمريكي', 'USD', NULL, 3, NULL),
(7, '2025-02-25 00:47:58.748574', '2025-02-25 00:47:58.748574', NULL, 'ريال سعودي', 'SAR', NULL, 4, NULL),
(8, '2025-02-25 00:47:58.761434', '2025-02-25 00:47:58.761434', NULL, 'دولار أمريكي', 'USD', NULL, 4, NULL),
(9, '2025-02-25 00:47:58.774485', '2025-02-25 00:47:58.774485', NULL, 'ريال سعودي', 'SAR', NULL, 5, NULL),
(10, '2025-02-25 00:47:58.786323', '2025-02-25 00:47:58.786323', NULL, 'دولار أمريكي', 'USD', NULL, 5, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `payments_hotelpaymentmethod`
--

CREATE TABLE `payments_hotelpaymentmethod` (
  `id` bigint(20) NOT NULL,
  `account_name` varchar(100) NOT NULL,
  `account_number` varchar(50) NOT NULL,
  `iban` varchar(50) NOT NULL,
  `description` longtext DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `hotel_id` bigint(20) NOT NULL,
  `payment_option_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payments_hotelpaymentmethod`
--

INSERT INTO `payments_hotelpaymentmethod` (`id`, `account_name`, `account_number`, `iban`, `description`, `is_active`, `hotel_id`, `payment_option_id`) VALUES
(1, 'Grand Hotel Account', '4412831388', 'SA14285157935506625981', 'Payment instructions for بطاقة ائتمان', 1, 1, 1),
(2, 'Grand Hotel Account', '2181829018', 'SA28194120750451920740', 'Payment instructions for Apple Pay', 1, 1, 2),
(3, 'Grand Hotel Account', '8553924985', 'SA37381711423082704021', 'Payment instructions for تحويل بنكي', 1, 1, 3),
(4, 'Grand Hotel Account', '2624433049', 'SA30981365334279417037', 'Payment instructions for نقداً', 1, 1, 4),
(5, 'Grand Hotel Account', '1692005140', 'SA47934659997753436985', 'Payment instructions for بطاقة ائتمان', 1, 1, 5),
(6, 'Grand Hotel Account', '2262365579', 'SA50924087691236755415', 'Payment instructions for Apple Pay', 1, 1, 6),
(7, 'Grand Hotel Account', '6236183491', 'SA56089074090736914782', 'Payment instructions for تحويل بنكي', 1, 1, 7),
(8, 'Grand Hotel Account', '3306980543', 'SA67423631085014990711', 'Payment instructions for نقداً', 1, 1, 8),
(9, 'Grand Hotel Account', '2611079110', 'SA88406568724265599341', 'Payment instructions for بطاقة ائتمان', 1, 1, 9),
(10, 'Grand Hotel Account', '1400443183', 'SA32116895575727548225', 'Payment instructions for Apple Pay', 1, 1, 10),
(11, 'Grand Hotel Account', '3606794054', 'SA85983027348241297881', 'Payment instructions for تحويل بنكي', 1, 1, 11),
(12, 'Grand Hotel Account', '4670356829', 'SA79728379658094711913', 'Payment instructions for نقداً', 1, 1, 12),
(13, 'Grand Hotel Account', '8251052011', 'SA89050604874590390983', 'Payment instructions for بطاقة ائتمان', 1, 1, 13),
(14, 'Grand Hotel Account', '9599823519', 'SA92206089744563315653', 'Payment instructions for Apple Pay', 1, 1, 14),
(15, 'Grand Hotel Account', '2807776380', 'SA78814978302035165387', 'Payment instructions for تحويل بنكي', 1, 1, 15),
(16, 'Grand Hotel Account', '6332724976', 'SA25719805227982958317', 'Payment instructions for نقداً', 1, 1, 16),
(17, 'Grand Hotel Account', '9090900751', 'SA59848014346322484927', 'Payment instructions for بطاقة ائتمان', 1, 1, 17),
(18, 'Grand Hotel Account', '7255209045', 'SA32155607141229366311', 'Payment instructions for Apple Pay', 1, 1, 18),
(19, 'Grand Hotel Account', '1444501953', 'SA58841577902472966372', 'Payment instructions for تحويل بنكي', 1, 1, 19),
(20, 'Grand Hotel Account', '4490941482', 'SA91777893907808145684', 'Payment instructions for نقداً', 1, 1, 20),
(21, 'Grand Hotel Account', '6300723534', 'SA97694364833438846484', 'Payment instructions for بطاقة ائتمان', 1, 1, 21),
(22, 'Grand Hotel Account', '7309893383', 'SA53503773435529568005', 'Payment instructions for Apple Pay', 1, 1, 22),
(23, 'Grand Hotel Account', '7496017605', 'SA49187563825548663693', 'Payment instructions for تحويل بنكي', 1, 1, 23),
(24, 'Grand Hotel Account', '1197650583', 'SA39241158191608603920', 'Payment instructions for نقداً', 1, 1, 24),
(25, 'Grand Hotel Account', '9672884068', 'SA67696523126676112993', 'Payment instructions for بطاقة ائتمان', 1, 1, 25),
(26, 'Grand Hotel Account', '5316118764', 'SA93172507027132892071', 'Payment instructions for Apple Pay', 1, 1, 26),
(27, 'Grand Hotel Account', '1638020335', 'SA27126309384691015882', 'Payment instructions for تحويل بنكي', 1, 1, 27),
(28, 'Grand Hotel Account', '3536368964', 'SA36056032473982901827', 'Payment instructions for نقداً', 1, 1, 28),
(29, 'Grand Hotel Account', '8289904879', 'SA33043030630907534407', 'Payment instructions for بطاقة ائتمان', 1, 1, 29),
(30, 'Grand Hotel Account', '8777791571', 'SA95299931494908692187', 'Payment instructions for Apple Pay', 1, 1, 30),
(31, 'Grand Hotel Account', '5025977063', 'SA79066924619227271181', 'Payment instructions for تحويل بنكي', 1, 1, 31),
(32, 'Grand Hotel Account', '5733097750', 'SA99185564554495085801', 'Payment instructions for نقداً', 1, 1, 32),
(33, 'Grand Hotel Account', '9576230531', 'SA44281014784647232653', 'Payment instructions for بطاقة ائتمان', 1, 1, 33),
(34, 'Grand Hotel Account', '8985404299', 'SA91987226294034121994', 'Payment instructions for Apple Pay', 1, 1, 34),
(35, 'Grand Hotel Account', '3656461136', 'SA60021467437141104492', 'Payment instructions for تحويل بنكي', 1, 1, 35),
(36, 'Grand Hotel Account', '3849414568', 'SA24086195052193535296', 'Payment instructions for نقداً', 1, 1, 36),
(37, 'Grand Hotel Account', '1134758557', 'SA91416022633791932296', 'Payment instructions for بطاقة ائتمان', 1, 1, 37),
(38, 'Grand Hotel Account', '9368003424', 'SA92752894662464182983', 'Payment instructions for Apple Pay', 1, 1, 38),
(39, 'Grand Hotel Account', '2390074472', 'SA61458969872322455655', 'Payment instructions for تحويل بنكي', 1, 1, 39),
(40, 'Grand Hotel Account', '2628756909', 'SA96530825770025495796', 'Payment instructions for نقداً', 1, 1, 40),
(41, 'فندق الفخامة Account', '4643586484', 'SA95454077211127923858', 'Payment instructions for بطاقة ائتمان', 1, 2, 1),
(42, 'فندق الفخامة Account', '5454269643', 'SA41174961128478753309', 'Payment instructions for Apple Pay', 1, 2, 2),
(43, 'فندق الفخامة Account', '2293224565', 'SA17553833640864968312', 'Payment instructions for تحويل بنكي', 1, 2, 3),
(44, 'فندق الفخامة Account', '1784168626', 'SA81576910082588183755', 'Payment instructions for نقداً', 1, 2, 4),
(45, 'فندق الفخامة Account', '8787990382', 'SA95922006016234371464', 'Payment instructions for بطاقة ائتمان', 1, 2, 5),
(46, 'فندق الفخامة Account', '8507732202', 'SA22171138483692853703', 'Payment instructions for Apple Pay', 1, 2, 6),
(47, 'فندق الفخامة Account', '6711807782', 'SA68825374322137258546', 'Payment instructions for تحويل بنكي', 1, 2, 7),
(48, 'فندق الفخامة Account', '4949730344', 'SA72821896404182271116', 'Payment instructions for نقداً', 1, 2, 8),
(49, 'فندق الفخامة Account', '4969793140', 'SA35963382098381976430', 'Payment instructions for بطاقة ائتمان', 1, 2, 9),
(50, 'فندق الفخامة Account', '1590623381', 'SA11308165624521814320', 'Payment instructions for Apple Pay', 1, 2, 10),
(51, 'فندق الفخامة Account', '5484037417', 'SA94335479307131969184', 'Payment instructions for تحويل بنكي', 1, 2, 11),
(52, 'فندق الفخامة Account', '7757905981', 'SA53232262727938980990', 'Payment instructions for نقداً', 1, 2, 12),
(53, 'فندق الفخامة Account', '3130289999', 'SA86385103538930184799', 'Payment instructions for بطاقة ائتمان', 1, 2, 13),
(54, 'فندق الفخامة Account', '2854874451', 'SA39252819328483797150', 'Payment instructions for Apple Pay', 1, 2, 14),
(55, 'فندق الفخامة Account', '1792230313', 'SA98999280033963096818', 'Payment instructions for تحويل بنكي', 1, 2, 15),
(56, 'فندق الفخامة Account', '3528524906', 'SA71524731340928198846', 'Payment instructions for نقداً', 1, 2, 16),
(57, 'فندق الفخامة Account', '4492668431', 'SA79309111453852905156', 'Payment instructions for بطاقة ائتمان', 1, 2, 17),
(58, 'فندق الفخامة Account', '5354644232', 'SA10278969008947609313', 'Payment instructions for Apple Pay', 1, 2, 18),
(59, 'فندق الفخامة Account', '1393291135', 'SA94153600576249517125', 'Payment instructions for تحويل بنكي', 1, 2, 19),
(60, 'فندق الفخامة Account', '3340534333', 'SA45588251657116364670', 'Payment instructions for نقداً', 1, 2, 20),
(61, 'فندق الفخامة Account', '5698232432', 'SA30447501711476862278', 'Payment instructions for بطاقة ائتمان', 1, 2, 21),
(62, 'فندق الفخامة Account', '3749691903', 'SA96436640645611630842', 'Payment instructions for Apple Pay', 1, 2, 22),
(63, 'فندق الفخامة Account', '1088876025', 'SA25843362204649932363', 'Payment instructions for تحويل بنكي', 1, 2, 23),
(64, 'فندق الفخامة Account', '4881580759', 'SA87973331686128003109', 'Payment instructions for نقداً', 1, 2, 24),
(65, 'فندق الفخامة Account', '9995408304', 'SA54905305893247131876', 'Payment instructions for بطاقة ائتمان', 1, 2, 25),
(66, 'فندق الفخامة Account', '2798387669', 'SA45375004128410680655', 'Payment instructions for Apple Pay', 1, 2, 26),
(67, 'فندق الفخامة Account', '6433727747', 'SA78276008009126559307', 'Payment instructions for تحويل بنكي', 1, 2, 27),
(68, 'فندق الفخامة Account', '2219890379', 'SA58069455056870617916', 'Payment instructions for نقداً', 1, 2, 28),
(69, 'فندق الفخامة Account', '1328435962', 'SA39236480029554866518', 'Payment instructions for بطاقة ائتمان', 1, 2, 29),
(70, 'فندق الفخامة Account', '2658599824', 'SA34158159812793227711', 'Payment instructions for Apple Pay', 1, 2, 30),
(71, 'فندق الفخامة Account', '4001256140', 'SA43511617408248691003', 'Payment instructions for تحويل بنكي', 1, 2, 31),
(72, 'فندق الفخامة Account', '8149497108', 'SA74099724096240766857', 'Payment instructions for نقداً', 1, 2, 32),
(73, 'فندق الفخامة Account', '5559172127', 'SA55349569728047599700', 'Payment instructions for بطاقة ائتمان', 1, 2, 33),
(74, 'فندق الفخامة Account', '1922140865', 'SA14492397187331548828', 'Payment instructions for Apple Pay', 1, 2, 34),
(75, 'فندق الفخامة Account', '1218682612', 'SA10444886918336415314', 'Payment instructions for تحويل بنكي', 1, 2, 35),
(76, 'فندق الفخامة Account', '6207580890', 'SA58824981946754261373', 'Payment instructions for نقداً', 1, 2, 36),
(77, 'فندق الفخامة Account', '2919247410', 'SA86044794869481992083', 'Payment instructions for بطاقة ائتمان', 1, 2, 37),
(78, 'فندق الفخامة Account', '8764171860', 'SA59597028392454581920', 'Payment instructions for Apple Pay', 1, 2, 38),
(79, 'فندق الفخامة Account', '2151185902', 'SA24622082413480823459', 'Payment instructions for تحويل بنكي', 1, 2, 39),
(80, 'فندق الفخامة Account', '1818110255', 'SA47889542856826104819', 'Payment instructions for نقداً', 1, 2, 40),
(81, 'فندق الأعمال Account', '8684525061', 'SA59942168397066208573', 'Payment instructions for بطاقة ائتمان', 1, 3, 1),
(82, 'فندق الأعمال Account', '8300917384', 'SA60255014463600093667', 'Payment instructions for Apple Pay', 1, 3, 2),
(83, 'فندق الأعمال Account', '8338936340', 'SA95542646414039099129', 'Payment instructions for تحويل بنكي', 1, 3, 3),
(84, 'فندق الأعمال Account', '3566854870', 'SA60597472698562543020', 'Payment instructions for نقداً', 1, 3, 4),
(85, 'فندق الأعمال Account', '5881433753', 'SA83388621456412234131', 'Payment instructions for بطاقة ائتمان', 1, 3, 5),
(86, 'فندق الأعمال Account', '9976270205', 'SA87542132734316891608', 'Payment instructions for Apple Pay', 1, 3, 6),
(87, 'فندق الأعمال Account', '6977115217', 'SA56938297209073443044', 'Payment instructions for تحويل بنكي', 1, 3, 7),
(88, 'فندق الأعمال Account', '3046554459', 'SA79406712015788561969', 'Payment instructions for نقداً', 1, 3, 8),
(89, 'فندق الأعمال Account', '3172376323', 'SA89407699055516640489', 'Payment instructions for بطاقة ائتمان', 1, 3, 9),
(90, 'فندق الأعمال Account', '7187123758', 'SA79455478638714883737', 'Payment instructions for Apple Pay', 1, 3, 10),
(91, 'فندق الأعمال Account', '3684191842', 'SA85108646643938324766', 'Payment instructions for تحويل بنكي', 1, 3, 11),
(92, 'فندق الأعمال Account', '2830848541', 'SA51945066170712199950', 'Payment instructions for نقداً', 1, 3, 12),
(93, 'فندق الأعمال Account', '5550731348', 'SA29586682416788724637', 'Payment instructions for بطاقة ائتمان', 1, 3, 13),
(94, 'فندق الأعمال Account', '3494106402', 'SA17112353044044294514', 'Payment instructions for Apple Pay', 1, 3, 14),
(95, 'فندق الأعمال Account', '4175153413', 'SA38827412999359858326', 'Payment instructions for تحويل بنكي', 1, 3, 15),
(96, 'فندق الأعمال Account', '8122759639', 'SA53699173084298370048', 'Payment instructions for نقداً', 1, 3, 16),
(97, 'فندق الأعمال Account', '8868751763', 'SA52477341852926405404', 'Payment instructions for بطاقة ائتمان', 1, 3, 17),
(98, 'فندق الأعمال Account', '7682901100', 'SA29671976781476379852', 'Payment instructions for Apple Pay', 1, 3, 18),
(99, 'فندق الأعمال Account', '3764679566', 'SA88738500390368597683', 'Payment instructions for تحويل بنكي', 1, 3, 19),
(100, 'فندق الأعمال Account', '5511649922', 'SA18932356727558433435', 'Payment instructions for نقداً', 1, 3, 20),
(101, 'فندق الأعمال Account', '2126450507', 'SA88882709056400563044', 'Payment instructions for بطاقة ائتمان', 1, 3, 21),
(102, 'فندق الأعمال Account', '9054376984', 'SA80214356195214040379', 'Payment instructions for Apple Pay', 1, 3, 22),
(103, 'فندق الأعمال Account', '1239329337', 'SA95845360961452960096', 'Payment instructions for تحويل بنكي', 1, 3, 23),
(104, 'فندق الأعمال Account', '4607062486', 'SA92525819070849943743', 'Payment instructions for نقداً', 1, 3, 24),
(105, 'فندق الأعمال Account', '5122184154', 'SA97911990202441263587', 'Payment instructions for بطاقة ائتمان', 1, 3, 25),
(106, 'فندق الأعمال Account', '5440907854', 'SA57745240175545784809', 'Payment instructions for Apple Pay', 1, 3, 26),
(107, 'فندق الأعمال Account', '6030487102', 'SA16539768294440106263', 'Payment instructions for تحويل بنكي', 1, 3, 27),
(108, 'فندق الأعمال Account', '9537577001', 'SA65100675682292943501', 'Payment instructions for نقداً', 1, 3, 28),
(109, 'فندق الأعمال Account', '8357155100', 'SA89132762939784308162', 'Payment instructions for بطاقة ائتمان', 1, 3, 29),
(110, 'فندق الأعمال Account', '2367982539', 'SA81140206909637274601', 'Payment instructions for Apple Pay', 1, 3, 30),
(111, 'فندق الأعمال Account', '2329635492', 'SA43267581076366034380', 'Payment instructions for تحويل بنكي', 1, 3, 31),
(112, 'فندق الأعمال Account', '7900139090', 'SA56930023899737512116', 'Payment instructions for نقداً', 1, 3, 32),
(113, 'فندق الأعمال Account', '9810510439', 'SA90830061588808076955', 'Payment instructions for بطاقة ائتمان', 1, 3, 33),
(114, 'فندق الأعمال Account', '6107415007', 'SA22007906252687989479', 'Payment instructions for Apple Pay', 1, 3, 34),
(115, 'فندق الأعمال Account', '8595349790', 'SA94701284349353525338', 'Payment instructions for تحويل بنكي', 1, 3, 35),
(116, 'فندق الأعمال Account', '9921477958', 'SA65739990356735042233', 'Payment instructions for نقداً', 1, 3, 36),
(117, 'فندق الأعمال Account', '1031542498', 'SA21263409455122679589', 'Payment instructions for بطاقة ائتمان', 1, 3, 37),
(118, 'فندق الأعمال Account', '2993543677', 'SA15402236504304573511', 'Payment instructions for Apple Pay', 1, 3, 38),
(119, 'فندق الأعمال Account', '8134604708', 'SA96004258642055295347', 'Payment instructions for تحويل بنكي', 1, 3, 39),
(120, 'فندق الأعمال Account', '2991729362', 'SA24310151051775665074', 'Payment instructions for نقداً', 1, 3, 40),
(121, 'فندق العائلة Account', '9892486346', 'SA86404498576494377087', 'Payment instructions for بطاقة ائتمان', 1, 4, 1),
(122, 'فندق العائلة Account', '3071496764', 'SA38273904241231524587', 'Payment instructions for Apple Pay', 1, 4, 2),
(123, 'فندق العائلة Account', '2740132362', 'SA64448615254790895183', 'Payment instructions for تحويل بنكي', 1, 4, 3),
(124, 'فندق العائلة Account', '8837721211', 'SA71233901851917988817', 'Payment instructions for نقداً', 1, 4, 4),
(125, 'فندق العائلة Account', '7463320712', 'SA64354048811796744690', 'Payment instructions for بطاقة ائتمان', 1, 4, 5),
(126, 'فندق العائلة Account', '7729087975', 'SA13037961965903626650', 'Payment instructions for Apple Pay', 1, 4, 6),
(127, 'فندق العائلة Account', '4632442440', 'SA12012958333543184704', 'Payment instructions for تحويل بنكي', 1, 4, 7),
(128, 'فندق العائلة Account', '1343727776', 'SA79330063829092417845', 'Payment instructions for نقداً', 1, 4, 8),
(129, 'فندق العائلة Account', '5806850611', 'SA61857671674552084299', 'Payment instructions for بطاقة ائتمان', 1, 4, 9),
(130, 'فندق العائلة Account', '6887618782', 'SA50737487912589355078', 'Payment instructions for Apple Pay', 1, 4, 10),
(131, 'فندق العائلة Account', '3226054213', 'SA93367154737634542443', 'Payment instructions for تحويل بنكي', 1, 4, 11),
(132, 'فندق العائلة Account', '2873913191', 'SA69339217607827367320', 'Payment instructions for نقداً', 1, 4, 12),
(133, 'فندق العائلة Account', '1343239848', 'SA65912601270939983276', 'Payment instructions for بطاقة ائتمان', 1, 4, 13),
(134, 'فندق العائلة Account', '1159300041', 'SA78009095366627139962', 'Payment instructions for Apple Pay', 1, 4, 14),
(135, 'فندق العائلة Account', '5727130874', 'SA72773423763659454672', 'Payment instructions for تحويل بنكي', 1, 4, 15),
(136, 'فندق العائلة Account', '6771966576', 'SA97420224535773558571', 'Payment instructions for نقداً', 1, 4, 16),
(137, 'فندق العائلة Account', '4122439137', 'SA25386399064148290541', 'Payment instructions for بطاقة ائتمان', 1, 4, 17),
(138, 'فندق العائلة Account', '6685131095', 'SA98114951518926080753', 'Payment instructions for Apple Pay', 1, 4, 18),
(139, 'فندق العائلة Account', '7641532840', 'SA74913815040750206291', 'Payment instructions for تحويل بنكي', 1, 4, 19),
(140, 'فندق العائلة Account', '5958557554', 'SA17864089852164536780', 'Payment instructions for نقداً', 1, 4, 20),
(141, 'فندق العائلة Account', '8066475856', 'SA35758829985410754564', 'Payment instructions for بطاقة ائتمان', 1, 4, 21),
(142, 'فندق العائلة Account', '8423410371', 'SA18849268973792965290', 'Payment instructions for Apple Pay', 1, 4, 22),
(143, 'فندق العائلة Account', '4999675409', 'SA47784986370620045903', 'Payment instructions for تحويل بنكي', 1, 4, 23),
(144, 'فندق العائلة Account', '2027797426', 'SA11770066073842723185', 'Payment instructions for نقداً', 1, 4, 24),
(145, 'فندق العائلة Account', '3485142196', 'SA56053317170350880868', 'Payment instructions for بطاقة ائتمان', 1, 4, 25),
(146, 'فندق العائلة Account', '7286889432', 'SA36920509874372276870', 'Payment instructions for Apple Pay', 1, 4, 26),
(147, 'فندق العائلة Account', '5936429084', 'SA55579447278471486755', 'Payment instructions for تحويل بنكي', 1, 4, 27),
(148, 'فندق العائلة Account', '6802029426', 'SA59536830529930882659', 'Payment instructions for نقداً', 1, 4, 28),
(149, 'فندق العائلة Account', '3713025078', 'SA20880463135176049346', 'Payment instructions for بطاقة ائتمان', 1, 4, 29),
(150, 'فندق العائلة Account', '9208411821', 'SA94428091260073371308', 'Payment instructions for Apple Pay', 1, 4, 30),
(151, 'فندق العائلة Account', '9039280366', 'SA53159262981809441444', 'Payment instructions for تحويل بنكي', 1, 4, 31),
(152, 'فندق العائلة Account', '5618454838', 'SA27023678133560475129', 'Payment instructions for نقداً', 1, 4, 32),
(153, 'فندق العائلة Account', '8446738799', 'SA94650115184937796810', 'Payment instructions for بطاقة ائتمان', 1, 4, 33),
(154, 'فندق العائلة Account', '4787856888', 'SA50472324604717117262', 'Payment instructions for Apple Pay', 1, 4, 34),
(155, 'فندق العائلة Account', '9345232896', 'SA45024563619351003734', 'Payment instructions for تحويل بنكي', 1, 4, 35),
(156, 'فندق العائلة Account', '5450970119', 'SA44947716984831000659', 'Payment instructions for نقداً', 1, 4, 36),
(157, 'فندق العائلة Account', '7575202537', 'SA76846000830649212415', 'Payment instructions for بطاقة ائتمان', 1, 4, 37),
(158, 'فندق العائلة Account', '8562127070', 'SA56476398979247794964', 'Payment instructions for Apple Pay', 1, 4, 38),
(159, 'فندق العائلة Account', '1988951235', 'SA92908611743304111549', 'Payment instructions for تحويل بنكي', 1, 4, 39),
(160, 'فندق العائلة Account', '6007058057', 'SA98224932154672524609', 'Payment instructions for نقداً', 1, 4, 40),
(161, 'منتجع الشاطئ Account', '5885422912', 'SA68561597269515568378', 'Payment instructions for بطاقة ائتمان', 1, 5, 1),
(162, 'منتجع الشاطئ Account', '3787543310', 'SA94048968311304507238', 'Payment instructions for Apple Pay', 1, 5, 2),
(163, 'منتجع الشاطئ Account', '9882311555', 'SA88078637363289971610', 'Payment instructions for تحويل بنكي', 1, 5, 3),
(164, 'منتجع الشاطئ Account', '1806071991', 'SA21308995563498131266', 'Payment instructions for نقداً', 1, 5, 4),
(165, 'منتجع الشاطئ Account', '3779010213', 'SA60570984091172283131', 'Payment instructions for بطاقة ائتمان', 1, 5, 5),
(166, 'منتجع الشاطئ Account', '8878676576', 'SA33651014421053489232', 'Payment instructions for Apple Pay', 1, 5, 6),
(167, 'منتجع الشاطئ Account', '8167877740', 'SA81753350895324982225', 'Payment instructions for تحويل بنكي', 1, 5, 7),
(168, 'منتجع الشاطئ Account', '3536641542', 'SA52126037526681454033', 'Payment instructions for نقداً', 1, 5, 8),
(169, 'منتجع الشاطئ Account', '5338698788', 'SA26581565116758964575', 'Payment instructions for بطاقة ائتمان', 1, 5, 9),
(170, 'منتجع الشاطئ Account', '6470814226', 'SA28489497933008116578', 'Payment instructions for Apple Pay', 1, 5, 10),
(171, 'منتجع الشاطئ Account', '1572890977', 'SA25498128037196810513', 'Payment instructions for تحويل بنكي', 1, 5, 11),
(172, 'منتجع الشاطئ Account', '4801605923', 'SA34927213071357574746', 'Payment instructions for نقداً', 1, 5, 12),
(173, 'منتجع الشاطئ Account', '9236222853', 'SA67367401759348244482', 'Payment instructions for بطاقة ائتمان', 1, 5, 13),
(174, 'منتجع الشاطئ Account', '3602633301', 'SA97230818528495659335', 'Payment instructions for Apple Pay', 1, 5, 14),
(175, 'منتجع الشاطئ Account', '1388258986', 'SA72206162106686771701', 'Payment instructions for تحويل بنكي', 1, 5, 15),
(176, 'منتجع الشاطئ Account', '6400373195', 'SA51320796532252941382', 'Payment instructions for نقداً', 1, 5, 16),
(177, 'منتجع الشاطئ Account', '7314285116', 'SA94559428321128463632', 'Payment instructions for بطاقة ائتمان', 1, 5, 17),
(178, 'منتجع الشاطئ Account', '3248919050', 'SA79969489803254172235', 'Payment instructions for Apple Pay', 1, 5, 18),
(179, 'منتجع الشاطئ Account', '1623746501', 'SA55529942004470786415', 'Payment instructions for تحويل بنكي', 1, 5, 19),
(180, 'منتجع الشاطئ Account', '8309638471', 'SA81459306252538586010', 'Payment instructions for نقداً', 1, 5, 20),
(181, 'منتجع الشاطئ Account', '9858859709', 'SA99015431542723108946', 'Payment instructions for بطاقة ائتمان', 1, 5, 21),
(182, 'منتجع الشاطئ Account', '4412998068', 'SA69375546688867640896', 'Payment instructions for Apple Pay', 1, 5, 22),
(183, 'منتجع الشاطئ Account', '2426370942', 'SA80235123563060701721', 'Payment instructions for تحويل بنكي', 1, 5, 23),
(184, 'منتجع الشاطئ Account', '8807293951', 'SA91438435782714804359', 'Payment instructions for نقداً', 1, 5, 24),
(185, 'منتجع الشاطئ Account', '9990746354', 'SA46682413605997996784', 'Payment instructions for بطاقة ائتمان', 1, 5, 25),
(186, 'منتجع الشاطئ Account', '2587101134', 'SA92215509604129378879', 'Payment instructions for Apple Pay', 1, 5, 26),
(187, 'منتجع الشاطئ Account', '3931778972', 'SA34597132368576431807', 'Payment instructions for تحويل بنكي', 1, 5, 27),
(188, 'منتجع الشاطئ Account', '9470779423', 'SA13430747609468379681', 'Payment instructions for نقداً', 1, 5, 28),
(189, 'منتجع الشاطئ Account', '6461821858', 'SA36749913267666740016', 'Payment instructions for بطاقة ائتمان', 1, 5, 29),
(190, 'منتجع الشاطئ Account', '3809860228', 'SA55347886698007891207', 'Payment instructions for Apple Pay', 1, 5, 30),
(191, 'منتجع الشاطئ Account', '6209513611', 'SA77296972321852714382', 'Payment instructions for تحويل بنكي', 1, 5, 31),
(192, 'منتجع الشاطئ Account', '2951301547', 'SA53394283992759756095', 'Payment instructions for نقداً', 1, 5, 32),
(193, 'منتجع الشاطئ Account', '3913184596', 'SA95346224966363153636', 'Payment instructions for بطاقة ائتمان', 1, 5, 33),
(194, 'منتجع الشاطئ Account', '5019253069', 'SA58027997903338311970', 'Payment instructions for Apple Pay', 1, 5, 34),
(195, 'منتجع الشاطئ Account', '9398295118', 'SA13272163456014866337', 'Payment instructions for تحويل بنكي', 1, 5, 35),
(196, 'منتجع الشاطئ Account', '2862798010', 'SA68743348649386812471', 'Payment instructions for نقداً', 1, 5, 36),
(197, 'منتجع الشاطئ Account', '5020568525', 'SA57512007028192874484', 'Payment instructions for بطاقة ائتمان', 1, 5, 37),
(198, 'منتجع الشاطئ Account', '6574782294', 'SA18091060358410363535', 'Payment instructions for Apple Pay', 1, 5, 38),
(199, 'منتجع الشاطئ Account', '9099379593', 'SA76373830772246131172', 'Payment instructions for تحويل بنكي', 1, 5, 39),
(200, 'منتجع الشاطئ Account', '3766575784', 'SA38303687148156890557', 'Payment instructions for نقداً', 1, 5, 40);

-- --------------------------------------------------------

--
-- Table structure for table `payments_payment`
--

CREATE TABLE `payments_payment` (
  `id` bigint(20) NOT NULL,
  `payment_status` varchar(20) NOT NULL,
  `payment_date` datetime(6) NOT NULL,
  `payment_subtotal` decimal(10,2) NOT NULL,
  `payment_discount` decimal(10,2) NOT NULL,
  `payment_totalamount` decimal(10,2) NOT NULL,
  `payment_currency` varchar(25) NOT NULL,
  `payment_note` longtext DEFAULT NULL,
  `payment_type` varchar(20) NOT NULL,
  `booking_id` bigint(20) NOT NULL,
  `payment_method_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payments_paymentoption`
--

CREATE TABLE `payments_paymentoption` (
  `id` bigint(20) NOT NULL,
  `method_name` varchar(100) NOT NULL,
  `logo` varchar(100) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `currency_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payments_paymentoption`
--

INSERT INTO `payments_paymentoption` (`id`, `method_name`, `logo`, `is_active`, `currency_id`) VALUES
(1, 'بطاقة ائتمان', 'payment_logos/credit_card.png', 1, 10),
(2, 'Apple Pay', 'payment_logos/apple_pay.png', 1, 10),
(3, 'تحويل بنكي', 'payment_logos/bank_transfer.png', 1, 10),
(4, 'نقداً', 'payment_logos/cash.png', 1, 10),
(5, 'بطاقة ائتمان', 'payment_logos/credit_card.png', 1, 8),
(6, 'Apple Pay', 'payment_logos/apple_pay.png', 1, 8),
(7, 'تحويل بنكي', 'payment_logos/bank_transfer.png', 1, 8),
(8, 'نقداً', 'payment_logos/cash.png', 1, 8),
(9, 'بطاقة ائتمان', 'payment_logos/credit_card.png', 1, 6),
(10, 'Apple Pay', 'payment_logos/apple_pay.png', 1, 6),
(11, 'تحويل بنكي', 'payment_logos/bank_transfer.png', 1, 6),
(12, 'نقداً', 'payment_logos/cash.png', 1, 6),
(13, 'بطاقة ائتمان', 'payment_logos/credit_card.png', 1, 4),
(14, 'Apple Pay', 'payment_logos/apple_pay.png', 1, 4),
(15, 'تحويل بنكي', 'payment_logos/bank_transfer.png', 1, 4),
(16, 'نقداً', 'payment_logos/cash.png', 1, 4),
(17, 'بطاقة ائتمان', 'payment_logos/credit_card.png', 1, 2),
(18, 'Apple Pay', 'payment_logos/apple_pay.png', 1, 2),
(19, 'تحويل بنكي', 'payment_logos/bank_transfer.png', 1, 2),
(20, 'نقداً', 'payment_logos/cash.png', 1, 2),
(21, 'بطاقة ائتمان', 'payment_logos/credit_card.png', 1, 5),
(22, 'Apple Pay', 'payment_logos/apple_pay.png', 1, 5),
(23, 'تحويل بنكي', 'payment_logos/bank_transfer.png', 1, 5),
(24, 'نقداً', 'payment_logos/cash.png', 1, 5),
(25, 'بطاقة ائتمان', 'payment_logos/credit_card.png', 1, 3),
(26, 'Apple Pay', 'payment_logos/apple_pay.png', 1, 3),
(27, 'تحويل بنكي', 'payment_logos/bank_transfer.png', 1, 3),
(28, 'نقداً', 'payment_logos/cash.png', 1, 3),
(29, 'بطاقة ائتمان', 'payment_logos/credit_card.png', 1, 7),
(30, 'Apple Pay', 'payment_logos/apple_pay.png', 1, 7),
(31, 'تحويل بنكي', 'payment_logos/bank_transfer.png', 1, 7),
(32, 'نقداً', 'payment_logos/cash.png', 1, 7),
(33, 'بطاقة ائتمان', 'payment_logos/credit_card.png', 1, 9),
(34, 'Apple Pay', 'payment_logos/apple_pay.png', 1, 9),
(35, 'تحويل بنكي', 'payment_logos/bank_transfer.png', 1, 9),
(36, 'نقداً', 'payment_logos/cash.png', 1, 9),
(37, 'بطاقة ائتمان', 'payment_logos/credit_card.png', 1, 1),
(38, 'Apple Pay', 'payment_logos/apple_pay.png', 1, 1),
(39, 'تحويل بنكي', 'payment_logos/bank_transfer.png', 1, 1),
(40, 'نقداً', 'payment_logos/cash.png', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `reviews_hotelreview`
--

CREATE TABLE `reviews_hotelreview` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `slug` varchar(255) NOT NULL,
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

--
-- Dumping data for table `reviews_hotelreview`
--

INSERT INTO `reviews_hotelreview` (`id`, `created_at`, `updated_at`, `deleted_at`, `slug`, `rating_service`, `rating_location`, `rating_value_for_money`, `rating_cleanliness`, `review`, `status`, `created_by_id`, `hotel_id`, `updated_by_id`, `user_id`) VALUES
(1, '2025-02-26 12:06:53.947005', '2025-02-26 12:06:53.947005', NULL, '', 4, 4, 3, 4, 'kljlkj\r\n', 1, NULL, 1, NULL, 7);

-- --------------------------------------------------------

--
-- Table structure for table `reviews_offer`
--

CREATE TABLE `reviews_offer` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `description` longtext NOT NULL,
  `start_date` date NOT NULL,
  `slug` varchar(255) NOT NULL,
  `end_date` date NOT NULL,
  `discount_percentage` decimal(5,2) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `hotel_id` bigint(20) NOT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
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
  `slug` varchar(255) NOT NULL,
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
  `updated_by_id` bigint(20) DEFAULT NULL,
  `room_status_id` bigint(20) NOT NULL,
  `room_type_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rooms_availability`
--

INSERT INTO `rooms_availability` (`id`, `created_at`, `updated_at`, `deleted_at`, `availability_date`, `available_rooms`, `notes`, `created_by_id`, `hotel_id`, `updated_by_id`, `room_status_id`, `room_type_id`) VALUES
(1, '2025-02-25 00:47:51.366753', '2025-02-25 00:47:51.366753', NULL, '2025-02-25', 15, 'Automatically generated for 2025-02-25', NULL, 1, NULL, 1, 3),
(2, '2025-02-25 00:47:51.376750', '2025-02-26 23:28:33.450398', NULL, '2025-02-26', 12, 'Automatically generated for 2025-02-26', NULL, 1, NULL, 1, 3),
(3, '2025-02-25 00:47:51.384750', '2025-02-26 23:28:33.452423', NULL, '2025-02-27', 12, 'Automatically generated for 2025-02-27', NULL, 1, NULL, 1, 3),
(4, '2025-02-25 00:47:51.393264', '2025-02-26 23:28:33.454417', NULL, '2025-02-28', 12, 'Automatically generated for 2025-02-28', NULL, 1, NULL, 1, 3),
(5, '2025-02-25 00:47:51.400789', '2025-02-25 00:47:51.400789', NULL, '2025-03-01', 13, 'Automatically generated for 2025-03-01', NULL, 1, NULL, 1, 3),
(6, '2025-02-25 00:47:51.408789', '2025-02-25 00:47:51.408789', NULL, '2025-03-02', 13, 'Automatically generated for 2025-03-02', NULL, 1, NULL, 1, 3),
(7, '2025-02-25 00:47:51.416828', '2025-02-25 00:47:51.416828', NULL, '2025-03-03', 13, 'Automatically generated for 2025-03-03', NULL, 1, NULL, 1, 3),
(8, '2025-02-25 00:47:51.425242', '2025-02-25 00:47:51.425242', NULL, '2025-03-04', 15, 'Automatically generated for 2025-03-04', NULL, 1, NULL, 1, 3),
(9, '2025-02-25 00:47:51.433748', '2025-02-25 00:47:51.433748', NULL, '2025-03-05', 13, 'Automatically generated for 2025-03-05', NULL, 1, NULL, 1, 3),
(10, '2025-02-25 00:47:51.441748', '2025-02-25 00:47:51.441748', NULL, '2025-03-06', 14, 'Automatically generated for 2025-03-06', NULL, 1, NULL, 1, 3),
(11, '2025-02-25 00:47:51.451060', '2025-02-25 00:47:51.451060', NULL, '2025-03-07', 13, 'Automatically generated for 2025-03-07', NULL, 1, NULL, 1, 3),
(12, '2025-02-25 00:47:51.458816', '2025-02-25 00:47:51.458816', NULL, '2025-03-08', 12, 'Automatically generated for 2025-03-08', NULL, 1, NULL, 1, 3),
(13, '2025-02-25 00:47:51.466947', '2025-02-25 00:47:51.466947', NULL, '2025-03-09', 15, 'Automatically generated for 2025-03-09', NULL, 1, NULL, 1, 3),
(14, '2025-02-25 00:47:51.475460', '2025-02-25 00:47:51.475460', NULL, '2025-03-10', 13, 'Automatically generated for 2025-03-10', NULL, 1, NULL, 1, 3),
(15, '2025-02-25 00:47:51.483499', '2025-02-25 00:47:51.483499', NULL, '2025-03-11', 13, 'Automatically generated for 2025-03-11', NULL, 1, NULL, 1, 3),
(16, '2025-02-25 00:47:51.492372', '2025-02-25 00:47:51.492372', NULL, '2025-03-12', 15, 'Automatically generated for 2025-03-12', NULL, 1, NULL, 1, 3),
(17, '2025-02-25 00:47:51.500139', '2025-02-25 00:47:51.500139', NULL, '2025-03-13', 14, 'Automatically generated for 2025-03-13', NULL, 1, NULL, 1, 3),
(18, '2025-02-25 00:47:51.507960', '2025-02-25 00:47:51.507960', NULL, '2025-03-14', 12, 'Automatically generated for 2025-03-14', NULL, 1, NULL, 1, 3),
(19, '2025-02-25 00:47:51.516170', '2025-02-25 00:47:51.516170', NULL, '2025-03-15', 13, 'Automatically generated for 2025-03-15', NULL, 1, NULL, 1, 3),
(20, '2025-02-25 00:47:51.524287', '2025-02-25 00:47:51.524287', NULL, '2025-03-16', 14, 'Automatically generated for 2025-03-16', NULL, 1, NULL, 1, 3),
(21, '2025-02-25 00:47:51.533168', '2025-02-25 00:47:51.533168', NULL, '2025-03-17', 13, 'Automatically generated for 2025-03-17', NULL, 1, NULL, 1, 3),
(22, '2025-02-25 00:47:51.541802', '2025-02-25 00:47:51.541802', NULL, '2025-03-18', 15, 'Automatically generated for 2025-03-18', NULL, 1, NULL, 1, 3),
(23, '2025-02-25 00:47:51.549777', '2025-02-25 00:47:51.549777', NULL, '2025-03-19', 13, 'Automatically generated for 2025-03-19', NULL, 1, NULL, 1, 3),
(24, '2025-02-25 00:47:51.558343', '2025-02-25 00:47:51.558343', NULL, '2025-03-20', 13, 'Automatically generated for 2025-03-20', NULL, 1, NULL, 1, 3),
(25, '2025-02-25 00:47:51.566923', '2025-02-25 00:47:51.566923', NULL, '2025-03-21', 13, 'Automatically generated for 2025-03-21', NULL, 1, NULL, 1, 3),
(26, '2025-02-25 00:47:51.574524', '2025-02-25 00:47:51.574524', NULL, '2025-03-22', 14, 'Automatically generated for 2025-03-22', NULL, 1, NULL, 1, 3),
(27, '2025-02-25 00:47:51.582974', '2025-02-25 00:47:51.582974', NULL, '2025-03-23', 15, 'Automatically generated for 2025-03-23', NULL, 1, NULL, 1, 3),
(28, '2025-02-25 00:47:51.589978', '2025-02-25 00:47:51.589978', NULL, '2025-03-24', 14, 'Automatically generated for 2025-03-24', NULL, 1, NULL, 1, 3),
(29, '2025-02-25 00:47:51.598190', '2025-02-25 00:47:51.598190', NULL, '2025-03-25', 12, 'Automatically generated for 2025-03-25', NULL, 1, NULL, 1, 3),
(30, '2025-02-25 00:47:51.606142', '2025-02-25 00:47:51.606142', NULL, '2025-03-26', 13, 'Automatically generated for 2025-03-26', NULL, 1, NULL, 1, 3),
(31, '2025-02-25 00:47:51.614687', '2025-02-25 00:47:51.614687', NULL, '2025-02-25', 6, 'Automatically generated for 2025-02-25', NULL, 1, NULL, 1, 5),
(32, '2025-02-25 00:47:51.622723', '2025-02-25 00:47:51.623429', NULL, '2025-02-26', 7, 'Automatically generated for 2025-02-26', NULL, 1, NULL, 1, 5),
(33, '2025-02-25 00:47:51.631298', '2025-02-25 00:47:51.631298', NULL, '2025-02-27', 8, 'Automatically generated for 2025-02-27', NULL, 1, NULL, 1, 5),
(34, '2025-02-25 00:47:51.639298', '2025-02-25 00:47:51.639298', NULL, '2025-02-28', 8, 'Automatically generated for 2025-02-28', NULL, 1, NULL, 1, 5),
(35, '2025-02-25 00:47:51.648119', '2025-02-25 00:47:51.648119', NULL, '2025-03-01', 7, 'Automatically generated for 2025-03-01', NULL, 1, NULL, 1, 5),
(36, '2025-02-25 00:47:51.656023', '2025-02-25 00:47:51.656023', NULL, '2025-03-02', 9, 'Automatically generated for 2025-03-02', NULL, 1, NULL, 1, 5),
(37, '2025-02-25 00:47:51.664820', '2025-02-25 00:47:51.664820', NULL, '2025-03-03', 6, 'Automatically generated for 2025-03-03', NULL, 1, NULL, 1, 5),
(38, '2025-02-25 00:47:51.673010', '2025-02-25 00:47:51.673010', NULL, '2025-03-04', 8, 'Automatically generated for 2025-03-04', NULL, 1, NULL, 1, 5),
(39, '2025-02-25 00:47:51.680906', '2025-02-25 00:47:51.680906', NULL, '2025-03-05', 8, 'Automatically generated for 2025-03-05', NULL, 1, NULL, 1, 5),
(40, '2025-02-25 00:47:51.688812', '2025-02-25 00:47:51.688812', NULL, '2025-03-06', 7, 'Automatically generated for 2025-03-06', NULL, 1, NULL, 1, 5),
(41, '2025-02-25 00:47:51.698590', '2025-02-25 00:47:51.698590', NULL, '2025-03-07', 9, 'Automatically generated for 2025-03-07', NULL, 1, NULL, 1, 5),
(42, '2025-02-25 00:47:51.707725', '2025-02-25 00:47:51.707725', NULL, '2025-03-08', 9, 'Automatically generated for 2025-03-08', NULL, 1, NULL, 1, 5),
(43, '2025-02-25 00:47:51.715723', '2025-02-25 00:47:51.715723', NULL, '2025-03-09', 8, 'Automatically generated for 2025-03-09', NULL, 1, NULL, 1, 5),
(44, '2025-02-25 00:47:51.727761', '2025-02-25 00:47:51.727761', NULL, '2025-03-10', 6, 'Automatically generated for 2025-03-10', NULL, 1, NULL, 1, 5),
(45, '2025-02-25 00:47:51.735760', '2025-02-25 00:47:51.735760', NULL, '2025-03-11', 9, 'Automatically generated for 2025-03-11', NULL, 1, NULL, 1, 5),
(46, '2025-02-25 00:47:51.743518', '2025-02-25 00:47:51.743518', NULL, '2025-03-12', 6, 'Automatically generated for 2025-03-12', NULL, 1, NULL, 1, 5),
(47, '2025-02-25 00:47:51.752205', '2025-02-25 00:47:51.752205', NULL, '2025-03-13', 8, 'Automatically generated for 2025-03-13', NULL, 1, NULL, 1, 5),
(48, '2025-02-25 00:47:51.760214', '2025-02-25 00:47:51.760214', NULL, '2025-03-14', 8, 'Automatically generated for 2025-03-14', NULL, 1, NULL, 1, 5),
(49, '2025-02-25 00:47:51.768918', '2025-02-25 00:47:51.768918', NULL, '2025-03-15', 6, 'Automatically generated for 2025-03-15', NULL, 1, NULL, 1, 5),
(50, '2025-02-25 00:47:51.778210', '2025-02-25 00:47:51.778210', NULL, '2025-03-16', 6, 'Automatically generated for 2025-03-16', NULL, 1, NULL, 1, 5),
(51, '2025-02-25 00:47:51.786854', '2025-02-25 00:47:51.786854', NULL, '2025-03-17', 8, 'Automatically generated for 2025-03-17', NULL, 1, NULL, 1, 5),
(52, '2025-02-25 00:47:51.796246', '2025-02-25 00:47:51.796246', NULL, '2025-03-18', 7, 'Automatically generated for 2025-03-18', NULL, 1, NULL, 1, 5),
(53, '2025-02-25 00:47:51.805168', '2025-02-25 00:47:51.805168', NULL, '2025-03-19', 8, 'Automatically generated for 2025-03-19', NULL, 1, NULL, 1, 5),
(54, '2025-02-25 00:47:51.815133', '2025-02-25 00:47:51.815133', NULL, '2025-03-20', 9, 'Automatically generated for 2025-03-20', NULL, 1, NULL, 1, 5),
(55, '2025-02-25 00:47:51.825715', '2025-02-25 00:47:51.825715', NULL, '2025-03-21', 8, 'Automatically generated for 2025-03-21', NULL, 1, NULL, 1, 5),
(56, '2025-02-25 00:47:51.835432', '2025-02-25 00:47:51.835432', NULL, '2025-03-22', 8, 'Automatically generated for 2025-03-22', NULL, 1, NULL, 1, 5),
(57, '2025-02-25 00:47:51.844494', '2025-02-25 00:47:51.844494', NULL, '2025-03-23', 9, 'Automatically generated for 2025-03-23', NULL, 1, NULL, 1, 5),
(58, '2025-02-25 00:47:51.854797', '2025-02-25 00:47:51.854797', NULL, '2025-03-24', 9, 'Automatically generated for 2025-03-24', NULL, 1, NULL, 1, 5),
(59, '2025-02-25 00:47:51.864206', '2025-02-25 00:47:51.864206', NULL, '2025-03-25', 8, 'Automatically generated for 2025-03-25', NULL, 1, NULL, 1, 5),
(60, '2025-02-25 00:47:51.872969', '2025-02-25 00:47:51.872969', NULL, '2025-03-26', 6, 'Automatically generated for 2025-03-26', NULL, 1, NULL, 1, 5),
(61, '2025-02-25 00:47:51.883140', '2025-02-25 00:47:51.883140', NULL, '2025-02-25', 14, 'Automatically generated for 2025-02-25', NULL, 1, NULL, 1, 4),
(62, '2025-02-25 00:47:51.901831', '2025-02-25 00:47:51.901831', NULL, '2025-02-26', 12, 'Automatically generated for 2025-02-26', NULL, 1, NULL, 1, 4),
(63, '2025-02-25 00:47:51.910336', '2025-02-25 00:47:51.910336', NULL, '2025-02-27', 14, 'Automatically generated for 2025-02-27', NULL, 1, NULL, 1, 4),
(64, '2025-02-25 00:47:51.919339', '2025-02-25 00:47:51.919339', NULL, '2025-02-28', 13, 'Automatically generated for 2025-02-28', NULL, 1, NULL, 1, 4),
(65, '2025-02-25 00:47:51.928079', '2025-02-25 00:47:51.928079', NULL, '2025-03-01', 14, 'Automatically generated for 2025-03-01', NULL, 1, NULL, 1, 4),
(66, '2025-02-25 00:47:51.937944', '2025-02-25 00:47:51.937944', NULL, '2025-03-02', 14, 'Automatically generated for 2025-03-02', NULL, 1, NULL, 1, 4),
(67, '2025-02-25 00:47:51.946416', '2025-02-25 00:47:51.946416', NULL, '2025-03-03', 14, 'Automatically generated for 2025-03-03', NULL, 1, NULL, 1, 4),
(68, '2025-02-25 00:47:51.954927', '2025-02-25 00:47:51.954927', NULL, '2025-03-04', 14, 'Automatically generated for 2025-03-04', NULL, 1, NULL, 1, 4),
(69, '2025-02-25 00:47:51.963955', '2025-02-25 00:47:51.963955', NULL, '2025-03-05', 14, 'Automatically generated for 2025-03-05', NULL, 1, NULL, 1, 4),
(70, '2025-02-25 00:47:51.973854', '2025-02-25 00:47:51.973854', NULL, '2025-03-06', 13, 'Automatically generated for 2025-03-06', NULL, 1, NULL, 1, 4),
(71, '2025-02-25 00:47:51.982691', '2025-02-25 00:47:51.982691', NULL, '2025-03-07', 13, 'Automatically generated for 2025-03-07', NULL, 1, NULL, 1, 4),
(72, '2025-02-25 00:47:51.992221', '2025-02-25 00:47:51.992221', NULL, '2025-03-08', 11, 'Automatically generated for 2025-03-08', NULL, 1, NULL, 1, 4),
(73, '2025-02-25 00:47:52.000798', '2025-02-25 00:47:52.000798', NULL, '2025-03-09', 13, 'Automatically generated for 2025-03-09', NULL, 1, NULL, 1, 4),
(74, '2025-02-25 00:47:52.009551', '2025-02-25 00:47:52.009551', NULL, '2025-03-10', 11, 'Automatically generated for 2025-03-10', NULL, 1, NULL, 1, 4),
(75, '2025-02-25 00:47:52.017580', '2025-02-25 00:47:52.017580', NULL, '2025-03-11', 12, 'Automatically generated for 2025-03-11', NULL, 1, NULL, 1, 4),
(76, '2025-02-25 00:47:52.026398', '2025-02-25 00:47:52.026398', NULL, '2025-03-12', 14, 'Automatically generated for 2025-03-12', NULL, 1, NULL, 1, 4),
(77, '2025-02-25 00:47:52.035150', '2025-02-25 00:47:52.035150', NULL, '2025-03-13', 12, 'Automatically generated for 2025-03-13', NULL, 1, NULL, 1, 4),
(78, '2025-02-25 00:47:52.044181', '2025-02-25 00:47:52.044181', NULL, '2025-03-14', 12, 'Automatically generated for 2025-03-14', NULL, 1, NULL, 1, 4),
(79, '2025-02-25 00:47:52.053747', '2025-02-25 00:47:52.053747', NULL, '2025-03-15', 14, 'Automatically generated for 2025-03-15', NULL, 1, NULL, 1, 4),
(80, '2025-02-25 00:47:52.062411', '2025-02-25 00:47:52.062411', NULL, '2025-03-16', 14, 'Automatically generated for 2025-03-16', NULL, 1, NULL, 1, 4),
(81, '2025-02-25 00:47:52.071369', '2025-02-25 00:47:52.071369', NULL, '2025-03-17', 11, 'Automatically generated for 2025-03-17', NULL, 1, NULL, 1, 4),
(82, '2025-02-25 00:47:52.079060', '2025-02-25 00:47:52.079060', NULL, '2025-03-18', 11, 'Automatically generated for 2025-03-18', NULL, 1, NULL, 1, 4),
(83, '2025-02-25 00:47:52.088953', '2025-02-25 00:47:52.088953', NULL, '2025-03-19', 13, 'Automatically generated for 2025-03-19', NULL, 1, NULL, 1, 4),
(84, '2025-02-25 00:47:52.098084', '2025-02-25 00:47:52.098084', NULL, '2025-03-20', 13, 'Automatically generated for 2025-03-20', NULL, 1, NULL, 1, 4),
(85, '2025-02-25 00:47:52.105914', '2025-02-25 00:47:52.105914', NULL, '2025-03-21', 12, 'Automatically generated for 2025-03-21', NULL, 1, NULL, 1, 4),
(86, '2025-02-25 00:47:52.114699', '2025-02-25 00:47:52.114699', NULL, '2025-03-22', 11, 'Automatically generated for 2025-03-22', NULL, 1, NULL, 1, 4),
(87, '2025-02-25 00:47:52.124230', '2025-02-25 00:47:52.124230', NULL, '2025-03-23', 12, 'Automatically generated for 2025-03-23', NULL, 1, NULL, 1, 4),
(88, '2025-02-25 00:47:52.132253', '2025-02-25 00:47:52.132253', NULL, '2025-03-24', 11, 'Automatically generated for 2025-03-24', NULL, 1, NULL, 1, 4),
(89, '2025-02-25 00:47:52.140604', '2025-02-25 00:47:52.140604', NULL, '2025-03-25', 14, 'Automatically generated for 2025-03-25', NULL, 1, NULL, 1, 4),
(90, '2025-02-25 00:47:52.150796', '2025-02-25 00:47:52.150796', NULL, '2025-03-26', 14, 'Automatically generated for 2025-03-26', NULL, 1, NULL, 1, 4),
(91, '2025-02-25 00:47:52.160316', '2025-02-25 00:47:52.160316', NULL, '2025-02-25', 15, 'Automatically generated for 2025-02-25', NULL, 1, NULL, 1, 2),
(92, '2025-02-25 00:47:52.169762', '2025-02-25 00:47:52.169762', NULL, '2025-02-26', 13, 'Automatically generated for 2025-02-26', NULL, 1, NULL, 1, 2),
(93, '2025-02-25 00:47:52.178453', '2025-02-25 00:47:52.178453', NULL, '2025-02-27', 14, 'Automatically generated for 2025-02-27', NULL, 1, NULL, 1, 2),
(94, '2025-02-25 00:47:52.188641', '2025-02-25 00:47:52.188641', NULL, '2025-02-28', 16, 'Automatically generated for 2025-02-28', NULL, 1, NULL, 1, 2),
(95, '2025-02-25 00:47:52.200581', '2025-02-25 00:47:52.200581', NULL, '2025-03-01', 15, 'Automatically generated for 2025-03-01', NULL, 1, NULL, 1, 2),
(96, '2025-02-25 00:47:52.209904', '2025-02-25 00:47:52.209904', NULL, '2025-03-02', 14, 'Automatically generated for 2025-03-02', NULL, 1, NULL, 1, 2),
(97, '2025-02-25 00:47:52.219435', '2025-02-25 00:47:52.219435', NULL, '2025-03-03', 15, 'Automatically generated for 2025-03-03', NULL, 1, NULL, 1, 2),
(98, '2025-02-25 00:47:52.228286', '2025-02-25 00:47:52.228286', NULL, '2025-03-04', 16, 'Automatically generated for 2025-03-04', NULL, 1, NULL, 1, 2),
(99, '2025-02-25 00:47:52.236174', '2025-02-25 00:47:52.237174', NULL, '2025-03-05', 14, 'Automatically generated for 2025-03-05', NULL, 1, NULL, 1, 2),
(100, '2025-02-25 00:47:52.245176', '2025-02-25 00:47:52.245176', NULL, '2025-03-06', 16, 'Automatically generated for 2025-03-06', NULL, 1, NULL, 1, 2),
(101, '2025-02-25 00:47:52.252963', '2025-02-25 00:47:52.252963', NULL, '2025-03-07', 15, 'Automatically generated for 2025-03-07', NULL, 1, NULL, 1, 2),
(102, '2025-02-25 00:47:52.262497', '2025-02-25 00:47:52.262497', NULL, '2025-03-08', 14, 'Automatically generated for 2025-03-08', NULL, 1, NULL, 1, 2),
(103, '2025-02-25 00:47:52.271105', '2025-02-25 00:47:52.271105', NULL, '2025-03-09', 16, 'Automatically generated for 2025-03-09', NULL, 1, NULL, 1, 2),
(104, '2025-02-25 00:47:52.280126', '2025-02-25 00:47:52.280126', NULL, '2025-03-10', 13, 'Automatically generated for 2025-03-10', NULL, 1, NULL, 1, 2),
(105, '2025-02-25 00:47:52.289124', '2025-02-25 00:47:52.289124', NULL, '2025-03-11', 14, 'Automatically generated for 2025-03-11', NULL, 1, NULL, 1, 2),
(106, '2025-02-25 00:47:52.298884', '2025-02-25 00:47:52.298884', NULL, '2025-03-12', 14, 'Automatically generated for 2025-03-12', NULL, 1, NULL, 1, 2),
(107, '2025-02-25 00:47:52.307881', '2025-02-25 00:47:52.307881', NULL, '2025-03-13', 15, 'Automatically generated for 2025-03-13', NULL, 1, NULL, 1, 2),
(108, '2025-02-25 00:47:52.316654', '2025-02-25 00:47:52.316654', NULL, '2025-03-14', 15, 'Automatically generated for 2025-03-14', NULL, 1, NULL, 1, 2),
(109, '2025-02-25 00:47:52.328022', '2025-02-25 00:47:52.328022', NULL, '2025-03-15', 15, 'Automatically generated for 2025-03-15', NULL, 1, NULL, 1, 2),
(110, '2025-02-25 00:47:52.337411', '2025-02-25 00:47:52.338409', NULL, '2025-03-16', 15, 'Automatically generated for 2025-03-16', NULL, 1, NULL, 1, 2),
(111, '2025-02-25 00:47:52.347036', '2025-02-25 00:47:52.347036', NULL, '2025-03-17', 16, 'Automatically generated for 2025-03-17', NULL, 1, NULL, 1, 2),
(112, '2025-02-25 00:47:52.355915', '2025-02-25 00:47:52.355915', NULL, '2025-03-18', 16, 'Automatically generated for 2025-03-18', NULL, 1, NULL, 1, 2),
(113, '2025-02-25 00:47:52.364197', '2025-02-25 00:47:52.364948', NULL, '2025-03-19', 16, 'Automatically generated for 2025-03-19', NULL, 1, NULL, 1, 2),
(114, '2025-02-25 00:47:52.371982', '2025-02-25 00:47:52.371982', NULL, '2025-03-20', 14, 'Automatically generated for 2025-03-20', NULL, 1, NULL, 1, 2),
(115, '2025-02-25 00:47:52.381581', '2025-02-25 00:47:52.381581', NULL, '2025-03-21', 15, 'Automatically generated for 2025-03-21', NULL, 1, NULL, 1, 2),
(116, '2025-02-25 00:47:52.389604', '2025-02-25 00:47:52.389604', NULL, '2025-03-22', 16, 'Automatically generated for 2025-03-22', NULL, 1, NULL, 1, 2),
(117, '2025-02-25 00:47:52.398256', '2025-02-25 00:47:52.398256', NULL, '2025-03-23', 14, 'Automatically generated for 2025-03-23', NULL, 1, NULL, 1, 2),
(118, '2025-02-25 00:47:52.407144', '2025-02-25 00:47:52.407144', NULL, '2025-03-24', 15, 'Automatically generated for 2025-03-24', NULL, 1, NULL, 1, 2),
(119, '2025-02-25 00:47:52.415574', '2025-02-25 00:47:52.415574', NULL, '2025-03-25', 14, 'Automatically generated for 2025-03-25', NULL, 1, NULL, 1, 2),
(120, '2025-02-25 00:47:52.424574', '2025-02-25 00:47:52.424574', NULL, '2025-03-26', 15, 'Automatically generated for 2025-03-26', NULL, 1, NULL, 1, 2),
(121, '2025-02-25 00:47:52.432575', '2025-02-25 00:47:52.432575', NULL, '2025-02-25', 17, 'Automatically generated for 2025-02-25', NULL, 1, NULL, 1, 1),
(122, '2025-02-25 00:47:52.440609', '2025-02-25 00:47:52.441611', NULL, '2025-02-26', 14, 'Automatically generated for 2025-02-26', NULL, 1, NULL, 1, 1),
(123, '2025-02-25 00:47:52.450257', '2025-02-25 00:47:52.450257', NULL, '2025-02-27', 16, 'Automatically generated for 2025-02-27', NULL, 1, NULL, 1, 1),
(124, '2025-02-25 00:47:52.459090', '2025-02-25 00:47:52.459090', NULL, '2025-02-28', 14, 'Automatically generated for 2025-02-28', NULL, 1, NULL, 1, 1),
(125, '2025-02-25 00:47:52.468090', '2025-02-25 00:47:52.468090', NULL, '2025-03-01', 17, 'Automatically generated for 2025-03-01', NULL, 1, NULL, 1, 1),
(126, '2025-02-25 00:47:52.477090', '2025-02-25 00:47:52.477090', NULL, '2025-03-02', 14, 'Automatically generated for 2025-03-02', NULL, 1, NULL, 1, 1),
(127, '2025-02-25 00:47:52.486090', '2025-02-25 00:47:52.486090', NULL, '2025-03-03', 16, 'Automatically generated for 2025-03-03', NULL, 1, NULL, 1, 1),
(128, '2025-02-25 00:47:52.495652', '2025-02-25 00:47:52.495652', NULL, '2025-03-04', 14, 'Automatically generated for 2025-03-04', NULL, 1, NULL, 1, 1),
(129, '2025-02-25 00:47:52.504651', '2025-02-25 00:47:52.504651', NULL, '2025-03-05', 14, 'Automatically generated for 2025-03-05', NULL, 1, NULL, 1, 1),
(130, '2025-02-25 00:47:52.513243', '2025-02-25 00:47:52.514243', NULL, '2025-03-06', 16, 'Automatically generated for 2025-03-06', NULL, 1, NULL, 1, 1),
(131, '2025-02-25 00:47:52.522720', '2025-02-25 00:47:52.522720', NULL, '2025-03-07', 14, 'Automatically generated for 2025-03-07', NULL, 1, NULL, 1, 1),
(132, '2025-02-25 00:47:52.532266', '2025-02-25 00:47:52.532266', NULL, '2025-03-08', 15, 'Automatically generated for 2025-03-08', NULL, 1, NULL, 1, 1),
(133, '2025-02-25 00:47:52.540231', '2025-02-25 00:47:52.540231', NULL, '2025-03-09', 17, 'Automatically generated for 2025-03-09', NULL, 1, NULL, 1, 1),
(134, '2025-02-25 00:47:52.553109', '2025-02-25 00:47:52.553109', NULL, '2025-03-10', 17, 'Automatically generated for 2025-03-10', NULL, 1, NULL, 1, 1),
(135, '2025-02-25 00:47:52.562378', '2025-02-25 00:47:52.562378', NULL, '2025-03-11', 16, 'Automatically generated for 2025-03-11', NULL, 1, NULL, 1, 1),
(136, '2025-02-25 00:47:52.575934', '2025-02-25 00:47:52.575934', NULL, '2025-03-12', 16, 'Automatically generated for 2025-03-12', NULL, 1, NULL, 1, 1),
(137, '2025-02-25 00:47:52.583933', '2025-02-25 00:47:52.583933', NULL, '2025-03-13', 17, 'Automatically generated for 2025-03-13', NULL, 1, NULL, 1, 1),
(138, '2025-02-25 00:47:52.592608', '2025-02-25 00:47:52.593478', NULL, '2025-03-14', 17, 'Automatically generated for 2025-03-14', NULL, 1, NULL, 1, 1),
(139, '2025-02-25 00:47:52.603387', '2025-02-25 00:47:52.603387', NULL, '2025-03-15', 16, 'Automatically generated for 2025-03-15', NULL, 1, NULL, 1, 1),
(140, '2025-02-25 00:47:52.612387', '2025-02-25 00:47:52.612387', NULL, '2025-03-16', 16, 'Automatically generated for 2025-03-16', NULL, 1, NULL, 1, 1),
(141, '2025-02-25 00:47:52.621900', '2025-02-25 00:47:52.621900', NULL, '2025-03-17', 14, 'Automatically generated for 2025-03-17', NULL, 1, NULL, 1, 1),
(142, '2025-02-25 00:47:52.630429', '2025-02-25 00:47:52.630429', NULL, '2025-03-18', 17, 'Automatically generated for 2025-03-18', NULL, 1, NULL, 1, 1),
(143, '2025-02-25 00:47:52.639425', '2025-02-25 00:47:52.639425', NULL, '2025-03-19', 14, 'Automatically generated for 2025-03-19', NULL, 1, NULL, 1, 1),
(144, '2025-02-25 00:47:52.649048', '2025-02-25 00:47:52.649048', NULL, '2025-03-20', 15, 'Automatically generated for 2025-03-20', NULL, 1, NULL, 1, 1),
(145, '2025-02-25 00:47:52.658014', '2025-02-25 00:47:52.658014', NULL, '2025-03-21', 17, 'Automatically generated for 2025-03-21', NULL, 1, NULL, 1, 1),
(146, '2025-02-25 00:47:52.667053', '2025-02-25 00:47:52.667053', NULL, '2025-03-22', 15, 'Automatically generated for 2025-03-22', NULL, 1, NULL, 1, 1),
(147, '2025-02-25 00:47:52.676014', '2025-02-25 00:47:52.676014', NULL, '2025-03-23', 16, 'Automatically generated for 2025-03-23', NULL, 1, NULL, 1, 1),
(148, '2025-02-25 00:47:52.687013', '2025-02-25 00:47:52.687013', NULL, '2025-03-24', 15, 'Automatically generated for 2025-03-24', NULL, 1, NULL, 1, 1),
(149, '2025-02-25 00:47:52.696013', '2025-02-25 00:47:52.696013', NULL, '2025-03-25', 14, 'Automatically generated for 2025-03-25', NULL, 1, NULL, 1, 1),
(150, '2025-02-25 00:47:52.705014', '2025-02-25 00:47:52.705014', NULL, '2025-03-26', 14, 'Automatically generated for 2025-03-26', NULL, 1, NULL, 1, 1),
(151, '2025-02-25 00:47:52.736094', '2025-02-25 00:47:52.736094', NULL, '2025-02-25', 5, 'Automatically generated for 2025-02-25', NULL, 2, NULL, 5, 8),
(152, '2025-02-25 00:47:52.746290', '2025-02-25 00:47:52.746290', NULL, '2025-02-26', 5, 'Automatically generated for 2025-02-26', NULL, 2, NULL, 5, 8),
(153, '2025-02-25 00:47:52.754803', '2025-02-25 00:47:52.754803', NULL, '2025-02-27', 3, 'Automatically generated for 2025-02-27', NULL, 2, NULL, 5, 8),
(154, '2025-02-25 00:47:52.763800', '2025-02-25 00:47:52.763800', NULL, '2025-02-28', 3, 'Automatically generated for 2025-02-28', NULL, 2, NULL, 5, 8),
(155, '2025-02-25 00:47:52.772352', '2025-02-25 00:47:52.772352', NULL, '2025-03-01', 4, 'Automatically generated for 2025-03-01', NULL, 2, NULL, 5, 8),
(156, '2025-02-25 00:47:52.782353', '2025-02-25 00:47:52.782353', NULL, '2025-03-02', 3, 'Automatically generated for 2025-03-02', NULL, 2, NULL, 5, 8),
(157, '2025-02-25 00:47:52.791392', '2025-02-25 00:47:52.791392', NULL, '2025-03-03', 3, 'Automatically generated for 2025-03-03', NULL, 2, NULL, 5, 8),
(158, '2025-02-25 00:47:52.799906', '2025-02-25 00:47:52.799906', NULL, '2025-03-04', 6, 'Automatically generated for 2025-03-04', NULL, 2, NULL, 5, 8),
(159, '2025-02-25 00:47:52.809387', '2025-02-25 00:47:52.809387', NULL, '2025-03-05', 4, 'Automatically generated for 2025-03-05', NULL, 2, NULL, 5, 8),
(160, '2025-02-25 00:47:52.820907', '2025-02-25 00:47:52.820907', NULL, '2025-03-06', 4, 'Automatically generated for 2025-03-06', NULL, 2, NULL, 5, 8),
(161, '2025-02-25 00:47:52.829906', '2025-02-25 00:47:52.830944', NULL, '2025-03-07', 3, 'Automatically generated for 2025-03-07', NULL, 2, NULL, 5, 8),
(162, '2025-02-25 00:47:52.838903', '2025-02-25 00:47:52.838903', NULL, '2025-03-08', 3, 'Automatically generated for 2025-03-08', NULL, 2, NULL, 5, 8),
(163, '2025-02-25 00:47:52.848458', '2025-02-25 00:47:52.848458', NULL, '2025-03-09', 4, 'Automatically generated for 2025-03-09', NULL, 2, NULL, 5, 8),
(164, '2025-02-25 00:47:52.857500', '2025-02-25 00:47:52.857500', NULL, '2025-03-10', 6, 'Automatically generated for 2025-03-10', NULL, 2, NULL, 5, 8),
(165, '2025-02-25 00:47:52.866178', '2025-02-25 00:47:52.866178', NULL, '2025-03-11', 5, 'Automatically generated for 2025-03-11', NULL, 2, NULL, 5, 8),
(166, '2025-02-25 00:47:52.874582', '2025-02-25 00:47:52.874582', NULL, '2025-03-12', 3, 'Automatically generated for 2025-03-12', NULL, 2, NULL, 5, 8),
(167, '2025-02-25 00:47:52.883584', '2025-02-25 00:47:52.883584', NULL, '2025-03-13', 5, 'Automatically generated for 2025-03-13', NULL, 2, NULL, 5, 8),
(168, '2025-02-25 00:47:52.892582', '2025-02-25 00:47:52.892582', NULL, '2025-03-14', 6, 'Automatically generated for 2025-03-14', NULL, 2, NULL, 5, 8),
(169, '2025-02-25 00:47:52.902164', '2025-02-25 00:47:52.902164', NULL, '2025-03-15', 4, 'Automatically generated for 2025-03-15', NULL, 2, NULL, 5, 8),
(170, '2025-02-25 00:47:52.910164', '2025-02-25 00:47:52.910164', NULL, '2025-03-16', 5, 'Automatically generated for 2025-03-16', NULL, 2, NULL, 5, 8),
(171, '2025-02-25 00:47:52.918820', '2025-02-25 00:47:52.918820', NULL, '2025-03-17', 5, 'Automatically generated for 2025-03-17', NULL, 2, NULL, 5, 8),
(172, '2025-02-25 00:47:52.927819', '2025-02-25 00:47:52.927819', NULL, '2025-03-18', 3, 'Automatically generated for 2025-03-18', NULL, 2, NULL, 5, 8),
(173, '2025-02-25 00:47:52.937821', '2025-02-25 00:47:52.937821', NULL, '2025-03-19', 3, 'Automatically generated for 2025-03-19', NULL, 2, NULL, 5, 8),
(174, '2025-02-25 00:47:52.946391', '2025-02-25 00:47:52.946391', NULL, '2025-03-20', 4, 'Automatically generated for 2025-03-20', NULL, 2, NULL, 5, 8),
(175, '2025-02-25 00:47:52.954939', '2025-02-25 00:47:52.954939', NULL, '2025-03-21', 3, 'Automatically generated for 2025-03-21', NULL, 2, NULL, 5, 8),
(176, '2025-02-25 00:47:52.963904', '2025-02-25 00:47:52.963904', NULL, '2025-03-22', 5, 'Automatically generated for 2025-03-22', NULL, 2, NULL, 5, 8),
(177, '2025-02-25 00:47:52.972926', '2025-02-25 00:47:52.972926', NULL, '2025-03-23', 6, 'Automatically generated for 2025-03-23', NULL, 2, NULL, 5, 8),
(178, '2025-02-25 00:47:52.981927', '2025-02-25 00:47:52.981927', NULL, '2025-03-24', 4, 'Automatically generated for 2025-03-24', NULL, 2, NULL, 5, 8),
(179, '2025-02-25 00:47:52.990927', '2025-02-25 00:47:52.990927', NULL, '2025-03-25', 6, 'Automatically generated for 2025-03-25', NULL, 2, NULL, 5, 8),
(180, '2025-02-25 00:47:52.999947', '2025-02-25 00:47:52.999947', NULL, '2025-03-26', 5, 'Automatically generated for 2025-03-26', NULL, 2, NULL, 5, 8),
(181, '2025-02-25 00:47:53.007947', '2025-02-25 00:47:53.007947', NULL, '2025-02-25', 15, 'Automatically generated for 2025-02-25', NULL, 2, NULL, 5, 10),
(182, '2025-02-25 00:47:53.017518', '2025-02-25 00:47:53.017518', NULL, '2025-02-26', 14, 'Automatically generated for 2025-02-26', NULL, 2, NULL, 5, 10),
(183, '2025-02-25 00:47:53.026519', '2025-02-25 00:47:53.026519', NULL, '2025-02-27', 15, 'Automatically generated for 2025-02-27', NULL, 2, NULL, 5, 10),
(184, '2025-02-25 00:47:53.035519', '2025-02-25 00:47:53.035519', NULL, '2025-02-28', 14, 'Automatically generated for 2025-02-28', NULL, 2, NULL, 5, 10),
(185, '2025-02-25 00:47:53.045209', '2025-02-25 00:47:53.045419', NULL, '2025-03-01', 17, 'Automatically generated for 2025-03-01', NULL, 2, NULL, 5, 10),
(186, '2025-02-25 00:47:53.053936', '2025-02-25 00:47:53.053936', NULL, '2025-03-02', 15, 'Automatically generated for 2025-03-02', NULL, 2, NULL, 5, 10),
(187, '2025-02-25 00:47:53.061937', '2025-02-25 00:47:53.061937', NULL, '2025-03-03', 17, 'Automatically generated for 2025-03-03', NULL, 2, NULL, 5, 10),
(188, '2025-02-25 00:47:53.070936', '2025-02-25 00:47:53.070936', NULL, '2025-03-04', 17, 'Automatically generated for 2025-03-04', NULL, 2, NULL, 5, 10),
(189, '2025-02-25 00:47:53.078935', '2025-02-25 00:47:53.078935', NULL, '2025-03-05', 15, 'Automatically generated for 2025-03-05', NULL, 2, NULL, 5, 10),
(190, '2025-02-25 00:47:53.087934', '2025-02-25 00:47:53.087934', NULL, '2025-03-06', 14, 'Automatically generated for 2025-03-06', NULL, 2, NULL, 5, 10),
(191, '2025-02-25 00:47:53.097589', '2025-02-25 00:47:53.097589', NULL, '2025-03-07', 17, 'Automatically generated for 2025-03-07', NULL, 2, NULL, 5, 10),
(192, '2025-02-25 00:47:53.106105', '2025-02-25 00:47:53.106105', NULL, '2025-03-08', 16, 'Automatically generated for 2025-03-08', NULL, 2, NULL, 5, 10),
(193, '2025-02-25 00:47:53.115660', '2025-02-25 00:47:53.115660', NULL, '2025-03-09', 14, 'Automatically generated for 2025-03-09', NULL, 2, NULL, 5, 10),
(194, '2025-02-25 00:47:53.124301', '2025-02-25 00:47:53.124301', NULL, '2025-03-10', 15, 'Automatically generated for 2025-03-10', NULL, 2, NULL, 5, 10),
(195, '2025-02-25 00:47:53.133302', '2025-02-25 00:47:53.133302', NULL, '2025-03-11', 16, 'Automatically generated for 2025-03-11', NULL, 2, NULL, 5, 10),
(196, '2025-02-25 00:47:53.142302', '2025-02-25 00:47:53.142302', NULL, '2025-03-12', 16, 'Automatically generated for 2025-03-12', NULL, 2, NULL, 5, 10),
(197, '2025-02-25 00:47:53.149858', '2025-02-25 00:47:53.150891', NULL, '2025-03-13', 17, 'Automatically generated for 2025-03-13', NULL, 2, NULL, 5, 10),
(198, '2025-02-25 00:47:53.158858', '2025-02-25 00:47:53.158858', NULL, '2025-03-14', 16, 'Automatically generated for 2025-03-14', NULL, 2, NULL, 5, 10),
(199, '2025-02-25 00:47:53.167858', '2025-02-25 00:47:53.167858', NULL, '2025-03-15', 15, 'Automatically generated for 2025-03-15', NULL, 2, NULL, 5, 10),
(200, '2025-02-25 00:47:53.176819', '2025-02-25 00:47:53.176819', NULL, '2025-03-16', 16, 'Automatically generated for 2025-03-16', NULL, 2, NULL, 5, 10),
(201, '2025-02-25 00:47:53.185335', '2025-02-25 00:47:53.185335', NULL, '2025-03-17', 15, 'Automatically generated for 2025-03-17', NULL, 2, NULL, 5, 10),
(202, '2025-02-25 00:47:53.193335', '2025-02-25 00:47:53.193335', NULL, '2025-03-18', 16, 'Automatically generated for 2025-03-18', NULL, 2, NULL, 5, 10),
(203, '2025-02-25 00:47:53.203861', '2025-02-25 00:47:53.203861', NULL, '2025-03-19', 15, 'Automatically generated for 2025-03-19', NULL, 2, NULL, 5, 10),
(204, '2025-02-25 00:47:53.212371', '2025-02-25 00:47:53.212371', NULL, '2025-03-20', 17, 'Automatically generated for 2025-03-20', NULL, 2, NULL, 5, 10),
(205, '2025-02-25 00:47:53.220422', '2025-02-25 00:47:53.220422', NULL, '2025-03-21', 14, 'Automatically generated for 2025-03-21', NULL, 2, NULL, 5, 10),
(206, '2025-02-25 00:47:53.229568', '2025-02-25 00:47:53.229568', NULL, '2025-03-22', 15, 'Automatically generated for 2025-03-22', NULL, 2, NULL, 5, 10),
(207, '2025-02-25 00:47:53.237568', '2025-02-25 00:47:53.237568', NULL, '2025-03-23', 16, 'Automatically generated for 2025-03-23', NULL, 2, NULL, 5, 10),
(208, '2025-02-25 00:47:53.246568', '2025-02-25 00:47:53.246568', NULL, '2025-03-24', 17, 'Automatically generated for 2025-03-24', NULL, 2, NULL, 5, 10),
(209, '2025-02-25 00:47:53.254084', '2025-02-25 00:47:53.254084', NULL, '2025-03-25', 15, 'Automatically generated for 2025-03-25', NULL, 2, NULL, 5, 10),
(210, '2025-02-25 00:47:53.262086', '2025-02-25 00:47:53.262086', NULL, '2025-03-26', 17, 'Automatically generated for 2025-03-26', NULL, 2, NULL, 5, 10),
(211, '2025-02-25 00:47:53.271600', '2025-02-25 00:47:53.271600', NULL, '2025-02-25', 3, 'Automatically generated for 2025-02-25', NULL, 2, NULL, 5, 9),
(212, '2025-02-25 00:47:53.280306', '2025-02-25 00:47:53.280306', NULL, '2025-02-26', 5, 'Automatically generated for 2025-02-26', NULL, 2, NULL, 5, 9),
(213, '2025-02-25 00:47:53.289633', '2025-02-25 00:47:53.289633', NULL, '2025-02-27', 3, 'Automatically generated for 2025-02-27', NULL, 2, NULL, 5, 9),
(214, '2025-02-25 00:47:53.298634', '2025-02-25 00:47:53.298634', NULL, '2025-02-28', 5, 'Automatically generated for 2025-02-28', NULL, 2, NULL, 5, 9),
(215, '2025-02-25 00:47:53.308156', '2025-02-25 00:47:53.308156', NULL, '2025-03-01', 5, 'Automatically generated for 2025-03-01', NULL, 2, NULL, 5, 9),
(216, '2025-02-25 00:47:53.317690', '2025-02-25 00:47:53.317690', NULL, '2025-03-02', 2, 'Automatically generated for 2025-03-02', NULL, 2, NULL, 5, 9),
(217, '2025-02-25 00:47:53.328284', '2025-02-25 00:47:53.328284', NULL, '2025-03-03', 5, 'Automatically generated for 2025-03-03', NULL, 2, NULL, 5, 9),
(218, '2025-02-25 00:47:53.338284', '2025-02-25 00:47:53.338284', NULL, '2025-03-04', 5, 'Automatically generated for 2025-03-04', NULL, 2, NULL, 5, 9),
(219, '2025-02-25 00:47:53.349097', '2025-02-25 00:47:53.349097', NULL, '2025-03-05', 2, 'Automatically generated for 2025-03-05', NULL, 2, NULL, 5, 9),
(220, '2025-02-25 00:47:53.358077', '2025-02-25 00:47:53.358077', NULL, '2025-03-06', 4, 'Automatically generated for 2025-03-06', NULL, 2, NULL, 5, 9),
(221, '2025-02-25 00:47:53.366689', '2025-02-25 00:47:53.366689', NULL, '2025-03-07', 5, 'Automatically generated for 2025-03-07', NULL, 2, NULL, 5, 9),
(222, '2025-02-25 00:47:53.376384', '2025-02-25 00:47:53.376384', NULL, '2025-03-08', 5, 'Automatically generated for 2025-03-08', NULL, 2, NULL, 5, 9),
(223, '2025-02-25 00:47:53.385358', '2025-02-25 00:47:53.385358', NULL, '2025-03-09', 4, 'Automatically generated for 2025-03-09', NULL, 2, NULL, 5, 9),
(224, '2025-02-25 00:47:53.394413', '2025-02-25 00:47:53.394413', NULL, '2025-03-10', 3, 'Automatically generated for 2025-03-10', NULL, 2, NULL, 5, 9),
(225, '2025-02-25 00:47:53.404244', '2025-02-25 00:47:53.404244', NULL, '2025-03-11', 3, 'Automatically generated for 2025-03-11', NULL, 2, NULL, 5, 9),
(226, '2025-02-25 00:47:53.411184', '2025-02-25 00:47:53.411184', NULL, '2025-03-12', 2, 'Automatically generated for 2025-03-12', NULL, 2, NULL, 5, 9),
(227, '2025-02-25 00:47:53.420009', '2025-02-25 00:47:53.420009', NULL, '2025-03-13', 5, 'Automatically generated for 2025-03-13', NULL, 2, NULL, 5, 9),
(228, '2025-02-25 00:47:53.429668', '2025-02-25 00:47:53.429668', NULL, '2025-03-14', 4, 'Automatically generated for 2025-03-14', NULL, 2, NULL, 5, 9),
(229, '2025-02-25 00:47:53.438189', '2025-02-25 00:47:53.438189', NULL, '2025-03-15', 2, 'Automatically generated for 2025-03-15', NULL, 2, NULL, 5, 9),
(230, '2025-02-25 00:47:53.446982', '2025-02-25 00:47:53.446982', NULL, '2025-03-16', 5, 'Automatically generated for 2025-03-16', NULL, 2, NULL, 5, 9),
(231, '2025-02-25 00:47:53.456665', '2025-02-25 00:47:53.456665', NULL, '2025-03-17', 4, 'Automatically generated for 2025-03-17', NULL, 2, NULL, 5, 9),
(232, '2025-02-25 00:47:53.465646', '2025-02-25 00:47:53.465646', NULL, '2025-03-18', 2, 'Automatically generated for 2025-03-18', NULL, 2, NULL, 5, 9),
(233, '2025-02-25 00:47:53.474624', '2025-02-25 00:47:53.474624', NULL, '2025-03-19', 4, 'Automatically generated for 2025-03-19', NULL, 2, NULL, 5, 9),
(234, '2025-02-25 00:47:53.483244', '2025-02-25 00:47:53.483244', NULL, '2025-03-20', 3, 'Automatically generated for 2025-03-20', NULL, 2, NULL, 5, 9),
(235, '2025-02-25 00:47:53.492814', '2025-02-25 00:47:53.492814', NULL, '2025-03-21', 4, 'Automatically generated for 2025-03-21', NULL, 2, NULL, 5, 9),
(236, '2025-02-25 00:47:53.502617', '2025-02-25 00:47:53.502617', NULL, '2025-03-22', 4, 'Automatically generated for 2025-03-22', NULL, 2, NULL, 5, 9),
(237, '2025-02-25 00:47:53.511526', '2025-02-25 00:47:53.511526', NULL, '2025-03-23', 4, 'Automatically generated for 2025-03-23', NULL, 2, NULL, 5, 9),
(238, '2025-02-25 00:47:53.519705', '2025-02-25 00:47:53.519705', NULL, '2025-03-24', 2, 'Automatically generated for 2025-03-24', NULL, 2, NULL, 5, 9),
(239, '2025-02-25 00:47:53.528333', '2025-02-25 00:47:53.528333', NULL, '2025-03-25', 5, 'Automatically generated for 2025-03-25', NULL, 2, NULL, 5, 9),
(240, '2025-02-25 00:47:53.537218', '2025-02-25 00:47:53.537218', NULL, '2025-03-26', 3, 'Automatically generated for 2025-03-26', NULL, 2, NULL, 5, 9),
(241, '2025-02-25 00:47:53.546746', '2025-02-25 00:47:53.546746', NULL, '2025-02-25', 7, 'Automatically generated for 2025-02-25', NULL, 2, NULL, 5, 7),
(242, '2025-02-25 00:47:53.555744', '2025-02-25 00:47:53.555744', NULL, '2025-02-26', 9, 'Automatically generated for 2025-02-26', NULL, 2, NULL, 5, 7),
(243, '2025-02-25 00:47:53.564822', '2025-02-25 00:47:53.564822', NULL, '2025-02-27', 6, 'Automatically generated for 2025-02-27', NULL, 2, NULL, 5, 7),
(244, '2025-02-25 00:47:53.574060', '2025-02-25 00:47:53.574060', NULL, '2025-02-28', 8, 'Automatically generated for 2025-02-28', NULL, 2, NULL, 5, 7),
(245, '2025-02-25 00:47:53.582992', '2025-02-25 00:47:53.582992', NULL, '2025-03-01', 6, 'Automatically generated for 2025-03-01', NULL, 2, NULL, 5, 7),
(246, '2025-02-25 00:47:53.590994', '2025-02-25 00:47:53.590994', NULL, '2025-03-02', 6, 'Automatically generated for 2025-03-02', NULL, 2, NULL, 5, 7),
(247, '2025-02-25 00:47:53.600111', '2025-02-25 00:47:53.600111', NULL, '2025-03-03', 7, 'Automatically generated for 2025-03-03', NULL, 2, NULL, 5, 7),
(248, '2025-02-25 00:47:53.608562', '2025-02-25 00:47:53.608562', NULL, '2025-03-04', 6, 'Automatically generated for 2025-03-04', NULL, 2, NULL, 5, 7),
(249, '2025-02-25 00:47:53.618627', '2025-02-25 00:47:53.618627', NULL, '2025-03-05', 8, 'Automatically generated for 2025-03-05', NULL, 2, NULL, 5, 7),
(250, '2025-02-25 00:47:53.626313', '2025-02-25 00:47:53.626313', NULL, '2025-03-06', 6, 'Automatically generated for 2025-03-06', NULL, 2, NULL, 5, 7),
(251, '2025-02-25 00:47:53.635006', '2025-02-25 00:47:53.635006', NULL, '2025-03-07', 7, 'Automatically generated for 2025-03-07', NULL, 2, NULL, 5, 7),
(252, '2025-02-25 00:47:53.643006', '2025-02-25 00:47:53.643006', NULL, '2025-03-08', 6, 'Automatically generated for 2025-03-08', NULL, 2, NULL, 5, 7),
(253, '2025-02-25 00:47:53.653634', '2025-02-25 00:47:53.653634', NULL, '2025-03-09', 9, 'Automatically generated for 2025-03-09', NULL, 2, NULL, 5, 7),
(254, '2025-02-25 00:47:53.662092', '2025-02-25 00:47:53.662092', NULL, '2025-03-10', 6, 'Automatically generated for 2025-03-10', NULL, 2, NULL, 5, 7),
(255, '2025-02-25 00:47:53.671609', '2025-02-25 00:47:53.671609', NULL, '2025-03-11', 7, 'Automatically generated for 2025-03-11', NULL, 2, NULL, 5, 7),
(256, '2025-02-25 00:47:53.680440', '2025-02-25 00:47:53.680440', NULL, '2025-03-12', 7, 'Automatically generated for 2025-03-12', NULL, 2, NULL, 5, 7),
(257, '2025-02-25 00:47:53.689439', '2025-02-25 00:47:53.689439', NULL, '2025-03-13', 6, 'Automatically generated for 2025-03-13', NULL, 2, NULL, 5, 7),
(258, '2025-02-25 00:47:53.698372', '2025-02-25 00:47:53.698372', NULL, '2025-03-14', 8, 'Automatically generated for 2025-03-14', NULL, 2, NULL, 5, 7),
(259, '2025-02-25 00:47:53.706286', '2025-02-25 00:47:53.706286', NULL, '2025-03-15', 9, 'Automatically generated for 2025-03-15', NULL, 2, NULL, 5, 7),
(260, '2025-02-25 00:47:53.715794', '2025-02-25 00:47:53.715794', NULL, '2025-03-16', 8, 'Automatically generated for 2025-03-16', NULL, 2, NULL, 5, 7),
(261, '2025-02-25 00:47:53.724655', '2025-02-25 00:47:53.724655', NULL, '2025-03-17', 6, 'Automatically generated for 2025-03-17', NULL, 2, NULL, 5, 7),
(262, '2025-02-25 00:47:53.733469', '2025-02-25 00:47:53.733469', NULL, '2025-03-18', 8, 'Automatically generated for 2025-03-18', NULL, 2, NULL, 5, 7),
(263, '2025-02-25 00:47:53.742543', '2025-02-25 00:47:53.743540', NULL, '2025-03-19', 7, 'Automatically generated for 2025-03-19', NULL, 2, NULL, 5, 7),
(264, '2025-02-25 00:47:53.751984', '2025-02-25 00:47:53.751984', NULL, '2025-03-20', 9, 'Automatically generated for 2025-03-20', NULL, 2, NULL, 5, 7),
(265, '2025-02-25 00:47:53.761147', '2025-02-25 00:47:53.761147', NULL, '2025-03-21', 8, 'Automatically generated for 2025-03-21', NULL, 2, NULL, 5, 7),
(266, '2025-02-25 00:47:53.770159', '2025-02-25 00:47:53.770159', NULL, '2025-03-22', 6, 'Automatically generated for 2025-03-22', NULL, 2, NULL, 5, 7),
(267, '2025-02-25 00:47:53.780159', '2025-02-25 00:47:53.780159', NULL, '2025-03-23', 8, 'Automatically generated for 2025-03-23', NULL, 2, NULL, 5, 7),
(268, '2025-02-25 00:47:53.789160', '2025-02-25 00:47:53.789160', NULL, '2025-03-24', 7, 'Automatically generated for 2025-03-24', NULL, 2, NULL, 5, 7),
(269, '2025-02-25 00:47:53.797846', '2025-02-25 00:47:53.797846', NULL, '2025-03-25', 8, 'Automatically generated for 2025-03-25', NULL, 2, NULL, 5, 7),
(270, '2025-02-25 00:47:53.807672', '2025-02-25 00:47:53.807672', NULL, '2025-03-26', 9, 'Automatically generated for 2025-03-26', NULL, 2, NULL, 5, 7),
(271, '2025-02-25 00:47:53.819673', '2025-02-25 00:47:53.819673', NULL, '2025-02-25', 14, 'Automatically generated for 2025-02-25', NULL, 2, NULL, 5, 6),
(272, '2025-02-25 00:47:53.828675', '2025-02-25 00:47:53.828675', NULL, '2025-02-26', 16, 'Automatically generated for 2025-02-26', NULL, 2, NULL, 5, 6),
(273, '2025-02-25 00:47:53.839191', '2025-02-25 00:47:53.839191', NULL, '2025-02-27', 15, 'Automatically generated for 2025-02-27', NULL, 2, NULL, 5, 6),
(274, '2025-02-25 00:47:53.848710', '2025-02-25 00:47:53.848710', NULL, '2025-02-28', 16, 'Automatically generated for 2025-02-28', NULL, 2, NULL, 5, 6),
(275, '2025-02-25 00:47:53.858267', '2025-02-25 00:47:53.858267', NULL, '2025-03-01', 16, 'Automatically generated for 2025-03-01', NULL, 2, NULL, 5, 6),
(276, '2025-02-25 00:47:53.867752', '2025-02-25 00:47:53.867752', NULL, '2025-03-02', 15, 'Automatically generated for 2025-03-02', NULL, 2, NULL, 5, 6),
(277, '2025-02-25 00:47:53.876445', '2025-02-25 00:47:53.876445', NULL, '2025-03-03', 14, 'Automatically generated for 2025-03-03', NULL, 2, NULL, 5, 6),
(278, '2025-02-25 00:47:53.885445', '2025-02-25 00:47:53.885445', NULL, '2025-03-04', 14, 'Automatically generated for 2025-03-04', NULL, 2, NULL, 5, 6),
(279, '2025-02-25 00:47:53.894599', '2025-02-25 00:47:53.894599', NULL, '2025-03-05', 14, 'Automatically generated for 2025-03-05', NULL, 2, NULL, 5, 6),
(280, '2025-02-25 00:47:53.903496', '2025-02-25 00:47:53.903496', NULL, '2025-03-06', 13, 'Automatically generated for 2025-03-06', NULL, 2, NULL, 5, 6),
(281, '2025-02-25 00:47:53.912666', '2025-02-25 00:47:53.912666', NULL, '2025-03-07', 14, 'Automatically generated for 2025-03-07', NULL, 2, NULL, 5, 6),
(282, '2025-02-25 00:47:53.920119', '2025-02-25 00:47:53.920119', NULL, '2025-03-08', 16, 'Automatically generated for 2025-03-08', NULL, 2, NULL, 5, 6),
(283, '2025-02-25 00:47:53.930605', '2025-02-25 00:47:53.930605', NULL, '2025-03-09', 14, 'Automatically generated for 2025-03-09', NULL, 2, NULL, 5, 6),
(284, '2025-02-25 00:47:53.940330', '2025-02-25 00:47:53.940330', NULL, '2025-03-10', 15, 'Automatically generated for 2025-03-10', NULL, 2, NULL, 5, 6),
(285, '2025-02-25 00:47:53.948951', '2025-02-25 00:47:53.948951', NULL, '2025-03-11', 15, 'Automatically generated for 2025-03-11', NULL, 2, NULL, 5, 6),
(286, '2025-02-25 00:47:53.957371', '2025-02-25 00:47:53.957371', NULL, '2025-03-12', 13, 'Automatically generated for 2025-03-12', NULL, 2, NULL, 5, 6),
(287, '2025-02-25 00:47:53.967374', '2025-02-25 00:47:53.967374', NULL, '2025-03-13', 16, 'Automatically generated for 2025-03-13', NULL, 2, NULL, 5, 6),
(288, '2025-02-25 00:47:53.976261', '2025-02-25 00:47:53.976261', NULL, '2025-03-14', 16, 'Automatically generated for 2025-03-14', NULL, 2, NULL, 5, 6),
(289, '2025-02-25 00:47:53.985467', '2025-02-25 00:47:53.985467', NULL, '2025-03-15', 13, 'Automatically generated for 2025-03-15', NULL, 2, NULL, 5, 6),
(290, '2025-02-25 00:47:53.993777', '2025-02-25 00:47:53.993777', NULL, '2025-03-16', 13, 'Automatically generated for 2025-03-16', NULL, 2, NULL, 5, 6),
(291, '2025-02-25 00:47:54.004105', '2025-02-25 00:47:54.004105', NULL, '2025-03-17', 14, 'Automatically generated for 2025-03-17', NULL, 2, NULL, 5, 6),
(292, '2025-02-25 00:47:54.012882', '2025-02-25 00:47:54.012882', NULL, '2025-03-18', 14, 'Automatically generated for 2025-03-18', NULL, 2, NULL, 5, 6),
(293, '2025-02-25 00:47:54.021882', '2025-02-25 00:47:54.021882', NULL, '2025-03-19', 16, 'Automatically generated for 2025-03-19', NULL, 2, NULL, 5, 6),
(294, '2025-02-25 00:47:54.031433', '2025-02-25 00:47:54.031433', NULL, '2025-03-20', 16, 'Automatically generated for 2025-03-20', NULL, 2, NULL, 5, 6),
(295, '2025-02-25 00:47:54.039432', '2025-02-25 00:47:54.039432', NULL, '2025-03-21', 14, 'Automatically generated for 2025-03-21', NULL, 2, NULL, 5, 6),
(296, '2025-02-25 00:47:54.048191', '2025-02-25 00:47:54.048191', NULL, '2025-03-22', 16, 'Automatically generated for 2025-03-22', NULL, 2, NULL, 5, 6),
(297, '2025-02-25 00:47:54.056689', '2025-02-25 00:47:54.056689', NULL, '2025-03-23', 16, 'Automatically generated for 2025-03-23', NULL, 2, NULL, 5, 6),
(298, '2025-02-25 00:47:54.066067', '2025-02-25 00:47:54.066067', NULL, '2025-03-24', 13, 'Automatically generated for 2025-03-24', NULL, 2, NULL, 5, 6),
(299, '2025-02-25 00:47:54.073889', '2025-02-25 00:47:54.073889', NULL, '2025-03-25', 15, 'Automatically generated for 2025-03-25', NULL, 2, NULL, 5, 6),
(300, '2025-02-25 00:47:54.084384', '2025-02-25 00:47:54.084384', NULL, '2025-03-26', 13, 'Automatically generated for 2025-03-26', NULL, 2, NULL, 5, 6),
(301, '2025-02-25 00:47:54.111342', '2025-02-25 00:47:54.111342', NULL, '2025-02-25', 10, 'Automatically generated for 2025-02-25', NULL, 3, NULL, 9, 13),
(302, '2025-02-25 00:47:54.121676', '2025-02-25 00:47:54.121676', NULL, '2025-02-26', 11, 'Automatically generated for 2025-02-26', NULL, 3, NULL, 9, 13),
(303, '2025-02-25 00:47:54.130418', '2025-02-25 00:47:54.130418', NULL, '2025-02-27', 9, 'Automatically generated for 2025-02-27', NULL, 3, NULL, 9, 13),
(304, '2025-02-25 00:47:54.139444', '2025-02-25 00:47:54.139444', NULL, '2025-02-28', 9, 'Automatically generated for 2025-02-28', NULL, 3, NULL, 9, 13),
(305, '2025-02-25 00:47:54.149019', '2025-02-25 00:47:54.149019', NULL, '2025-03-01', 10, 'Automatically generated for 2025-03-01', NULL, 3, NULL, 9, 13),
(306, '2025-02-25 00:47:54.157191', '2025-02-25 00:47:54.157191', NULL, '2025-03-02', 11, 'Automatically generated for 2025-03-02', NULL, 3, NULL, 9, 13),
(307, '2025-02-25 00:47:54.166634', '2025-02-25 00:47:54.166634', NULL, '2025-03-03', 10, 'Automatically generated for 2025-03-03', NULL, 3, NULL, 9, 13),
(308, '2025-02-25 00:47:54.176372', '2025-02-25 00:47:54.176372', NULL, '2025-03-04', 9, 'Automatically generated for 2025-03-04', NULL, 3, NULL, 9, 13),
(309, '2025-02-25 00:47:54.185422', '2025-02-25 00:47:54.185422', NULL, '2025-03-05', 12, 'Automatically generated for 2025-03-05', NULL, 3, NULL, 9, 13),
(310, '2025-02-25 00:47:54.193440', '2025-02-25 00:47:54.193440', NULL, '2025-03-06', 9, 'Automatically generated for 2025-03-06', NULL, 3, NULL, 9, 13),
(311, '2025-02-25 00:47:54.202828', '2025-02-25 00:47:54.202828', NULL, '2025-03-07', 12, 'Automatically generated for 2025-03-07', NULL, 3, NULL, 9, 13),
(312, '2025-02-25 00:47:54.211607', '2025-02-25 00:47:54.211607', NULL, '2025-03-08', 12, 'Automatically generated for 2025-03-08', NULL, 3, NULL, 9, 13),
(313, '2025-02-25 00:47:54.220575', '2025-02-25 00:47:54.220575', NULL, '2025-03-09', 10, 'Automatically generated for 2025-03-09', NULL, 3, NULL, 9, 13),
(314, '2025-02-25 00:47:54.229802', '2025-02-25 00:47:54.229802', NULL, '2025-03-10', 11, 'Automatically generated for 2025-03-10', NULL, 3, NULL, 9, 13),
(315, '2025-02-25 00:47:54.239378', '2025-02-25 00:47:54.239378', NULL, '2025-03-11', 9, 'Automatically generated for 2025-03-11', NULL, 3, NULL, 9, 13),
(316, '2025-02-25 00:47:54.247998', '2025-02-25 00:47:54.247998', NULL, '2025-03-12', 12, 'Automatically generated for 2025-03-12', NULL, 3, NULL, 9, 13),
(317, '2025-02-25 00:47:54.255997', '2025-02-25 00:47:54.257037', NULL, '2025-03-13', 9, 'Automatically generated for 2025-03-13', NULL, 3, NULL, 9, 13),
(318, '2025-02-25 00:47:54.265839', '2025-02-25 00:47:54.265839', NULL, '2025-03-14', 12, 'Automatically generated for 2025-03-14', NULL, 3, NULL, 9, 13),
(319, '2025-02-25 00:47:54.274840', '2025-02-25 00:47:54.274840', NULL, '2025-03-15', 9, 'Automatically generated for 2025-03-15', NULL, 3, NULL, 9, 13),
(320, '2025-02-25 00:47:54.283838', '2025-02-25 00:47:54.283838', NULL, '2025-03-16', 10, 'Automatically generated for 2025-03-16', NULL, 3, NULL, 9, 13),
(321, '2025-02-25 00:47:54.294353', '2025-02-25 00:47:54.294353', NULL, '2025-03-17', 9, 'Automatically generated for 2025-03-17', NULL, 3, NULL, 9, 13),
(322, '2025-02-25 00:47:54.302887', '2025-02-25 00:47:54.302887', NULL, '2025-03-18', 9, 'Automatically generated for 2025-03-18', NULL, 3, NULL, 9, 13),
(323, '2025-02-25 00:47:54.311891', '2025-02-25 00:47:54.311891', NULL, '2025-03-19', 10, 'Automatically generated for 2025-03-19', NULL, 3, NULL, 9, 13),
(324, '2025-02-25 00:47:54.320889', '2025-02-25 00:47:54.320889', NULL, '2025-03-20', 12, 'Automatically generated for 2025-03-20', NULL, 3, NULL, 9, 13),
(325, '2025-02-25 00:47:54.333888', '2025-02-25 00:47:54.333888', NULL, '2025-03-21', 9, 'Automatically generated for 2025-03-21', NULL, 3, NULL, 9, 13),
(326, '2025-02-25 00:47:54.342704', '2025-02-25 00:47:54.342704', NULL, '2025-03-22', 11, 'Automatically generated for 2025-03-22', NULL, 3, NULL, 9, 13),
(327, '2025-02-25 00:47:54.352283', '2025-02-25 00:47:54.352283', NULL, '2025-03-23', 12, 'Automatically generated for 2025-03-23', NULL, 3, NULL, 9, 13),
(328, '2025-02-25 00:47:54.361282', '2025-02-25 00:47:54.361282', NULL, '2025-03-24', 12, 'Automatically generated for 2025-03-24', NULL, 3, NULL, 9, 13);
INSERT INTO `rooms_availability` (`id`, `created_at`, `updated_at`, `deleted_at`, `availability_date`, `available_rooms`, `notes`, `created_by_id`, `hotel_id`, `updated_by_id`, `room_status_id`, `room_type_id`) VALUES
(329, '2025-02-25 00:47:54.371986', '2025-02-25 00:47:54.371986', NULL, '2025-03-25', 9, 'Automatically generated for 2025-03-25', NULL, 3, NULL, 9, 13),
(330, '2025-02-25 00:47:54.381606', '2025-02-25 00:47:54.381606', NULL, '2025-03-26', 9, 'Automatically generated for 2025-03-26', NULL, 3, NULL, 9, 13),
(331, '2025-02-25 00:47:54.390606', '2025-02-25 00:47:54.390606', NULL, '2025-02-25', 7, 'Automatically generated for 2025-02-25', NULL, 3, NULL, 9, 15),
(332, '2025-02-25 00:47:54.399158', '2025-02-25 00:47:54.399158', NULL, '2025-02-26', 7, 'Automatically generated for 2025-02-26', NULL, 3, NULL, 9, 15),
(333, '2025-02-25 00:47:54.407117', '2025-02-25 00:47:54.407117', NULL, '2025-02-27', 9, 'Automatically generated for 2025-02-27', NULL, 3, NULL, 9, 15),
(334, '2025-02-25 00:47:54.416630', '2025-02-25 00:47:54.416630', NULL, '2025-02-28', 8, 'Automatically generated for 2025-02-28', NULL, 3, NULL, 9, 15),
(335, '2025-02-25 00:47:54.424629', '2025-02-25 00:47:54.424629', NULL, '2025-03-01', 7, 'Automatically generated for 2025-03-01', NULL, 3, NULL, 9, 15),
(336, '2025-02-25 00:47:54.433147', '2025-02-25 00:47:54.433147', NULL, '2025-03-02', 7, 'Automatically generated for 2025-03-02', NULL, 3, NULL, 9, 15),
(337, '2025-02-25 00:47:54.442662', '2025-02-25 00:47:54.442662', NULL, '2025-03-03', 8, 'Automatically generated for 2025-03-03', NULL, 3, NULL, 9, 15),
(338, '2025-02-25 00:47:54.451660', '2025-02-25 00:47:54.451660', NULL, '2025-03-04', 9, 'Automatically generated for 2025-03-04', NULL, 3, NULL, 9, 15),
(339, '2025-02-25 00:47:54.459662', '2025-02-25 00:47:54.459662', NULL, '2025-03-05', 9, 'Automatically generated for 2025-03-05', NULL, 3, NULL, 9, 15),
(340, '2025-02-25 00:47:54.468661', '2025-02-25 00:47:54.468661', NULL, '2025-03-06', 9, 'Automatically generated for 2025-03-06', NULL, 3, NULL, 9, 15),
(341, '2025-02-25 00:47:54.476659', '2025-02-25 00:47:54.477661', NULL, '2025-03-07', 6, 'Automatically generated for 2025-03-07', NULL, 3, NULL, 9, 15),
(342, '2025-02-25 00:47:54.485576', '2025-02-25 00:47:54.485576', NULL, '2025-03-08', 6, 'Automatically generated for 2025-03-08', NULL, 3, NULL, 9, 15),
(343, '2025-02-25 00:47:54.493577', '2025-02-25 00:47:54.494576', NULL, '2025-03-09', 7, 'Automatically generated for 2025-03-09', NULL, 3, NULL, 9, 15),
(344, '2025-02-25 00:47:54.502089', '2025-02-25 00:47:54.502089', NULL, '2025-03-10', 6, 'Automatically generated for 2025-03-10', NULL, 3, NULL, 9, 15),
(345, '2025-02-25 00:47:54.510091', '2025-02-25 00:47:54.510091', NULL, '2025-03-11', 9, 'Automatically generated for 2025-03-11', NULL, 3, NULL, 9, 15),
(346, '2025-02-25 00:47:54.519599', '2025-02-25 00:47:54.519599', NULL, '2025-03-12', 7, 'Automatically generated for 2025-03-12', NULL, 3, NULL, 9, 15),
(347, '2025-02-25 00:47:54.527599', '2025-02-25 00:47:54.527599', NULL, '2025-03-13', 6, 'Automatically generated for 2025-03-13', NULL, 3, NULL, 9, 15),
(348, '2025-02-25 00:47:54.535599', '2025-02-25 00:47:54.535599', NULL, '2025-03-14', 7, 'Automatically generated for 2025-03-14', NULL, 3, NULL, 9, 15),
(349, '2025-02-25 00:47:54.543599', '2025-02-25 00:47:54.543599', NULL, '2025-03-15', 6, 'Automatically generated for 2025-03-15', NULL, 3, NULL, 9, 15),
(350, '2025-02-25 00:47:54.552111', '2025-02-25 00:47:54.552111', NULL, '2025-03-16', 8, 'Automatically generated for 2025-03-16', NULL, 3, NULL, 9, 15),
(351, '2025-02-25 00:47:54.560111', '2025-02-25 00:47:54.560111', NULL, '2025-03-17', 9, 'Automatically generated for 2025-03-17', NULL, 3, NULL, 9, 15),
(352, '2025-02-25 00:47:54.568110', '2025-02-25 00:47:54.568110', NULL, '2025-03-18', 7, 'Automatically generated for 2025-03-18', NULL, 3, NULL, 9, 15),
(353, '2025-02-25 00:47:54.577113', '2025-02-25 00:47:54.577113', NULL, '2025-03-19', 9, 'Automatically generated for 2025-03-19', NULL, 3, NULL, 9, 15),
(354, '2025-02-25 00:47:54.585108', '2025-02-25 00:47:54.585108', NULL, '2025-03-20', 8, 'Automatically generated for 2025-03-20', NULL, 3, NULL, 9, 15),
(355, '2025-02-25 00:47:54.595379', '2025-02-25 00:47:54.595379', NULL, '2025-03-21', 6, 'Automatically generated for 2025-03-21', NULL, 3, NULL, 9, 15),
(356, '2025-02-25 00:47:54.603897', '2025-02-25 00:47:54.603897', NULL, '2025-03-22', 6, 'Automatically generated for 2025-03-22', NULL, 3, NULL, 9, 15),
(357, '2025-02-25 00:47:54.611897', '2025-02-25 00:47:54.611897', NULL, '2025-03-23', 9, 'Automatically generated for 2025-03-23', NULL, 3, NULL, 9, 15),
(358, '2025-02-25 00:47:54.619896', '2025-02-25 00:47:54.619896', NULL, '2025-03-24', 6, 'Automatically generated for 2025-03-24', NULL, 3, NULL, 9, 15),
(359, '2025-02-25 00:47:54.628897', '2025-02-25 00:47:54.628897', NULL, '2025-03-25', 7, 'Automatically generated for 2025-03-25', NULL, 3, NULL, 9, 15),
(360, '2025-02-25 00:47:54.636896', '2025-02-25 00:47:54.636896', NULL, '2025-03-26', 7, 'Automatically generated for 2025-03-26', NULL, 3, NULL, 9, 15),
(361, '2025-02-25 00:47:54.645412', '2025-02-25 00:47:54.645412', NULL, '2025-02-25', 17, 'Automatically generated for 2025-02-25', NULL, 3, NULL, 9, 14),
(362, '2025-02-25 00:47:54.653923', '2025-02-25 00:47:54.653923', NULL, '2025-02-26', 17, 'Automatically generated for 2025-02-26', NULL, 3, NULL, 9, 14),
(363, '2025-02-25 00:47:54.661922', '2025-02-25 00:47:54.661922', NULL, '2025-02-27', 16, 'Automatically generated for 2025-02-27', NULL, 3, NULL, 9, 14),
(364, '2025-02-25 00:47:54.670923', '2025-02-25 00:47:54.670923', NULL, '2025-02-28', 16, 'Automatically generated for 2025-02-28', NULL, 3, NULL, 9, 14),
(365, '2025-02-25 00:47:54.678923', '2025-02-25 00:47:54.678923', NULL, '2025-03-01', 14, 'Automatically generated for 2025-03-01', NULL, 3, NULL, 9, 14),
(366, '2025-02-25 00:47:54.686922', '2025-02-25 00:47:54.686922', NULL, '2025-03-02', 15, 'Automatically generated for 2025-03-02', NULL, 3, NULL, 9, 14),
(367, '2025-02-25 00:47:54.696445', '2025-02-25 00:47:54.696445', NULL, '2025-03-03', 14, 'Automatically generated for 2025-03-03', NULL, 3, NULL, 9, 14),
(368, '2025-02-25 00:47:54.704958', '2025-02-25 00:47:54.704958', NULL, '2025-03-04', 15, 'Automatically generated for 2025-03-04', NULL, 3, NULL, 9, 14),
(369, '2025-02-25 00:47:54.712958', '2025-02-25 00:47:54.712958', NULL, '2025-03-05', 16, 'Automatically generated for 2025-03-05', NULL, 3, NULL, 9, 14),
(370, '2025-02-25 00:47:54.720957', '2025-02-25 00:47:54.720957', NULL, '2025-03-06', 15, 'Automatically generated for 2025-03-06', NULL, 3, NULL, 9, 14),
(371, '2025-02-25 00:47:54.729958', '2025-02-25 00:47:54.729958', NULL, '2025-03-07', 14, 'Automatically generated for 2025-03-07', NULL, 3, NULL, 9, 14),
(372, '2025-02-25 00:47:54.737947', '2025-02-25 00:47:54.737947', NULL, '2025-03-08', 14, 'Automatically generated for 2025-03-08', NULL, 3, NULL, 9, 14),
(373, '2025-02-25 00:47:54.746477', '2025-02-25 00:47:54.746477', NULL, '2025-03-09', 14, 'Automatically generated for 2025-03-09', NULL, 3, NULL, 9, 14),
(374, '2025-02-25 00:47:54.754986', '2025-02-25 00:47:54.754986', NULL, '2025-03-10', 16, 'Automatically generated for 2025-03-10', NULL, 3, NULL, 9, 14),
(375, '2025-02-25 00:47:54.763510', '2025-02-25 00:47:54.763510', NULL, '2025-03-11', 14, 'Automatically generated for 2025-03-11', NULL, 3, NULL, 9, 14),
(376, '2025-02-25 00:47:54.772510', '2025-02-25 00:47:54.772510', NULL, '2025-03-12', 15, 'Automatically generated for 2025-03-12', NULL, 3, NULL, 9, 14),
(377, '2025-02-25 00:47:54.781510', '2025-02-25 00:47:54.781510', NULL, '2025-03-13', 17, 'Automatically generated for 2025-03-13', NULL, 3, NULL, 9, 14),
(378, '2025-02-25 00:47:54.789510', '2025-02-25 00:47:54.789510', NULL, '2025-03-14', 15, 'Automatically generated for 2025-03-14', NULL, 3, NULL, 9, 14),
(379, '2025-02-25 00:47:54.799026', '2025-02-25 00:47:54.799026', NULL, '2025-03-15', 14, 'Automatically generated for 2025-03-15', NULL, 3, NULL, 9, 14),
(380, '2025-02-25 00:47:54.808026', '2025-02-25 00:47:54.808026', NULL, '2025-03-16', 16, 'Automatically generated for 2025-03-16', NULL, 3, NULL, 9, 14),
(381, '2025-02-25 00:47:54.819562', '2025-02-25 00:47:54.819562', NULL, '2025-03-17', 16, 'Automatically generated for 2025-03-17', NULL, 3, NULL, 9, 14),
(382, '2025-02-25 00:47:54.828564', '2025-02-25 00:47:54.828564', NULL, '2025-03-18', 14, 'Automatically generated for 2025-03-18', NULL, 3, NULL, 9, 14),
(383, '2025-02-25 00:47:54.838561', '2025-02-25 00:47:54.838561', NULL, '2025-03-19', 16, 'Automatically generated for 2025-03-19', NULL, 3, NULL, 9, 14),
(384, '2025-02-25 00:47:54.848561', '2025-02-25 00:47:54.848561', NULL, '2025-03-20', 17, 'Automatically generated for 2025-03-20', NULL, 3, NULL, 9, 14),
(385, '2025-02-25 00:47:54.858082', '2025-02-25 00:47:54.858082', NULL, '2025-03-21', 15, 'Automatically generated for 2025-03-21', NULL, 3, NULL, 9, 14),
(386, '2025-02-25 00:47:54.866603', '2025-02-25 00:47:54.866603', NULL, '2025-03-22', 15, 'Automatically generated for 2025-03-22', NULL, 3, NULL, 9, 14),
(387, '2025-02-25 00:47:54.876602', '2025-02-25 00:47:54.876602', NULL, '2025-03-23', 16, 'Automatically generated for 2025-03-23', NULL, 3, NULL, 9, 14),
(388, '2025-02-25 00:47:54.884601', '2025-02-25 00:47:54.884601', NULL, '2025-03-24', 17, 'Automatically generated for 2025-03-24', NULL, 3, NULL, 9, 14),
(389, '2025-02-25 00:47:54.893117', '2025-02-25 00:47:54.893117', NULL, '2025-03-25', 17, 'Automatically generated for 2025-03-25', NULL, 3, NULL, 9, 14),
(390, '2025-02-25 00:47:54.900629', '2025-02-25 00:47:54.901630', NULL, '2025-03-26', 15, 'Automatically generated for 2025-03-26', NULL, 3, NULL, 9, 14),
(391, '2025-02-25 00:47:54.909630', '2025-02-25 00:47:54.909630', NULL, '2025-02-25', 16, 'Automatically generated for 2025-02-25', NULL, 3, NULL, 9, 12),
(392, '2025-02-25 00:47:54.917659', '2025-02-25 00:47:54.917659', NULL, '2025-02-26', 18, 'Automatically generated for 2025-02-26', NULL, 3, NULL, 9, 12),
(393, '2025-02-25 00:47:54.926661', '2025-02-25 00:47:54.926661', NULL, '2025-02-27', 18, 'Automatically generated for 2025-02-27', NULL, 3, NULL, 9, 12),
(394, '2025-02-25 00:47:54.934661', '2025-02-25 00:47:54.934661', NULL, '2025-02-28', 19, 'Automatically generated for 2025-02-28', NULL, 3, NULL, 9, 12),
(395, '2025-02-25 00:47:54.943172', '2025-02-25 00:47:54.943172', NULL, '2025-03-01', 16, 'Automatically generated for 2025-03-01', NULL, 3, NULL, 9, 12),
(396, '2025-02-25 00:47:54.951701', '2025-02-25 00:47:54.951701', NULL, '2025-03-02', 17, 'Automatically generated for 2025-03-02', NULL, 3, NULL, 9, 12),
(397, '2025-02-25 00:47:54.958702', '2025-02-25 00:47:54.958702', NULL, '2025-03-03', 18, 'Automatically generated for 2025-03-03', NULL, 3, NULL, 9, 12),
(398, '2025-02-25 00:47:54.966702', '2025-02-25 00:47:54.966702', NULL, '2025-03-04', 17, 'Automatically generated for 2025-03-04', NULL, 3, NULL, 9, 12),
(399, '2025-02-25 00:47:54.975701', '2025-02-25 00:47:54.975701', NULL, '2025-03-05', 16, 'Automatically generated for 2025-03-05', NULL, 3, NULL, 9, 12),
(400, '2025-02-25 00:47:54.984702', '2025-02-25 00:47:54.984702', NULL, '2025-03-06', 17, 'Automatically generated for 2025-03-06', NULL, 3, NULL, 9, 12),
(401, '2025-02-25 00:47:54.993212', '2025-02-25 00:47:54.993212', NULL, '2025-03-07', 16, 'Automatically generated for 2025-03-07', NULL, 3, NULL, 9, 12),
(402, '2025-02-25 00:47:55.000720', '2025-02-25 00:47:55.001721', NULL, '2025-03-08', 18, 'Automatically generated for 2025-03-08', NULL, 3, NULL, 9, 12),
(403, '2025-02-25 00:47:55.008720', '2025-02-25 00:47:55.009720', NULL, '2025-03-09', 18, 'Automatically generated for 2025-03-09', NULL, 3, NULL, 9, 12),
(404, '2025-02-25 00:47:55.017721', '2025-02-25 00:47:55.017721', NULL, '2025-03-10', 17, 'Automatically generated for 2025-03-10', NULL, 3, NULL, 9, 12),
(405, '2025-02-25 00:47:55.026236', '2025-02-25 00:47:55.026236', NULL, '2025-03-11', 17, 'Automatically generated for 2025-03-11', NULL, 3, NULL, 9, 12),
(406, '2025-02-25 00:47:55.034239', '2025-02-25 00:47:55.034239', NULL, '2025-03-12', 17, 'Automatically generated for 2025-03-12', NULL, 3, NULL, 9, 12),
(407, '2025-02-25 00:47:55.042238', '2025-02-25 00:47:55.042238', NULL, '2025-03-13', 17, 'Automatically generated for 2025-03-13', NULL, 3, NULL, 9, 12),
(408, '2025-02-25 00:47:55.050750', '2025-02-25 00:47:55.050750', NULL, '2025-03-14', 16, 'Automatically generated for 2025-03-14', NULL, 3, NULL, 9, 12),
(409, '2025-02-25 00:47:55.058750', '2025-02-25 00:47:55.058750', NULL, '2025-03-15', 17, 'Automatically generated for 2025-03-15', NULL, 3, NULL, 9, 12),
(410, '2025-02-25 00:47:55.067750', '2025-02-25 00:47:55.067750', NULL, '2025-03-16', 19, 'Automatically generated for 2025-03-16', NULL, 3, NULL, 9, 12),
(411, '2025-02-25 00:47:55.075750', '2025-02-25 00:47:55.075750', NULL, '2025-03-17', 17, 'Automatically generated for 2025-03-17', NULL, 3, NULL, 9, 12),
(412, '2025-02-25 00:47:55.083750', '2025-02-25 00:47:55.083750', NULL, '2025-03-18', 18, 'Automatically generated for 2025-03-18', NULL, 3, NULL, 9, 12),
(413, '2025-02-25 00:47:55.092383', '2025-02-25 00:47:55.092383', NULL, '2025-03-19', 19, 'Automatically generated for 2025-03-19', NULL, 3, NULL, 9, 12),
(414, '2025-02-25 00:47:55.100778', '2025-02-25 00:47:55.100778', NULL, '2025-03-20', 16, 'Automatically generated for 2025-03-20', NULL, 3, NULL, 9, 12),
(415, '2025-02-25 00:47:55.109298', '2025-02-25 00:47:55.109298', NULL, '2025-03-21', 19, 'Automatically generated for 2025-03-21', NULL, 3, NULL, 9, 12),
(416, '2025-02-25 00:47:55.117809', '2025-02-25 00:47:55.117809', NULL, '2025-03-22', 17, 'Automatically generated for 2025-03-22', NULL, 3, NULL, 9, 12),
(417, '2025-02-25 00:47:55.125809', '2025-02-25 00:47:55.125809', NULL, '2025-03-23', 17, 'Automatically generated for 2025-03-23', NULL, 3, NULL, 9, 12),
(418, '2025-02-25 00:47:55.133810', '2025-02-25 00:47:55.133810', NULL, '2025-03-24', 18, 'Automatically generated for 2025-03-24', NULL, 3, NULL, 9, 12),
(419, '2025-02-25 00:47:55.142409', '2025-02-25 00:47:55.142409', NULL, '2025-03-25', 17, 'Automatically generated for 2025-03-25', NULL, 3, NULL, 9, 12),
(420, '2025-02-25 00:47:55.150957', '2025-02-25 00:47:55.150957', NULL, '2025-03-26', 17, 'Automatically generated for 2025-03-26', NULL, 3, NULL, 9, 12),
(421, '2025-02-25 00:47:55.159956', '2025-02-25 00:47:55.159956', NULL, '2025-02-25', 12, 'Automatically generated for 2025-02-25', NULL, 3, NULL, 9, 11),
(422, '2025-02-25 00:47:55.168467', '2025-02-25 00:47:55.168467', NULL, '2025-02-26', 13, 'Automatically generated for 2025-02-26', NULL, 3, NULL, 9, 11),
(423, '2025-02-25 00:47:55.176466', '2025-02-25 00:47:55.176466', NULL, '2025-02-27', 14, 'Automatically generated for 2025-02-27', NULL, 3, NULL, 9, 11),
(424, '2025-02-25 00:47:55.184468', '2025-02-25 00:47:55.184468', NULL, '2025-02-28', 11, 'Automatically generated for 2025-02-28', NULL, 3, NULL, 9, 11),
(425, '2025-02-25 00:47:55.193467', '2025-02-25 00:47:55.193467', NULL, '2025-03-01', 11, 'Automatically generated for 2025-03-01', NULL, 3, NULL, 9, 11),
(426, '2025-02-25 00:47:55.201989', '2025-02-25 00:47:55.201989', NULL, '2025-03-02', 14, 'Automatically generated for 2025-03-02', NULL, 3, NULL, 9, 11),
(427, '2025-02-25 00:47:55.208989', '2025-02-25 00:47:55.208989', NULL, '2025-03-03', 13, 'Automatically generated for 2025-03-03', NULL, 3, NULL, 9, 11),
(428, '2025-02-25 00:47:55.216989', '2025-02-25 00:47:55.216989', NULL, '2025-03-04', 11, 'Automatically generated for 2025-03-04', NULL, 3, NULL, 9, 11),
(429, '2025-02-25 00:47:55.224988', '2025-02-25 00:47:55.225989', NULL, '2025-03-05', 11, 'Automatically generated for 2025-03-05', NULL, 3, NULL, 9, 11),
(430, '2025-02-25 00:47:55.233989', '2025-02-25 00:47:55.233989', NULL, '2025-03-06', 12, 'Automatically generated for 2025-03-06', NULL, 3, NULL, 9, 11),
(431, '2025-02-25 00:47:55.242819', '2025-02-25 00:47:55.242819', NULL, '2025-03-07', 11, 'Automatically generated for 2025-03-07', NULL, 3, NULL, 9, 11),
(432, '2025-02-25 00:47:55.250857', '2025-02-25 00:47:55.250857', NULL, '2025-03-08', 12, 'Automatically generated for 2025-03-08', NULL, 3, NULL, 9, 11),
(433, '2025-02-25 00:47:55.259858', '2025-02-25 00:47:55.259858', NULL, '2025-03-09', 11, 'Automatically generated for 2025-03-09', NULL, 3, NULL, 9, 11),
(434, '2025-02-25 00:47:55.267884', '2025-02-25 00:47:55.268884', NULL, '2025-03-10', 14, 'Automatically generated for 2025-03-10', NULL, 3, NULL, 9, 11),
(435, '2025-02-25 00:47:55.277401', '2025-02-25 00:47:55.277401', NULL, '2025-03-11', 14, 'Automatically generated for 2025-03-11', NULL, 3, NULL, 9, 11),
(436, '2025-02-25 00:47:55.286401', '2025-02-25 00:47:55.286401', NULL, '2025-03-12', 13, 'Automatically generated for 2025-03-12', NULL, 3, NULL, 9, 11),
(437, '2025-02-25 00:47:55.294593', '2025-02-25 00:47:55.294593', NULL, '2025-03-13', 13, 'Automatically generated for 2025-03-13', NULL, 3, NULL, 9, 11),
(438, '2025-02-25 00:47:55.303950', '2025-02-25 00:47:55.303950', NULL, '2025-03-14', 14, 'Automatically generated for 2025-03-14', NULL, 3, NULL, 9, 11),
(439, '2025-02-25 00:47:55.313952', '2025-02-25 00:47:55.313952', NULL, '2025-03-15', 13, 'Automatically generated for 2025-03-15', NULL, 3, NULL, 9, 11),
(440, '2025-02-25 00:47:55.325522', '2025-02-25 00:47:55.325522', NULL, '2025-03-16', 14, 'Automatically generated for 2025-03-16', NULL, 3, NULL, 9, 11),
(441, '2025-02-25 00:47:55.334522', '2025-02-25 00:47:55.334522', NULL, '2025-03-17', 13, 'Automatically generated for 2025-03-17', NULL, 3, NULL, 9, 11),
(442, '2025-02-25 00:47:55.342522', '2025-02-25 00:47:55.342522', NULL, '2025-03-18', 13, 'Automatically generated for 2025-03-18', NULL, 3, NULL, 9, 11),
(443, '2025-02-25 00:47:55.351065', '2025-02-25 00:47:55.351065', NULL, '2025-03-19', 12, 'Automatically generated for 2025-03-19', NULL, 3, NULL, 9, 11),
(444, '2025-02-25 00:47:55.359063', '2025-02-25 00:47:55.359063', NULL, '2025-03-20', 12, 'Automatically generated for 2025-03-20', NULL, 3, NULL, 9, 11),
(445, '2025-02-25 00:47:55.368063', '2025-02-25 00:47:55.368063', NULL, '2025-03-21', 14, 'Automatically generated for 2025-03-21', NULL, 3, NULL, 9, 11),
(446, '2025-02-25 00:47:55.376063', '2025-02-25 00:47:55.376063', NULL, '2025-03-22', 12, 'Automatically generated for 2025-03-22', NULL, 3, NULL, 9, 11),
(447, '2025-02-25 00:47:55.384063', '2025-02-25 00:47:55.384063', NULL, '2025-03-23', 12, 'Automatically generated for 2025-03-23', NULL, 3, NULL, 9, 11),
(448, '2025-02-25 00:47:55.392650', '2025-02-25 00:47:55.392650', NULL, '2025-03-24', 14, 'Automatically generated for 2025-03-24', NULL, 3, NULL, 9, 11),
(449, '2025-02-25 00:47:55.401084', '2025-02-25 00:47:55.401084', NULL, '2025-03-25', 11, 'Automatically generated for 2025-03-25', NULL, 3, NULL, 9, 11),
(450, '2025-02-25 00:47:55.409084', '2025-02-25 00:47:55.409084', NULL, '2025-03-26', 13, 'Automatically generated for 2025-03-26', NULL, 3, NULL, 9, 11),
(451, '2025-02-25 00:47:55.436085', '2025-02-25 00:47:55.436085', NULL, '2025-02-25', 13, 'Automatically generated for 2025-02-25', NULL, 4, NULL, 13, 18),
(452, '2025-02-25 00:47:55.445596', '2025-02-25 00:47:55.445596', NULL, '2025-02-26', 15, 'Automatically generated for 2025-02-26', NULL, 4, NULL, 13, 18),
(453, '2025-02-25 00:47:55.454125', '2025-02-25 00:47:55.454125', NULL, '2025-02-27', 16, 'Automatically generated for 2025-02-27', NULL, 4, NULL, 13, 18),
(454, '2025-02-25 00:47:55.462126', '2025-02-25 00:47:55.462126', NULL, '2025-02-28', 14, 'Automatically generated for 2025-02-28', NULL, 4, NULL, 13, 18),
(455, '2025-02-25 00:47:55.469641', '2025-02-25 00:47:55.469641', NULL, '2025-03-01', 15, 'Automatically generated for 2025-03-01', NULL, 4, NULL, 13, 18),
(456, '2025-02-25 00:47:55.477641', '2025-02-25 00:47:55.478642', NULL, '2025-03-02', 16, 'Automatically generated for 2025-03-02', NULL, 4, NULL, 13, 18),
(457, '2025-02-25 00:47:55.487159', '2025-02-25 00:47:55.487159', NULL, '2025-03-03', 13, 'Automatically generated for 2025-03-03', NULL, 4, NULL, 13, 18),
(458, '2025-02-25 00:47:55.494675', '2025-02-25 00:47:55.494675', NULL, '2025-03-04', 14, 'Automatically generated for 2025-03-04', NULL, 4, NULL, 13, 18),
(459, '2025-02-25 00:47:55.503219', '2025-02-25 00:47:55.503219', NULL, '2025-03-05', 15, 'Automatically generated for 2025-03-05', NULL, 4, NULL, 13, 18),
(460, '2025-02-25 00:47:55.510869', '2025-02-25 00:47:55.511869', NULL, '2025-03-06', 13, 'Automatically generated for 2025-03-06', NULL, 4, NULL, 13, 18),
(461, '2025-02-25 00:47:55.519869', '2025-02-25 00:47:55.519869', NULL, '2025-03-07', 14, 'Automatically generated for 2025-03-07', NULL, 4, NULL, 13, 18),
(462, '2025-02-25 00:47:55.527869', '2025-02-25 00:47:55.527869', NULL, '2025-03-08', 15, 'Automatically generated for 2025-03-08', NULL, 4, NULL, 13, 18),
(463, '2025-02-25 00:47:55.535378', '2025-02-25 00:47:55.536378', NULL, '2025-03-09', 13, 'Automatically generated for 2025-03-09', NULL, 4, NULL, 13, 18),
(464, '2025-02-25 00:47:55.543893', '2025-02-25 00:47:55.543893', NULL, '2025-03-10', 16, 'Automatically generated for 2025-03-10', NULL, 4, NULL, 13, 18),
(465, '2025-02-25 00:47:55.551935', '2025-02-25 00:47:55.551935', NULL, '2025-03-11', 13, 'Automatically generated for 2025-03-11', NULL, 4, NULL, 13, 18),
(466, '2025-02-25 00:47:55.560935', '2025-02-25 00:47:55.560935', NULL, '2025-03-12', 16, 'Automatically generated for 2025-03-12', NULL, 4, NULL, 13, 18),
(467, '2025-02-25 00:47:55.568935', '2025-02-25 00:47:55.568935', NULL, '2025-03-13', 15, 'Automatically generated for 2025-03-13', NULL, 4, NULL, 13, 18),
(468, '2025-02-25 00:47:55.576935', '2025-02-25 00:47:55.576935', NULL, '2025-03-14', 14, 'Automatically generated for 2025-03-14', NULL, 4, NULL, 13, 18),
(469, '2025-02-25 00:47:55.585697', '2025-02-25 00:47:55.585697', NULL, '2025-03-15', 14, 'Automatically generated for 2025-03-15', NULL, 4, NULL, 13, 18),
(470, '2025-02-25 00:47:55.594384', '2025-02-25 00:47:55.594384', NULL, '2025-03-16', 13, 'Automatically generated for 2025-03-16', NULL, 4, NULL, 13, 18),
(471, '2025-02-25 00:47:55.605727', '2025-02-25 00:47:55.605727', NULL, '2025-03-17', 13, 'Automatically generated for 2025-03-17', NULL, 4, NULL, 13, 18),
(472, '2025-02-25 00:47:55.613727', '2025-02-25 00:47:55.613727', NULL, '2025-03-18', 16, 'Automatically generated for 2025-03-18', NULL, 4, NULL, 13, 18),
(473, '2025-02-25 00:47:55.622251', '2025-02-25 00:47:55.622251', NULL, '2025-03-19', 16, 'Automatically generated for 2025-03-19', NULL, 4, NULL, 13, 18),
(474, '2025-02-25 00:47:55.630249', '2025-02-25 00:47:55.630249', NULL, '2025-03-20', 15, 'Automatically generated for 2025-03-20', NULL, 4, NULL, 13, 18),
(475, '2025-02-25 00:47:55.639251', '2025-02-25 00:47:55.639251', NULL, '2025-03-21', 16, 'Automatically generated for 2025-03-21', NULL, 4, NULL, 13, 18),
(476, '2025-02-25 00:47:55.647843', '2025-02-25 00:47:55.647843', NULL, '2025-03-22', 13, 'Automatically generated for 2025-03-22', NULL, 4, NULL, 13, 18),
(477, '2025-02-25 00:47:55.655764', '2025-02-25 00:47:55.655764', NULL, '2025-03-23', 13, 'Automatically generated for 2025-03-23', NULL, 4, NULL, 13, 18),
(478, '2025-02-25 00:47:55.664764', '2025-02-25 00:47:55.664764', NULL, '2025-03-24', 13, 'Automatically generated for 2025-03-24', NULL, 4, NULL, 13, 18),
(479, '2025-02-25 00:47:55.672763', '2025-02-25 00:47:55.672763', NULL, '2025-03-25', 16, 'Automatically generated for 2025-03-25', NULL, 4, NULL, 13, 18),
(480, '2025-02-25 00:47:55.680763', '2025-02-25 00:47:55.680763', NULL, '2025-03-26', 15, 'Automatically generated for 2025-03-26', NULL, 4, NULL, 13, 18),
(481, '2025-02-25 00:47:55.688763', '2025-02-25 00:47:55.688763', NULL, '2025-02-25', 12, 'Automatically generated for 2025-02-25', NULL, 4, NULL, 13, 20),
(482, '2025-02-25 00:47:55.698794', '2025-02-25 00:47:55.698794', NULL, '2025-02-26', 12, 'Automatically generated for 2025-02-26', NULL, 4, NULL, 13, 20),
(483, '2025-02-25 00:47:55.706794', '2025-02-25 00:47:55.706794', NULL, '2025-02-27', 12, 'Automatically generated for 2025-02-27', NULL, 4, NULL, 13, 20),
(484, '2025-02-25 00:47:55.714794', '2025-02-25 00:47:55.714794', NULL, '2025-02-28', 13, 'Automatically generated for 2025-02-28', NULL, 4, NULL, 13, 20),
(485, '2025-02-25 00:47:55.722824', '2025-02-25 00:47:55.722824', NULL, '2025-03-01', 15, 'Automatically generated for 2025-03-01', NULL, 4, NULL, 13, 20),
(486, '2025-02-25 00:47:55.732823', '2025-02-25 00:47:55.732823', NULL, '2025-03-02', 14, 'Automatically generated for 2025-03-02', NULL, 4, NULL, 13, 20),
(487, '2025-02-25 00:47:55.741554', '2025-02-25 00:47:55.741554', NULL, '2025-03-03', 12, 'Automatically generated for 2025-03-03', NULL, 4, NULL, 13, 20),
(488, '2025-02-25 00:47:55.749554', '2025-02-25 00:47:55.749554', NULL, '2025-03-04', 14, 'Automatically generated for 2025-03-04', NULL, 4, NULL, 13, 20),
(489, '2025-02-25 00:47:55.757068', '2025-02-25 00:47:55.757068', NULL, '2025-03-05', 15, 'Automatically generated for 2025-03-05', NULL, 4, NULL, 13, 20),
(490, '2025-02-25 00:47:55.765592', '2025-02-25 00:47:55.765592', NULL, '2025-03-06', 15, 'Automatically generated for 2025-03-06', NULL, 4, NULL, 13, 20),
(491, '2025-02-25 00:47:55.774592', '2025-02-25 00:47:55.774592', NULL, '2025-03-07', 13, 'Automatically generated for 2025-03-07', NULL, 4, NULL, 13, 20),
(492, '2025-02-25 00:47:55.783107', '2025-02-25 00:47:55.783107', NULL, '2025-03-08', 15, 'Automatically generated for 2025-03-08', NULL, 4, NULL, 13, 20),
(493, '2025-02-25 00:47:55.792107', '2025-02-25 00:47:55.792107', NULL, '2025-03-09', 12, 'Automatically generated for 2025-03-09', NULL, 4, NULL, 13, 20),
(494, '2025-02-25 00:47:55.800721', '2025-02-25 00:47:55.800721', NULL, '2025-03-10', 15, 'Automatically generated for 2025-03-10', NULL, 4, NULL, 13, 20),
(495, '2025-02-25 00:47:55.809720', '2025-02-25 00:47:55.809720', NULL, '2025-03-11', 15, 'Automatically generated for 2025-03-11', NULL, 4, NULL, 13, 20),
(496, '2025-02-25 00:47:55.821769', '2025-02-25 00:47:55.821769', NULL, '2025-03-12', 14, 'Automatically generated for 2025-03-12', NULL, 4, NULL, 13, 20),
(497, '2025-02-25 00:47:55.830760', '2025-02-25 00:47:55.830760', NULL, '2025-03-13', 13, 'Automatically generated for 2025-03-13', NULL, 4, NULL, 13, 20),
(498, '2025-02-25 00:47:55.838758', '2025-02-25 00:47:55.838758', NULL, '2025-03-14', 13, 'Automatically generated for 2025-03-14', NULL, 4, NULL, 13, 20),
(499, '2025-02-25 00:47:55.847862', '2025-02-25 00:47:55.847862', NULL, '2025-03-15', 12, 'Automatically generated for 2025-03-15', NULL, 4, NULL, 13, 20),
(500, '2025-02-25 00:47:55.855788', '2025-02-25 00:47:55.855788', NULL, '2025-03-16', 13, 'Automatically generated for 2025-03-16', NULL, 4, NULL, 13, 20),
(501, '2025-02-25 00:47:55.864789', '2025-02-25 00:47:55.864789', NULL, '2025-03-17', 12, 'Automatically generated for 2025-03-17', NULL, 4, NULL, 13, 20),
(502, '2025-02-25 00:47:55.876299', '2025-02-25 00:47:55.876299', NULL, '2025-03-18', 14, 'Automatically generated for 2025-03-18', NULL, 4, NULL, 13, 20),
(503, '2025-02-25 00:47:55.884299', '2025-02-25 00:47:55.884299', NULL, '2025-03-19', 14, 'Automatically generated for 2025-03-19', NULL, 4, NULL, 13, 20),
(504, '2025-02-25 00:47:55.893300', '2025-02-25 00:47:55.893300', NULL, '2025-03-20', 12, 'Automatically generated for 2025-03-20', NULL, 4, NULL, 13, 20),
(505, '2025-02-25 00:47:55.901829', '2025-02-25 00:47:55.901829', NULL, '2025-03-21', 14, 'Automatically generated for 2025-03-21', NULL, 4, NULL, 13, 20),
(506, '2025-02-25 00:47:55.911374', '2025-02-25 00:47:55.911374', NULL, '2025-03-22', 12, 'Automatically generated for 2025-03-22', NULL, 4, NULL, 13, 20),
(507, '2025-02-25 00:47:55.919589', '2025-02-25 00:47:55.919589', NULL, '2025-03-23', 12, 'Automatically generated for 2025-03-23', NULL, 4, NULL, 13, 20),
(508, '2025-02-25 00:47:55.927571', '2025-02-25 00:47:55.927571', NULL, '2025-03-24', 12, 'Automatically generated for 2025-03-24', NULL, 4, NULL, 13, 20),
(509, '2025-02-25 00:47:55.936610', '2025-02-25 00:47:55.936610', NULL, '2025-03-25', 12, 'Automatically generated for 2025-03-25', NULL, 4, NULL, 13, 20),
(510, '2025-02-25 00:47:55.945107', '2025-02-25 00:47:55.945107', NULL, '2025-03-26', 15, 'Automatically generated for 2025-03-26', NULL, 4, NULL, 13, 20),
(511, '2025-02-25 00:47:55.954602', '2025-02-25 00:47:55.954602', NULL, '2025-02-25', 14, 'Automatically generated for 2025-02-25', NULL, 4, NULL, 13, 19),
(512, '2025-02-25 00:47:55.962601', '2025-02-25 00:47:55.962601', NULL, '2025-02-26', 14, 'Automatically generated for 2025-02-26', NULL, 4, NULL, 13, 19),
(513, '2025-02-25 00:47:55.971805', '2025-02-25 00:47:55.971805', NULL, '2025-02-27', 14, 'Automatically generated for 2025-02-27', NULL, 4, NULL, 13, 19),
(514, '2025-02-25 00:47:55.981044', '2025-02-25 00:47:55.981044', NULL, '2025-02-28', 13, 'Automatically generated for 2025-02-28', NULL, 4, NULL, 13, 19),
(515, '2025-02-25 00:47:55.990046', '2025-02-25 00:47:55.990046', NULL, '2025-03-01', 12, 'Automatically generated for 2025-03-01', NULL, 4, NULL, 13, 19),
(516, '2025-02-25 00:47:55.998838', '2025-02-25 00:47:55.998838', NULL, '2025-03-02', 11, 'Automatically generated for 2025-03-02', NULL, 4, NULL, 13, 19),
(517, '2025-02-25 00:47:56.007470', '2025-02-25 00:47:56.007470', NULL, '2025-03-03', 14, 'Automatically generated for 2025-03-03', NULL, 4, NULL, 13, 19),
(518, '2025-02-25 00:47:56.017036', '2025-02-25 00:47:56.017036', NULL, '2025-03-04', 12, 'Automatically generated for 2025-03-04', NULL, 4, NULL, 13, 19),
(519, '2025-02-25 00:47:56.026517', '2025-02-25 00:47:56.026517', NULL, '2025-03-05', 11, 'Automatically generated for 2025-03-05', NULL, 4, NULL, 13, 19),
(520, '2025-02-25 00:47:56.035961', '2025-02-25 00:47:56.035961', NULL, '2025-03-06', 11, 'Automatically generated for 2025-03-06', NULL, 4, NULL, 13, 19),
(521, '2025-02-25 00:47:56.044794', '2025-02-25 00:47:56.044794', NULL, '2025-03-07', 11, 'Automatically generated for 2025-03-07', NULL, 4, NULL, 13, 19),
(522, '2025-02-25 00:47:56.054061', '2025-02-25 00:47:56.054061', NULL, '2025-03-08', 14, 'Automatically generated for 2025-03-08', NULL, 4, NULL, 13, 19),
(523, '2025-02-25 00:47:56.063091', '2025-02-25 00:47:56.063091', NULL, '2025-03-09', 13, 'Automatically generated for 2025-03-09', NULL, 4, NULL, 13, 19),
(524, '2025-02-25 00:47:56.072941', '2025-02-25 00:47:56.072941', NULL, '2025-03-10', 14, 'Automatically generated for 2025-03-10', NULL, 4, NULL, 13, 19),
(525, '2025-02-25 00:47:56.081366', '2025-02-25 00:47:56.081366', NULL, '2025-03-11', 13, 'Automatically generated for 2025-03-11', NULL, 4, NULL, 13, 19),
(526, '2025-02-25 00:47:56.091121', '2025-02-25 00:47:56.091121', NULL, '2025-03-12', 12, 'Automatically generated for 2025-03-12', NULL, 4, NULL, 13, 19),
(527, '2025-02-25 00:47:56.099991', '2025-02-25 00:47:56.099991', NULL, '2025-03-13', 12, 'Automatically generated for 2025-03-13', NULL, 4, NULL, 13, 19),
(528, '2025-02-25 00:47:56.109166', '2025-02-25 00:47:56.109166', NULL, '2025-03-14', 12, 'Automatically generated for 2025-03-14', NULL, 4, NULL, 13, 19),
(529, '2025-02-25 00:47:56.117987', '2025-02-25 00:47:56.117987', NULL, '2025-03-15', 12, 'Automatically generated for 2025-03-15', NULL, 4, NULL, 13, 19),
(530, '2025-02-25 00:47:56.127567', '2025-02-25 00:47:56.127567', NULL, '2025-03-16', 11, 'Automatically generated for 2025-03-16', NULL, 4, NULL, 13, 19),
(531, '2025-02-25 00:47:56.137672', '2025-02-25 00:47:56.137672', NULL, '2025-03-17', 13, 'Automatically generated for 2025-03-17', NULL, 4, NULL, 13, 19),
(532, '2025-02-25 00:47:56.146162', '2025-02-25 00:47:56.146162', NULL, '2025-03-18', 12, 'Automatically generated for 2025-03-18', NULL, 4, NULL, 13, 19),
(533, '2025-02-25 00:47:56.155082', '2025-02-25 00:47:56.155082', NULL, '2025-03-19', 13, 'Automatically generated for 2025-03-19', NULL, 4, NULL, 13, 19),
(534, '2025-02-25 00:47:56.164949', '2025-02-25 00:47:56.164949', NULL, '2025-03-20', 13, 'Automatically generated for 2025-03-20', NULL, 4, NULL, 13, 19),
(535, '2025-02-25 00:47:56.174278', '2025-02-25 00:47:56.174278', NULL, '2025-03-21', 13, 'Automatically generated for 2025-03-21', NULL, 4, NULL, 13, 19),
(536, '2025-02-25 00:47:56.182253', '2025-02-25 00:47:56.182253', NULL, '2025-03-22', 14, 'Automatically generated for 2025-03-22', NULL, 4, NULL, 13, 19),
(537, '2025-02-25 00:47:56.191251', '2025-02-25 00:47:56.191251', NULL, '2025-03-23', 14, 'Automatically generated for 2025-03-23', NULL, 4, NULL, 13, 19),
(538, '2025-02-25 00:47:56.200138', '2025-02-25 00:47:56.200138', NULL, '2025-03-24', 11, 'Automatically generated for 2025-03-24', NULL, 4, NULL, 13, 19),
(539, '2025-02-25 00:47:56.208967', '2025-02-25 00:47:56.208967', NULL, '2025-03-25', 12, 'Automatically generated for 2025-03-25', NULL, 4, NULL, 13, 19),
(540, '2025-02-25 00:47:56.218529', '2025-02-25 00:47:56.218529', NULL, '2025-03-26', 11, 'Automatically generated for 2025-03-26', NULL, 4, NULL, 13, 19),
(541, '2025-02-25 00:47:56.227416', '2025-02-25 00:47:56.227416', NULL, '2025-02-25', 10, 'Automatically generated for 2025-02-25', NULL, 4, NULL, 13, 17),
(542, '2025-02-25 00:47:56.235616', '2025-02-25 00:47:56.235616', NULL, '2025-02-26', 8, 'Automatically generated for 2025-02-26', NULL, 4, NULL, 13, 17),
(543, '2025-02-25 00:47:56.244613', '2025-02-25 00:47:56.244613', NULL, '2025-02-27', 7, 'Automatically generated for 2025-02-27', NULL, 4, NULL, 13, 17),
(544, '2025-02-25 00:47:56.253879', '2025-02-25 00:47:56.253879', NULL, '2025-02-28', 10, 'Automatically generated for 2025-02-28', NULL, 4, NULL, 13, 17),
(545, '2025-02-25 00:47:56.261880', '2025-02-25 00:47:56.261880', NULL, '2025-03-01', 10, 'Automatically generated for 2025-03-01', NULL, 4, NULL, 13, 17),
(546, '2025-02-25 00:47:56.270880', '2025-02-25 00:47:56.270880', NULL, '2025-03-02', 9, 'Automatically generated for 2025-03-02', NULL, 4, NULL, 13, 17),
(547, '2025-02-25 00:47:56.279880', '2025-02-25 00:47:56.279880', NULL, '2025-03-03', 9, 'Automatically generated for 2025-03-03', NULL, 4, NULL, 13, 17),
(548, '2025-02-25 00:47:56.288879', '2025-02-25 00:47:56.288879', NULL, '2025-03-04', 10, 'Automatically generated for 2025-03-04', NULL, 4, NULL, 13, 17),
(549, '2025-02-25 00:47:56.297991', '2025-02-25 00:47:56.297991', NULL, '2025-03-05', 7, 'Automatically generated for 2025-03-05', NULL, 4, NULL, 13, 17),
(550, '2025-02-25 00:47:56.307541', '2025-02-25 00:47:56.307541', NULL, '2025-03-06', 7, 'Automatically generated for 2025-03-06', NULL, 4, NULL, 13, 17),
(551, '2025-02-25 00:47:56.320127', '2025-02-25 00:47:56.320127', NULL, '2025-03-07', 7, 'Automatically generated for 2025-03-07', NULL, 4, NULL, 13, 17),
(552, '2025-02-25 00:47:56.328646', '2025-02-25 00:47:56.328646', NULL, '2025-03-08', 7, 'Automatically generated for 2025-03-08', NULL, 4, NULL, 13, 17),
(553, '2025-02-25 00:47:56.338646', '2025-02-25 00:47:56.338646', NULL, '2025-03-09', 9, 'Automatically generated for 2025-03-09', NULL, 4, NULL, 13, 17),
(554, '2025-02-25 00:47:56.348103', '2025-02-25 00:47:56.348103', NULL, '2025-03-10', 10, 'Automatically generated for 2025-03-10', NULL, 4, NULL, 13, 17),
(555, '2025-02-25 00:47:56.357103', '2025-02-25 00:47:56.357103', NULL, '2025-03-11', 9, 'Automatically generated for 2025-03-11', NULL, 4, NULL, 13, 17),
(556, '2025-02-25 00:47:56.367694', '2025-02-25 00:47:56.367694', NULL, '2025-03-12', 10, 'Automatically generated for 2025-03-12', NULL, 4, NULL, 13, 17),
(557, '2025-02-25 00:47:56.376465', '2025-02-25 00:47:56.376465', NULL, '2025-03-13', 7, 'Automatically generated for 2025-03-13', NULL, 4, NULL, 13, 17),
(558, '2025-02-25 00:47:56.385465', '2025-02-25 00:47:56.385465', NULL, '2025-03-14', 10, 'Automatically generated for 2025-03-14', NULL, 4, NULL, 13, 17),
(559, '2025-02-25 00:47:56.394465', '2025-02-25 00:47:56.394465', NULL, '2025-03-15', 8, 'Automatically generated for 2025-03-15', NULL, 4, NULL, 13, 17),
(560, '2025-02-25 00:47:56.403240', '2025-02-25 00:47:56.403240', NULL, '2025-03-16', 9, 'Automatically generated for 2025-03-16', NULL, 4, NULL, 13, 17),
(561, '2025-02-25 00:47:56.413129', '2025-02-25 00:47:56.413129', NULL, '2025-03-17', 10, 'Automatically generated for 2025-03-17', NULL, 4, NULL, 13, 17),
(562, '2025-02-25 00:47:56.421690', '2025-02-25 00:47:56.421690', NULL, '2025-03-18', 7, 'Automatically generated for 2025-03-18', NULL, 4, NULL, 13, 17),
(563, '2025-02-25 00:47:56.431487', '2025-02-25 00:47:56.431487', NULL, '2025-03-19', 9, 'Automatically generated for 2025-03-19', NULL, 4, NULL, 13, 17),
(564, '2025-02-25 00:47:56.440488', '2025-02-25 00:47:56.440488', NULL, '2025-03-20', 9, 'Automatically generated for 2025-03-20', NULL, 4, NULL, 13, 17),
(565, '2025-02-25 00:47:56.449855', '2025-02-25 00:47:56.449855', NULL, '2025-03-21', 8, 'Automatically generated for 2025-03-21', NULL, 4, NULL, 13, 17),
(566, '2025-02-25 00:47:56.457904', '2025-02-25 00:47:56.457904', NULL, '2025-03-22', 10, 'Automatically generated for 2025-03-22', NULL, 4, NULL, 13, 17),
(567, '2025-02-25 00:47:56.467369', '2025-02-25 00:47:56.467369', NULL, '2025-03-23', 7, 'Automatically generated for 2025-03-23', NULL, 4, NULL, 13, 17),
(568, '2025-02-25 00:47:56.476482', '2025-02-25 00:47:56.476482', NULL, '2025-03-24', 8, 'Automatically generated for 2025-03-24', NULL, 4, NULL, 13, 17),
(569, '2025-02-25 00:47:56.485448', '2025-02-25 00:47:56.486448', NULL, '2025-03-25', 9, 'Automatically generated for 2025-03-25', NULL, 4, NULL, 13, 17),
(570, '2025-02-25 00:47:56.495250', '2025-02-25 00:47:56.495250', NULL, '2025-03-26', 7, 'Automatically generated for 2025-03-26', NULL, 4, NULL, 13, 17),
(571, '2025-02-25 00:47:56.503771', '2025-02-25 00:47:56.503771', NULL, '2025-02-25', 10, 'Automatically generated for 2025-02-25', NULL, 4, NULL, 13, 16),
(572, '2025-02-25 00:47:56.511328', '2025-02-25 00:47:56.511328', NULL, '2025-02-26', 13, 'Automatically generated for 2025-02-26', NULL, 4, NULL, 13, 16),
(573, '2025-02-25 00:47:56.520001', '2025-02-25 00:47:56.520965', NULL, '2025-02-27', 11, 'Automatically generated for 2025-02-27', NULL, 4, NULL, 13, 16),
(574, '2025-02-25 00:47:56.529042', '2025-02-25 00:47:56.529042', NULL, '2025-02-28', 11, 'Automatically generated for 2025-02-28', NULL, 4, NULL, 13, 16),
(575, '2025-02-25 00:47:56.538033', '2025-02-25 00:47:56.538033', NULL, '2025-03-01', 13, 'Automatically generated for 2025-03-01', NULL, 4, NULL, 13, 16),
(576, '2025-02-25 00:47:56.547046', '2025-02-25 00:47:56.547046', NULL, '2025-03-02', 13, 'Automatically generated for 2025-03-02', NULL, 4, NULL, 13, 16),
(577, '2025-02-25 00:47:56.557069', '2025-02-25 00:47:56.557069', NULL, '2025-03-03', 13, 'Automatically generated for 2025-03-03', NULL, 4, NULL, 13, 16),
(578, '2025-02-25 00:47:56.566046', '2025-02-25 00:47:56.566046', NULL, '2025-03-04', 12, 'Automatically generated for 2025-03-04', NULL, 4, NULL, 13, 16),
(579, '2025-02-25 00:47:56.575145', '2025-02-25 00:47:56.575145', NULL, '2025-03-05', 12, 'Automatically generated for 2025-03-05', NULL, 4, NULL, 13, 16),
(580, '2025-02-25 00:47:56.584143', '2025-02-25 00:47:56.584143', NULL, '2025-03-06', 10, 'Automatically generated for 2025-03-06', NULL, 4, NULL, 13, 16),
(581, '2025-02-25 00:47:56.594198', '2025-02-25 00:47:56.594198', NULL, '2025-03-07', 11, 'Automatically generated for 2025-03-07', NULL, 4, NULL, 13, 16),
(582, '2025-02-25 00:47:56.603155', '2025-02-25 00:47:56.603155', NULL, '2025-03-08', 12, 'Automatically generated for 2025-03-08', NULL, 4, NULL, 13, 16),
(583, '2025-02-25 00:47:56.612156', '2025-02-25 00:47:56.612156', NULL, '2025-03-09', 13, 'Automatically generated for 2025-03-09', NULL, 4, NULL, 13, 16),
(584, '2025-02-25 00:47:56.621156', '2025-02-25 00:47:56.621156', NULL, '2025-03-10', 12, 'Automatically generated for 2025-03-10', NULL, 4, NULL, 13, 16),
(585, '2025-02-25 00:47:56.630518', '2025-02-25 00:47:56.630518', NULL, '2025-03-11', 10, 'Automatically generated for 2025-03-11', NULL, 4, NULL, 13, 16),
(586, '2025-02-25 00:47:56.638553', '2025-02-25 00:47:56.638553', NULL, '2025-03-12', 11, 'Automatically generated for 2025-03-12', NULL, 4, NULL, 13, 16),
(587, '2025-02-25 00:47:56.648107', '2025-02-25 00:47:56.648107', NULL, '2025-03-13', 11, 'Automatically generated for 2025-03-13', NULL, 4, NULL, 13, 16),
(588, '2025-02-25 00:47:56.657116', '2025-02-25 00:47:56.657116', NULL, '2025-03-14', 12, 'Automatically generated for 2025-03-14', NULL, 4, NULL, 13, 16),
(589, '2025-02-25 00:47:56.666087', '2025-02-25 00:47:56.666087', NULL, '2025-03-15', 10, 'Automatically generated for 2025-03-15', NULL, 4, NULL, 13, 16),
(590, '2025-02-25 00:47:56.675145', '2025-02-25 00:47:56.675145', NULL, '2025-03-16', 10, 'Automatically generated for 2025-03-16', NULL, 4, NULL, 13, 16),
(591, '2025-02-25 00:47:56.684145', '2025-02-25 00:47:56.684145', NULL, '2025-03-17', 11, 'Automatically generated for 2025-03-17', NULL, 4, NULL, 13, 16),
(592, '2025-02-25 00:47:56.693145', '2025-02-25 00:47:56.693145', NULL, '2025-03-18', 11, 'Automatically generated for 2025-03-18', NULL, 4, NULL, 13, 16),
(593, '2025-02-25 00:47:56.701979', '2025-02-25 00:47:56.701979', NULL, '2025-03-19', 10, 'Automatically generated for 2025-03-19', NULL, 4, NULL, 13, 16),
(594, '2025-02-25 00:47:56.711629', '2025-02-25 00:47:56.711629', NULL, '2025-03-20', 13, 'Automatically generated for 2025-03-20', NULL, 4, NULL, 13, 16),
(595, '2025-02-25 00:47:56.720187', '2025-02-25 00:47:56.720187', NULL, '2025-03-21', 13, 'Automatically generated for 2025-03-21', NULL, 4, NULL, 13, 16),
(596, '2025-02-25 00:47:56.729559', '2025-02-25 00:47:56.729559', NULL, '2025-03-22', 13, 'Automatically generated for 2025-03-22', NULL, 4, NULL, 13, 16),
(597, '2025-02-25 00:47:56.738559', '2025-02-25 00:47:56.738559', NULL, '2025-03-23', 13, 'Automatically generated for 2025-03-23', NULL, 4, NULL, 13, 16),
(598, '2025-02-25 00:47:56.748100', '2025-02-25 00:47:56.748100', NULL, '2025-03-24', 11, 'Automatically generated for 2025-03-24', NULL, 4, NULL, 13, 16),
(599, '2025-02-25 00:47:56.757411', '2025-02-25 00:47:56.757411', NULL, '2025-03-25', 10, 'Automatically generated for 2025-03-25', NULL, 4, NULL, 13, 16),
(600, '2025-02-25 00:47:56.766925', '2025-02-25 00:47:56.766925', NULL, '2025-03-26', 12, 'Automatically generated for 2025-03-26', NULL, 4, NULL, 13, 16),
(601, '2025-02-25 00:47:56.799033', '2025-02-25 00:47:56.799033', NULL, '2025-02-25', 16, 'Automatically generated for 2025-02-25', NULL, 5, NULL, 17, 23),
(602, '2025-02-25 00:47:56.806654', '2025-02-25 00:47:56.806654', NULL, '2025-02-26', 19, 'Automatically generated for 2025-02-26', NULL, 5, NULL, 17, 23),
(603, '2025-02-25 00:47:56.818569', '2025-02-25 00:47:56.818569', NULL, '2025-02-27', 16, 'Automatically generated for 2025-02-27', NULL, 5, NULL, 17, 23),
(604, '2025-02-25 00:47:56.827139', '2025-02-25 00:47:56.827139', NULL, '2025-02-28', 16, 'Automatically generated for 2025-02-28', NULL, 5, NULL, 17, 23),
(605, '2025-02-25 00:47:56.838174', '2025-02-25 00:47:56.839140', NULL, '2025-03-01', 19, 'Automatically generated for 2025-03-01', NULL, 5, NULL, 17, 23),
(606, '2025-02-25 00:47:56.846756', '2025-02-25 00:47:56.847721', NULL, '2025-03-02', 17, 'Automatically generated for 2025-03-02', NULL, 5, NULL, 17, 23),
(607, '2025-02-25 00:47:56.855722', '2025-02-25 00:47:56.855722', NULL, '2025-03-03', 18, 'Automatically generated for 2025-03-03', NULL, 5, NULL, 17, 23),
(608, '2025-02-25 00:47:56.863840', '2025-02-25 00:47:56.863840', NULL, '2025-03-04', 18, 'Automatically generated for 2025-03-04', NULL, 5, NULL, 17, 23),
(609, '2025-02-25 00:47:56.871759', '2025-02-25 00:47:56.871759', NULL, '2025-03-05', 16, 'Automatically generated for 2025-03-05', NULL, 5, NULL, 17, 23),
(610, '2025-02-25 00:47:56.880730', '2025-02-25 00:47:56.880730', NULL, '2025-03-06', 19, 'Automatically generated for 2025-03-06', NULL, 5, NULL, 17, 23),
(611, '2025-02-25 00:47:56.888730', '2025-02-25 00:47:56.888730', NULL, '2025-03-07', 16, 'Automatically generated for 2025-03-07', NULL, 5, NULL, 17, 23),
(612, '2025-02-25 00:47:56.896580', '2025-02-25 00:47:56.897554', NULL, '2025-03-08', 18, 'Automatically generated for 2025-03-08', NULL, 5, NULL, 17, 23),
(613, '2025-02-25 00:47:56.904715', '2025-02-25 00:47:56.904715', NULL, '2025-03-09', 19, 'Automatically generated for 2025-03-09', NULL, 5, NULL, 17, 23),
(614, '2025-02-25 00:47:56.913713', '2025-02-25 00:47:56.913713', NULL, '2025-03-10', 19, 'Automatically generated for 2025-03-10', NULL, 5, NULL, 17, 23),
(615, '2025-02-25 00:47:56.922447', '2025-02-25 00:47:56.922447', NULL, '2025-03-11', 19, 'Automatically generated for 2025-03-11', NULL, 5, NULL, 17, 23),
(616, '2025-02-25 00:47:56.930927', '2025-02-25 00:47:56.930927', NULL, '2025-03-12', 16, 'Automatically generated for 2025-03-12', NULL, 5, NULL, 17, 23),
(617, '2025-02-25 00:47:56.938747', '2025-02-25 00:47:56.938747', NULL, '2025-03-13', 16, 'Automatically generated for 2025-03-13', NULL, 5, NULL, 17, 23),
(618, '2025-02-25 00:47:56.947176', '2025-02-25 00:47:56.947176', NULL, '2025-03-14', 16, 'Automatically generated for 2025-03-14', NULL, 5, NULL, 17, 23),
(619, '2025-02-25 00:47:56.955902', '2025-02-25 00:47:56.955902', NULL, '2025-03-15', 18, 'Automatically generated for 2025-03-15', NULL, 5, NULL, 17, 23),
(620, '2025-02-25 00:47:56.964140', '2025-02-25 00:47:56.964140', NULL, '2025-03-16', 19, 'Automatically generated for 2025-03-16', NULL, 5, NULL, 17, 23),
(621, '2025-02-25 00:47:56.971991', '2025-02-25 00:47:56.971991', NULL, '2025-03-17', 17, 'Automatically generated for 2025-03-17', NULL, 5, NULL, 17, 23),
(622, '2025-02-25 00:47:56.981340', '2025-02-25 00:47:56.981340', NULL, '2025-03-18', 17, 'Automatically generated for 2025-03-18', NULL, 5, NULL, 17, 23),
(623, '2025-02-25 00:47:56.990338', '2025-02-25 00:47:56.990338', NULL, '2025-03-19', 19, 'Automatically generated for 2025-03-19', NULL, 5, NULL, 17, 23),
(624, '2025-02-25 00:47:56.998616', '2025-02-25 00:47:56.998616', NULL, '2025-03-20', 19, 'Automatically generated for 2025-03-20', NULL, 5, NULL, 17, 23),
(625, '2025-02-25 00:47:57.007104', '2025-02-25 00:47:57.007104', NULL, '2025-03-21', 19, 'Automatically generated for 2025-03-21', NULL, 5, NULL, 17, 23),
(626, '2025-02-25 00:47:57.015101', '2025-02-25 00:47:57.015101', NULL, '2025-03-22', 16, 'Automatically generated for 2025-03-22', NULL, 5, NULL, 17, 23),
(627, '2025-02-25 00:47:57.023217', '2025-02-25 00:47:57.023217', NULL, '2025-03-23', 16, 'Automatically generated for 2025-03-23', NULL, 5, NULL, 17, 23),
(628, '2025-02-25 00:47:57.031456', '2025-02-25 00:47:57.031456', NULL, '2025-03-24', 17, 'Automatically generated for 2025-03-24', NULL, 5, NULL, 17, 23),
(629, '2025-02-25 00:47:57.038457', '2025-02-25 00:47:57.038457', NULL, '2025-03-25', 16, 'Automatically generated for 2025-03-25', NULL, 5, NULL, 17, 23),
(630, '2025-02-25 00:47:57.047598', '2025-02-25 00:47:57.047598', NULL, '2025-03-26', 17, 'Automatically generated for 2025-03-26', NULL, 5, NULL, 17, 23),
(631, '2025-02-25 00:47:57.055878', '2025-02-25 00:47:57.055878', NULL, '2025-02-25', 8, 'Automatically generated for 2025-02-25', NULL, 5, NULL, 17, 25),
(632, '2025-02-25 00:47:57.064879', '2025-02-25 00:47:57.064879', NULL, '2025-02-26', 8, 'Automatically generated for 2025-02-26', NULL, 5, NULL, 17, 25),
(633, '2025-02-25 00:47:57.072244', '2025-02-25 00:47:57.072244', NULL, '2025-02-27', 10, 'Automatically generated for 2025-02-27', NULL, 5, NULL, 17, 25),
(634, '2025-02-25 00:47:57.081258', '2025-02-25 00:47:57.081258', NULL, '2025-02-28', 11, 'Automatically generated for 2025-02-28', NULL, 5, NULL, 17, 25),
(635, '2025-02-25 00:47:57.089258', '2025-02-25 00:47:57.089258', NULL, '2025-03-01', 8, 'Automatically generated for 2025-03-01', NULL, 5, NULL, 17, 25),
(636, '2025-02-25 00:47:57.097930', '2025-02-25 00:47:57.097930', NULL, '2025-03-02', 9, 'Automatically generated for 2025-03-02', NULL, 5, NULL, 17, 25),
(637, '2025-02-25 00:47:57.105931', '2025-02-25 00:47:57.105931', NULL, '2025-03-03', 10, 'Automatically generated for 2025-03-03', NULL, 5, NULL, 17, 25),
(638, '2025-02-25 00:47:57.114931', '2025-02-25 00:47:57.114931', NULL, '2025-03-04', 8, 'Automatically generated for 2025-03-04', NULL, 5, NULL, 17, 25),
(639, '2025-02-25 00:47:57.123298', '2025-02-25 00:47:57.123298', NULL, '2025-03-05', 9, 'Automatically generated for 2025-03-05', NULL, 5, NULL, 17, 25),
(640, '2025-02-25 00:47:57.131679', '2025-02-25 00:47:57.131679', NULL, '2025-03-06', 11, 'Automatically generated for 2025-03-06', NULL, 5, NULL, 17, 25),
(641, '2025-02-25 00:47:57.139681', '2025-02-25 00:47:57.139681', NULL, '2025-03-07', 8, 'Automatically generated for 2025-03-07', NULL, 5, NULL, 17, 25),
(642, '2025-02-25 00:47:57.148171', '2025-02-25 00:47:57.148171', NULL, '2025-03-08', 11, 'Automatically generated for 2025-03-08', NULL, 5, NULL, 17, 25),
(643, '2025-02-25 00:47:57.157133', '2025-02-25 00:47:57.157133', NULL, '2025-03-09', 10, 'Automatically generated for 2025-03-09', NULL, 5, NULL, 17, 25),
(644, '2025-02-25 00:47:57.165222', '2025-02-25 00:47:57.165222', NULL, '2025-03-10', 8, 'Automatically generated for 2025-03-10', NULL, 5, NULL, 17, 25),
(645, '2025-02-25 00:47:57.173185', '2025-02-25 00:47:57.173185', NULL, '2025-03-11', 10, 'Automatically generated for 2025-03-11', NULL, 5, NULL, 17, 25),
(646, '2025-02-25 00:47:57.181203', '2025-02-25 00:47:57.181203', NULL, '2025-03-12', 8, 'Automatically generated for 2025-03-12', NULL, 5, NULL, 17, 25),
(647, '2025-02-25 00:47:57.189235', '2025-02-25 00:47:57.189235', NULL, '2025-03-13', 8, 'Automatically generated for 2025-03-13', NULL, 5, NULL, 17, 25),
(648, '2025-02-25 00:47:57.197296', '2025-02-25 00:47:57.198258', NULL, '2025-03-14', 10, 'Automatically generated for 2025-03-14', NULL, 5, NULL, 17, 25),
(649, '2025-02-25 00:47:57.206331', '2025-02-25 00:47:57.206331', NULL, '2025-03-15', 10, 'Automatically generated for 2025-03-15', NULL, 5, NULL, 17, 25),
(650, '2025-02-25 00:47:57.214341', '2025-02-25 00:47:57.214341', NULL, '2025-03-16', 11, 'Automatically generated for 2025-03-16', NULL, 5, NULL, 17, 25),
(651, '2025-02-25 00:47:57.222924', '2025-02-25 00:47:57.222924', NULL, '2025-03-17', 10, 'Automatically generated for 2025-03-17', NULL, 5, NULL, 17, 25),
(652, '2025-02-25 00:47:57.231459', '2025-02-25 00:47:57.231459', NULL, '2025-03-18', 9, 'Automatically generated for 2025-03-18', NULL, 5, NULL, 17, 25);
INSERT INTO `rooms_availability` (`id`, `created_at`, `updated_at`, `deleted_at`, `availability_date`, `available_rooms`, `notes`, `created_by_id`, `hotel_id`, `updated_by_id`, `room_status_id`, `room_type_id`) VALUES
(653, '2025-02-25 00:47:57.239494', '2025-02-25 00:47:57.239494', NULL, '2025-03-19', 8, 'Automatically generated for 2025-03-19', NULL, 5, NULL, 17, 25),
(654, '2025-02-25 00:47:57.248252', '2025-02-25 00:47:57.248252', NULL, '2025-03-20', 10, 'Automatically generated for 2025-03-20', NULL, 5, NULL, 17, 25),
(655, '2025-02-25 00:47:57.256126', '2025-02-25 00:47:57.256126', NULL, '2025-03-21', 8, 'Automatically generated for 2025-03-21', NULL, 5, NULL, 17, 25),
(656, '2025-02-25 00:47:57.265678', '2025-02-25 00:47:57.265678', NULL, '2025-03-22', 11, 'Automatically generated for 2025-03-22', NULL, 5, NULL, 17, 25),
(657, '2025-02-25 00:47:57.274361', '2025-02-25 00:47:57.274361', NULL, '2025-03-23', 10, 'Automatically generated for 2025-03-23', NULL, 5, NULL, 17, 25),
(658, '2025-02-25 00:47:57.282372', '2025-02-25 00:47:57.282372', NULL, '2025-03-24', 9, 'Automatically generated for 2025-03-24', NULL, 5, NULL, 17, 25),
(659, '2025-02-25 00:47:57.292492', '2025-02-25 00:47:57.293371', NULL, '2025-03-25', 8, 'Automatically generated for 2025-03-25', NULL, 5, NULL, 17, 25),
(660, '2025-02-25 00:47:57.303982', '2025-02-25 00:47:57.303982', NULL, '2025-03-26', 10, 'Automatically generated for 2025-03-26', NULL, 5, NULL, 17, 25),
(661, '2025-02-25 00:47:57.312981', '2025-02-25 00:47:57.312981', NULL, '2025-02-25', 6, 'Automatically generated for 2025-02-25', NULL, 5, NULL, 17, 24),
(662, '2025-02-25 00:47:57.321981', '2025-02-25 00:47:57.321981', NULL, '2025-02-26', 5, 'Automatically generated for 2025-02-26', NULL, 5, NULL, 17, 24),
(663, '2025-02-25 00:47:57.330981', '2025-02-25 00:47:57.330981', NULL, '2025-02-27', 4, 'Automatically generated for 2025-02-27', NULL, 5, NULL, 17, 24),
(664, '2025-02-25 00:47:57.338981', '2025-02-25 00:47:57.338981', NULL, '2025-02-28', 4, 'Automatically generated for 2025-02-28', NULL, 5, NULL, 17, 24),
(665, '2025-02-25 00:47:57.351190', '2025-02-25 00:47:57.351190', NULL, '2025-03-01', 6, 'Automatically generated for 2025-03-01', NULL, 5, NULL, 17, 24),
(666, '2025-02-25 00:47:57.359224', '2025-02-25 00:47:57.359224', NULL, '2025-03-02', 6, 'Automatically generated for 2025-03-02', NULL, 5, NULL, 17, 24),
(667, '2025-02-25 00:47:57.368725', '2025-02-25 00:47:57.368725', NULL, '2025-03-03', 6, 'Automatically generated for 2025-03-03', NULL, 5, NULL, 17, 24),
(668, '2025-02-25 00:47:57.377281', '2025-02-25 00:47:57.377281', NULL, '2025-03-04', 4, 'Automatically generated for 2025-03-04', NULL, 5, NULL, 17, 24),
(669, '2025-02-25 00:47:57.391282', '2025-02-25 00:47:57.391282', NULL, '2025-03-05', 5, 'Automatically generated for 2025-03-05', NULL, 5, NULL, 17, 24),
(670, '2025-02-25 00:47:57.398099', '2025-02-25 00:47:57.398099', NULL, '2025-03-06', 3, 'Automatically generated for 2025-03-06', NULL, 5, NULL, 17, 24),
(671, '2025-02-25 00:47:57.406931', '2025-02-25 00:47:57.406931', NULL, '2025-03-07', 3, 'Automatically generated for 2025-03-07', NULL, 5, NULL, 17, 24),
(672, '2025-02-25 00:47:57.414943', '2025-02-25 00:47:57.414943', NULL, '2025-03-08', 5, 'Automatically generated for 2025-03-08', NULL, 5, NULL, 17, 24),
(673, '2025-02-25 00:47:57.423135', '2025-02-25 00:47:57.423135', NULL, '2025-03-09', 4, 'Automatically generated for 2025-03-09', NULL, 5, NULL, 17, 24),
(674, '2025-02-25 00:47:57.431336', '2025-02-25 00:47:57.431336', NULL, '2025-03-10', 5, 'Automatically generated for 2025-03-10', NULL, 5, NULL, 17, 24),
(675, '2025-02-25 00:47:57.439272', '2025-02-25 00:47:57.439272', NULL, '2025-03-11', 6, 'Automatically generated for 2025-03-11', NULL, 5, NULL, 17, 24),
(676, '2025-02-25 00:47:57.447335', '2025-02-25 00:47:57.447335', NULL, '2025-03-12', 3, 'Automatically generated for 2025-03-12', NULL, 5, NULL, 17, 24),
(677, '2025-02-25 00:47:57.456577', '2025-02-25 00:47:57.456577', NULL, '2025-03-13', 6, 'Automatically generated for 2025-03-13', NULL, 5, NULL, 17, 24),
(678, '2025-02-25 00:47:57.464408', '2025-02-25 00:47:57.464408', NULL, '2025-03-14', 6, 'Automatically generated for 2025-03-14', NULL, 5, NULL, 17, 24),
(679, '2025-02-25 00:47:57.473404', '2025-02-25 00:47:57.473404', NULL, '2025-03-15', 6, 'Automatically generated for 2025-03-15', NULL, 5, NULL, 17, 24),
(680, '2025-02-25 00:47:57.482121', '2025-02-25 00:47:57.482121', NULL, '2025-03-16', 5, 'Automatically generated for 2025-03-16', NULL, 5, NULL, 17, 24),
(681, '2025-02-25 00:47:57.491120', '2025-02-25 00:47:57.491120', NULL, '2025-03-17', 3, 'Automatically generated for 2025-03-17', NULL, 5, NULL, 17, 24),
(682, '2025-02-25 00:47:57.499070', '2025-02-25 00:47:57.499070', NULL, '2025-03-18', 3, 'Automatically generated for 2025-03-18', NULL, 5, NULL, 17, 24),
(683, '2025-02-25 00:47:57.507206', '2025-02-25 00:47:57.507206', NULL, '2025-03-19', 5, 'Automatically generated for 2025-03-19', NULL, 5, NULL, 17, 24),
(684, '2025-02-25 00:47:57.515108', '2025-02-25 00:47:57.515108', NULL, '2025-03-20', 4, 'Automatically generated for 2025-03-20', NULL, 5, NULL, 17, 24),
(685, '2025-02-25 00:47:57.523815', '2025-02-25 00:47:57.523815', NULL, '2025-03-21', 3, 'Automatically generated for 2025-03-21', NULL, 5, NULL, 17, 24),
(686, '2025-02-25 00:47:57.532368', '2025-02-25 00:47:57.532368', NULL, '2025-03-22', 3, 'Automatically generated for 2025-03-22', NULL, 5, NULL, 17, 24),
(687, '2025-02-25 00:47:57.540404', '2025-02-25 00:47:57.540404', NULL, '2025-03-23', 4, 'Automatically generated for 2025-03-23', NULL, 5, NULL, 17, 24),
(688, '2025-02-25 00:47:57.549518', '2025-02-25 00:47:57.549518', NULL, '2025-03-24', 4, 'Automatically generated for 2025-03-24', NULL, 5, NULL, 17, 24),
(689, '2025-02-25 00:47:57.557532', '2025-02-25 00:47:57.557532', NULL, '2025-03-25', 4, 'Automatically generated for 2025-03-25', NULL, 5, NULL, 17, 24),
(690, '2025-02-25 00:47:57.566058', '2025-02-25 00:47:57.566058', NULL, '2025-03-26', 4, 'Automatically generated for 2025-03-26', NULL, 5, NULL, 17, 24),
(691, '2025-02-25 00:47:57.574540', '2025-02-25 00:47:57.574540', NULL, '2025-02-25', 19, 'Automatically generated for 2025-02-25', NULL, 5, NULL, 17, 22),
(692, '2025-02-25 00:47:57.582451', '2025-02-25 00:47:57.582451', NULL, '2025-02-26', 16, 'Automatically generated for 2025-02-26', NULL, 5, NULL, 17, 22),
(693, '2025-02-25 00:47:57.591415', '2025-02-25 00:47:57.591415', NULL, '2025-02-27', 18, 'Automatically generated for 2025-02-27', NULL, 5, NULL, 17, 22),
(694, '2025-02-25 00:47:57.599204', '2025-02-25 00:47:57.599204', NULL, '2025-02-28', 18, 'Automatically generated for 2025-02-28', NULL, 5, NULL, 17, 22),
(695, '2025-02-25 00:47:57.607891', '2025-02-25 00:47:57.607891', NULL, '2025-03-01', 17, 'Automatically generated for 2025-03-01', NULL, 5, NULL, 17, 22),
(696, '2025-02-25 00:47:57.617281', '2025-02-25 00:47:57.617281', NULL, '2025-03-02', 16, 'Automatically generated for 2025-03-02', NULL, 5, NULL, 17, 22),
(697, '2025-02-25 00:47:57.625016', '2025-02-25 00:47:57.625016', NULL, '2025-03-03', 18, 'Automatically generated for 2025-03-03', NULL, 5, NULL, 17, 22),
(698, '2025-02-25 00:47:57.637675', '2025-02-25 00:47:57.637675', NULL, '2025-03-04', 19, 'Automatically generated for 2025-03-04', NULL, 5, NULL, 17, 22),
(699, '2025-02-25 00:47:57.645945', '2025-02-25 00:47:57.645945', NULL, '2025-03-05', 19, 'Automatically generated for 2025-03-05', NULL, 5, NULL, 17, 22),
(700, '2025-02-25 00:47:57.653884', '2025-02-25 00:47:57.653884', NULL, '2025-03-06', 17, 'Automatically generated for 2025-03-06', NULL, 5, NULL, 17, 22),
(701, '2025-02-25 00:47:57.662977', '2025-02-25 00:47:57.662977', NULL, '2025-03-07', 16, 'Automatically generated for 2025-03-07', NULL, 5, NULL, 17, 22),
(702, '2025-02-25 00:47:57.670977', '2025-02-25 00:47:57.670977', NULL, '2025-03-08', 17, 'Automatically generated for 2025-03-08', NULL, 5, NULL, 17, 22),
(703, '2025-02-25 00:47:57.679241', '2025-02-25 00:47:57.679241', NULL, '2025-03-09', 19, 'Automatically generated for 2025-03-09', NULL, 5, NULL, 17, 22),
(704, '2025-02-25 00:47:57.687280', '2025-02-25 00:47:57.688242', NULL, '2025-03-10', 19, 'Automatically generated for 2025-03-10', NULL, 5, NULL, 17, 22),
(705, '2025-02-25 00:47:57.696164', '2025-02-25 00:47:57.696164', NULL, '2025-03-11', 18, 'Automatically generated for 2025-03-11', NULL, 5, NULL, 17, 22),
(706, '2025-02-25 00:47:57.704071', '2025-02-25 00:47:57.704071', NULL, '2025-03-12', 18, 'Automatically generated for 2025-03-12', NULL, 5, NULL, 17, 22),
(707, '2025-02-25 00:47:57.712120', '2025-02-25 00:47:57.712120', NULL, '2025-03-13', 16, 'Automatically generated for 2025-03-13', NULL, 5, NULL, 17, 22),
(708, '2025-02-25 00:47:57.721120', '2025-02-25 00:47:57.721120', NULL, '2025-03-14', 19, 'Automatically generated for 2025-03-14', NULL, 5, NULL, 17, 22),
(709, '2025-02-25 00:47:57.728652', '2025-02-25 00:47:57.728652', NULL, '2025-03-15', 16, 'Automatically generated for 2025-03-15', NULL, 5, NULL, 17, 22),
(710, '2025-02-25 00:47:57.737334', '2025-02-25 00:47:57.737334', NULL, '2025-03-16', 16, 'Automatically generated for 2025-03-16', NULL, 5, NULL, 17, 22),
(711, '2025-02-25 00:47:57.745506', '2025-02-25 00:47:57.745506', NULL, '2025-03-17', 18, 'Automatically generated for 2025-03-17', NULL, 5, NULL, 17, 22),
(712, '2025-02-25 00:47:57.755049', '2025-02-25 00:47:57.755049', NULL, '2025-03-18', 17, 'Automatically generated for 2025-03-18', NULL, 5, NULL, 17, 22),
(713, '2025-02-25 00:47:57.764899', '2025-02-25 00:47:57.764899', NULL, '2025-03-19', 18, 'Automatically generated for 2025-03-19', NULL, 5, NULL, 17, 22),
(714, '2025-02-25 00:47:57.773527', '2025-02-25 00:47:57.773527', NULL, '2025-03-20', 16, 'Automatically generated for 2025-03-20', NULL, 5, NULL, 17, 22),
(715, '2025-02-25 00:47:57.781576', '2025-02-25 00:47:57.781576', NULL, '2025-03-21', 17, 'Automatically generated for 2025-03-21', NULL, 5, NULL, 17, 22),
(716, '2025-02-25 00:47:57.790576', '2025-02-25 00:47:57.790576', NULL, '2025-03-22', 18, 'Automatically generated for 2025-03-22', NULL, 5, NULL, 17, 22),
(717, '2025-02-25 00:47:57.799575', '2025-02-25 00:47:57.799575', NULL, '2025-03-23', 16, 'Automatically generated for 2025-03-23', NULL, 5, NULL, 17, 22),
(718, '2025-02-25 00:47:57.808090', '2025-02-25 00:47:57.808090', NULL, '2025-03-24', 18, 'Automatically generated for 2025-03-24', NULL, 5, NULL, 17, 22),
(719, '2025-02-25 00:47:57.816606', '2025-02-25 00:47:57.816606', NULL, '2025-03-25', 16, 'Automatically generated for 2025-03-25', NULL, 5, NULL, 17, 22),
(720, '2025-02-25 00:47:57.825613', '2025-02-25 00:47:57.825613', NULL, '2025-03-26', 16, 'Automatically generated for 2025-03-26', NULL, 5, NULL, 17, 22),
(721, '2025-02-25 00:47:57.836606', '2025-02-25 00:47:57.836606', NULL, '2025-02-25', 14, 'Automatically generated for 2025-02-25', NULL, 5, NULL, 17, 21),
(722, '2025-02-25 00:47:57.844607', '2025-02-25 00:47:57.844607', NULL, '2025-02-26', 14, 'Automatically generated for 2025-02-26', NULL, 5, NULL, 17, 21),
(723, '2025-02-25 00:47:57.853607', '2025-02-25 00:47:57.853607', NULL, '2025-02-27', 16, 'Automatically generated for 2025-02-27', NULL, 5, NULL, 17, 21),
(724, '2025-02-25 00:47:57.862608', '2025-02-25 00:47:57.862608', NULL, '2025-02-28', 15, 'Automatically generated for 2025-02-28', NULL, 5, NULL, 17, 21),
(725, '2025-02-25 00:47:57.872107', '2025-02-25 00:47:57.872107', NULL, '2025-03-01', 17, 'Automatically generated for 2025-03-01', NULL, 5, NULL, 17, 21),
(726, '2025-02-25 00:47:57.880475', '2025-02-25 00:47:57.880475', NULL, '2025-03-02', 14, 'Automatically generated for 2025-03-02', NULL, 5, NULL, 17, 21),
(727, '2025-02-25 00:47:57.888472', '2025-02-25 00:47:57.888472', NULL, '2025-03-03', 16, 'Automatically generated for 2025-03-03', NULL, 5, NULL, 17, 21),
(728, '2025-02-25 00:47:57.896863', '2025-02-25 00:47:57.896863', NULL, '2025-03-04', 16, 'Automatically generated for 2025-03-04', NULL, 5, NULL, 17, 21),
(729, '2025-02-25 00:47:57.905879', '2025-02-25 00:47:57.905879', NULL, '2025-03-05', 16, 'Automatically generated for 2025-03-05', NULL, 5, NULL, 17, 21),
(730, '2025-02-25 00:47:57.912955', '2025-02-25 00:47:57.912955', NULL, '2025-03-06', 16, 'Automatically generated for 2025-03-06', NULL, 5, NULL, 17, 21),
(731, '2025-02-25 00:47:57.920946', '2025-02-25 00:47:57.920946', NULL, '2025-03-07', 14, 'Automatically generated for 2025-03-07', NULL, 5, NULL, 17, 21),
(732, '2025-02-25 00:47:57.929284', '2025-02-25 00:47:57.929284', NULL, '2025-03-08', 15, 'Automatically generated for 2025-03-08', NULL, 5, NULL, 17, 21),
(733, '2025-02-25 00:47:57.937284', '2025-02-25 00:47:57.937284', NULL, '2025-03-09', 16, 'Automatically generated for 2025-03-09', NULL, 5, NULL, 17, 21),
(734, '2025-02-25 00:47:57.945767', '2025-02-25 00:47:57.945767', NULL, '2025-03-10', 15, 'Automatically generated for 2025-03-10', NULL, 5, NULL, 17, 21),
(735, '2025-02-25 00:47:57.953633', '2025-02-25 00:47:57.953633', NULL, '2025-03-11', 17, 'Automatically generated for 2025-03-11', NULL, 5, NULL, 17, 21),
(736, '2025-02-25 00:47:57.961635', '2025-02-25 00:47:57.962606', NULL, '2025-03-12', 17, 'Automatically generated for 2025-03-12', NULL, 5, NULL, 17, 21),
(737, '2025-02-25 00:47:57.970607', '2025-02-25 00:47:57.970607', NULL, '2025-03-13', 17, 'Automatically generated for 2025-03-13', NULL, 5, NULL, 17, 21),
(738, '2025-02-25 00:47:57.978252', '2025-02-25 00:47:57.978252', NULL, '2025-03-14', 15, 'Automatically generated for 2025-03-14', NULL, 5, NULL, 17, 21),
(739, '2025-02-25 00:47:57.990033', '2025-02-25 00:47:57.990033', NULL, '2025-03-15', 15, 'Automatically generated for 2025-03-15', NULL, 5, NULL, 17, 21),
(740, '2025-02-25 00:47:57.998045', '2025-02-25 00:47:57.998045', NULL, '2025-03-16', 16, 'Automatically generated for 2025-03-16', NULL, 5, NULL, 17, 21),
(741, '2025-02-25 00:47:58.006047', '2025-02-25 00:47:58.006047', NULL, '2025-03-17', 14, 'Automatically generated for 2025-03-17', NULL, 5, NULL, 17, 21),
(742, '2025-02-25 00:47:58.014721', '2025-02-25 00:47:58.014721', NULL, '2025-03-18', 16, 'Automatically generated for 2025-03-18', NULL, 5, NULL, 17, 21),
(743, '2025-02-25 00:47:58.022451', '2025-02-25 00:47:58.022451', NULL, '2025-03-19', 17, 'Automatically generated for 2025-03-19', NULL, 5, NULL, 17, 21),
(744, '2025-02-25 00:47:58.031464', '2025-02-25 00:47:58.031464', NULL, '2025-03-20', 17, 'Automatically generated for 2025-03-20', NULL, 5, NULL, 17, 21),
(745, '2025-02-25 00:47:58.039464', '2025-02-25 00:47:58.039464', NULL, '2025-03-21', 14, 'Automatically generated for 2025-03-21', NULL, 5, NULL, 17, 21),
(746, '2025-02-25 00:47:58.047504', '2025-02-25 00:47:58.047504', NULL, '2025-03-22', 14, 'Automatically generated for 2025-03-22', NULL, 5, NULL, 17, 21),
(747, '2025-02-25 00:47:58.056057', '2025-02-25 00:47:58.056057', NULL, '2025-03-23', 17, 'Automatically generated for 2025-03-23', NULL, 5, NULL, 17, 21),
(748, '2025-02-25 00:47:58.064208', '2025-02-25 00:47:58.064208', NULL, '2025-03-24', 15, 'Automatically generated for 2025-03-24', NULL, 5, NULL, 17, 21),
(749, '2025-02-25 00:47:58.072298', '2025-02-25 00:47:58.072298', NULL, '2025-03-25', 14, 'Automatically generated for 2025-03-25', NULL, 5, NULL, 17, 21),
(750, '2025-02-25 00:47:58.081315', '2025-02-25 00:47:58.081315', NULL, '2025-03-26', 14, 'Automatically generated for 2025-03-26', NULL, 5, NULL, 17, 21);

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
(1, '2025-02-25 00:47:49.819182', '2025-02-25 00:47:49.820182', NULL, 'Default', 'Default room category', NULL, 1, NULL),
(2, '2025-02-25 00:47:50.081131', '2025-02-25 00:47:50.081131', NULL, 'Default', 'Default room category', NULL, 2, NULL),
(3, '2025-02-25 00:47:50.311881', '2025-02-25 00:47:50.311881', NULL, 'Default', 'Default room category', NULL, 3, NULL),
(4, '2025-02-25 00:47:50.571802', '2025-02-25 00:47:50.572786', NULL, 'Default', 'Default room category', NULL, 4, NULL),
(5, '2025-02-25 00:47:50.790002', '2025-02-25 00:47:50.790002', NULL, 'Default', 'Default room category', NULL, 5, NULL);

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
  `updated_by_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL,
  `room_type_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rooms_review`
--

INSERT INTO `rooms_review` (`id`, `updated_at`, `deleted_at`, `rating`, `content`, `created_at`, `created_by_id`, `hotel_id`, `updated_by_id`, `user_id`, `room_type_id`) VALUES
(1, '2025-02-25 00:47:58.108767', NULL, 5, 'تجربة لا تنسى', '2025-02-25 00:47:58.108767', NULL, 1, NULL, 4, 3),
(2, '2025-02-25 00:47:58.116762', NULL, 4, 'موقع ممتاز وطاقم ودود', '2025-02-25 00:47:58.116762', NULL, 1, NULL, 4, 3),
(3, '2025-02-25 00:47:58.121763', NULL, 4, 'تجربة لا تنسى', '2025-02-25 00:47:58.121763', NULL, 1, NULL, 4, 3),
(4, '2025-02-25 00:47:58.126245', NULL, 4, 'نظيفة ومريحة جداً', '2025-02-25 00:47:58.126245', NULL, 1, NULL, 4, 5),
(5, '2025-02-25 00:47:58.130396', NULL, 5, 'تجربة مميزة', '2025-02-25 00:47:58.130396', NULL, 1, NULL, 4, 5),
(6, '2025-02-25 00:47:58.135246', NULL, 4, 'غرفة رائعة وخدمة ممتازة', '2025-02-25 00:47:58.135246', NULL, 1, NULL, 4, 5),
(7, '2025-02-25 00:47:58.139304', NULL, 5, 'تجربة لا تنسى', '2025-02-25 00:47:58.139304', NULL, 1, NULL, 4, 5),
(8, '2025-02-25 00:47:58.143335', NULL, 5, 'موقع ممتاز وطاقم ودود', '2025-02-25 00:47:58.143335', NULL, 1, NULL, 4, 4),
(9, '2025-02-25 00:47:58.147766', NULL, 4, 'تجربة مميزة', '2025-02-25 00:47:58.147766', NULL, 1, NULL, 4, 4),
(10, '2025-02-25 00:47:58.151766', NULL, 4, 'تجربة لا تنسى', '2025-02-25 00:47:58.151766', NULL, 1, NULL, 4, 4),
(11, '2025-02-25 00:47:58.156794', NULL, 5, 'موقع ممتاز وطاقم ودود', '2025-02-25 00:47:58.156794', NULL, 1, NULL, 4, 4),
(12, '2025-02-25 00:47:58.160832', NULL, 5, 'موقع ممتاز وطاقم ودود', '2025-02-25 00:47:58.160832', NULL, 1, NULL, 4, 4),
(13, '2025-02-25 00:47:58.166021', NULL, 5, 'نظيفة ومريحة جداً', '2025-02-25 00:47:58.166021', NULL, 1, NULL, 4, 2),
(14, '2025-02-25 00:47:58.170837', NULL, 5, 'الغرفة كانت أكبر من المتوقع', '2025-02-25 00:47:58.170837', NULL, 1, NULL, 4, 2),
(15, '2025-02-25 00:47:58.174874', NULL, 5, 'سعر معقول مقابل الخدمة', '2025-02-25 00:47:58.174874', NULL, 1, NULL, 4, 2),
(16, '2025-02-25 00:47:58.178864', NULL, 4, 'نظيفة ومريحة جداً', '2025-02-25 00:47:58.178864', NULL, 1, NULL, 4, 1),
(17, '2025-02-25 00:47:58.184412', NULL, 4, 'غرفة رائعة وخدمة ممتازة', '2025-02-25 00:47:58.184412', NULL, 1, NULL, 4, 1),
(18, '2025-02-25 00:47:58.189418', NULL, 5, 'سعر معقول مقابل الخدمة', '2025-02-25 00:47:58.189418', NULL, 1, NULL, 4, 1),
(19, '2025-02-25 00:47:58.194050', NULL, 4, 'غرفة رائعة وخدمة ممتازة', '2025-02-25 00:47:58.194050', NULL, 1, NULL, 4, 1),
(20, '2025-02-25 00:47:58.214261', NULL, 4, 'موقع ممتاز وطاقم ودود', '2025-02-25 00:47:58.214261', NULL, 2, NULL, 4, 8),
(21, '2025-02-25 00:47:58.219772', NULL, 4, 'تجربة مميزة', '2025-02-25 00:47:58.219772', NULL, 2, NULL, 4, 8),
(22, '2025-02-25 00:47:58.223834', NULL, 5, 'تجربة جميلة، سأعود مرة أخرى', '2025-02-25 00:47:58.223834', NULL, 2, NULL, 4, 8),
(23, '2025-02-25 00:47:58.229262', NULL, 4, 'موقع ممتاز وطاقم ودود', '2025-02-25 00:47:58.229262', NULL, 2, NULL, 4, 10),
(24, '2025-02-25 00:47:58.233281', NULL, 4, 'نظيفة ومريحة جداً', '2025-02-25 00:47:58.233281', NULL, 2, NULL, 4, 10),
(25, '2025-02-25 00:47:58.238296', NULL, 5, 'غرفة رائعة وخدمة ممتازة', '2025-02-25 00:47:58.238296', NULL, 2, NULL, 4, 10),
(26, '2025-02-25 00:47:58.242281', NULL, 4, 'تجربة مميزة', '2025-02-25 00:47:58.242281', NULL, 2, NULL, 4, 10),
(27, '2025-02-25 00:47:58.246858', NULL, 4, 'موقع ممتاز وطاقم ودود', '2025-02-25 00:47:58.246858', NULL, 2, NULL, 4, 9),
(28, '2025-02-25 00:47:58.251858', NULL, 4, 'تجربة لا تنسى', '2025-02-25 00:47:58.251858', NULL, 2, NULL, 4, 9),
(29, '2025-02-25 00:47:58.255918', NULL, 5, 'تجربة جميلة، سأعود مرة أخرى', '2025-02-25 00:47:58.255918', NULL, 2, NULL, 4, 9),
(30, '2025-02-25 00:47:58.260918', NULL, 5, 'تجربة جميلة، سأعود مرة أخرى', '2025-02-25 00:47:58.260918', NULL, 2, NULL, 4, 9),
(31, '2025-02-25 00:47:58.266175', NULL, 4, 'تجربة مميزة', '2025-02-25 00:47:58.266175', NULL, 2, NULL, 4, 7),
(32, '2025-02-25 00:47:58.270283', NULL, 4, 'غرفة رائعة وخدمة ممتازة', '2025-02-25 00:47:58.270283', NULL, 2, NULL, 4, 7),
(33, '2025-02-25 00:47:58.274132', NULL, 4, 'تجربة لا تنسى', '2025-02-25 00:47:58.274132', NULL, 2, NULL, 4, 7),
(34, '2025-02-25 00:47:58.278696', NULL, 5, 'الغرفة كانت أكبر من المتوقع', '2025-02-25 00:47:58.278696', NULL, 2, NULL, 4, 7),
(35, '2025-02-25 00:47:58.283691', NULL, 5, 'تجربة جميلة، سأعود مرة أخرى', '2025-02-25 00:47:58.283691', NULL, 2, NULL, 4, 7),
(36, '2025-02-25 00:47:58.288691', NULL, 5, 'تجربة مميزة', '2025-02-25 00:47:58.288691', NULL, 2, NULL, 4, 6),
(37, '2025-02-25 00:47:58.293207', NULL, 5, 'الغرفة كانت أكبر من المتوقع', '2025-02-25 00:47:58.293207', NULL, 2, NULL, 4, 6),
(38, '2025-02-25 00:47:58.299724', NULL, 4, 'موقع ممتاز وطاقم ودود', '2025-02-25 00:47:58.299724', NULL, 2, NULL, 4, 6),
(39, '2025-02-25 00:47:58.304724', NULL, 5, 'تجربة مميزة', '2025-02-25 00:47:58.304724', NULL, 2, NULL, 4, 6),
(40, '2025-02-25 00:47:58.309723', NULL, 4, 'موقع ممتاز وطاقم ودود', '2025-02-25 00:47:58.309723', NULL, 2, NULL, 4, 6),
(41, '2025-02-25 00:47:58.335726', NULL, 5, 'الغرفة كانت أكبر من المتوقع', '2025-02-25 00:47:58.336727', NULL, 3, NULL, 4, 13),
(42, '2025-02-25 00:47:58.341724', NULL, 5, 'غرفة رائعة وخدمة ممتازة', '2025-02-25 00:47:58.341724', NULL, 3, NULL, 4, 13),
(43, '2025-02-25 00:47:58.346336', NULL, 4, 'نظيفة ومريحة جداً', '2025-02-25 00:47:58.346336', NULL, 3, NULL, 4, 13),
(44, '2025-02-25 00:47:58.350929', NULL, 5, 'الغرفة كانت أكبر من المتوقع', '2025-02-25 00:47:58.350929', NULL, 3, NULL, 4, 13),
(45, '2025-02-25 00:47:58.355931', NULL, 4, 'سعر معقول مقابل الخدمة', '2025-02-25 00:47:58.355931', NULL, 3, NULL, 4, 13),
(46, '2025-02-25 00:47:58.360876', NULL, 4, 'تجربة جميلة، سأعود مرة أخرى', '2025-02-25 00:47:58.360876', NULL, 3, NULL, 4, 15),
(47, '2025-02-25 00:47:58.365566', NULL, 4, 'غرفة رائعة وخدمة ممتازة', '2025-02-25 00:47:58.365566', NULL, 3, NULL, 4, 15),
(48, '2025-02-25 00:47:58.369507', NULL, 4, 'سعر معقول مقابل الخدمة', '2025-02-25 00:47:58.369507', NULL, 3, NULL, 4, 15),
(49, '2025-02-25 00:47:58.374559', NULL, 5, 'تجربة مميزة', '2025-02-25 00:47:58.374559', NULL, 3, NULL, 4, 15),
(50, '2025-02-25 00:47:58.379624', NULL, 4, 'تجربة جميلة، سأعود مرة أخرى', '2025-02-25 00:47:58.379624', NULL, 3, NULL, 4, 15),
(51, '2025-02-25 00:47:58.383606', NULL, 5, 'سعر معقول مقابل الخدمة', '2025-02-25 00:47:58.383606', NULL, 3, NULL, 4, 14),
(52, '2025-02-25 00:47:58.388606', NULL, 5, 'تجربة لا تنسى', '2025-02-25 00:47:58.388606', NULL, 3, NULL, 4, 14),
(53, '2025-02-25 00:47:58.393612', NULL, 5, 'غرفة رائعة وخدمة ممتازة', '2025-02-25 00:47:58.393612', NULL, 3, NULL, 4, 14),
(54, '2025-02-25 00:47:58.398033', NULL, 5, 'تجربة جميلة، سأعود مرة أخرى', '2025-02-25 00:47:58.398033', NULL, 3, NULL, 4, 14),
(55, '2025-02-25 00:47:58.402971', NULL, 4, 'غرفة رائعة وخدمة ممتازة', '2025-02-25 00:47:58.402971', NULL, 3, NULL, 4, 12),
(56, '2025-02-25 00:47:58.407227', NULL, 4, 'تجربة مميزة', '2025-02-25 00:47:58.407227', NULL, 3, NULL, 4, 12),
(57, '2025-02-25 00:47:58.412014', NULL, 5, 'تجربة مميزة', '2025-02-25 00:47:58.412014', NULL, 3, NULL, 4, 12),
(58, '2025-02-25 00:47:58.416638', NULL, 4, 'تجربة لا تنسى', '2025-02-25 00:47:58.416638', NULL, 3, NULL, 4, 12),
(59, '2025-02-25 00:47:58.420140', NULL, 4, 'غرفة رائعة وخدمة ممتازة', '2025-02-25 00:47:58.420140', NULL, 3, NULL, 4, 12),
(60, '2025-02-25 00:47:58.424631', NULL, 5, 'نظيفة ومريحة جداً', '2025-02-25 00:47:58.424631', NULL, 3, NULL, 4, 11),
(61, '2025-02-25 00:47:58.428657', NULL, 4, 'موقع ممتاز وطاقم ودود', '2025-02-25 00:47:58.428657', NULL, 3, NULL, 4, 11),
(62, '2025-02-25 00:47:58.434066', NULL, 4, 'نظيفة ومريحة جداً', '2025-02-25 00:47:58.434066', NULL, 3, NULL, 4, 11),
(63, '2025-02-25 00:47:58.439007', NULL, 4, 'غرفة رائعة وخدمة ممتازة', '2025-02-25 00:47:58.439007', NULL, 3, NULL, 4, 11),
(64, '2025-02-25 00:47:58.443066', NULL, 5, 'سعر معقول مقابل الخدمة', '2025-02-25 00:47:58.443066', NULL, 3, NULL, 4, 11),
(65, '2025-02-25 00:47:58.462052', NULL, 4, 'غرفة رائعة وخدمة ممتازة', '2025-02-25 00:47:58.462052', NULL, 4, NULL, 4, 18),
(66, '2025-02-25 00:47:58.467564', NULL, 4, 'الغرفة كانت أكبر من المتوقع', '2025-02-25 00:47:58.467564', NULL, 4, NULL, 4, 18),
(67, '2025-02-25 00:47:58.472811', NULL, 4, 'الغرفة كانت أكبر من المتوقع', '2025-02-25 00:47:58.472811', NULL, 4, NULL, 4, 18),
(68, '2025-02-25 00:47:58.477620', NULL, 4, 'تجربة لا تنسى', '2025-02-25 00:47:58.477620', NULL, 4, NULL, 4, 18),
(69, '2025-02-25 00:47:58.481619', NULL, 5, 'نظيفة ومريحة جداً', '2025-02-25 00:47:58.481619', NULL, 4, NULL, 4, 20),
(70, '2025-02-25 00:47:58.486618', NULL, 5, 'تجربة لا تنسى', '2025-02-25 00:47:58.486618', NULL, 4, NULL, 4, 20),
(71, '2025-02-25 00:47:58.491620', NULL, 5, 'سعر معقول مقابل الخدمة', '2025-02-25 00:47:58.491620', NULL, 4, NULL, 4, 20),
(72, '2025-02-25 00:47:58.496973', NULL, 5, 'نظيفة ومريحة جداً', '2025-02-25 00:47:58.496973', NULL, 4, NULL, 4, 19),
(73, '2025-02-25 00:47:58.502936', NULL, 5, 'نظيفة ومريحة جداً', '2025-02-25 00:47:58.502936', NULL, 4, NULL, 4, 19),
(74, '2025-02-25 00:47:58.507183', NULL, 5, 'تجربة جميلة، سأعود مرة أخرى', '2025-02-25 00:47:58.507183', NULL, 4, NULL, 4, 19),
(75, '2025-02-25 00:47:58.511615', NULL, 5, 'غرفة رائعة وخدمة ممتازة', '2025-02-25 00:47:58.511615', NULL, 4, NULL, 4, 17),
(76, '2025-02-25 00:47:58.516545', NULL, 4, 'سعر معقول مقابل الخدمة', '2025-02-25 00:47:58.516545', NULL, 4, NULL, 4, 17),
(77, '2025-02-25 00:47:58.521438', NULL, 5, 'موقع ممتاز وطاقم ودود', '2025-02-25 00:47:58.521438', NULL, 4, NULL, 4, 17),
(78, '2025-02-25 00:47:58.525747', NULL, 5, 'تجربة مميزة', '2025-02-25 00:47:58.525747', NULL, 4, NULL, 4, 17),
(79, '2025-02-25 00:47:58.530662', NULL, 4, 'تجربة جميلة، سأعود مرة أخرى', '2025-02-25 00:47:58.530662', NULL, 4, NULL, 4, 17),
(80, '2025-02-25 00:47:58.534722', NULL, 5, 'تجربة جميلة، سأعود مرة أخرى', '2025-02-25 00:47:58.534722', NULL, 4, NULL, 4, 16),
(81, '2025-02-25 00:47:58.539722', NULL, 4, 'سعر معقول مقابل الخدمة', '2025-02-25 00:47:58.539722', NULL, 4, NULL, 4, 16),
(82, '2025-02-25 00:47:58.544722', NULL, 4, 'موقع ممتاز وطاقم ودود', '2025-02-25 00:47:58.544722', NULL, 4, NULL, 4, 16),
(83, '2025-02-25 00:47:58.549712', NULL, 4, 'موقع ممتاز وطاقم ودود', '2025-02-25 00:47:58.549712', NULL, 4, NULL, 4, 16),
(84, '2025-02-25 00:47:58.568715', NULL, 4, 'موقع ممتاز وطاقم ودود', '2025-02-25 00:47:58.568715', NULL, 5, NULL, 4, 23),
(85, '2025-02-25 00:47:58.572743', NULL, 4, 'سعر معقول مقابل الخدمة', '2025-02-25 00:47:58.572743', NULL, 5, NULL, 4, 23),
(86, '2025-02-25 00:47:58.578280', NULL, 4, 'الغرفة كانت أكبر من المتوقع', '2025-02-25 00:47:58.578280', NULL, 5, NULL, 4, 23),
(87, '2025-02-25 00:47:58.582338', NULL, 5, 'تجربة لا تنسى', '2025-02-25 00:47:58.582338', NULL, 5, NULL, 4, 23),
(88, '2025-02-25 00:47:58.587320', NULL, 5, 'تجربة مميزة', '2025-02-25 00:47:58.587320', NULL, 5, NULL, 4, 23),
(89, '2025-02-25 00:47:58.591531', NULL, 5, 'تجربة جميلة، سأعود مرة أخرى', '2025-02-25 00:47:58.591531', NULL, 5, NULL, 4, 25),
(90, '2025-02-25 00:47:58.596496', NULL, 4, 'موقع ممتاز وطاقم ودود', '2025-02-25 00:47:58.596496', NULL, 5, NULL, 4, 25),
(91, '2025-02-25 00:47:58.601705', NULL, 4, 'تجربة جميلة، سأعود مرة أخرى', '2025-02-25 00:47:58.601705', NULL, 5, NULL, 4, 25),
(92, '2025-02-25 00:47:58.605744', NULL, 4, 'تجربة لا تنسى', '2025-02-25 00:47:58.605744', NULL, 5, NULL, 4, 24),
(93, '2025-02-25 00:47:58.609765', NULL, 5, 'تجربة جميلة، سأعود مرة أخرى', '2025-02-25 00:47:58.609765', NULL, 5, NULL, 4, 24),
(94, '2025-02-25 00:47:58.614544', NULL, 5, 'تجربة لا تنسى', '2025-02-25 00:47:58.614544', NULL, 5, NULL, 4, 24),
(95, '2025-02-25 00:47:58.619587', NULL, 5, 'تجربة مميزة', '2025-02-25 00:47:58.619587', NULL, 5, NULL, 4, 24),
(96, '2025-02-25 00:47:58.624352', NULL, 5, 'تجربة مميزة', '2025-02-25 00:47:58.624352', NULL, 5, NULL, 4, 22),
(97, '2025-02-25 00:47:58.629347', NULL, 4, 'نظيفة ومريحة جداً', '2025-02-25 00:47:58.629347', NULL, 5, NULL, 4, 22),
(98, '2025-02-25 00:47:58.633395', NULL, 4, 'سعر معقول مقابل الخدمة', '2025-02-25 00:47:58.633395', NULL, 5, NULL, 4, 22),
(99, '2025-02-25 00:47:58.645540', NULL, 4, 'تجربة لا تنسى', '2025-02-25 00:47:58.645608', NULL, 5, NULL, 4, 22),
(100, '2025-02-25 00:47:58.650161', NULL, 4, 'تجربة مميزة', '2025-02-25 00:47:58.650161', NULL, 5, NULL, 4, 21),
(101, '2025-02-25 00:47:58.653929', NULL, 5, 'تجربة لا تنسى', '2025-02-25 00:47:58.653929', NULL, 5, NULL, 4, 21),
(102, '2025-02-25 00:47:58.658940', NULL, 4, 'الغرفة كانت أكبر من المتوقع', '2025-02-25 00:47:58.658940', NULL, 5, NULL, 4, 21),
(103, '2025-02-25 00:47:58.662930', NULL, 5, 'نظيفة ومريحة جداً', '2025-02-25 00:47:58.663871', NULL, 5, NULL, 4, 21);

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
  `updated_by_id` bigint(20) DEFAULT NULL,
  `room_type_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rooms_roomimage`
--

INSERT INTO `rooms_roomimage` (`id`, `created_at`, `updated_at`, `deleted_at`, `image`, `is_main`, `caption`, `created_by_id`, `hotel_id`, `updated_by_id`, `room_type_id`) VALUES
(1, '2025-02-25 00:47:49.853703', '2025-02-25 00:47:49.853703', NULL, 'room_images/img29.jpg', 1, 'Single Room - Image 1', NULL, 1, NULL, 1),
(2, '2025-02-25 00:47:49.869004', '2025-02-25 00:47:49.869004', NULL, 'room_images/img30.jpg', 0, 'Single Room - Image 2', NULL, 1, NULL, 1),
(3, '2025-02-25 00:47:49.878004', '2025-02-25 00:47:49.878004', NULL, 'room_images/ShopApp2.jpg', 0, 'Single Room - Image 3', NULL, 1, NULL, 1),
(4, '2025-02-25 00:47:49.911765', '2025-02-25 00:47:49.911765', NULL, 'room_images/img29_dZlCbWn.jpg', 1, 'Double Room - Image 1', NULL, 1, NULL, 2),
(5, '2025-02-25 00:47:49.921784', '2025-02-25 00:47:49.921784', NULL, 'room_images/img29.jpg', 0, 'Double Room - Image 2', NULL, 1, NULL, 2),
(6, '2025-02-25 00:47:49.926761', '2025-02-25 00:47:49.926761', NULL, 'room_images/img32_oEKTWAi.jpg', 0, 'Double Room - Image 3', NULL, 1, NULL, 2),
(7, '2025-02-25 00:47:49.964440', '2025-02-25 00:47:49.964440', NULL, 'room_images/img32.jpg', 1, 'Suite - Image 1', NULL, 1, NULL, 3),
(8, '2025-02-25 00:47:49.972980', '2025-02-25 00:47:49.972980', NULL, 'room_images/img31_1_AN1dG4b.jpg', 0, 'Suite - Image 2', NULL, 1, NULL, 3),
(9, '2025-02-25 00:47:49.980044', '2025-02-25 00:47:49.980044', NULL, 'room_images/img32_oEKTWAi.jpg', 0, 'Suite - Image 3', NULL, 1, NULL, 3),
(10, '2025-02-25 00:47:50.008568', '2025-02-25 00:47:50.008568', NULL, 'room_images/img31.jpg', 1, 'Luxury Room - Image 1', NULL, 1, NULL, 4),
(11, '2025-02-25 00:47:50.014573', '2025-02-25 00:47:50.014573', NULL, 'room_images/img29.jpg', 0, 'Luxury Room - Image 2', NULL, 1, NULL, 4),
(12, '2025-02-25 00:47:50.022568', '2025-02-25 00:47:50.022568', NULL, 'room_images/img31_1_69lhEU4.jpg', 0, 'Luxury Room - Image 3', NULL, 1, NULL, 4),
(13, '2025-02-25 00:47:50.054488', '2025-02-25 00:47:50.054488', NULL, 'room_images/img32_oEKTWAi.jpg', 1, 'Family Room - Image 1', NULL, 1, NULL, 5),
(14, '2025-02-25 00:47:50.059484', '2025-02-25 00:47:50.059484', NULL, 'room_images/img31_1_69lhEU4.jpg', 0, 'Family Room - Image 2', NULL, 1, NULL, 5),
(15, '2025-02-25 00:47:50.069497', '2025-02-25 00:47:50.069497', NULL, 'room_images/img31.jpg', 0, 'Family Room - Image 3', NULL, 1, NULL, 5),
(16, '2025-02-25 00:47:50.110650', '2025-02-25 00:47:50.110650', NULL, 'room_images/img31.jpg', 1, 'Single Room - Image 1', NULL, 2, NULL, 6),
(17, '2025-02-25 00:47:50.119648', '2025-02-25 00:47:50.119648', NULL, 'room_images/img31_1_69lhEU4.jpg', 0, 'Single Room - Image 2', NULL, 2, NULL, 6),
(18, '2025-02-25 00:47:50.124640', '2025-02-25 00:47:50.124640', NULL, 'room_images/img32.jpg', 0, 'Single Room - Image 3', NULL, 2, NULL, 6),
(19, '2025-02-25 00:47:50.152728', '2025-02-25 00:47:50.152728', NULL, 'room_images/airline-img11.png', 1, 'Double Room - Image 1', NULL, 2, NULL, 7),
(20, '2025-02-25 00:47:50.158676', '2025-02-25 00:47:50.158676', NULL, 'room_images/img32_Ymxnjo1.jpg', 0, 'Double Room - Image 2', NULL, 2, NULL, 7),
(21, '2025-02-25 00:47:50.164680', '2025-02-25 00:47:50.164680', NULL, 'room_images/img31.jpg', 0, 'Double Room - Image 3', NULL, 2, NULL, 7),
(22, '2025-02-25 00:47:50.203347', '2025-02-25 00:47:50.203347', NULL, 'room_images/ShopApp2_9aVU7Uy.jpg', 1, 'Suite - Image 1', NULL, 2, NULL, 8),
(23, '2025-02-25 00:47:50.208961', '2025-02-25 00:47:50.208961', NULL, 'room_images/img31.jpg', 0, 'Suite - Image 2', NULL, 2, NULL, 8),
(24, '2025-02-25 00:47:50.214961', '2025-02-25 00:47:50.214961', NULL, 'room_images/img32_Rch0Dy1.jpg', 0, 'Suite - Image 3', NULL, 2, NULL, 8),
(25, '2025-02-25 00:47:50.241960', '2025-02-25 00:47:50.241960', NULL, 'room_images/airline-img11.png', 1, 'Luxury Room - Image 1', NULL, 2, NULL, 9),
(26, '2025-02-25 00:47:50.247484', '2025-02-25 00:47:50.247484', NULL, 'room_images/img31.jpg', 0, 'Luxury Room - Image 2', NULL, 2, NULL, 9),
(27, '2025-02-25 00:47:50.256009', '2025-02-25 00:47:50.256009', NULL, 'room_images/img32_oEKTWAi.jpg', 0, 'Luxury Room - Image 3', NULL, 2, NULL, 9),
(28, '2025-02-25 00:47:50.280560', '2025-02-25 00:47:50.280560', NULL, 'room_images/img29_dZlCbWn.jpg', 1, 'Family Room - Image 1', NULL, 2, NULL, 10),
(29, '2025-02-25 00:47:50.288560', '2025-02-25 00:47:50.288560', NULL, 'room_images/img31.jpg', 0, 'Family Room - Image 2', NULL, 2, NULL, 10),
(30, '2025-02-25 00:47:50.297382', '2025-02-25 00:47:50.297382', NULL, 'room_images/ShopApp2.jpg', 0, 'Family Room - Image 3', NULL, 2, NULL, 10),
(31, '2025-02-25 00:47:50.346272', '2025-02-25 00:47:50.346272', NULL, 'room_images/airline-img11.png', 1, 'Single Room - Image 1', NULL, 3, NULL, 11),
(32, '2025-02-25 00:47:50.353951', '2025-02-25 00:47:50.353951', NULL, 'room_images/img30.jpg', 0, 'Single Room - Image 2', NULL, 3, NULL, 11),
(33, '2025-02-25 00:47:50.359936', '2025-02-25 00:47:50.359936', NULL, 'room_images/img31_nR0xROo.jpg', 0, 'Single Room - Image 3', NULL, 3, NULL, 11),
(34, '2025-02-25 00:47:50.409148', '2025-02-25 00:47:50.409148', NULL, 'room_images/img31_1_AN1dG4b.jpg', 1, 'Double Room - Image 1', NULL, 3, NULL, 12),
(35, '2025-02-25 00:47:50.416154', '2025-02-25 00:47:50.416154', NULL, 'room_images/ShopApp2.jpg', 0, 'Double Room - Image 2', NULL, 3, NULL, 12),
(36, '2025-02-25 00:47:50.424151', '2025-02-25 00:47:50.424151', NULL, 'room_images/img32_oEKTWAi.jpg', 0, 'Double Room - Image 3', NULL, 3, NULL, 12),
(37, '2025-02-25 00:47:50.455137', '2025-02-25 00:47:50.455137', NULL, 'room_images/img31_1_AN1dG4b.jpg', 1, 'Suite - Image 1', NULL, 3, NULL, 13),
(38, '2025-02-25 00:47:50.460612', '2025-02-25 00:47:50.460612', NULL, 'room_images/img32_Ymxnjo1.jpg', 0, 'Suite - Image 2', NULL, 3, NULL, 13),
(39, '2025-02-25 00:47:50.469651', '2025-02-25 00:47:50.469651', NULL, 'room_images/img31_1_69lhEU4.jpg', 0, 'Suite - Image 3', NULL, 3, NULL, 13),
(40, '2025-02-25 00:47:50.497133', '2025-02-25 00:47:50.497133', NULL, 'room_images/img29_GunOUow.jpg', 1, 'Luxury Room - Image 1', NULL, 3, NULL, 14),
(41, '2025-02-25 00:47:50.507130', '2025-02-25 00:47:50.507130', NULL, 'room_images/img31_nR0xROo.jpg', 0, 'Luxury Room - Image 2', NULL, 3, NULL, 14),
(42, '2025-02-25 00:47:50.514145', '2025-02-25 00:47:50.514145', NULL, 'room_images/img31_nR0xROo.jpg', 0, 'Luxury Room - Image 3', NULL, 3, NULL, 14),
(43, '2025-02-25 00:47:50.543548', '2025-02-25 00:47:50.543548', NULL, 'room_images/img32_oEKTWAi.jpg', 1, 'Family Room - Image 1', NULL, 3, NULL, 15),
(44, '2025-02-25 00:47:50.553117', '2025-02-25 00:47:50.553117', NULL, 'room_images/img29.jpg', 0, 'Family Room - Image 2', NULL, 3, NULL, 15),
(45, '2025-02-25 00:47:50.558243', '2025-02-25 00:47:50.558243', NULL, 'room_images/blog-img3.jpg', 0, 'Family Room - Image 3', NULL, 3, NULL, 15),
(46, '2025-02-25 00:47:50.603854', '2025-02-25 00:47:50.603854', NULL, 'room_images/img30.jpg', 1, 'Single Room - Image 1', NULL, 4, NULL, 16),
(47, '2025-02-25 00:47:50.608854', '2025-02-25 00:47:50.608854', NULL, 'room_images/img32_8bTxV5E.jpg', 0, 'Single Room - Image 2', NULL, 4, NULL, 16),
(48, '2025-02-25 00:47:50.613897', '2025-02-25 00:47:50.613897', NULL, 'room_images/img29.jpg', 0, 'Single Room - Image 3', NULL, 4, NULL, 16),
(49, '2025-02-25 00:47:50.641392', '2025-02-25 00:47:50.641392', NULL, 'room_images/img31_nR0xROo.jpg', 1, 'Double Room - Image 1', NULL, 4, NULL, 17),
(50, '2025-02-25 00:47:50.647392', '2025-02-25 00:47:50.647392', NULL, 'room_images/img31.jpg', 0, 'Double Room - Image 2', NULL, 4, NULL, 17),
(51, '2025-02-25 00:47:50.654921', '2025-02-25 00:47:50.654921', NULL, 'room_images/img32_oEKTWAi.jpg', 0, 'Double Room - Image 3', NULL, 4, NULL, 17),
(52, '2025-02-25 00:47:50.680900', '2025-02-25 00:47:50.680900', NULL, 'room_images/app-store.png', 1, 'Suite - Image 1', NULL, 4, NULL, 18),
(53, '2025-02-25 00:47:50.688895', '2025-02-25 00:47:50.688895', NULL, 'room_images/img31_1.jpg', 0, 'Suite - Image 2', NULL, 4, NULL, 18),
(54, '2025-02-25 00:47:50.695155', '2025-02-25 00:47:50.695155', NULL, 'room_images/img29_dZlCbWn.jpg', 0, 'Suite - Image 3', NULL, 4, NULL, 18),
(55, '2025-02-25 00:47:50.722702', '2025-02-25 00:47:50.722702', NULL, 'room_images/img32.jpg', 1, 'Luxury Room - Image 1', NULL, 4, NULL, 19),
(56, '2025-02-25 00:47:50.727704', '2025-02-25 00:47:50.727704', NULL, 'room_images/img32_oEKTWAi.jpg', 0, 'Luxury Room - Image 2', NULL, 4, NULL, 19),
(57, '2025-02-25 00:47:50.736812', '2025-02-25 00:47:50.736812', NULL, 'room_images/img32_Ymxnjo1.jpg', 0, 'Luxury Room - Image 3', NULL, 4, NULL, 19),
(58, '2025-02-25 00:47:50.764484', '2025-02-25 00:47:50.764484', NULL, 'room_images/img32_Ymxnjo1.jpg', 1, 'Family Room - Image 1', NULL, 4, NULL, 20),
(59, '2025-02-25 00:47:50.773006', '2025-02-25 00:47:50.773006', NULL, 'room_images/img32_Rch0Dy1.jpg', 0, 'Family Room - Image 2', NULL, 4, NULL, 20),
(60, '2025-02-25 00:47:50.778002', '2025-02-25 00:47:50.778002', NULL, 'room_images/ShopApp2.jpg', 0, 'Family Room - Image 3', NULL, 4, NULL, 20),
(61, '2025-02-25 00:47:50.884103', '2025-02-25 00:47:50.885130', NULL, 'room_images/img29_dZlCbWn.jpg', 1, 'Single Room - Image 1', NULL, 5, NULL, 21),
(62, '2025-02-25 00:47:50.933109', '2025-02-25 00:47:50.933109', NULL, 'room_images/img31.jpg', 0, 'Single Room - Image 2', NULL, 5, NULL, 21),
(63, '2025-02-25 00:47:50.972100', '2025-02-25 00:47:50.972100', NULL, 'room_images/img29_GunOUow.jpg', 0, 'Single Room - Image 3', NULL, 5, NULL, 21),
(64, '2025-02-25 00:47:51.003748', '2025-02-25 00:47:51.003748', NULL, 'room_images/img31_1.jpg', 1, 'Double Room - Image 1', NULL, 5, NULL, 22),
(65, '2025-02-25 00:47:51.008740', '2025-02-25 00:47:51.008740', NULL, 'room_images/ShopApp2_9aVU7Uy.jpg', 0, 'Double Room - Image 2', NULL, 5, NULL, 22),
(66, '2025-02-25 00:47:51.014743', '2025-02-25 00:47:51.014743', NULL, 'room_images/ShopApp2_9aVU7Uy.jpg', 0, 'Double Room - Image 3', NULL, 5, NULL, 22),
(67, '2025-02-25 00:47:51.049069', '2025-02-25 00:47:51.049069', NULL, 'room_images/app-store.png', 1, 'Suite - Image 1', NULL, 5, NULL, 23),
(68, '2025-02-25 00:47:51.057614', '2025-02-25 00:47:51.057614', NULL, 'room_images/img31_1_AN1dG4b.jpg', 0, 'Suite - Image 2', NULL, 5, NULL, 23),
(69, '2025-02-25 00:47:51.064631', '2025-02-25 00:47:51.064631', NULL, 'room_images/blog-img3.jpg', 0, 'Suite - Image 3', NULL, 5, NULL, 23),
(70, '2025-02-25 00:47:51.092145', '2025-02-25 00:47:51.092145', NULL, 'room_images/img32_Ymxnjo1.jpg', 1, 'Luxury Room - Image 1', NULL, 5, NULL, 24),
(71, '2025-02-25 00:47:51.097871', '2025-02-25 00:47:51.097871', NULL, 'room_images/img32_Rch0Dy1.jpg', 0, 'Luxury Room - Image 2', NULL, 5, NULL, 24),
(72, '2025-02-25 00:47:51.105873', '2025-02-25 00:47:51.105873', NULL, 'room_images/img32_Rch0Dy1.jpg', 0, 'Luxury Room - Image 3', NULL, 5, NULL, 24),
(73, '2025-02-25 00:47:51.130903', '2025-02-25 00:47:51.130903', NULL, 'room_images/app-store.png', 1, 'Family Room - Image 1', NULL, 5, NULL, 25),
(74, '2025-02-25 00:47:51.137906', '2025-02-25 00:47:51.137906', NULL, 'room_images/img32_Rch0Dy1.jpg', 0, 'Family Room - Image 2', NULL, 5, NULL, 25),
(75, '2025-02-25 00:47:51.142530', '2025-02-25 00:47:51.142530', NULL, 'room_images/img32_8bTxV5E.jpg', 0, 'Family Room - Image 3', NULL, 5, NULL, 25);

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
  `updated_by_id` bigint(20) DEFAULT NULL,
  `room_type_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rooms_roomprice`
--

INSERT INTO `rooms_roomprice` (`id`, `created_at`, `updated_at`, `deleted_at`, `date_from`, `date_to`, `price`, `is_special_offer`, `created_by_id`, `hotel_id`, `updated_by_id`, `room_type_id`) VALUES
(1, '2025-02-25 00:47:49.845199', '2025-02-25 00:47:49.845199', NULL, '2025-02-25', '2026-02-25', 100.00, 0, NULL, 1, NULL, 1),
(2, '2025-02-25 00:47:49.905763', '2025-02-25 00:47:49.905763', NULL, '2025-02-25', '2026-02-25', 150.00, 0, NULL, 1, NULL, 2),
(3, '2025-02-25 00:47:49.948836', '2025-02-25 19:53:27.875772', NULL, '2025-02-25', '2026-02-25', 40.00, 0, NULL, 1, NULL, 3),
(4, '2025-02-25 00:47:50.004029', '2025-02-25 00:47:50.004029', NULL, '2025-02-25', '2026-02-25', 250.00, 0, NULL, 1, NULL, 4),
(5, '2025-02-25 00:47:50.043098', '2025-02-25 00:47:50.043098', NULL, '2025-02-25', '2026-02-25', 400.00, 0, NULL, 1, NULL, 5),
(6, '2025-02-25 00:47:50.104642', '2025-02-25 00:47:50.104642', NULL, '2025-02-25', '2026-02-25', 100.00, 0, NULL, 2, NULL, 6),
(7, '2025-02-25 00:47:50.143150', '2025-02-25 00:47:50.143150', NULL, '2025-02-25', '2026-02-25', 150.00, 0, NULL, 2, NULL, 7),
(8, '2025-02-25 00:47:50.192540', '2025-02-25 00:47:50.192540', NULL, '2025-02-25', '2026-02-25', 300.00, 0, NULL, 2, NULL, 8),
(9, '2025-02-25 00:47:50.235997', '2025-02-25 00:47:50.235997', NULL, '2025-02-25', '2026-02-25', 250.00, 0, NULL, 2, NULL, 9),
(10, '2025-02-25 00:47:50.273560', '2025-02-25 00:47:50.273560', NULL, '2025-02-25', '2026-02-25', 400.00, 0, NULL, 2, NULL, 10),
(11, '2025-02-25 00:47:50.336271', '2025-02-25 00:47:50.336271', NULL, '2025-02-25', '2026-02-25', 100.00, 0, NULL, 3, NULL, 11),
(12, '2025-02-25 00:47:50.400260', '2025-02-25 00:47:50.400260', NULL, '2025-02-25', '2026-02-25', 150.00, 0, NULL, 3, NULL, 12),
(13, '2025-02-25 00:47:50.445534', '2025-02-25 00:47:50.445534', NULL, '2025-02-25', '2026-02-25', 300.00, 0, NULL, 3, NULL, 13),
(14, '2025-02-25 00:47:50.490139', '2025-02-25 00:47:50.490139', NULL, '2025-02-25', '2026-02-25', 250.00, 0, NULL, 3, NULL, 14),
(15, '2025-02-25 00:47:50.537282', '2025-02-25 00:47:50.537282', NULL, '2025-02-25', '2026-02-25', 400.00, 0, NULL, 3, NULL, 15),
(16, '2025-02-25 00:47:50.595310', '2025-02-25 00:47:50.595310', NULL, '2025-02-25', '2026-02-25', 100.00, 0, NULL, 4, NULL, 16),
(17, '2025-02-25 00:47:50.633412', '2025-02-25 00:47:50.633412', NULL, '2025-02-25', '2026-02-25', 150.00, 0, NULL, 4, NULL, 17),
(18, '2025-02-25 00:47:50.672895', '2025-02-25 00:47:50.672895', NULL, '2025-02-25', '2026-02-25', 300.00, 0, NULL, 4, NULL, 18),
(19, '2025-02-25 00:47:50.714705', '2025-02-25 00:47:50.714705', NULL, '2025-02-25', '2026-02-25', 250.00, 0, NULL, 4, NULL, 19),
(20, '2025-02-25 00:47:50.756903', '2025-02-25 00:47:50.756903', NULL, '2025-02-25', '2026-02-25', 400.00, 0, NULL, 4, NULL, 20),
(21, '2025-02-25 00:47:50.812106', '2025-02-25 00:47:50.812106', NULL, '2025-02-25', '2026-02-25', 100.00, 0, NULL, 5, NULL, 21),
(22, '2025-02-25 00:47:50.994221', '2025-02-25 00:47:50.994221', NULL, '2025-02-25', '2026-02-25', 150.00, 0, NULL, 5, NULL, 22),
(23, '2025-02-25 00:47:51.040457', '2025-02-25 00:47:51.040457', NULL, '2025-02-25', '2026-02-25', 300.00, 0, NULL, 5, NULL, 23),
(24, '2025-02-25 00:47:51.086623', '2025-02-25 00:47:51.086623', NULL, '2025-02-25', '2026-02-25', 250.00, 0, NULL, 5, NULL, 24),
(25, '2025-02-25 00:47:51.124904', '2025-02-25 00:47:51.124904', NULL, '2025-02-25', '2026-02-25', 400.00, 0, NULL, 5, NULL, 25);

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
(1, '2025-02-25 00:47:51.157578', '2025-02-25 00:47:51.157578', NULL, 'available', 'متاح', 'الغرفة متاحة للحجز', 1, NULL, 1, NULL),
(2, '2025-02-25 00:47:51.169580', '2025-02-25 00:47:51.169580', NULL, 'occupied', 'مشغولة', 'الغرفة مشغولة حالياً', 0, NULL, 1, NULL),
(3, '2025-02-25 00:47:51.180595', '2025-02-25 00:47:51.180595', NULL, 'maintenance', 'صيانة', 'الغرفة تحت الصيانة', 0, NULL, 1, NULL),
(4, '2025-02-25 00:47:51.192586', '2025-02-25 00:47:51.192586', NULL, 'cleaning', 'تنظيف', 'الغرفة قيد التنظيف', 0, NULL, 1, NULL),
(5, '2025-02-25 00:47:51.203725', '2025-02-25 00:47:51.203725', NULL, 'available', 'متاح', 'الغرفة متاحة للحجز', 1, NULL, 2, NULL),
(6, '2025-02-25 00:47:51.213245', '2025-02-25 00:47:51.213245', NULL, 'occupied', 'مشغولة', 'الغرفة مشغولة حالياً', 0, NULL, 2, NULL),
(7, '2025-02-25 00:47:51.221264', '2025-02-25 00:47:51.221264', NULL, 'maintenance', 'صيانة', 'الغرفة تحت الصيانة', 0, NULL, 2, NULL),
(8, '2025-02-25 00:47:51.230264', '2025-02-25 00:47:51.230264', NULL, 'cleaning', 'تنظيف', 'الغرفة قيد التنظيف', 0, NULL, 2, NULL),
(9, '2025-02-25 00:47:51.238790', '2025-02-25 00:47:51.238790', NULL, 'available', 'متاح', 'الغرفة متاحة للحجز', 1, NULL, 3, NULL),
(10, '2025-02-25 00:47:51.246313', '2025-02-25 00:47:51.246313', NULL, 'occupied', 'مشغولة', 'الغرفة مشغولة حالياً', 0, NULL, 3, NULL),
(11, '2025-02-25 00:47:51.253900', '2025-02-25 00:47:51.254900', NULL, 'maintenance', 'صيانة', 'الغرفة تحت الصيانة', 0, NULL, 3, NULL),
(12, '2025-02-25 00:47:51.261902', '2025-02-25 00:47:51.261902', NULL, 'cleaning', 'تنظيف', 'الغرفة قيد التنظيف', 0, NULL, 3, NULL),
(13, '2025-02-25 00:47:51.270899', '2025-02-25 00:47:51.270899', NULL, 'available', 'متاح', 'الغرفة متاحة للحجز', 1, NULL, 4, NULL),
(14, '2025-02-25 00:47:51.278900', '2025-02-25 00:47:51.278900', NULL, 'occupied', 'مشغولة', 'الغرفة مشغولة حالياً', 0, NULL, 4, NULL),
(15, '2025-02-25 00:47:51.287898', '2025-02-25 00:47:51.287898', NULL, 'maintenance', 'صيانة', 'الغرفة تحت الصيانة', 0, NULL, 4, NULL),
(16, '2025-02-25 00:47:51.295416', '2025-02-25 00:47:51.295416', NULL, 'cleaning', 'تنظيف', 'الغرفة قيد التنظيف', 0, NULL, 4, NULL),
(17, '2025-02-25 00:47:51.303930', '2025-02-25 00:47:51.303930', NULL, 'available', 'متاح', 'الغرفة متاحة للحجز', 1, NULL, 5, NULL),
(18, '2025-02-25 00:47:51.313934', '2025-02-25 00:47:51.313934', NULL, 'occupied', 'مشغولة', 'الغرفة مشغولة حالياً', 0, NULL, 5, NULL),
(19, '2025-02-25 00:47:51.324205', '2025-02-25 00:47:51.324205', NULL, 'maintenance', 'صيانة', 'الغرفة تحت الصيانة', 0, NULL, 5, NULL),
(20, '2025-02-25 00:47:51.333719', '2025-02-25 00:47:51.333719', NULL, 'cleaning', 'تنظيف', 'الغرفة قيد التنظيف', 0, NULL, 5, NULL);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rooms_roomtype`
--

INSERT INTO `rooms_roomtype` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `description`, `default_capacity`, `max_capacity`, `beds_count`, `rooms_count`, `base_price`, `is_active`, `category_id`, `created_by_id`, `hotel_id`, `updated_by_id`) VALUES
(1, '2025-02-25 00:47:49.834181', '2025-02-25 00:47:49.834181', NULL, 'غرفة مفردة', 'A comfortable single room', 1, 2, 1, 17, 100.00, 1, 1, NULL, 1, NULL),
(2, '2025-02-25 00:47:49.893640', '2025-02-25 00:47:49.893640', NULL, 'غرفة مزدوجة', 'A comfortable double room', 2, 3, 1, 16, 150.00, 1, 1, NULL, 1, NULL),
(3, '2025-02-25 00:47:49.940761', '2025-02-25 00:47:49.940761', NULL, 'جناح', 'A comfortable suite', 2, 4, 2, 15, 300.00, 1, 1, NULL, 1, NULL),
(4, '2025-02-25 00:47:49.993981', '2025-02-25 00:47:49.993981', NULL, 'غرفة فاخرة', 'A comfortable luxury room', 2, 3, 1, 14, 250.00, 1, 1, NULL, 1, NULL),
(5, '2025-02-25 00:47:50.037107', '2025-02-25 00:47:50.037107', NULL, 'غرفة عائلية', 'A comfortable family room', 4, 6, 2, 9, 400.00, 1, 1, NULL, 1, NULL),
(6, '2025-02-25 00:47:50.094641', '2025-02-25 00:47:50.094641', NULL, 'غرفة مفردة', 'A comfortable single room', 1, 2, 1, 16, 100.00, 1, 2, NULL, 2, NULL),
(7, '2025-02-25 00:47:50.136640', '2025-02-25 00:47:50.136640', NULL, 'غرفة مزدوجة', 'A comfortable double room', 2, 3, 1, 9, 150.00, 1, 2, NULL, 2, NULL),
(8, '2025-02-25 00:47:50.183534', '2025-02-25 00:47:50.183534', NULL, 'جناح', 'A comfortable suite', 2, 4, 2, 6, 300.00, 1, 2, NULL, 2, NULL),
(9, '2025-02-25 00:47:50.225958', '2025-02-25 00:47:50.225958', NULL, 'غرفة فاخرة', 'A comfortable luxury room', 2, 3, 1, 5, 250.00, 1, 2, NULL, 2, NULL),
(10, '2025-02-25 00:47:50.267565', '2025-02-25 00:47:50.267565', NULL, 'غرفة عائلية', 'A comfortable family room', 4, 6, 2, 17, 400.00, 1, 2, NULL, 2, NULL),
(11, '2025-02-25 00:47:50.325268', '2025-02-25 00:47:50.325268', NULL, 'غرفة مفردة', 'A comfortable single room', 1, 2, 1, 14, 100.00, 1, 3, NULL, 3, NULL),
(12, '2025-02-25 00:47:50.390613', '2025-02-25 00:47:50.391575', NULL, 'غرفة مزدوجة', 'A comfortable double room', 2, 3, 1, 19, 150.00, 1, 3, NULL, 3, NULL),
(13, '2025-02-25 00:47:50.438495', '2025-02-25 00:47:50.438495', NULL, 'جناح', 'A comfortable suite', 2, 4, 2, 12, 300.00, 1, 3, NULL, 3, NULL),
(14, '2025-02-25 00:47:50.481136', '2025-02-25 00:47:50.481136', NULL, 'غرفة فاخرة', 'A comfortable luxury room', 2, 3, 1, 17, 250.00, 1, 3, NULL, 3, NULL),
(15, '2025-02-25 00:47:50.526651', '2025-02-25 00:47:50.526651', NULL, 'غرفة عائلية', 'A comfortable family room', 4, 6, 2, 9, 400.00, 1, 3, NULL, 3, NULL),
(16, '2025-02-25 00:47:50.588786', '2025-02-25 00:47:50.588786', NULL, 'غرفة مفردة', 'A comfortable single room', 1, 2, 1, 13, 100.00, 1, 4, NULL, 4, NULL),
(17, '2025-02-25 00:47:50.625390', '2025-02-25 00:47:50.625390', NULL, 'غرفة مزدوجة', 'A comfortable double room', 2, 3, 1, 10, 150.00, 1, 4, NULL, 4, NULL),
(18, '2025-02-25 00:47:50.665897', '2025-02-25 00:47:50.665897', NULL, 'جناح', 'A comfortable suite', 2, 4, 2, 16, 300.00, 1, 4, NULL, 4, NULL),
(19, '2025-02-25 00:47:50.708709', '2025-02-25 00:47:50.708709', NULL, 'غرفة فاخرة', 'A comfortable luxury room', 2, 3, 1, 14, 250.00, 1, 4, NULL, 4, NULL),
(20, '2025-02-25 00:47:50.748346', '2025-02-25 00:47:50.748346', NULL, 'غرفة عائلية', 'A comfortable family room', 4, 6, 2, 15, 400.00, 1, 4, NULL, 4, NULL),
(21, '2025-02-25 00:47:50.803441', '2025-02-25 00:47:50.803441', NULL, 'غرفة مفردة', 'A comfortable single room', 1, 2, 1, 17, 100.00, 1, 5, NULL, 5, NULL),
(22, '2025-02-25 00:47:50.985104', '2025-02-25 00:47:50.985104', NULL, 'غرفة مزدوجة', 'A comfortable double room', 2, 3, 1, 19, 150.00, 1, 5, NULL, 5, NULL),
(23, '2025-02-25 00:47:51.026451', '2025-02-25 00:47:51.027453', NULL, 'جناح', 'A comfortable suite', 2, 4, 2, 19, 300.00, 1, 5, NULL, 5, NULL),
(24, '2025-02-25 00:47:51.076613', '2025-02-25 00:47:51.076613', NULL, 'غرفة فاخرة', 'A comfortable luxury room', 2, 3, 1, 6, 250.00, 1, 5, NULL, 5, NULL),
(25, '2025-02-25 00:47:51.118904', '2025-02-25 00:47:51.118904', NULL, 'غرفة عائلية', 'A comfortable family room', 4, 6, 2, 11, 400.00, 1, 5, NULL, 5, NULL);

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

--
-- Dumping data for table `services_roomtypeservice`
--

INSERT INTO `services_roomtypeservice` (`id`, `name`, `description`, `is_active`, `icon`, `additional_fee`, `hotel_id`, `room_type_id`) VALUES
(1, 'ماء', 'لبلبلب', 1, '', 5, 1, 3);

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
-- Table structure for table `shopping_cart`
--

CREATE TABLE `shopping_cart` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `shopping_cart`
--

INSERT INTO `shopping_cart` (`id`, `created_at`, `updated_at`, `deleted_at`, `user_id`) VALUES
(1, '2025-02-25 12:50:45.439248', '2025-02-25 12:50:45.439248', NULL, 6),
(2, '2025-02-26 10:11:58.375450', '2025-02-26 10:11:58.375450', NULL, 7),
(3, '2025-02-26 21:56:12.879313', '2025-02-26 21:56:12.879313', NULL, 8),
(4, '2025-02-26 22:15:29.754780', '2025-02-26 22:15:29.754780', NULL, 9);

-- --------------------------------------------------------

--
-- Table structure for table `shopping_cart_item`
--

CREATE TABLE `shopping_cart_item` (
  `id` bigint(20) NOT NULL,
  `item_type` varchar(20) NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL CHECK (`quantity` >= 0),
  `Total_price` decimal(10,2) NOT NULL,
  `check_in_date` datetime(6) DEFAULT NULL,
  `check_out_date` datetime(6) DEFAULT NULL,
  `notes` longtext DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `cart_id` bigint(20) NOT NULL,
  `hotel_service_id` bigint(20) DEFAULT NULL,
  `room_type_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `shopping_cart_item`
--

INSERT INTO `shopping_cart_item` (`id`, `item_type`, `quantity`, `Total_price`, `check_in_date`, `check_out_date`, `notes`, `created_at`, `updated_at`, `deleted_at`, `cart_id`, `hotel_service_id`, `room_type_id`) VALUES
(1, 'room', 1, 300.00, '2025-02-25 12:57:00.000000', '2025-02-26 12:57:00.000000', NULL, '2025-02-25 12:59:52.024138', '2025-02-25 13:05:46.286192', '2025-02-25 13:05:46.286192', 1, NULL, 3),
(2, 'room', 1, 30.00, '2025-02-25 13:09:00.000000', '2025-02-26 13:09:00.000000', NULL, '2025-02-25 13:11:25.217212', '2025-02-25 14:40:11.506080', '2025-02-25 14:40:11.506080', 1, NULL, 3),
(3, 'room', 1, 300.00, '2025-02-25 13:26:00.000000', '2025-02-26 13:26:00.000000', NULL, '2025-02-25 13:26:51.422377', '2025-02-25 14:39:54.186631', '2025-02-25 14:39:54.186631', 1, NULL, 8),
(4, 'room', 1, 300.00, '2025-02-25 13:27:00.000000', '2025-02-26 13:27:00.000000', NULL, '2025-02-25 13:27:28.841161', '2025-02-25 13:36:54.338039', '2025-02-25 13:36:54.338039', 1, NULL, 8),
(5, 'room', 1, 300.00, '2025-02-25 13:35:00.000000', '2025-02-26 13:35:00.000000', NULL, '2025-02-25 13:35:19.671277', '2025-02-25 13:36:49.711832', '2025-02-25 13:36:49.710818', 1, NULL, 8),
(6, 'room', 1, 300.00, '2025-02-25 13:43:00.000000', '2025-02-26 13:43:00.000000', NULL, '2025-02-25 13:43:40.217992', '2025-02-25 14:39:59.004373', '2025-02-25 14:39:59.003215', 1, NULL, 8),
(7, 'room', 3, 900.00, '2025-02-25 13:43:00.000000', '2025-02-26 13:43:00.000000', NULL, '2025-02-25 13:48:13.966273', '2025-02-25 14:40:03.811121', '2025-02-25 14:40:03.811121', 1, NULL, 8),
(8, 'room', 1, 300.00, '2025-02-25 13:55:00.000000', '2025-02-26 13:55:00.000000', NULL, '2025-02-25 13:55:53.842619', '2025-02-25 13:55:53.842619', NULL, 1, NULL, 8),
(9, 'room', 2, 600.00, '2025-02-25 13:55:00.000000', '2025-02-26 13:55:00.000000', NULL, '2025-02-25 13:56:09.870488', '2025-02-25 19:29:36.848671', NULL, 1, NULL, 8),
(10, 'room', 2, 60.00, '2025-02-25 14:39:00.000000', '2025-02-26 14:39:00.000000', NULL, '2025-02-25 14:40:27.594774', '2025-02-25 19:29:33.336544', NULL, 1, NULL, 3),
(11, 'room', 1, 30.00, '2025-02-25 19:29:00.000000', '2025-02-26 19:29:00.000000', NULL, '2025-02-25 19:29:15.954711', '2025-02-25 19:29:15.954711', NULL, 1, NULL, 3),
(12, 'room', 1, 30.00, '2025-02-25 19:42:00.000000', '2025-02-26 19:42:00.000000', NULL, '2025-02-25 19:42:04.346945', '2025-02-25 19:42:04.346945', NULL, 1, NULL, 3),
(13, 'room', 1, 30.00, '2025-02-25 19:42:00.000000', '2025-02-26 19:42:00.000000', NULL, '2025-02-25 19:42:12.538849', '2025-02-25 19:42:12.538849', NULL, 1, NULL, 3),
(14, 'room', 1, 30.00, '2025-02-25 19:51:00.000000', '2025-02-26 19:51:00.000000', NULL, '2025-02-25 19:51:40.247249', '2025-02-25 19:51:40.247249', NULL, 1, NULL, 3),
(15, 'room', 1, 40.00, '2025-02-25 19:53:00.000000', '2025-02-26 19:53:00.000000', NULL, '2025-02-25 19:53:33.812783', '2025-02-25 19:53:33.812783', NULL, 1, NULL, 3),
(16, 'room', 1, 40.00, '2025-02-26 10:11:00.000000', '2025-02-27 10:11:00.000000', NULL, '2025-02-26 10:11:58.408220', '2025-02-26 10:12:04.005006', '2025-02-26 10:12:04.005006', 2, NULL, 3),
(17, 'room', 1, 40.00, '2025-02-26 10:48:00.000000', '2025-02-27 10:48:00.000000', NULL, '2025-02-26 10:48:34.062242', '2025-02-26 10:51:03.668980', '2025-02-26 10:51:03.668980', 2, NULL, 3),
(18, 'room', 1, 40.00, '2025-02-26 10:49:00.000000', '2025-02-27 10:49:00.000000', NULL, '2025-02-26 10:49:06.032438', '2025-02-26 10:51:05.690471', '2025-02-26 10:51:05.690471', 2, NULL, 3),
(19, 'room', 1, 40.00, '2025-02-26 10:50:00.000000', '2025-02-27 10:50:00.000000', NULL, '2025-02-26 10:50:19.743650', '2025-02-26 10:51:07.592005', '2025-02-26 10:51:07.592005', 2, NULL, 3),
(20, 'room', 1, 40.00, '2025-02-26 10:56:00.000000', '2025-02-27 10:56:00.000000', NULL, '2025-02-26 10:57:21.597857', '2025-02-26 11:20:43.285043', '2025-02-26 11:20:43.284043', 2, NULL, 3),
(21, 'room', 1, 40.00, '2025-02-26 11:13:00.000000', '2025-02-27 11:13:00.000000', NULL, '2025-02-26 11:13:08.149352', '2025-02-26 11:20:45.694806', '2025-02-26 11:20:45.694806', 2, NULL, 3),
(22, 'room', 1, 40.00, '2025-02-26 11:13:00.000000', '2025-02-27 11:13:00.000000', NULL, '2025-02-26 11:14:26.823246', '2025-02-26 11:20:47.634087', '2025-02-26 11:20:47.634087', 2, NULL, 3),
(23, 'room', 2, 80.00, '2025-02-26 11:13:00.000000', '2025-02-27 11:13:00.000000', NULL, '2025-02-26 11:17:51.465698', '2025-02-26 11:20:50.380195', '2025-02-26 11:20:50.380195', 2, NULL, 3),
(24, 'room', 1, 45.00, '2025-02-26 11:20:00.000000', '2025-02-27 11:20:00.000000', NULL, '2025-02-26 11:20:06.761402', '2025-02-26 11:20:52.600503', '2025-02-26 11:20:52.600503', 2, NULL, 3),
(25, 'room', 1, 45.00, '2025-02-26 11:21:00.000000', '2025-02-27 11:21:00.000000', NULL, '2025-02-26 11:21:06.578886', '2025-02-26 11:37:29.748689', '2025-02-26 11:37:29.748689', 2, NULL, 3),
(26, 'room', 2, 80.00, '2025-02-26 11:21:00.000000', '2025-02-27 11:21:00.000000', NULL, '2025-02-26 11:21:51.911396', '2025-02-26 11:34:28.634189', '2025-02-26 11:34:28.634189', 2, NULL, 3),
(27, 'room', 1, 40.00, '2025-02-26 11:21:00.000000', '2025-02-27 11:21:00.000000', NULL, '2025-02-26 11:21:58.612957', '2025-02-26 11:34:32.815915', '2025-02-26 11:34:32.815915', 2, NULL, 3),
(28, 'room', 1, 40.00, '2025-02-26 11:32:00.000000', '2025-02-27 11:32:00.000000', NULL, '2025-02-26 11:33:03.085109', '2025-02-26 11:34:38.240834', '2025-02-26 11:34:38.240834', 2, NULL, 3),
(29, 'room', 1, 40.00, '2025-02-26 11:32:00.000000', '2025-02-27 11:32:00.000000', NULL, '2025-02-26 11:33:11.504943', '2025-02-26 11:37:32.824390', '2025-02-26 11:37:32.824390', 2, NULL, 3),
(30, 'room', 1, 40.00, '2025-02-26 11:33:00.000000', '2025-02-27 11:33:00.000000', NULL, '2025-02-26 11:33:28.538404', '2025-02-26 11:37:34.857810', '2025-02-26 11:37:34.857810', 2, NULL, 3),
(31, 'room', 1, 40.00, '2025-02-26 11:37:00.000000', '2025-02-27 11:37:00.000000', NULL, '2025-02-26 11:37:52.341822', '2025-02-26 11:41:45.473613', '2025-02-26 11:41:45.473613', 2, NULL, 3),
(32, 'room', 3, 135.00, '2025-02-26 11:37:00.000000', '2025-02-27 11:37:00.000000', NULL, '2025-02-26 11:38:04.061289', '2025-02-26 11:41:47.462627', '2025-02-26 11:41:47.462627', 2, NULL, 3),
(33, 'room', 2, 80.00, '2025-02-26 11:41:00.000000', '2025-02-27 11:41:00.000000', NULL, '2025-02-26 11:41:58.252990', '2025-02-26 11:42:00.927154', NULL, 2, NULL, 3),
(34, 'room', 1, 45.00, '2025-02-26 11:41:00.000000', '2025-02-27 11:41:00.000000', NULL, '2025-02-26 11:42:07.327475', '2025-02-26 11:42:07.333477', NULL, 2, NULL, 3),
(35, 'room', 2, 90.00, '2025-02-26 11:47:00.000000', '2025-02-27 11:47:00.000000', NULL, '2025-02-26 11:47:10.120102', '2025-02-26 11:47:20.740722', NULL, 2, NULL, 3),
(36, 'room', 1, 45.00, '2025-02-26 12:17:00.000000', '2025-02-27 12:17:00.000000', NULL, '2025-02-26 12:17:53.951805', '2025-02-26 12:17:53.974404', NULL, 2, NULL, 3),
(37, 'room', 1, 40.00, '2025-02-26 21:55:00.000000', '2025-02-27 21:55:00.000000', NULL, '2025-02-26 21:56:12.957180', '2025-02-26 21:56:12.963142', NULL, 3, NULL, 3),
(38, 'room', 2, 80.00, '2025-02-26 22:15:00.000000', '2025-02-27 22:15:00.000000', NULL, '2025-02-26 22:15:29.778426', '2025-02-26 22:15:34.494696', NULL, 4, NULL, 3),
(39, 'room', 1, 45.00, '2025-02-26 22:20:00.000000', '2025-02-27 22:20:00.000000', NULL, '2025-02-26 22:21:01.920810', '2025-02-26 22:21:01.937552', NULL, 4, NULL, 3);

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
  `is_active` tinyint(1) NOT NULL,
  `chield_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users_customuser`
--

INSERT INTO `users_customuser` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `date_joined`, `created_at`, `updated_at`, `user_type`, `phone`, `image`, `is_active`, `chield_id`) VALUES
(1, 'pbkdf2_sha256$870000$uhw755iVvp3gMKtQv9kMg8$8a+uel+f81hBdDR5knOtnE/iy/2pJCHal5H4veuKxvo=', NULL, 0, 'admin', 'Admin', 'User', 'admin@example.com', 0, '2025-02-25 00:47:44.333072', '2025-02-25 00:47:44.333072', '2025-02-25 00:47:45.375203', 'admin', '0500000000', '', 1, NULL),
(2, 'pbkdf2_sha256$870000$mOwu11HBSOHZcAnicApj5e$czpbp1c+seueBWK8SJBB1ZaSXDhCPyFNwjX96RVPlCc=', NULL, 0, 'manager1', 'Hotel', 'Manager 1', 'manager1@example.com', 0, '2025-02-25 00:47:45.386932', '2025-02-25 00:47:45.386932', '2025-02-25 00:47:46.475512', 'hotel_manager', '0511111111', '', 1, NULL),
(3, 'pbkdf2_sha256$870000$uv5XLg1Qn2wVqQWJezszF5$hGcngchQZO358Z6k8ghZzYlX4YW3MX1S8KF/JhMRC0I=', NULL, 0, 'manager2', 'Hotel', 'Manager 2', 'manager2@example.com', 0, '2025-02-25 00:47:46.488205', '2025-02-25 00:47:46.488205', '2025-02-25 00:47:47.502979', 'hotel_manager', '0522222222', '', 1, NULL),
(4, 'pbkdf2_sha256$870000$9zLiWKu9gRiWRBbUeWDrev$sghK1iE3q399dORnG39xVvlC/7DnXi9zeGM/lhxP3pM=', NULL, 0, 'customer1', 'Customer', 'One', 'customer1@example.com', 0, '2025-02-25 00:47:47.512856', '2025-02-25 00:47:47.512856', '2025-02-25 00:47:48.530187', 'customer', '0533333333', '', 1, NULL),
(5, 'pbkdf2_sha256$870000$HUjSgQsKOhn25IzKmXBUBD$91vM4KhhcAsTRCqeA8VCvLrKsek+dvmIhcs5GFOBkvM=', NULL, 0, 'staff1', 'Staff', 'One', 'staff1@example.com', 0, '2025-02-25 00:47:48.541227', '2025-02-25 00:47:48.541227', '2025-02-25 00:47:49.577067', 'staff', '0544444444', '', 1, NULL),
(6, 'pbkdf2_sha256$600000$F2vEmUnNVf4f9fOtOOVItC$hBpnAmdWWvY+ltUvxSC22vKN4E5x+VhY+X5ESW82Lmg=', '2025-02-25 19:28:10.203894', 1, 'ali', '', '', '', 1, '2025-02-25 00:50:01.299612', '2025-02-25 00:50:02.348686', '2025-02-25 00:50:02.348686', '', '', '', 1, NULL),
(7, 'pbkdf2_sha256$600000$p6JuQ9P7wv2sQhUDaTrogS$lNhIPSDy+us6FyuDwCtaQR57wwXlUTrvXz8I19qijgI=', '2025-02-26 10:11:41.771831', 1, 'ah', '', '', 'ah@ah.com', 1, '2025-02-26 10:11:30.338998', '2025-02-26 10:11:30.821540', '2025-02-26 10:11:30.821540', '', '', '', 1, NULL),
(8, 'pbkdf2_sha256$600000$F253zdmhfnmrvK7AYF9dcI$jH8fkgCEy98J0tLIpQTnKYz+0zmojgruk4eWOMBBw4A=', '2025-02-26 21:55:46.658928', 0, 'ahmed', '', '', 'ashh@s.com', 0, '2025-02-26 21:55:44.921067', '2025-02-26 21:55:46.634082', '2025-02-26 21:55:46.634082', 'user', '', '', 1, NULL),
(9, 'pbkdf2_sha256$600000$yWuxL9PEPDVFgueE2SlYGu$Ft35HFze9+lLaxzcgqN6sFRhbM+E1jynUXNFTbmw7WU=', '2025-02-26 22:09:41.105654', 1, 'a', '', '', 'a@a.com', 1, '2025-02-26 22:09:34.596256', '2025-02-26 22:09:35.416331', '2025-02-26 22:09:35.416331', '', '', '', 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users_customuser_groups`
--

CREATE TABLE `users_customuser_groups` (
  `id` bigint(20) NOT NULL,
  `customuser_id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users_customuser_groups`
--

INSERT INTO `users_customuser_groups` (`id`, `customuser_id`, `group_id`) VALUES
(1, 2, 1),
(2, 3, 1);

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
-- Dumping data for table `users_customuser_user_permissions`
--

INSERT INTO `users_customuser_user_permissions` (`id`, `customuser_id`, `permission_id`) VALUES
(1, 1, 5),
(2, 1, 6),
(3, 2, 5),
(4, 3, 5);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `additional_services`
--
ALTER TABLE `additional_services`
  ADD PRIMARY KEY (`id`);

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
-- Indexes for table `bookings_booking`
--
ALTER TABLE `bookings_booking`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bookings_booking_created_by_id_d8a2f432_fk_users_customuser_id` (`created_by_id`),
  ADD KEY `bookings_booking_hotel_id_e1f8132f_fk_HotelManagement_hotel_id` (`hotel_id`),
  ADD KEY `bookings_booking_room_id_6f0fa517_fk_rooms_roomtype_id` (`room_id`),
  ADD KEY `bookings_booking_updated_by_id_6c0bc7d4_fk_users_customuser_id` (`updated_by_id`),
  ADD KEY `bookings_booking_user_id_834dfc23_fk_users_customuser_id` (`user_id`),
  ADD KEY `bookings_booking_status_id_000bd21d_fk_bookings_bookingstatus_id` (`status_id`);

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
-- Indexes for table `bookings_bookingstatus`
--
ALTER TABLE `bookings_bookingstatus`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bookings_bookingstat_created_by_id_3055158b_fk_users_cus` (`created_by_id`),
  ADD KEY `bookings_bookingstat_updated_by_id_b6e4a5d9_fk_users_cus` (`updated_by_id`);

--
-- Indexes for table `bookings_guest`
--
ALTER TABLE `bookings_guest`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bookings_guest_account_id_b0d59ca6_fk_users_customuser_id` (`account_id`),
  ADD KEY `bookings_guest_booking_id_b8c4c07b_fk_bookings_booking_id` (`booking_id`),
  ADD KEY `bookings_guest_created_by_id_0cc0af08_fk_users_customuser_id` (`created_by_id`),
  ADD KEY `bookings_guest_hotel_id_333c72e5_fk_HotelManagement_hotel_id` (`hotel_id`),
  ADD KEY `bookings_guest_updated_by_id_7fb9973c_fk_users_customuser_id` (`updated_by_id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_users_customuser_id` (`user_id`);

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
  ADD KEY `HotelManagement_hote_updated_by_id_9c63fc69_fk_users_cus` (`updated_by_id`),
  ADD KEY `HotelManagement_hote_location_id_2f7c61ed_fk_HotelMana` (`location_id`);

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
  ADD KEY `payments_hotelpaymen_payment_option_id_4b539d55_fk_payments_` (`payment_option_id`);

--
-- Indexes for table `payments_payment`
--
ALTER TABLE `payments_payment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `payments_payment_booking_id_2a46974b_fk_bookings_booking_id` (`booking_id`),
  ADD KEY `payments_payment_payment_method_id_c909ff25_fk_payments_` (`payment_method_id`);

--
-- Indexes for table `payments_paymentoption`
--
ALTER TABLE `payments_paymentoption`
  ADD PRIMARY KEY (`id`),
  ADD KEY `payments_paymentopti_currency_id_9986031a_fk_payments_` (`currency_id`);

--
-- Indexes for table `reviews_hotelreview`
--
ALTER TABLE `reviews_hotelreview`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD UNIQUE KEY `unique_hotel_user_review` (`hotel_id`,`user_id`),
  ADD KEY `reviews_hotelreview_created_by_id_fbc20ee8_fk_users_cus` (`created_by_id`),
  ADD KEY `reviews_hotelreview_updated_by_id_2fbc72a0_fk_users_cus` (`updated_by_id`),
  ADD KEY `reviews_hotelreview_user_id_b1101c52_fk_users_customuser_id` (`user_id`);

--
-- Indexes for table `reviews_offer`
--
ALTER TABLE `reviews_offer`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `reviews_offer_created_by_id_6d3a14d1_fk_users_customuser_id` (`created_by_id`),
  ADD KEY `reviews_offer_hotel_id_631603f9_fk_HotelManagement_hotel_id` (`hotel_id`),
  ADD KEY `reviews_offer_updated_by_id_696a12c5_fk_users_customuser_id` (`updated_by_id`);

--
-- Indexes for table `reviews_roomreview`
--
ALTER TABLE `reviews_roomreview`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
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
  ADD UNIQUE KEY `unique_room_availability` (`hotel_id`,`room_type_id`,`availability_date`),
  ADD KEY `rooms_availability_created_by_id_168a5943_fk_users_customuser_id` (`created_by_id`),
  ADD KEY `rooms_availability_updated_by_id_f8d6a9d2_fk_users_customuser_id` (`updated_by_id`),
  ADD KEY `rooms_availability_room_status_id_1add85a0_fk_rooms_roo` (`room_status_id`),
  ADD KEY `rooms_availability_room_type_id_ee87e18f_fk_rooms_roomtype_id` (`room_type_id`);

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
  ADD KEY `rooms_review_updated_by_id_276c8602_fk_users_customuser_id` (`updated_by_id`),
  ADD KEY `rooms_review_user_id_7ce3bdba_fk_users_customuser_id` (`user_id`),
  ADD KEY `rooms_review_room_type_id_3efa460c_fk_rooms_roomtype_id` (`room_type_id`);

--
-- Indexes for table `rooms_roomimage`
--
ALTER TABLE `rooms_roomimage`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rooms_roomimage_created_by_id_168789df_fk_users_customuser_id` (`created_by_id`),
  ADD KEY `rooms_roomimage_hotel_id_13fbdfad_fk_HotelManagement_hotel_id` (`hotel_id`),
  ADD KEY `rooms_roomimage_updated_by_id_c3e3a6e5_fk_users_customuser_id` (`updated_by_id`),
  ADD KEY `rooms_roomimage_room_type_id_d35f7810_fk_rooms_roomtype_id` (`room_type_id`);

--
-- Indexes for table `rooms_roomprice`
--
ALTER TABLE `rooms_roomprice`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rooms_roomprice_created_by_id_7459c49f_fk_users_customuser_id` (`created_by_id`),
  ADD KEY `rooms_roomprice_hotel_id_bfc064b3_fk_HotelManagement_hotel_id` (`hotel_id`),
  ADD KEY `rooms_roomprice_updated_by_id_20da56f3_fk_users_customuser_id` (`updated_by_id`),
  ADD KEY `rooms_roomprice_room_type_id_b8f396b9_fk_rooms_roomtype_id` (`room_type_id`);

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
-- Indexes for table `shopping_cart`
--
ALTER TABLE `shopping_cart`
  ADD PRIMARY KEY (`id`),
  ADD KEY `shopping_cart_user_id_27d1bbc3_fk_users_customuser_id` (`user_id`);

--
-- Indexes for table `shopping_cart_item`
--
ALTER TABLE `shopping_cart_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `shopping_cart_item_cart_id_ef9ac9a8_fk_shopping_cart_id` (`cart_id`),
  ADD KEY `shopping_cart_item_hotel_service_id_51d94719_fk_services_` (`hotel_service_id`),
  ADD KEY `shopping_cart_item_room_type_id_f2e17af0_fk_rooms_roomtype_id` (`room_type_id`);

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
-- AUTO_INCREMENT for table `additional_services`
--
ALTER TABLE `additional_services`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=171;

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
-- AUTO_INCREMENT for table `bookings_booking`
--
ALTER TABLE `bookings_booking`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `bookings_bookingdetail`
--
ALTER TABLE `bookings_bookingdetail`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bookings_bookingstatus`
--
ALTER TABLE `bookings_bookingstatus`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `bookings_guest`
--
ALTER TABLE `bookings_guest`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `hotelmanagement_city`
--
ALTER TABLE `hotelmanagement_city`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `hotelmanagement_hotel`
--
ALTER TABLE `hotelmanagement_hotel`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `hotelmanagement_hotelrequest`
--
ALTER TABLE `hotelmanagement_hotelrequest`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hotelmanagement_image`
--
ALTER TABLE `hotelmanagement_image`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payments_currency`
--
ALTER TABLE `payments_currency`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `payments_hotelpaymentmethod`
--
ALTER TABLE `payments_hotelpaymentmethod`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=201;

--
-- AUTO_INCREMENT for table `payments_payment`
--
ALTER TABLE `payments_payment`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payments_paymentoption`
--
ALTER TABLE `payments_paymentoption`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `reviews_hotelreview`
--
ALTER TABLE `reviews_hotelreview`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `reviews_offer`
--
ALTER TABLE `reviews_offer`
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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=751;

--
-- AUTO_INCREMENT for table `rooms_category`
--
ALTER TABLE `rooms_category`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `rooms_review`
--
ALTER TABLE `rooms_review`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=104;

--
-- AUTO_INCREMENT for table `rooms_roomimage`
--
ALTER TABLE `rooms_roomimage`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;

--
-- AUTO_INCREMENT for table `rooms_roomprice`
--
ALTER TABLE `rooms_roomprice`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `rooms_roomstatus`
--
ALTER TABLE `rooms_roomstatus`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `rooms_roomtype`
--
ALTER TABLE `rooms_roomtype`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `services_hotelservice`
--
ALTER TABLE `services_hotelservice`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `services_roomtypeservice`
--
ALTER TABLE `services_roomtypeservice`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `service_offers`
--
ALTER TABLE `service_offers`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `shopping_cart`
--
ALTER TABLE `shopping_cart`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `shopping_cart_item`
--
ALTER TABLE `shopping_cart_item`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `users_customuser_groups`
--
ALTER TABLE `users_customuser_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users_customuser_user_permissions`
--
ALTER TABLE `users_customuser_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

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
-- Constraints for table `bookings_booking`
--
ALTER TABLE `bookings_booking`
  ADD CONSTRAINT `bookings_booking_created_by_id_d8a2f432_fk_users_customuser_id` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `bookings_booking_hotel_id_e1f8132f_fk_HotelManagement_hotel_id` FOREIGN KEY (`hotel_id`) REFERENCES `hotelmanagement_hotel` (`id`),
  ADD CONSTRAINT `bookings_booking_room_id_6f0fa517_fk_rooms_roomtype_id` FOREIGN KEY (`room_id`) REFERENCES `rooms_roomtype` (`id`),
  ADD CONSTRAINT `bookings_booking_status_id_000bd21d_fk_bookings_bookingstatus_id` FOREIGN KEY (`status_id`) REFERENCES `bookings_bookingstatus` (`id`),
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
-- Constraints for table `bookings_bookingstatus`
--
ALTER TABLE `bookings_bookingstatus`
  ADD CONSTRAINT `bookings_bookingstat_created_by_id_3055158b_fk_users_cus` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `bookings_bookingstat_updated_by_id_b6e4a5d9_fk_users_cus` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- Constraints for table `bookings_guest`
--
ALTER TABLE `bookings_guest`
  ADD CONSTRAINT `bookings_guest_account_id_b0d59ca6_fk_users_customuser_id` FOREIGN KEY (`account_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `bookings_guest_booking_id_b8c4c07b_fk_bookings_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `bookings_booking` (`id`),
  ADD CONSTRAINT `bookings_guest_created_by_id_0cc0af08_fk_users_customuser_id` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `bookings_guest_hotel_id_333c72e5_fk_HotelManagement_hotel_id` FOREIGN KEY (`hotel_id`) REFERENCES `hotelmanagement_hotel` (`id`),
  ADD CONSTRAINT `bookings_guest_updated_by_id_7fb9973c_fk_users_customuser_id` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_users_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_customuser` (`id`);

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
  ADD CONSTRAINT `payments_hotelpaymen_hotel_id_ce0a1829_fk_HotelMana` FOREIGN KEY (`hotel_id`) REFERENCES `hotelmanagement_hotel` (`id`),
  ADD CONSTRAINT `payments_hotelpaymen_payment_option_id_4b539d55_fk_payments_` FOREIGN KEY (`payment_option_id`) REFERENCES `payments_paymentoption` (`id`);

--
-- Constraints for table `payments_payment`
--
ALTER TABLE `payments_payment`
  ADD CONSTRAINT `payments_payment_booking_id_2a46974b_fk_bookings_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `bookings_booking` (`id`),
  ADD CONSTRAINT `payments_payment_payment_method_id_c909ff25_fk_payments_` FOREIGN KEY (`payment_method_id`) REFERENCES `payments_hotelpaymentmethod` (`id`);

--
-- Constraints for table `payments_paymentoption`
--
ALTER TABLE `payments_paymentoption`
  ADD CONSTRAINT `payments_paymentopti_currency_id_9986031a_fk_payments_` FOREIGN KEY (`currency_id`) REFERENCES `payments_currency` (`id`);

--
-- Constraints for table `reviews_hotelreview`
--
ALTER TABLE `reviews_hotelreview`
  ADD CONSTRAINT `reviews_hotelreview_created_by_id_fbc20ee8_fk_users_cus` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `reviews_hotelreview_hotel_id_6819d0d9_fk_HotelMana` FOREIGN KEY (`hotel_id`) REFERENCES `hotelmanagement_hotel` (`id`),
  ADD CONSTRAINT `reviews_hotelreview_updated_by_id_2fbc72a0_fk_users_cus` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `reviews_hotelreview_user_id_b1101c52_fk_users_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_customuser` (`id`);

--
-- Constraints for table `reviews_offer`
--
ALTER TABLE `reviews_offer`
  ADD CONSTRAINT `reviews_offer_created_by_id_6d3a14d1_fk_users_customuser_id` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `reviews_offer_hotel_id_631603f9_fk_HotelManagement_hotel_id` FOREIGN KEY (`hotel_id`) REFERENCES `hotelmanagement_hotel` (`id`),
  ADD CONSTRAINT `reviews_offer_updated_by_id_696a12c5_fk_users_customuser_id` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

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
-- Constraints for table `shopping_cart`
--
ALTER TABLE `shopping_cart`
  ADD CONSTRAINT `shopping_cart_user_id_27d1bbc3_fk_users_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_customuser` (`id`);

--
-- Constraints for table `shopping_cart_item`
--
ALTER TABLE `shopping_cart_item`
  ADD CONSTRAINT `shopping_cart_item_cart_id_ef9ac9a8_fk_shopping_cart_id` FOREIGN KEY (`cart_id`) REFERENCES `shopping_cart` (`id`),
  ADD CONSTRAINT `shopping_cart_item_hotel_service_id_51d94719_fk_services_` FOREIGN KEY (`hotel_service_id`) REFERENCES `services_hotelservice` (`id`),
  ADD CONSTRAINT `shopping_cart_item_room_type_id_f2e17af0_fk_rooms_roomtype_id` FOREIGN KEY (`room_type_id`) REFERENCES `rooms_roomtype` (`id`);

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
