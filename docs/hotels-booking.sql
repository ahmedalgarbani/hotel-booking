-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 23, 2025 at 08:14 PM
-- Server version: 11.4.4-MariaDB
-- PHP Version: 7.4.27

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
(1, 'Hotel Managers'),
(2, 'Hotel Staff'),
(3, 'hotel_manager');

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
(2, 1, 21),
(3, 1, 22),
(4, 1, 23),
(1, 1, 24),
(5, 1, 73),
(6, 1, 74),
(7, 1, 75),
(8, 1, 76),
(10, 1, 77),
(11, 1, 78),
(12, 1, 79),
(9, 1, 80),
(14, 1, 125),
(15, 1, 126),
(16, 1, 127),
(13, 1, 128),
(33, 3, 32),
(17, 3, 33),
(18, 3, 34),
(20, 3, 35),
(19, 3, 36),
(25, 3, 41),
(26, 3, 42),
(28, 3, 43),
(27, 3, 44),
(29, 3, 45),
(30, 3, 46),
(32, 3, 47),
(31, 3, 48),
(21, 3, 49),
(22, 3, 50),
(24, 3, 51),
(23, 3, 52);

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
(5, 'Can add permission', 7, 'add_permission'),
(6, 'Can change permission', 7, 'change_permission'),
(7, 'Can delete permission', 7, 'delete_permission'),
(8, 'Can view permission', 7, 'view_permission'),
(9, 'Can add group', 8, 'add_group'),
(10, 'Can change group', 8, 'change_group'),
(11, 'Can delete group', 8, 'delete_group'),
(12, 'Can view group', 8, 'view_group'),
(13, 'Can add content type', 9, 'add_contenttype'),
(14, 'Can change content type', 9, 'change_contenttype'),
(15, 'Can delete content type', 9, 'delete_contenttype'),
(16, 'Can view content type', 9, 'view_contenttype'),
(17, 'Can add session', 10, 'add_session'),
(18, 'Can change session', 10, 'change_session'),
(19, 'Can delete session', 10, 'delete_session'),
(20, 'Can view session', 10, 'view_session'),
(21, 'Can add مستخدم', 2, 'add_customuser'),
(22, 'Can change مستخدم', 2, 'change_customuser'),
(23, 'Can delete مستخدم', 2, 'delete_customuser'),
(24, 'Can view مستخدم', 2, 'view_customuser'),
(25, 'Can add سجل النشاط', 11, 'add_activitylog'),
(26, 'Can change سجل النشاط', 11, 'change_activitylog'),
(27, 'Can delete سجل النشاط', 11, 'delete_activitylog'),
(28, 'Can view سجل النشاط', 11, 'view_activitylog'),
(29, 'Can add منطقه', 12, 'add_city'),
(30, 'Can change منطقه', 12, 'change_city'),
(31, 'Can delete منطقه', 12, 'delete_city'),
(32, 'Can view منطقه', 12, 'view_city'),
(33, 'Can add فندق', 13, 'add_hotel'),
(34, 'Can change فندق', 13, 'change_hotel'),
(35, 'Can delete فندق', 13, 'delete_hotel'),
(36, 'Can view فندق', 13, 'view_hotel'),
(37, 'Can add طلب إضافة فندق', 14, 'add_hotelrequest'),
(38, 'Can change طلب إضافة فندق', 14, 'change_hotelrequest'),
(39, 'Can delete طلب إضافة فندق', 14, 'delete_hotelrequest'),
(40, 'Can view طلب إضافة فندق', 14, 'view_hotelrequest'),
(41, 'Can add صورة', 15, 'add_image'),
(42, 'Can change صورة', 15, 'change_image'),
(43, 'Can delete صورة', 15, 'delete_image'),
(44, 'Can view صورة', 15, 'view_image'),
(45, 'Can add الموقع', 16, 'add_location'),
(46, 'Can change الموقع', 16, 'change_location'),
(47, 'Can delete الموقع', 16, 'delete_location'),
(48, 'Can view الموقع', 16, 'view_location'),
(49, 'Can add رقم هاتف', 17, 'add_phone'),
(50, 'Can change رقم هاتف', 17, 'change_phone'),
(51, 'Can delete رقم هاتف', 17, 'delete_phone'),
(52, 'Can view رقم هاتف', 17, 'view_phone'),
(53, 'Can add توفر الغرف', 18, 'add_availability'),
(54, 'Can change توفر الغرف', 18, 'change_availability'),
(55, 'Can delete توفر الغرف', 18, 'delete_availability'),
(56, 'Can view توفر الغرف', 18, 'view_availability'),
(57, 'Can add تصنيف', 19, 'add_category'),
(58, 'Can change تصنيف', 19, 'change_category'),
(59, 'Can delete تصنيف', 19, 'delete_category'),
(60, 'Can view تصنيف', 19, 'view_category'),
(61, 'Can add صورة الغرفة', 20, 'add_roomimage'),
(62, 'Can change صورة الغرفة', 20, 'change_roomimage'),
(63, 'Can delete صورة الغرفة', 20, 'delete_roomimage'),
(64, 'Can view صورة الغرفة', 20, 'view_roomimage'),
(65, 'Can add سعر الغرفة', 21, 'add_roomprice'),
(66, 'Can change سعر الغرفة', 21, 'change_roomprice'),
(67, 'Can delete سعر الغرفة', 21, 'delete_roomprice'),
(68, 'Can view سعر الغرفة', 21, 'view_roomprice'),
(69, 'Can add حالة الغرفة', 22, 'add_roomstatus'),
(70, 'Can change حالة الغرفة', 22, 'change_roomstatus'),
(71, 'Can delete حالة الغرفة', 22, 'delete_roomstatus'),
(72, 'Can view حالة الغرفة', 22, 'view_roomstatus'),
(73, 'Can add نوع الغرفة', 4, 'add_roomtype'),
(74, 'Can change نوع الغرفة', 4, 'change_roomtype'),
(75, 'Can delete نوع الغرفة', 4, 'delete_roomtype'),
(76, 'Can view نوع الغرفة', 4, 'view_roomtype'),
(77, 'Can add حجز', 5, 'add_booking'),
(78, 'Can change حجز', 5, 'change_booking'),
(79, 'Can delete حجز', 5, 'delete_booking'),
(80, 'Can view حجز', 5, 'view_booking'),
(81, 'Can add تفصيل الحجز', 23, 'add_bookingdetail'),
(82, 'Can change تفصيل الحجز', 23, 'change_bookingdetail'),
(83, 'Can delete تفصيل الحجز', 23, 'delete_bookingdetail'),
(84, 'Can view تفصيل الحجز', 23, 'view_bookingdetail'),
(85, 'Can add حالة الحجز', 24, 'add_bookingstatus'),
(86, 'Can change حالة الحجز', 24, 'change_bookingstatus'),
(87, 'Can delete حالة الحجز', 24, 'delete_bookingstatus'),
(88, 'Can view حالة الحجز', 24, 'view_bookingstatus'),
(89, 'Can add ضيف', 25, 'add_guest'),
(90, 'Can change ضيف', 25, 'change_guest'),
(91, 'Can delete ضيف', 25, 'delete_guest'),
(92, 'Can view ضيف', 25, 'view_guest'),
(93, 'Can add عملة', 26, 'add_currency'),
(94, 'Can change عملة', 26, 'change_currency'),
(95, 'Can delete عملة', 26, 'delete_currency'),
(96, 'Can view عملة', 26, 'view_currency'),
(97, 'Can add طريقة دفع الفندق', 27, 'add_hotelpaymentmethod'),
(98, 'Can change طريقة دفع الفندق', 27, 'change_hotelpaymentmethod'),
(99, 'Can delete طريقة دفع الفندق', 27, 'delete_hotelpaymentmethod'),
(100, 'Can view طريقة دفع الفندق', 27, 'view_hotelpaymentmethod'),
(101, 'Can add فاتورة دفع', 28, 'add_payment'),
(102, 'Can change فاتورة دفع', 28, 'change_payment'),
(103, 'Can delete فاتورة دفع', 28, 'delete_payment'),
(104, 'Can view فاتورة دفع', 28, 'view_payment'),
(105, 'Can add طريقة دفع', 29, 'add_paymentoption'),
(106, 'Can change طريقة دفع', 29, 'change_paymentoption'),
(107, 'Can delete طريقة دفع', 29, 'delete_paymentoption'),
(108, 'Can view طريقة دفع', 29, 'view_paymentoption'),
(109, 'Can add مراجعة فندق', 30, 'add_hotelreview'),
(110, 'Can change مراجعة فندق', 30, 'change_hotelreview'),
(111, 'Can delete مراجعة فندق', 30, 'delete_hotelreview'),
(112, 'Can view مراجعة فندق', 30, 'view_hotelreview'),
(113, 'Can add عرض', 31, 'add_offer'),
(114, 'Can change عرض', 31, 'change_offer'),
(115, 'Can delete عرض', 31, 'delete_offer'),
(116, 'Can view عرض', 31, 'view_offer'),
(117, 'Can add مراجعة غرفة', 32, 'add_roomreview'),
(118, 'Can change مراجعة غرفة', 32, 'change_roomreview'),
(119, 'Can delete مراجعة غرفة', 32, 'delete_roomreview'),
(120, 'Can view مراجعة غرفة', 32, 'view_roomreview'),
(121, 'Can add عرض', 33, 'add_offer'),
(122, 'Can change عرض', 33, 'change_offer'),
(123, 'Can delete عرض', 33, 'delete_offer'),
(124, 'Can view عرض', 33, 'view_offer'),
(125, 'Can add خدمة', 6, 'add_service'),
(126, 'Can change خدمة', 6, 'change_service'),
(127, 'Can delete خدمة', 6, 'delete_service'),
(128, 'Can view خدمة', 6, 'view_service'),
(129, 'Can approve hotel request', 14, 'can_approve_request'),
(130, 'Can reject hotel request', 14, 'can_reject_request'),
(131, 'Can add مقال', 34, 'add_post'),
(132, 'Can change مقال', 34, 'change_post'),
(133, 'Can delete مقال', 34, 'delete_post'),
(134, 'Can view مقال', 34, 'view_post'),
(135, 'Can add تصنيف', 35, 'add_category'),
(136, 'Can change تصنيف', 35, 'change_category'),
(137, 'Can delete تصنيف', 35, 'delete_category'),
(138, 'Can view تصنيف', 35, 'view_category'),
(139, 'Can add تعليق', 36, 'add_comment'),
(140, 'Can change تعليق', 36, 'change_comment'),
(141, 'Can delete تعليق', 36, 'delete_comment'),
(142, 'Can view تعليق', 36, 'view_comment');

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
  `slug` varchar(255) NOT NULL,
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

-- --------------------------------------------------------

--
-- Table structure for table `bookings_bookingdetail`
--

CREATE TABLE `bookings_bookingdetail` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `slug` varchar(255) NOT NULL,
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
  `slug` varchar(255) NOT NULL,
  `booking_status_name` varchar(50) NOT NULL,
  `status_code` int(11) NOT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bookings_guest`
--

CREATE TABLE `bookings_guest` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `slug` varchar(255) NOT NULL,
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
(1, '2025-01-24 15:35:26.595256', '2', 'فندق النبراس', 3, '', 2, 1),
(2, '2025-01-24 15:35:46.310883', '1', 'dfd', 3, '', 13, 1),
(3, '2025-01-24 15:36:12.374029', '1', 'dfd - فندق النبراس', 2, '[{\"changed\": {\"fields\": [\"\\u0627\\u0644\\u0628\\u0631\\u064a\\u062f \\u0627\\u0644\\u0625\\u0644\\u0643\\u062a\\u0631\\u0648\\u0646\\u064a\", \"\\u0627\\u0644\\u0645\\u062f\\u064a\\u0646\\u0629\"]}}]', 14, 1),
(4, '2025-01-24 15:36:41.074806', '1', 'dfd - فندق النبراس', 2, '[{\"changed\": {\"fields\": [\"\\u062a\\u0645\\u062a \\u0627\\u0644\\u0645\\u0648\\u0627\\u0641\\u0642\\u0629\"]}}]', 14, 1),
(5, '2025-01-24 15:37:55.052660', '2', 'dfd', 3, '', 13, 1),
(6, '2025-01-24 15:38:18.441830', '3', 'فندق النبراس', 3, '', 2, 1),
(7, '2025-01-24 15:38:30.377420', '1', 'dfd - فندق النبراس', 2, '[{\"changed\": {\"fields\": [\"\\u062a\\u0645\\u062a \\u0627\\u0644\\u0645\\u0648\\u0627\\u0641\\u0642\\u0629\"]}}]', 14, 1),
(8, '2025-01-24 15:41:30.396149', '4', 'فندق النبراس', 3, '', 2, 1),
(9, '2025-01-24 15:41:42.907225', '3', 'dfd', 3, '', 13, 1),
(10, '2025-01-24 15:41:54.974331', '1', 'dfd - فندق النبراس', 2, '[{\"changed\": {\"fields\": [\"\\u062a\\u0645\\u062a \\u0627\\u0644\\u0645\\u0648\\u0627\\u0641\\u0642\\u0629\"]}}]', 14, 1),
(11, '2025-01-24 15:47:20.340957', '4', 'dfd', 3, '', 13, 1),
(12, '2025-01-24 15:47:30.739972', '5', 'فندق النبراس', 3, '', 2, 1),
(13, '2025-01-24 15:47:42.206202', '1', 'dfd - فندق النبراس', 2, '[{\"changed\": {\"fields\": [\"\\u062a\\u0645\\u062a \\u0627\\u0644\\u0645\\u0648\\u0627\\u0641\\u0642\\u0629\"]}}]', 14, 1),
(14, '2025-01-24 15:49:40.514977', '6', 'فندق النبراس', 3, '', 2, 1),
(15, '2025-01-24 15:49:53.483490', '5', 'dfd', 3, '', 13, 1),
(16, '2025-01-24 15:50:05.100729', '1', 'dfd - فندق النبراس', 2, '[{\"changed\": {\"fields\": [\"\\u062a\\u0645\\u062a \\u0627\\u0644\\u0645\\u0648\\u0627\\u0641\\u0642\\u0629\"]}}]', 14, 1),
(17, '2025-01-24 15:54:56.603393', '7', 'فندق النبراس', 3, '', 2, 1),
(18, '2025-01-24 17:17:34.735603', '6', 'dfd', 3, '', 13, 1),
(19, '2025-01-24 17:18:09.731724', '8', 'فندق النبراس', 3, '', 2, 1),
(20, '2025-01-24 17:18:21.524167', '1', 'dfd - فندق النبراس', 2, '[{\"changed\": {\"fields\": [\"\\u062a\\u0645\\u062a \\u0627\\u0644\\u0645\\u0648\\u0627\\u0641\\u0642\\u0629\"]}}]', 14, 1),
(21, '2025-01-24 17:41:29.589642', '12', 'فندق النبراس', 2, '[{\"changed\": {\"fields\": [\"password\"]}}]', 2, 1),
(22, '2025-01-24 17:41:31.424686', '12', 'فندق النبراس', 2, '[]', 2, 1),
(23, '2025-01-24 17:45:43.568272', '13', 'aa', 1, '[{\"added\": {}}]', 2, 12),
(24, '2025-01-24 18:17:36.223938', '11', 'ddd', 2, '[{\"changed\": {\"fields\": [\"\\u0646\\u0648\\u0639 \\u0627\\u0644\\u0645\\u0633\\u062a\\u062e\\u062f\\u0645\", \"Staff status\"]}}]', 2, 1),
(25, '2025-01-24 20:31:19.072557', '2', 'فنذق الاندلس - فنذق الاندلس', 3, '', 14, 14),
(26, '2025-01-24 21:28:24.601343', '10', 'ahmed', 1, '[{\"added\": {}}]', 13, 15),
(27, '2025-01-24 21:31:31.104751', '1', 'غرفة - فنذق الاندلس', 1, '[{\"added\": {}}]', 19, 15),
(28, '2025-01-24 21:32:31.180397', '1', 'غرفة - فنذق الاندلس', 2, '[]', 19, 15),
(29, '2025-01-24 21:32:51.743982', '2', 'جناح - فنذق الاندلس', 1, '[{\"added\": {}}]', 19, 15),
(30, '2025-01-24 21:34:15.599426', '1', 'عادي (فنذق الاندلس)', 1, '[{\"added\": {}}]', 4, 15),
(31, '2025-01-24 21:35:22.725982', '1', 'متوفرة (1)', 1, '[{\"added\": {}}]', 22, 15),
(32, '2025-01-24 21:37:18.321123', '1', 'عادي - 100 (2025-01-24 إلى 2025-01-31)', 1, '[{\"added\": {}}]', 21, 15),
(33, '2025-01-24 21:38:53.388321', '1', 'عادي - إضافية', 1, '[{\"added\": {}}]', 20, 15),
(34, '2025-01-24 21:40:38.484366', '1', 'عادي - 2025-01-23 (2 غرفة متوفرة)', 1, '[{\"added\": {}}]', 18, 15),
(35, '2025-01-24 21:41:18.183304', '2', 'عادي - 2025-01-24 (1 غرفة متوفرة)', 1, '[{\"added\": {}}]', 18, 15),
(36, '2025-01-24 21:48:51.736720', '1', 'عادي - إضافية', 3, '', 20, 15),
(37, '2025-01-24 21:49:14.613069', '2', 'عادي - إضافية', 1, '[{\"added\": {}}]', 20, 15),
(38, '2025-01-24 21:49:24.574399', '2', 'عادي - رئيسية', 2, '[{\"changed\": {\"fields\": [\"\\u0635\\u0648\\u0631\\u0629 \\u0631\\u0626\\u064a\\u0633\\u064a\\u0629\"]}}]', 20, 15),
(39, '2025-01-25 19:27:29.418994', '1', 'غرفة عادي (فنذق الاندلس)', 2, '[{\"changed\": {\"fields\": [\"\\u0627\\u0633\\u0645 \\u0646\\u0648\\u0639 \\u0627\\u0644\\u063a\\u0631\\u0641\\u0629\"]}}]', 4, 15),
(40, '2025-01-25 19:30:18.936279', '1', 'غرفة عادي (فنذق الاندلس)', 3, '', 4, 15),
(41, '2025-01-25 19:36:23.837040', '1', 'متوفرة (1)', 3, '', 22, 15),
(42, '2025-01-25 19:45:12.443138', '2', 'جناح - فنذق الاندلس', 3, '', 19, 15),
(43, '2025-01-25 19:45:12.443138', '1', 'غرفة - فنذق الاندلس', 3, '', 19, 15),
(44, '2025-01-25 20:05:22.071423', '3', 'جناح - فنذق الاندلس', 1, '[{\"added\": {}}]', 19, 15),
(45, '2025-01-25 20:14:17.199807', '4', 'جناح - فنذق الاندلس', 1, '[{\"added\": {}}]', 19, 15),
(46, '2025-01-25 20:14:25.877415', '5', 'غرفة - فنذق الاندلس', 1, '[{\"added\": {}}]', 19, 15),
(47, '2025-01-25 20:14:34.814496', '6', 'شقة - فنذق الاندلس', 1, '[{\"added\": {}}]', 19, 15),
(48, '2025-01-25 20:24:34.962392', '4', 'جناح vip - فنذق الاندلس', 2, '[{\"changed\": {\"fields\": [\"\\u0627\\u0633\\u0645 \\u0627\\u0644\\u062a\\u0635\\u0646\\u064a\\u0641\"]}}]', 19, 15),
(49, '2025-01-25 20:24:41.462974', '6', 'شقة vip - فنذق الاندلس', 2, '[{\"changed\": {\"fields\": [\"\\u0627\\u0633\\u0645 \\u0627\\u0644\\u062a\\u0635\\u0646\\u064a\\u0641\"]}}]', 19, 15),
(50, '2025-01-25 20:24:45.913942', '5', 'غرفة vip - فنذق الاندلس', 2, '[{\"changed\": {\"fields\": [\"\\u0627\\u0633\\u0645 \\u0627\\u0644\\u062a\\u0635\\u0646\\u064a\\u0641\"]}}]', 19, 15),
(51, '2025-01-25 20:25:05.156451', '7', 'جناح عادي - فنذق الاندلس', 1, '[{\"added\": {}}]', 19, 15),
(52, '2025-01-25 20:25:38.591485', '7', 'جناح متوسط - فنذق الاندلس', 2, '[{\"changed\": {\"fields\": [\"\\u0627\\u0633\\u0645 \\u0627\\u0644\\u062a\\u0635\\u0646\\u064a\\u0641\"]}}]', 19, 15),
(53, '2025-01-25 20:26:04.057038', '7', 'جناح - فنذق الاندلس', 2, '[{\"changed\": {\"fields\": [\"\\u0627\\u0633\\u0645 \\u0627\\u0644\\u062a\\u0635\\u0646\\u064a\\u0641\"]}}]', 19, 15),
(54, '2025-01-25 20:26:15.288377', '8', 'غرفة - فنذق الاندلس', 1, '[{\"added\": {}}]', 19, 15),
(55, '2025-01-25 20:26:20.595017', '9', 'شقة - فنذق الاندلس', 1, '[{\"added\": {}}]', 19, 15),
(56, '2025-01-25 20:27:18.684004', '10', 'غرفة شخص واحد - فنذق الاندلس', 1, '[{\"added\": {}}]', 19, 15),
(57, '2025-01-25 20:27:26.348287', '11', 'غرفة شخصان - فنذق الاندلس', 1, '[{\"added\": {}}]', 19, 15),
(58, '2025-01-25 20:33:25.947870', '2', 'غرفة شخص (فنذق الاندلس)', 1, '[{\"added\": {}}]', 4, 15),
(59, '2025-01-25 20:34:17.200630', '3', 'غرفة شخصان (فنذق الاندلس)', 1, '[{\"added\": {}}]', 4, 15),
(60, '2025-01-25 20:36:03.473900', '10', 'ثنائي - فنذق الاندلس', 2, '[{\"changed\": {\"fields\": [\"\\u0627\\u0633\\u0645 \\u0627\\u0644\\u062a\\u0635\\u0646\\u064a\\u0641\"]}}]', 19, 15),
(61, '2025-01-25 20:36:30.135555', '11', 'شخصان - فنذق الاندلس', 2, '[{\"changed\": {\"fields\": [\"\\u0627\\u0633\\u0645 \\u0627\\u0644\\u062a\\u0635\\u0646\\u064a\\u0641\"]}}]', 19, 15),
(62, '2025-01-25 20:39:43.367938', '10', 'مفردة - فنذق الاندلس', 2, '[{\"changed\": {\"fields\": [\"\\u0627\\u0633\\u0645 \\u0627\\u0644\\u062a\\u0635\\u0646\\u064a\\u0641\"]}}]', 19, 15),
(63, '2025-01-25 20:39:54.747548', '11', 'مزدوجة - فنذق الاندلس', 2, '[{\"changed\": {\"fields\": [\"\\u0627\\u0633\\u0645 \\u0627\\u0644\\u062a\\u0635\\u0646\\u064a\\u0641\"]}}]', 19, 15),
(64, '2025-01-25 20:40:04.723564', '12', 'عائلية - فنذق الاندلس', 1, '[{\"added\": {}}]', 19, 15),
(65, '2025-01-25 20:40:18.990867', '4', 'جناح vip - فنذق الاندلس', 3, '', 19, 15),
(66, '2025-01-25 20:40:18.990867', '6', 'شقة vip - فنذق الاندلس', 3, '', 19, 15),
(67, '2025-01-25 20:40:18.990867', '5', 'غرفة vip - فنذق الاندلس', 3, '', 19, 15),
(68, '2025-01-25 20:42:16.066798', '8', 'قياسية - فنذق الاندلس', 2, '[{\"changed\": {\"fields\": [\"\\u0627\\u0633\\u0645 \\u0627\\u0644\\u062a\\u0635\\u0646\\u064a\\u0641\", \"\\u0648\\u0635\\u0641 \\u0627\\u0644\\u062a\\u0635\\u0646\\u064a\\u0641\"]}}]', 19, 15),
(69, '2025-01-25 20:42:24.382633', '7', 'جناح - فنذق الاندلس', 2, '[{\"changed\": {\"fields\": [\"\\u0648\\u0635\\u0641 \\u0627\\u0644\\u062a\\u0635\\u0646\\u064a\\u0641\"]}}]', 19, 15),
(70, '2025-01-25 20:42:32.839941', '9', 'شقة - فنذق الاندلس', 3, '', 19, 15),
(71, '2025-01-25 20:43:06.347747', '13', 'تنفيذية - فنذق الاندلس', 1, '[{\"added\": {}}]', 19, 15),
(72, '2025-01-25 20:43:22.948091', '14', 'ثلاثية - فنذق الاندلس', 1, '[{\"added\": {}}]', 19, 15),
(73, '2025-01-25 20:43:53.023216', '12', 'عائلية - فنذق الاندلس', 2, '[{\"changed\": {\"fields\": [\"\\u0648\\u0635\\u0641 \\u0627\\u0644\\u062a\\u0635\\u0646\\u064a\\u0641\"]}}]', 19, 15),
(74, '2025-01-25 20:43:58.977763', '14', 'ثلاثية - فنذق الاندلس', 3, '', 19, 15),
(75, '2025-01-25 20:44:20.579569', '15', 'ثلاثية - فنذق الاندلس', 1, '[{\"added\": {}}]', 19, 15),
(76, '2025-01-25 20:45:25.962222', '3', 'غرفة شخصان (فنذق الاندلس)', 3, '', 4, 15),
(77, '2025-01-25 20:45:25.962222', '2', 'غرفة شخص (فنذق الاندلس)', 3, '', 4, 15),
(78, '2025-01-25 20:45:40.927058', '13', 'تنفيذية - فنذق الاندلس', 3, '', 19, 15),
(79, '2025-01-25 20:45:40.927058', '15', 'ثلاثية - فنذق الاندلس', 3, '', 19, 15),
(80, '2025-01-25 20:45:40.927058', '7', 'جناح - فنذق الاندلس', 3, '', 19, 15),
(81, '2025-01-25 20:45:40.927058', '12', 'عائلية - فنذق الاندلس', 3, '', 19, 15),
(82, '2025-01-25 20:45:40.927058', '8', 'قياسية - فنذق الاندلس', 3, '', 19, 15),
(83, '2025-01-25 20:45:40.927058', '11', 'مزدوجة - فنذق الاندلس', 3, '', 19, 15),
(84, '2025-01-25 20:45:40.927058', '10', 'مفردة - فنذق الاندلس', 3, '', 19, 15),
(85, '2025-01-25 20:52:07.694871', '16', 'جناح - فنذق الاندلس', 1, '[{\"added\": {}}]', 19, 15),
(86, '2025-01-25 20:55:40.755089', '4', 'جناح صغير (فنذق الاندلس)', 1, '[{\"added\": {}}]', 4, 15),
(87, '2025-01-25 20:57:17.858256', '4', 'جناح صغير (فنذق الاندلس)', 3, '', 4, 15),
(88, '2025-01-25 21:04:30.238608', '5', 'جناح (فنذق الاندلس)', 1, '[{\"added\": {}}]', 4, 15),
(89, '2025-01-25 21:06:40.146997', '5', 'جناح (فنذق الاندلس)', 3, '', 4, 15),
(90, '2025-01-25 21:07:23.206763', '6', 'قياسية مفردة (فنذق الاندلس)', 1, '[{\"added\": {}}]', 4, 15),
(91, '2025-01-25 21:07:51.089522', '7', 'قياسية مزدوجة (فنذق الاندلس)', 1, '[{\"added\": {}}]', 4, 15),
(92, '2025-01-25 21:08:20.310488', '8', 'ديلوكس مفردة (فنذق الاندلس)', 1, '[{\"added\": {}}]', 4, 15),
(93, '2025-01-25 21:08:42.985015', '9', 'ديلوكس مزدوجة (فنذق الاندلس)', 1, '[{\"added\": {}}]', 4, 15),
(94, '2025-01-25 21:09:13.007590', '10', 'جناح صغير (فنذق الاندلس)', 1, '[{\"added\": {}}]', 4, 15),
(95, '2025-01-25 21:09:37.246734', '11', 'جناح عائلي (فنذق الاندلس)', 1, '[{\"added\": {}}]', 4, 15),
(96, '2025-01-25 21:10:00.185064', '12', 'غرفة مفردة اقتصادية (فنذق الاندلس)', 1, '[{\"added\": {}}]', 4, 15),
(97, '2025-01-25 21:10:22.248539', '13', 'غرفة مزدوجة اقتصادية (فنذق الاندلس)', 1, '[{\"added\": {}}]', 4, 15),
(98, '2025-01-25 21:10:47.241202', '14', 'غرفة ثلاثية (فنذق الاندلس)', 1, '[{\"added\": {}}]', 4, 15),
(99, '2025-01-25 21:11:13.167236', '15', 'غرفة عائلية قياسية (فنذق الاندلس)', 1, '[{\"added\": {}}]', 4, 15),
(100, '2025-01-25 21:11:43.523574', '16', 'غرفة بإطلالة على البحر (فنذق الاندلس)', 1, '[{\"added\": {}}]', 4, 15),
(101, '2025-01-25 21:12:13.854378', '17', 'غرفة رجال الأعمال (فنذق الاندلس)', 1, '[{\"added\": {}}]', 4, 15),
(102, '2025-01-25 21:15:11.771763', '2', 'غرفة بإطلالة على البحر - 300 (2025-01-25 إلى 2025-01-31)', 1, '[{\"added\": {}}]', 21, 15),
(103, '2025-01-25 21:20:41.653387', '2', 'محجوزة (1)', 1, '[{\"added\": {}}]', 22, 15),
(104, '2025-01-25 21:28:41.749244', '3', 'قياسية مفردة - رئيسية', 1, '[{\"added\": {}}]', 20, 15),
(105, '2025-01-25 21:41:07.706771', '4', 'غرفة بإطلالة على البحر - إضافية', 1, '[{\"added\": {}}]', 20, 15),
(106, '2025-01-25 21:41:24.627436', '5', 'غرفة رجال الأعمال - رئيسية', 1, '[{\"added\": {}}]', 20, 15),
(107, '2025-01-25 21:41:35.335621', '6', 'غرفة ثلاثية - رئيسية', 1, '[{\"added\": {}}]', 20, 15),
(108, '2025-01-25 21:41:44.112020', '7', 'غرفة ثلاثية - إضافية', 1, '[{\"added\": {}}]', 20, 15),
(109, '2025-01-25 21:41:52.629490', '8', 'جناح صغير - إضافية', 1, '[{\"added\": {}}]', 20, 15),
(110, '2025-01-25 21:42:00.008377', '9', 'جناح عائلي - إضافية', 1, '[{\"added\": {}}]', 20, 15),
(111, '2025-01-25 21:42:19.853695', '10', 'ديلوكس مزدوجة - إضافية', 1, '[{\"added\": {}}]', 20, 15),
(112, '2025-01-25 21:42:28.229617', '11', 'ديلوكس مفردة - إضافية', 1, '[{\"added\": {}}]', 20, 15),
(113, '2025-01-25 21:42:42.658377', '12', 'ديلوكس مفردة - إضافية', 1, '[{\"added\": {}}]', 20, 15),
(114, '2025-01-25 21:42:52.117808', '13', 'غرفة عائلية قياسية - إضافية', 1, '[{\"added\": {}}]', 20, 15),
(115, '2025-01-25 21:43:00.427828', '14', 'قياسية مزدوجة - إضافية', 1, '[{\"added\": {}}]', 20, 15),
(116, '2025-01-25 21:43:13.236898', '15', 'قياسية مفردة - إضافية', 1, '[{\"added\": {}}]', 20, 15),
(117, '2025-01-25 21:43:25.643137', '16', 'غرفة مزدوجة اقتصادية - إضافية', 1, '[{\"added\": {}}]', 20, 15),
(118, '2025-01-25 21:43:34.289019', '17', 'غرفة مفردة اقتصادية - إضافية', 1, '[{\"added\": {}}]', 20, 15),
(119, '2025-01-25 21:50:20.387463', '3', 'غرفة بإطلالة على البحر - 2025-01-25 (5 غرفة متوفرة)', 1, '[{\"added\": {}}]', 18, 15),
(120, '2025-01-25 21:51:15.452011', '3', 'غرفة بإطلالة على البحر - 2025-01-25 (5 غرفة متوفرة)', 3, '', 18, 15),
(121, '2025-01-27 14:25:29.408038', '1', 'sanaa, غامبيا', 2, '[{\"changed\": {\"fields\": [\"\\u0627\\u0644\\u0645\\u062d\\u0627\\u0641\\u0638\\u0629\"]}}]', 12, 14),
(122, '2025-01-27 14:30:15.338087', '2', 'ibb, yemen', 1, '[{\"added\": {}}]', 12, 14),
(123, '2025-01-27 14:34:18.202231', '10', 'ib jebla', 1, '[{\"added\": {}}]', 16, 14),
(124, '2025-01-27 14:39:46.791160', '9', 'فنذق الاندلس', 2, '[{\"changed\": {\"fields\": [\"\\u0645\\u0648\\u0642\\u0639 \\u0627\\u0644\\u0641\\u0646\\u062f\\u0642\"]}}]', 13, 14),
(125, '2025-01-27 14:52:43.282340', '11', 'hotels/images/img5.jpg', 1, '[{\"added\": {}}]', 15, 14),
(126, '2025-01-27 14:56:12.768594', '12', 'hotels/images/img31.jpg', 1, '[{\"added\": {}}]', 15, 14),
(127, '2025-01-27 15:05:05.367852', '13', 'hotels/images/img29_GK1LPzc.jpg', 1, '[{\"added\": {}}]', 15, 14),
(128, '2025-01-27 15:08:39.760749', '10', 'hotels/images/ShopApp3.png', 3, '', 15, 14),
(129, '2025-01-27 15:08:39.760749', '9', 'hotels/images/ShopApp3.png', 3, '', 15, 14),
(130, '2025-01-27 15:08:39.760749', '8', 'hotels/images/ShopApp3.png', 3, '', 15, 14),
(131, '2025-01-27 15:08:39.760749', '7', 'hotels/images/ShopApp3.png', 3, '', 15, 14),
(132, '2025-01-27 15:08:55.216698', '14', 'hotels/images/Pngtreesmart_home_3d_illustration_14591663.png', 1, '[{\"added\": {}}]', 15, 14),
(133, '2025-01-27 15:10:15.994038', '18', 'غرفة رجال الأعمال - إضافية', 1, '[{\"added\": {}}]', 20, 14),
(134, '2025-02-04 07:47:27.745834', '10', 'غرفة بإطلالة على البحر - 5000 (2025-01-25 إلى 2025-01-31)', 2, '[{\"changed\": {\"fields\": [\"\\u0627\\u0644\\u0633\\u0639\\u0631\"]}}]', 21, 15);

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
(35, 'blog', 'category'),
(36, 'blog', 'comment'),
(34, 'blog', 'post'),
(5, 'bookings', 'booking'),
(23, 'bookings', 'bookingdetail'),
(24, 'bookings', 'bookingstatus'),
(25, 'bookings', 'guest'),
(9, 'contenttypes', 'contenttype'),
(12, 'HotelManagement', 'city'),
(13, 'HotelManagement', 'hotel'),
(14, 'HotelManagement', 'hotelrequest'),
(15, 'HotelManagement', 'image'),
(16, 'HotelManagement', 'location'),
(17, 'HotelManagement', 'phone'),
(26, 'payments', 'currency'),
(27, 'payments', 'hotelpaymentmethod'),
(28, 'payments', 'payment'),
(29, 'payments', 'paymentoption'),
(30, 'reviews', 'hotelreview'),
(31, 'reviews', 'offer'),
(32, 'reviews', 'roomreview'),
(18, 'rooms', 'availability'),
(19, 'rooms', 'category'),
(20, 'rooms', 'roomimage'),
(21, 'rooms', 'roomprice'),
(22, 'rooms', 'roomstatus'),
(4, 'rooms', 'roomtype'),
(33, 'services', 'offer'),
(6, 'services', 'service'),
(10, 'sessions', 'session'),
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
(1, 'contenttypes', '0001_initial', '2025-01-24 15:25:17.971226'),
(2, 'contenttypes', '0002_remove_content_type_name', '2025-01-24 15:25:18.064887'),
(3, 'auth', '0001_initial', '2025-01-24 15:25:18.357182'),
(4, 'auth', '0002_alter_permission_name_max_length', '2025-01-24 15:25:18.421485'),
(5, 'auth', '0003_alter_user_email_max_length', '2025-01-24 15:25:18.433640'),
(6, 'auth', '0004_alter_user_username_opts', '2025-01-24 15:25:18.444123'),
(7, 'auth', '0005_alter_user_last_login_null', '2025-01-24 15:25:18.457214'),
(8, 'auth', '0006_require_contenttypes_0002', '2025-01-24 15:25:18.465560'),
(9, 'auth', '0007_alter_validators_add_error_messages', '2025-01-24 15:25:18.476423'),
(10, 'auth', '0008_alter_user_username_max_length', '2025-01-24 15:25:18.489824'),
(11, 'auth', '0009_alter_user_last_name_max_length', '2025-01-24 15:25:18.507684'),
(12, 'auth', '0010_alter_group_name_max_length', '2025-01-24 15:25:18.556134'),
(13, 'auth', '0011_update_proxy_permissions', '2025-01-24 15:25:18.573845'),
(14, 'auth', '0012_alter_user_first_name_max_length', '2025-01-24 15:25:18.590706'),
(15, 'users', '0001_initial', '2025-01-24 15:25:19.126222'),
(16, 'HotelManagement', '0001_initial', '2025-01-24 15:25:19.297037'),
(17, 'HotelManagement', '0002_initial', '2025-01-24 15:25:20.865598'),
(18, 'admin', '0001_initial', '2025-01-24 15:25:21.042182'),
(19, 'admin', '0002_logentry_remove_auto_add', '2025-01-24 15:25:21.063343'),
(20, 'admin', '0003_logentry_add_action_flag_choices', '2025-01-24 15:25:21.092124'),
(21, 'services', '0001_initial', '2025-01-24 15:25:21.150423'),
(22, 'rooms', '0001_initial', '2025-01-24 15:25:21.291869'),
(23, 'bookings', '0001_initial', '2025-01-24 15:25:21.396905'),
(24, 'bookings', '0002_initial', '2025-01-24 15:25:22.807864'),
(25, 'payments', '0001_initial', '2025-01-24 15:25:22.897928'),
(26, 'payments', '0002_initial', '2025-01-24 15:25:23.615522'),
(27, 'reviews', '0001_initial', '2025-01-24 15:25:23.703016'),
(28, 'reviews', '0002_initial', '2025-01-24 15:25:25.707539'),
(29, 'rooms', '0002_initial', '2025-01-24 15:25:28.523152'),
(30, 'services', '0002_initial', '2025-01-24 15:25:29.228927'),
(31, 'sessions', '0001_initial', '2025-01-24 15:25:29.306191'),
(32, 'blog', '0001_initial', '2025-01-24 16:44:56.157579');

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
('925aehoyu9oyxxw7ir8qv4sye0wyh0oc', '.eJxVjE0OwiAYBe_C2hAoBYpL956BfH-VqqFJaVfGu2uTLnT7Zua9VIZtLXlrsuSJ1VlZr06_IwI9pO6E71Bvs6a5rsuEelf0QZu-zizPy-H-HRRo5VuTCwCCYxy84dHFvhOPPSQbYkwGB8EESQw7NEypA4ZIyQciIOskkHp_ACcHOSc:1tblZG:BP-72vA_Ja074bTFm36o82JcDGI8sMHPGj4bz1x-aqw', '2025-02-08 19:11:42.482164'),
('b9ls7cofgkvr2xxp7e9oazmnlrkroryu', '.eJxVjE0OwiAYBe_C2hAoBYpL956BfH-VqqFJaVfGu2uTLnT7Zua9VIZtLXlrsuSJ1VlZr06_IwI9pO6E71Bvs6a5rsuEelf0QZu-zizPy-H-HRRo5VuTCwCCYxy84dHFvhOPPSQbYkwGB8EESQw7NEypA4ZIyQciIOskkHp_ACcHOSc:1tbmBu:WN6wWQ2uNZBz-uWtzWKsAjxl0492Z3wI3GQe2ohYDL4', '2025-02-08 19:51:38.266224'),
('hf2rrrg8dupwchv50wzg0jc1ety65vl8', '.eJxVjDsOwjAQBe_iGlkOXn9CSZ8zRN71Lg6gWIqTCnF3iJQC2jcz76XGtK1l3Bov45TVRXWgTr8jJnrwvJN8T_Otaqrzukyod0UftOmhZn5eD_fvoKRWvjVKh-QIey99htQZ64RBYnIRgJF8RGuC8aEniQ6FAhuXwRlgsfEM6v0BKZg4dQ:1tbREZ:T8VC2vC5k_0W8q86r1KnBRiZGkYR01Wr3dtvqh09-Ss', '2025-02-07 21:28:59.098998'),
('ivu4pk1ra0u3oh3k07qug56qsx4hgnb4', '.eJxVjDsOwjAQBe_iGlkOXn9CSZ8zRN71Lg6gWIqTCnF3iJQC2jcz76XGtK1l3Bov45TVRXWgTr8jJnrwvJN8T_Otaqrzukyod0UftOmhZn5eD_fvoKRWvjVKh-QIey99htQZ64RBYnIRgJF8RGuC8aEniQ6FAhuXwRlgsfEM6v0BKZg4dQ:1tcQ2u:QqhxhyGO-cmijlFhaksaeT1DyB4zeS0y1zpw84IwpEk', '2025-02-10 14:25:00.661840'),
('m5fkr69btrvap7dezu5ue7h7ht3sjh4m', '.eJxVjDsOwjAQBe_iGlneLPGHkj5niNbeNQ4gW8qnQtwdIqWA9s3Me6mRtrWM2yLzOLG6KFCn3y1SekjdAd-p3ppOra7zFPWu6IMuemgsz-vh_h0UWsq3RkQTjXFMEQWcDZhsys4TWi-O5dwBxhwIQvBRwAoycNeDQDa5z6LeH9fBOAA:1tbOZ4:zkPD2f-6y7RdIKA4pU_54W1wqaGxWF4qOVJwpSzHPos', '2025-02-07 18:37:58.377469');

-- --------------------------------------------------------

--
-- Table structure for table `hotelmanagement_city`
--

CREATE TABLE `hotelmanagement_city` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `slug` varchar(255) NOT NULL,
  `state` varchar(255) NOT NULL,
  `country` varchar(255) NOT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `hotelmanagement_city`
--

INSERT INTO `hotelmanagement_city` (`id`, `created_at`, `updated_at`, `deleted_at`, `slug`, `state`, `country`, `created_by_id`, `updated_by_id`) VALUES
(1, '2025-01-24 15:28:33.564821', '2025-01-27 14:25:29.408038', NULL, '', 'sanaa', 'غامبيا', NULL, NULL),
(2, '2025-01-27 14:30:15.331097', '2025-01-27 14:30:15.331097', NULL, 'ibb', 'ibb', 'yemen', NULL, NULL);

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
  `profile_picture` varchar(100) DEFAULT NULL,
  `description` longtext NOT NULL,
  `business_license_number` varchar(50) DEFAULT NULL,
  `document_path` varchar(100) DEFAULT NULL,
  `is_verified` tinyint(1) NOT NULL,
  `verification_date` datetime(6) DEFAULT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `manager_id` bigint(20) DEFAULT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL,
  `location_id` bigint(20) NOT NULL,
  `slug` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `hotelmanagement_hotel`
--

INSERT INTO `hotelmanagement_hotel` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `profile_picture`, `description`, `business_license_number`, `document_path`, `is_verified`, `verification_date`, `created_by_id`, `manager_id`, `updated_by_id`, `location_id`, `slug`) VALUES
(7, '2025-01-24 17:18:31.115705', '2025-01-24 17:18:31.115705', NULL, 'dfd', 'hotel_requests/profile_pictures/ammarcv_SeMlNwt.png', 'aaa', 'hgkfvhs', 'hotel_requests/documents/2025/01/24/ammarcv_37HlCAc.png', 1, '2025-01-24 17:18:31.112107', 1, 12, NULL, 7, ''),
(9, '2025-01-24 20:33:09.333469', '2025-01-27 14:39:46.789100', NULL, 'فنذق الاندلس', 'hotel_requests/profile_pictures/ShopApp2_ZvuMXOo.jpg', 'جديد', '212222457558a', 'hotel_requests/documents/2025/01/24/IT-cyber-com-_practical_ex_2_2024__2025_m7GL83i.pdf', 1, '2025-01-24 20:33:09.000000', 14, 15, NULL, 10, ''),
(10, '2025-01-24 21:28:24.601343', '2025-01-24 21:28:24.601343', NULL, 'ahmed', 'hotels/images/logo_1.png', 'jj', NULL, '', 0, NULL, NULL, NULL, NULL, 1, '');

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

--
-- Dumping data for table `hotelmanagement_hotelrequest`
--

INSERT INTO `hotelmanagement_hotelrequest` (`id`, `name`, `email`, `role`, `hotel_name`, `description`, `profile_picture`, `business_license_number`, `document_path`, `additional_images`, `country`, `state`, `city_name`, `address`, `country_code`, `phone_number`, `is_approved`, `approved_at`, `created_at`, `updated_at`, `approved_by_id`, `created_by_id`, `updated_by_id`) VALUES
(1, 'فندق النبراس', 'raghatube@gmail.com', 'مدير فندق', 'dfd', 'aaa', 'hotel_requests/profile_pictures/ammarcv_SeMlNwt.png', 'hgkfvhs', 'hotel_requests/documents/2025/01/24/ammarcv_37HlCAc.png', '\"[{\\\"image_path\\\": \\\"hotels/images/ammarcv.png\\\"}]\"', 'غامبيا', '-', 'صنعاء', 'الستين', 'اليمن', '0777782439', 1, '2025-01-24 17:18:31.138308', '2025-01-24 15:28:33.596814', '2025-01-24 17:18:31.138308', 1, NULL, 1),
(3, 'Motasam', 'motasamdv@gmail.com', 'مالك', 'فنذق الاندلس', 'جديد', 'hotel_requests/profile_pictures/ShopApp2_ZvuMXOo.jpg', '212222457558a', 'hotel_requests/documents/2025/01/24/IT-cyber-com-_practical_ex_2_2024__2025_m7GL83i.pdf', '\"[{\\\"image_path\\\": \\\"hotels/images/ShopApp7.webp\\\"}, {\\\"image_path\\\": \\\"hotels/images/ShopApp3.png\\\"}, {\\\"image_path\\\": \\\"hotels/images/ShopApp2.jpg\\\"}]\"', 'غامبيا', '-', '', 'sana', '77777', '777777', 1, '2025-01-24 20:33:09.353079', '2025-01-24 20:32:37.419403', '2025-01-24 20:33:09.353079', 14, NULL, NULL);

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
(11, '2025-01-27 14:52:43.274182', '2025-01-27 14:52:43.274182', NULL, 'hotels/images/img5.jpg', 'asd', NULL, 9, 14),
(12, '2025-01-27 14:56:12.758733', '2025-01-27 14:56:12.758733', NULL, 'hotels/images/img31.jpg', 'as', NULL, 7, 14),
(13, '2025-01-27 15:05:05.363965', '2025-01-27 15:05:05.363965', NULL, 'hotels/images/img29_GK1LPzc.jpg', 'as', NULL, 9, 14),
(14, '2025-01-27 15:08:55.203438', '2025-01-27 15:08:55.204374', NULL, 'hotels/images/Pngtreesmart_home_3d_illustration_14591663.png', 'as', NULL, 9, 14);

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
(1, '2025-01-24 15:28:50.294590', '2025-01-24 15:28:50.294590', NULL, 'الستين', 1, 1, NULL),
(2, '2025-01-24 15:36:55.578583', '2025-01-24 15:36:55.578583', NULL, 'الستين', 1, 1, NULL),
(3, '2025-01-24 15:38:50.042785', '2025-01-24 15:38:50.043050', NULL, 'الستين', 1, 1, NULL),
(4, '2025-01-24 15:42:05.429756', '2025-01-24 15:42:05.429756', NULL, 'الستين', 1, 1, NULL),
(5, '2025-01-24 15:48:50.647349', '2025-01-24 15:48:50.647349', NULL, 'الستين', 1, 1, NULL),
(6, '2025-01-24 15:55:19.971604', '2025-01-24 15:55:19.971604', NULL, 'الستين', 1, 1, NULL),
(7, '2025-01-24 17:18:31.105875', '2025-01-24 17:18:31.105875', NULL, 'الستين', 1, 1, NULL),
(8, '2025-01-24 17:18:33.252143', '2025-01-24 17:18:33.252143', NULL, 'الستين', 1, 1, NULL),
(9, '2025-01-24 20:33:09.330511', '2025-01-24 20:33:09.330511', NULL, 'sana', 1, 14, NULL),
(10, '2025-01-27 14:34:18.198320', '2025-01-27 14:34:18.198320', NULL, 'ib jebla', 2, NULL, 14);

-- --------------------------------------------------------

--
-- Table structure for table `hotelmanagement_phone`
--

CREATE TABLE `hotelmanagement_phone` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `slug` varchar(255) NOT NULL,
  `phone_number` varchar(10) NOT NULL,
  `country_code` varchar(5) NOT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `hotel_id` bigint(20) NOT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `hotelmanagement_phone`
--

INSERT INTO `hotelmanagement_phone` (`id`, `created_at`, `updated_at`, `deleted_at`, `slug`, `phone_number`, `country_code`, `created_by_id`, `hotel_id`, `updated_by_id`) VALUES
(7, '2025-01-24 17:18:31.124052', '2025-01-24 17:18:31.124052', NULL, '0777782439', '0777782439', 'اليمن', 1, 7, NULL),
(8, '2025-01-24 20:33:09.338457', '2025-01-24 20:33:09.338457', NULL, '777777', '777777', '77777', 14, 9, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `payments_currency`
--

CREATE TABLE `payments_currency` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `slug` varchar(255) NOT NULL,
  `currency_name` varchar(50) NOT NULL,
  `currency_symbol` varchar(10) NOT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `hotel_id` bigint(20) NOT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

-- --------------------------------------------------------

--
-- Table structure for table `reviews_offer`
--

CREATE TABLE `reviews_offer` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `slug` varchar(255) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` longtext NOT NULL,
  `start_date` date NOT NULL,
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
  `slug` varchar(255) DEFAULT NULL,
  `date` date NOT NULL,
  `available_rooms` int(10) UNSIGNED NOT NULL CHECK (`available_rooms` >= 0),
  `price` decimal(10,2) NOT NULL,
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

INSERT INTO `rooms_availability` (`id`, `created_at`, `updated_at`, `deleted_at`,  `notes`, `created_by_id`, `hotel_id`, `updated_by_id`, `room_status_id`, `room_type_id`) VALUES
(1, '2025-01-26 00:56:03.000000', '2025-01-26 00:56:03.000000', NULL,  NULL, 15, 9, 15, 2, 6),
(2, '2025-01-26 00:56:03.000000', '2025-01-26 00:56:03.000000', NULL,  NULL, 15, 9, 15, 2, 7),
(3, '2025-01-26 00:56:03.000000', '2025-01-26 00:56:03.000000', NULL, NULL, 15, 9, 15, 2, 8),
(4, '2025-01-26 00:56:03.000000', '2025-01-26 00:56:03.000000', NULL,  NULL, 15, 9, 15, 2, 9),
(5, '2025-01-26 00:56:03.000000', '2025-01-26 00:56:03.000000', NULL,  NULL, 15, 9, 15, 2, 10),
(6, '2025-01-26 00:56:03.000000', '2025-01-26 00:56:03.000000', NULL,  NULL, 15, 9, 15, 2, 11),
(7, '2025-01-26 00:56:03.000000', '2025-01-26 00:56:03.000000', NULL,  NULL, 15, 9, 15, 2, 12),
(8, '2025-01-26 00:56:03.000000', '2025-01-26 00:56:03.000000', NULL,  NULL, 15, 9, 15, 2, 13),
(9, '2025-01-26 00:56:03.000000', '2025-01-26 00:56:03.000000', NULL,  NULL, 15, 9, 15, 2, 14),
(10, '2025-01-26 00:56:03.000000', '2025-01-26 00:56:03.000000', NULL, NULL, 15, 9, 15, 2, 15),
(11, '2025-01-26 00:56:03.000000', '2025-01-26 00:56:03.000000', NULL, NULL, 15, 9, 15, 2, 16),
(12, '2025-01-26 00:56:03.000000', '2025-01-26 00:56:03.000000', NULL, NULL, 15, 9, 15, 2, 17);

-- --------------------------------------------------------

--
-- Table structure for table `rooms_category`
--

CREATE TABLE `rooms_category` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `description` longtext DEFAULT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `hotel_id` bigint(20) NOT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rooms_category`
--

INSERT INTO `rooms_category` (`id`, `created_at`, `updated_at`, `deleted_at`, `slug`, `name`, `description`, `created_by_id`, `hotel_id`, `updated_by_id`) VALUES
(1, '2025-01-25 23:53:59.000000', '2025-01-25 23:53:59.000000', NULL, NULL, 'قياسية', 'غرف ذات خدمات أساسية مريحة للمسافرين', 15, 9, 15),
(2, '2025-01-25 23:53:59.000000', '2025-01-25 23:53:59.000000', NULL, NULL, 'ديلوكس', 'غرف بمستوى أعلى من الراحة والخدمات', 15, 9, 15),
(4, '2025-01-25 23:53:59.000000', '2025-01-25 23:53:59.000000', NULL, NULL, 'مفردة', 'غرف اقتصادية للمسافرين الفرديين', 15, 9, 15),
(5, '2025-01-25 23:53:59.000000', '2025-01-25 23:53:59.000000', NULL, NULL, 'مزدوجة', 'غرف بسريرين تناسب شخصين', 15, 9, 15),
(6, '2025-01-25 23:53:59.000000', '2025-01-25 23:53:59.000000', NULL, NULL, 'ثلاثية', 'غرف بثلاثة أسرة تناسب المجموعات الصغيرة', 15, 9, 15),
(7, '2025-01-25 23:53:59.000000', '2025-01-25 23:53:59.000000', NULL, NULL, 'عائلية', 'غرف واسعة تناسب العائلات والأطفال', 15, 9, 15),
(8, '2025-01-25 23:53:59.000000', '2025-01-25 23:53:59.000000', NULL, NULL, 'بانورامية', 'غرف بإطلالات خلابة على البحر أو المدينة', 15, 9, 15),
(9, '2025-01-25 23:53:59.000000', '2025-01-25 23:53:59.000000', NULL, NULL, 'تنفيذية', 'غرف مجهزة لرجال الأعمال بمكاتب ومرافق حديثة', 15, 9, 15),
(16, '2025-01-25 20:52:07.693872', '2025-01-25 20:52:07.693872', NULL, NULL, 'جناح', 'جناح فاخر يحتوي على غرفة نوم ومنطقة جلوس منفصلة، مثالي للعائلات.', 15, 9, 15);

-- --------------------------------------------------------

--
-- Table structure for table `rooms_roomimage`
--

CREATE TABLE `rooms_roomimage` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
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

INSERT INTO `rooms_roomimage` (`id`, `created_at`, `updated_at`, `deleted_at`, `slug`, `image`, `is_main`, `caption`, `created_by_id`, `hotel_id`, `updated_by_id`, `room_type_id`) VALUES
(4, '2025-01-25 21:41:07.704807', '2025-01-25 21:41:07.704807', NULL, NULL, 'room_images/img31_1.jpg', 0, NULL, 15, 9, 15, 16),
(5, '2025-01-25 21:41:24.621779', '2025-01-25 21:41:24.621779', NULL, NULL, 'room_images/img32.jpg', 1, NULL, 15, 9, 15, 17),
(6, '2025-01-25 21:41:35.332306', '2025-01-25 21:41:35.332306', NULL, NULL, 'room_images/img32_8bTxV5E.jpg', 1, NULL, 15, 9, 15, 14),
(7, '2025-01-25 21:41:44.110058', '2025-01-25 21:41:44.110058', NULL, NULL, 'room_images/img30.jpg', 0, NULL, 15, 9, 15, 14),
(8, '2025-01-25 21:41:52.627494', '2025-01-25 21:41:52.627494', NULL, NULL, 'room_images/img29.jpg', 0, NULL, 15, 9, 15, 10),
(9, '2025-01-25 21:42:00.005138', '2025-01-25 21:42:00.005138', NULL, NULL, 'room_images/img29_KInOwGv.jpg', 0, NULL, 15, 9, 15, 11),
(10, '2025-01-25 21:42:19.850693', '2025-01-25 21:42:19.850693', NULL, NULL, 'room_images/img29_GunOUow.jpg', 0, NULL, 15, 9, 15, 9),
(11, '2025-01-25 21:42:28.227623', '2025-01-25 21:42:28.227623', NULL, NULL, 'room_images/img31.jpg', 0, NULL, 15, 9, 15, 8),
(12, '2025-01-25 21:42:42.655101', '2025-01-25 21:42:42.655101', NULL, NULL, 'room_images/img31_1_AN1dG4b.jpg', 0, NULL, 15, 9, 15, 8),
(13, '2025-01-25 21:42:52.115504', '2025-01-25 21:42:52.115504', NULL, NULL, 'room_images/img32_Rch0Dy1.jpg', 0, NULL, 15, 9, 15, 15),
(14, '2025-01-25 21:43:00.423519', '2025-01-25 21:43:00.423519', NULL, NULL, 'room_images/img31_nR0xROo.jpg', 0, NULL, 15, 9, 15, 7),
(15, '2025-01-25 21:43:13.232892', '2025-01-25 21:43:13.232892', NULL, NULL, 'room_images/img29_dZlCbWn.jpg', 0, NULL, 15, 9, 15, 6),
(16, '2025-01-25 21:43:25.641139', '2025-01-25 21:43:25.641139', NULL, NULL, 'room_images/img32_Ymxnjo1.jpg', 0, NULL, 15, 9, 15, 13),
(17, '2025-01-25 21:43:34.285751', '2025-01-25 21:43:34.285751', NULL, NULL, 'room_images/img31_1_69lhEU4.jpg', 0, NULL, 15, 9, 15, 12),
(18, '2025-01-27 15:10:15.977519', '2025-01-27 15:10:15.977519', NULL, NULL, 'room_images/img32_oEKTWAi.jpg', 0, 'asd', NULL, 9, NULL, 17);

-- --------------------------------------------------------

--
-- Table structure for table `rooms_roomprice`
--

CREATE TABLE `rooms_roomprice` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
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

INSERT INTO `rooms_roomprice` (`id`, `created_at`, `updated_at`, `deleted_at`, `slug`, `date_from`, `date_to`, `price`, `is_special_offer`, `created_by_id`, `hotel_id`, `updated_by_id`, `room_type_id`) VALUES
(1, '2025-01-26 00:19:30.000000', '2025-01-26 00:19:30.000000', NULL, NULL, '2025-01-25', '2025-01-31', '300.00', 0, 15, 9, 15, 6),
(2, '2025-01-26 00:19:30.000000', '2025-01-26 00:19:30.000000', NULL, NULL, '2025-01-25', '2025-01-31', '400.00', 1, 15, 9, 15, 7),
(3, '2025-01-26 00:19:30.000000', '2025-01-26 00:19:30.000000', NULL, NULL, '2025-01-25', '2025-01-31', '500.00', 0, 15, 9, 15, 9),
(4, '2025-01-26 00:19:30.000000', '2025-01-26 00:19:30.000000', NULL, NULL, '2025-01-25', '2025-01-31', '250.00', 1, 15, 9, 15, 10),
(5, '2025-01-26 00:19:30.000000', '2025-01-26 00:19:30.000000', NULL, NULL, '2025-01-25', '2025-01-31', '600.00', 0, 15, 9, 15, 11),
(6, '2025-01-26 00:19:30.000000', '2025-01-26 00:19:30.000000', NULL, NULL, '2025-01-25', '2025-01-31', '150.00', 1, 15, 9, 15, 12),
(7, '2025-01-26 00:19:30.000000', '2025-01-26 00:19:30.000000', NULL, NULL, '2025-01-25', '2025-01-31', '200.00', 0, 15, 9, 15, 13),
(8, '2025-01-26 00:19:30.000000', '2025-01-26 00:19:30.000000', NULL, NULL, '2025-01-25', '2025-01-31', '180.00', 1, 15, 9, 15, 14),
(9, '2025-01-26 00:19:30.000000', '2025-01-26 00:19:30.000000', NULL, NULL, '2025-01-25', '2025-01-31', '220.00', 0, 15, 9, 15, 15),
(10, '2025-01-26 00:19:30.000000', '2025-02-04 07:47:27.733755', NULL, NULL, '2025-01-25', '2025-01-31', '5000.00', 1, 15, 9, 15, 16);

-- --------------------------------------------------------

--
-- Table structure for table `rooms_roomstatus`
--

CREATE TABLE `rooms_roomstatus` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
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

INSERT INTO `rooms_roomstatus` (`id`, `created_at`, `updated_at`, `deleted_at`, `slug`, `code`, `name`, `description`, `is_available`, `created_by_id`, `hotel_id`, `updated_by_id`) VALUES
(1, '2025-01-26 00:25:00.000000', '2025-01-26 00:25:00.000000', NULL, NULL, '1', 'محجوزة', 'الغرفة محجوزة حالياً.', 0, 15, 9, 15),
(2, '2025-01-26 00:25:00.000000', '2025-01-26 00:25:00.000000', NULL, NULL, '2', 'شاغرة', 'الغرفة شاغرة وجاهزة للإقامة.', 1, 15, 9, 15),
(3, '2025-01-26 00:25:00.000000', '2025-01-26 00:25:00.000000', NULL, NULL, '3', 'تحت الصيانة', 'الغرفة حالياً قيد الصيانة.', 0, 15, 9, 15),
(4, '2025-01-26 00:25:00.000000', '2025-01-26 00:25:00.000000', NULL, NULL, '4', 'غير متوفرة', 'الغرفة غير متوفرة للحجز.', 0, 15, 9, 15);

-- --------------------------------------------------------

--
-- Table structure for table `rooms_roomtype`
--

CREATE TABLE `rooms_roomtype` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
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

INSERT INTO `rooms_roomtype` (`id`, `created_at`, `updated_at`, `deleted_at`, `slug`, `name`, `description`, `default_capacity`, `max_capacity`, `beds_count`, `rooms_count`, `base_price`, `is_active`, `category_id`, `created_by_id`, `hotel_id`, `updated_by_id`) VALUES
(6, '2025-01-25 21:07:23.204769', '2025-01-25 21:07:23.204769', NULL, NULL, 'قياسية مفردة', 'غرفة قياسية بسرير مفرد تناسب المسافرين الفرديين', 1, 1, 1, 10, '50.00', 1, 1, 15, 9, 15),
(7, '2025-01-25 21:07:51.088530', '2025-01-25 21:07:51.088530', NULL, NULL, 'قياسية مزدوجة', 'غرفة قياسية بسرير مزدوج، مريحة لشخصين', 2, 2, 1, 20, '80.00', 1, 1, 15, 9, 15),
(8, '2025-01-25 21:08:20.309490', '2025-01-25 21:08:20.309490', NULL, NULL, 'ديلوكس مفردة', 'غرفة ديلوكس بسرير مفرد مع وسائل راحة إضافية.', 1, 1, 1, 8, '100.00', 1, 2, 15, 9, 15),
(9, '2025-01-25 21:08:42.984346', '2025-01-25 21:08:42.984346', NULL, NULL, 'ديلوكس مزدوجة', 'غرفة ديلوكس بسرير مزدوج مع إطلالة جميلة.', 2, 2, 1, 15, '150.00', 1, 2, 15, 9, 15),
(10, '2025-01-25 21:09:13.005595', '2025-01-25 21:09:13.005595', NULL, NULL, 'جناح صغير', 'جناح فاخر صغير بغرفة نوم ومنطقة جلوس.', 2, 4, 1, 5, '250.00', 1, 16, 15, 9, 15),
(11, '2025-01-25 21:09:37.245747', '2025-01-25 21:09:37.245747', NULL, NULL, 'جناح عائلي', 'جناح فاخر للعائلات بغرفتي نوم ومنطقة جلوس.', 4, 6, 3, 3, '400.00', 1, 16, 15, 9, 15),
(12, '2025-01-25 21:10:00.184073', '2025-01-25 21:10:00.184073', NULL, NULL, 'غرفة مفردة اقتصادية', 'غرفة صغيرة بسرير مفرد تناسب السفر الاقتصادي.', 1, 1, 1, 10, '40.00', 1, 4, 15, 9, 15),
(13, '2025-01-25 21:10:22.247579', '2025-01-25 21:10:22.247579', NULL, NULL, 'غرفة مزدوجة اقتصادية', 'غرفة بسريرين مفردين مناسبة لشخصين.', 2, 2, 2, 12, '70.00', 1, 5, 15, 9, 15),
(14, '2025-01-25 21:10:47.240490', '2025-01-25 21:10:47.240490', NULL, NULL, 'غرفة ثلاثية', 'غرفة بثلاثة أسرة مفردة، مناسبة للمجموعات الصغيرة.', 3, 3, 3, 7, '120.00', 1, 6, 15, 9, 15),
(15, '2025-01-25 21:11:13.166104', '2025-01-25 21:11:13.166104', NULL, NULL, 'غرفة عائلية قياسية', 'غرفة واسعة للعائلات تحتوي على أسرة إضافية ومساحة كافية للأطفال.', 4, 6, 4, 5, '200.00', 1, 7, 15, 9, 15),
(16, '2025-01-25 21:11:43.522561', '2025-01-25 21:11:43.522561', NULL, NULL, 'غرفة بإطلالة على البحر', 'غرفة تطل مباشرة على البحر مع وسائل راحة ممتازة.', 2, 3, 1, 6, '180.00', 1, 8, 15, 9, 15),
(17, '2025-01-25 21:12:13.853380', '2025-01-25 21:12:13.853380', NULL, NULL, 'غرفة رجال الأعمال', 'غرفة مجهزة برجال الأعمال مع مكتب عمل ومرافق حديثة.', 2, 2, 1, 4, '220.00', 1, 9, 15, 9, 15);

-- --------------------------------------------------------

--
-- Table structure for table `services_service`
--

CREATE TABLE `services_service` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `slug` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `additional_fee` double DEFAULT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `hotel_id` bigint(20) DEFAULT NULL,
  `room_id` bigint(20) DEFAULT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
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
  `slug` varchar(255) NOT NULL,
  `offer_name` varchar(100) NOT NULL,
  `offer_description` longtext NOT NULL,
  `offer_start_date` date NOT NULL,
  `offer_end_date` date NOT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `hotel_id_id` bigint(20) NOT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
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
(1, 'admin', '2025-01-24 18:37:58.371435', 1, 'admin', '', '', '', 1, '2025-01-24 15:25:57.607666', '2025-01-24 15:25:58.597704', '2025-01-24 15:25:58.597704', '', '', '', 1, NULL),
(9, 'pbkdf2_sha256$870000$3F4KmUOAbfXgOVK5Hj8fWU$zAqx8IW8Gan8LwochUM/plc3Uv7Cg0btOf0KBf49O/k=', '2025-01-24 16:51:58.469657', 0, 'a', '', '', 'AarIT@gmail.com', 0, '2025-01-24 16:51:57.404603', '2025-01-24 16:51:58.442261', '2025-01-24 16:51:58.442261', '', '', '', 1, NULL),
(10, 'pbkdf2_sha256$870000$5XwCwmelsMSDdB2OfcpDRP$UKolmI/s8ch3jTPRavmpotpmUa/ANYKs/yhrf0gwQLU=', '2025-01-24 16:53:56.033244', 0, 'cxcali', '', '', 'amvvmar@test.com', 0, '2025-01-24 16:53:54.460594', '2025-01-24 16:53:55.984737', '2025-01-24 16:53:55.984737', '', '', '', 1, NULL),
(11, 'pbkdf2_sha256$870000$C30b0iWB4DdU9XhKUv2oLP$rEcmmM1yROnVPb3XN2MjPsQWRDT8J9VMY+t5SAopOF8=', '2025-01-24 18:17:51.068686', 0, 'ddd', '', '', 'mmarIT@gmail.com', 1, '2025-01-24 16:56:57.279500', '2025-01-24 16:56:58.322839', '2025-01-24 18:17:36.205706', 'hotel_manager', '', '', 1, NULL),
(12, 'pbkdf2_sha256$870000$tUfyll6MMrRz1jT2fKgIxP$H+E3qKNYoMtNi2c5Ifr/qgRbbTaHK1RsMu4TPgeRIkY=', '2025-01-24 20:03:45.931357', 0, 'raghatube@gmail.com', 'فندق النبراس', '', 'raghatube@gmail.com', 1, '2025-01-24 17:18:27.392107', '2025-01-24 17:18:27.393223', '2025-01-24 17:41:31.410618', 'hotel_manager', '', '', 1, NULL),
(13, 'pbkdf2_sha256$870000$gQJbC76ETWrayihia54Wd7$2BmocW+t0JHWGMR7tjqqHv3d+XH4dTJrgSheEjwo0+8=', NULL, 0, 'aa', '', '', 'AmIT@gmail.com', 1, '2025-01-24 17:45:42.527007', '2025-01-24 17:45:43.554213', '2025-01-24 17:45:43.554213', 'hotel_staff', '+9999999999', '', 1, 12),
(14, 'pbkdf2_sha256$870000$bknVI8bleTmdclj2KwLShC$E9J7xoJOnxNB2c9g16LKnj0bQpAZ2aH9pnPBLkClIo4=', '2025-01-27 14:25:00.652407', 1, 'admin1', '', '', 'admin@gmail.com', 1, '2025-01-24 20:29:16.256000', '2025-01-24 20:29:17.067733', '2025-01-24 20:29:17.067733', '', '', '', 1, NULL),
(15, 'pbkdf2_sha256$870000$8nrrdFAEfjWiNmdBOkkQwo$4L8tn3d4cgrgu27QmIVFAPZEdmD2gBZcrAPfLB7cmrA=', '2025-01-25 19:51:38.263156', 0, 'motasamdv@gmail.com', 'Motasam', '', 'motasamdv@gmail.com', 1, '2025-01-24 20:33:02.652774', '2025-01-24 20:33:02.652774', '2025-01-24 20:33:03.536166', 'hotel_manager', '', '', 1, NULL);

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
(9, 12, 1),
(10, 12, 3),
(11, 13, 2),
(12, 15, 1),
(13, 15, 3);

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
(2, 12, 129),
(3, 15, 129);

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
-- Indexes for table `bookings_booking`
--
ALTER TABLE `bookings_booking`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
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
  ADD UNIQUE KEY `slug` (`slug`),
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
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `bookings_bookingstat_created_by_id_3055158b_fk_users_cus` (`created_by_id`),
  ADD KEY `bookings_bookingstat_updated_by_id_b6e4a5d9_fk_users_cus` (`updated_by_id`);

--
-- Indexes for table `bookings_guest`
--
ALTER TABLE `bookings_guest`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
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
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `HotelManagement_phon_created_by_id_34b06bb1_fk_users_cus` (`created_by_id`),
  ADD KEY `HotelManagement_phon_hotel_id_67f340f6_fk_HotelMana` (`hotel_id`),
  ADD KEY `HotelManagement_phon_updated_by_id_114868f0_fk_users_cus` (`updated_by_id`);

--
-- Indexes for table `payments_currency`
--
ALTER TABLE `payments_currency`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
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
  ADD UNIQUE KEY `slug` (`slug`),
  ADD UNIQUE KEY `unique_room_availability` (`hotel_id`,`room_type_id`,`date`),
  ADD KEY `rooms_availability_created_by_id_168a5943_fk_users_customuser_id` (`created_by_id`),
  ADD KEY `rooms_availability_updated_by_id_f8d6a9d2_fk_users_customuser_id` (`updated_by_id`),
  ADD KEY `rooms_availability_room_status_id_1add85a0_fk_rooms_roo` (`room_status_id`),
  ADD KEY `rooms_availability_room_type_id_ee87e18f_fk_rooms_roomtype_id` (`room_type_id`);

--
-- Indexes for table `rooms_category`
--
ALTER TABLE `rooms_category`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD UNIQUE KEY `unique_hotel_category` (`hotel_id`,`name`),
  ADD KEY `rooms_category_created_by_id_c539b61c_fk_users_customuser_id` (`created_by_id`),
  ADD KEY `rooms_category_updated_by_id_85bbbd5a_fk_users_customuser_id` (`updated_by_id`);

--
-- Indexes for table `rooms_roomimage`
--
ALTER TABLE `rooms_roomimage`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `rooms_roomimage_created_by_id_168789df_fk_users_customuser_id` (`created_by_id`),
  ADD KEY `rooms_roomimage_hotel_id_13fbdfad_fk_HotelManagement_hotel_id` (`hotel_id`),
  ADD KEY `rooms_roomimage_updated_by_id_c3e3a6e5_fk_users_customuser_id` (`updated_by_id`),
  ADD KEY `rooms_roomimage_room_type_id_d35f7810_fk_rooms_roomtype_id` (`room_type_id`);

--
-- Indexes for table `rooms_roomprice`
--
ALTER TABLE `rooms_roomprice`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `rooms_roomprice_created_by_id_7459c49f_fk_users_customuser_id` (`created_by_id`),
  ADD KEY `rooms_roomprice_hotel_id_bfc064b3_fk_HotelManagement_hotel_id` (`hotel_id`),
  ADD KEY `rooms_roomprice_updated_by_id_20da56f3_fk_users_customuser_id` (`updated_by_id`),
  ADD KEY `rooms_roomprice_room_type_id_b8f396b9_fk_rooms_roomtype_id` (`room_type_id`);

--
-- Indexes for table `rooms_roomstatus`
--
ALTER TABLE `rooms_roomstatus`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD UNIQUE KEY `unique_hotel_status_code` (`hotel_id`,`code`),
  ADD KEY `rooms_roomstatus_created_by_id_50bd38ee_fk_users_customuser_id` (`created_by_id`),
  ADD KEY `rooms_roomstatus_updated_by_id_8cedb596_fk_users_customuser_id` (`updated_by_id`);

--
-- Indexes for table `rooms_roomtype`
--
ALTER TABLE `rooms_roomtype`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `rooms_roomtype_category_id_3203b18b_fk_rooms_category_id` (`category_id`),
  ADD KEY `rooms_roomtype_created_by_id_42c3bbaa_fk_users_customuser_id` (`created_by_id`),
  ADD KEY `rooms_roomtype_hotel_id_25b4be35_fk_HotelManagement_hotel_id` (`hotel_id`),
  ADD KEY `rooms_roomtype_updated_by_id_b5be2b42_fk_users_customuser_id` (`updated_by_id`);

--
-- Indexes for table `services_service`
--
ALTER TABLE `services_service`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `services_service_created_by_id_d0083628_fk_users_customuser_id` (`created_by_id`),
  ADD KEY `services_service_hotel_id_1323fbb7_fk_HotelManagement_hotel_id` (`hotel_id`),
  ADD KEY `services_service_room_id_ab62b7a1_fk_rooms_roomtype_id` (`room_id`),
  ADD KEY `services_service_updated_by_id_69a365e0_fk_users_customuser_id` (`updated_by_id`);

--
-- Indexes for table `service_offers`
--
ALTER TABLE `service_offers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `service_offers_created_by_id_8ca73e25_fk_users_customuser_id` (`created_by_id`),
  ADD KEY `service_offers_hotel_id_id_ad6df36c_fk_HotelManagement_hotel_id` (`hotel_id_id`),
  ADD KEY `service_offers_updated_by_id_42cd54e5_fk_users_customuser_id` (`updated_by_id`);

--
-- Indexes for table `users_activitylog`
--
ALTER TABLE `users_activitylog`
  ADD PRIMARY KEY (`id`),
  ADD KEY `users_activ_user_id_e43008_idx` (`user_id`,`DESC`),
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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=143;

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bookings_bookingdetail`
--
ALTER TABLE `bookings_bookingdetail`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bookings_bookingstatus`
--
ALTER TABLE `bookings_bookingstatus`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bookings_guest`
--
ALTER TABLE `bookings_guest`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=135;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `hotelmanagement_city`
--
ALTER TABLE `hotelmanagement_city`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `hotelmanagement_hotel`
--
ALTER TABLE `hotelmanagement_hotel`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `hotelmanagement_hotelrequest`
--
ALTER TABLE `hotelmanagement_hotelrequest`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `hotelmanagement_image`
--
ALTER TABLE `hotelmanagement_image`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `hotelmanagement_location`
--
ALTER TABLE `hotelmanagement_location`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `hotelmanagement_phone`
--
ALTER TABLE `hotelmanagement_phone`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `payments_currency`
--
ALTER TABLE `payments_currency`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payments_hotelpaymentmethod`
--
ALTER TABLE `payments_hotelpaymentmethod`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payments_payment`
--
ALTER TABLE `payments_payment`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payments_paymentoption`
--
ALTER TABLE `payments_paymentoption`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reviews_hotelreview`
--
ALTER TABLE `reviews_hotelreview`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `rooms_category`
--
ALTER TABLE `rooms_category`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `rooms_roomimage`
--
ALTER TABLE `rooms_roomimage`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `rooms_roomprice`
--
ALTER TABLE `rooms_roomprice`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `rooms_roomstatus`
--
ALTER TABLE `rooms_roomstatus`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `rooms_roomtype`
--
ALTER TABLE `rooms_roomtype`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `services_service`
--
ALTER TABLE `services_service`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `service_offers`
--
ALTER TABLE `service_offers`
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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `users_customuser_groups`
--
ALTER TABLE `users_customuser_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `users_customuser_user_permissions`
--
ALTER TABLE `users_customuser_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
  ADD CONSTRAINT `bookings_bookingdeta_service_id_8dc9681c_fk_services_` FOREIGN KEY (`service_id`) REFERENCES `services_service` (`id`),
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
-- Constraints for table `services_service`
--
ALTER TABLE `services_service`
  ADD CONSTRAINT `services_service_created_by_id_d0083628_fk_users_customuser_id` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `services_service_hotel_id_1323fbb7_fk_HotelManagement_hotel_id` FOREIGN KEY (`hotel_id`) REFERENCES `hotelmanagement_hotel` (`id`),
  ADD CONSTRAINT `services_service_room_id_ab62b7a1_fk_rooms_roomtype_id` FOREIGN KEY (`room_id`) REFERENCES `rooms_roomtype` (`id`),
  ADD CONSTRAINT `services_service_updated_by_id_69a365e0_fk_users_customuser_id` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- Constraints for table `service_offers`
--
ALTER TABLE `service_offers`
  ADD CONSTRAINT `service_offers_created_by_id_8ca73e25_fk_users_customuser_id` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `service_offers_hotel_id_id_ad6df36c_fk_HotelManagement_hotel_id` FOREIGN KEY (`hotel_id_id`) REFERENCES `hotelmanagement_hotel` (`id`),
  ADD CONSTRAINT `service_offers_updated_by_id_42cd54e5_fk_users_customuser_id` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

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
