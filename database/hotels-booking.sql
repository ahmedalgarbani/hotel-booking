-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 22, 2025 at 10:58 AM
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
(1, 'Hotel Managers'),
(4, 'Hotel Staff'),
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
(4, 1, 23),
(1, 1, 24),
(2, 1, 25),
(3, 1, 26),
(5, 1, 75),
(6, 1, 76),
(7, 1, 77),
(8, 1, 78),
(12, 1, 79),
(9, 1, 80),
(10, 1, 81),
(11, 1, 82),
(33, 3, 34),
(17, 3, 35),
(18, 3, 36),
(20, 3, 37),
(19, 3, 38),
(25, 3, 43),
(26, 3, 44),
(28, 3, 45),
(27, 3, 46),
(29, 3, 47),
(30, 3, 48),
(32, 3, 49),
(31, 3, 50),
(21, 3, 51),
(22, 3, 52),
(24, 3, 53),
(23, 3, 54);

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
(5, 'Can approve hotel request', 7, 'can_approve_request'),
(6, 'Can reject hotel request', 7, 'can_reject_request'),
(7, 'Can add permission', 8, 'add_permission'),
(8, 'Can change permission', 8, 'change_permission'),
(9, 'Can delete permission', 8, 'delete_permission'),
(10, 'Can view permission', 8, 'view_permission'),
(11, 'Can add group', 9, 'add_group'),
(12, 'Can change group', 9, 'change_group'),
(13, 'Can delete group', 9, 'delete_group'),
(14, 'Can view group', 9, 'view_group'),
(15, 'Can add content type', 10, 'add_contenttype'),
(16, 'Can change content type', 10, 'change_contenttype'),
(17, 'Can delete content type', 10, 'delete_contenttype'),
(18, 'Can view content type', 10, 'view_contenttype'),
(19, 'Can add session', 11, 'add_session'),
(20, 'Can change session', 11, 'change_session'),
(21, 'Can delete session', 11, 'delete_session'),
(22, 'Can view session', 11, 'view_session'),
(23, 'Can add مستخدم', 2, 'add_customuser'),
(24, 'Can change مستخدم', 2, 'change_customuser'),
(25, 'Can delete مستخدم', 2, 'delete_customuser'),
(26, 'Can view مستخدم', 2, 'view_customuser'),
(27, 'Can add سجل النشاط', 12, 'add_activitylog'),
(28, 'Can change سجل النشاط', 12, 'change_activitylog'),
(29, 'Can delete سجل النشاط', 12, 'delete_activitylog'),
(30, 'Can view سجل النشاط', 12, 'view_activitylog'),
(31, 'Can add منطقه', 13, 'add_city'),
(32, 'Can change منطقه', 13, 'change_city'),
(33, 'Can delete منطقه', 13, 'delete_city'),
(34, 'Can view منطقه', 13, 'view_city'),
(35, 'Can add فندق', 14, 'add_hotel'),
(36, 'Can change فندق', 14, 'change_hotel'),
(37, 'Can delete فندق', 14, 'delete_hotel'),
(38, 'Can view فندق', 14, 'view_hotel'),
(39, 'Can add طلب إضافة فندق', 7, 'add_hotelrequest'),
(40, 'Can change طلب إضافة فندق', 7, 'change_hotelrequest'),
(41, 'Can delete طلب إضافة فندق', 7, 'delete_hotelrequest'),
(42, 'Can view طلب إضافة فندق', 7, 'view_hotelrequest'),
(43, 'Can add صورة', 15, 'add_image'),
(44, 'Can change صورة', 15, 'change_image'),
(45, 'Can delete صورة', 15, 'delete_image'),
(46, 'Can view صورة', 15, 'view_image'),
(47, 'Can add الموقع', 16, 'add_location'),
(48, 'Can change الموقع', 16, 'change_location'),
(49, 'Can delete الموقع', 16, 'delete_location'),
(50, 'Can view الموقع', 16, 'view_location'),
(51, 'Can add رقم هاتف', 17, 'add_phone'),
(52, 'Can change رقم هاتف', 17, 'change_phone'),
(53, 'Can delete رقم هاتف', 17, 'delete_phone'),
(54, 'Can view رقم هاتف', 17, 'view_phone'),
(55, 'Can add توفر الغرف', 18, 'add_availability'),
(56, 'Can change توفر الغرف', 18, 'change_availability'),
(57, 'Can delete توفر الغرف', 18, 'delete_availability'),
(58, 'Can view توفر الغرف', 18, 'view_availability'),
(59, 'Can add تصنيف', 19, 'add_category'),
(60, 'Can change تصنيف', 19, 'change_category'),
(61, 'Can delete تصنيف', 19, 'delete_category'),
(62, 'Can view تصنيف', 19, 'view_category'),
(63, 'Can add صورة الغرفة', 20, 'add_roomimage'),
(64, 'Can change صورة الغرفة', 20, 'change_roomimage'),
(65, 'Can delete صورة الغرفة', 20, 'delete_roomimage'),
(66, 'Can view صورة الغرفة', 20, 'view_roomimage'),
(67, 'Can add سعر الغرفة', 21, 'add_roomprice'),
(68, 'Can change سعر الغرفة', 21, 'change_roomprice'),
(69, 'Can delete سعر الغرفة', 21, 'delete_roomprice'),
(70, 'Can view سعر الغرفة', 21, 'view_roomprice'),
(71, 'Can add حالة الغرفة', 22, 'add_roomstatus'),
(72, 'Can change حالة الغرفة', 22, 'change_roomstatus'),
(73, 'Can delete حالة الغرفة', 22, 'delete_roomstatus'),
(74, 'Can view حالة الغرفة', 22, 'view_roomstatus'),
(75, 'Can add نوع الغرفة', 4, 'add_roomtype'),
(76, 'Can change نوع الغرفة', 4, 'change_roomtype'),
(77, 'Can delete نوع الغرفة', 4, 'delete_roomtype'),
(78, 'Can view نوع الغرفة', 4, 'view_roomtype'),
(79, 'Can add حجز', 5, 'add_booking'),
(80, 'Can change حجز', 5, 'change_booking'),
(81, 'Can delete حجز', 5, 'delete_booking'),
(82, 'Can view حجز', 5, 'view_booking'),
(83, 'Can add تفصيل الحجز', 23, 'add_bookingdetail'),
(84, 'Can change تفصيل الحجز', 23, 'change_bookingdetail'),
(85, 'Can delete تفصيل الحجز', 23, 'delete_bookingdetail'),
(86, 'Can view تفصيل الحجز', 23, 'view_bookingdetail'),
(87, 'Can add حالة الحجز', 24, 'add_bookingstatus'),
(88, 'Can change حالة الحجز', 24, 'change_bookingstatus'),
(89, 'Can delete حالة الحجز', 24, 'delete_bookingstatus'),
(90, 'Can view حالة الحجز', 24, 'view_bookingstatus'),
(91, 'Can add ضيف', 25, 'add_guest'),
(92, 'Can change ضيف', 25, 'change_guest'),
(93, 'Can delete ضيف', 25, 'delete_guest'),
(94, 'Can view ضيف', 25, 'view_guest'),
(95, 'Can add عملة', 26, 'add_currency'),
(96, 'Can change عملة', 26, 'change_currency'),
(97, 'Can delete عملة', 26, 'delete_currency'),
(98, 'Can view عملة', 26, 'view_currency'),
(99, 'Can add طريقة دفع الفندق', 27, 'add_hotelpaymentmethod'),
(100, 'Can change طريقة دفع الفندق', 27, 'change_hotelpaymentmethod'),
(101, 'Can delete طريقة دفع الفندق', 27, 'delete_hotelpaymentmethod'),
(102, 'Can view طريقة دفع الفندق', 27, 'view_hotelpaymentmethod'),
(103, 'Can add طريقة دفع', 28, 'add_paymentoption'),
(104, 'Can change طريقة دفع', 28, 'change_paymentoption'),
(105, 'Can delete طريقة دفع', 28, 'delete_paymentoption'),
(106, 'Can view طريقة دفع', 28, 'view_paymentoption'),
(107, 'Can add فاتورة دفع', 29, 'add_payment'),
(108, 'Can change فاتورة دفع', 29, 'change_payment'),
(109, 'Can delete فاتورة دفع', 29, 'delete_payment'),
(110, 'Can view فاتورة دفع', 29, 'view_payment'),
(111, 'Can add مراجعة فندق', 30, 'add_hotelreview'),
(112, 'Can change مراجعة فندق', 30, 'change_hotelreview'),
(113, 'Can delete مراجعة فندق', 30, 'delete_hotelreview'),
(114, 'Can view مراجعة فندق', 30, 'view_hotelreview'),
(115, 'Can add عرض', 31, 'add_offer'),
(116, 'Can change عرض', 31, 'change_offer'),
(117, 'Can delete عرض', 31, 'delete_offer'),
(118, 'Can view عرض', 31, 'view_offer'),
(119, 'Can add مراجعة غرفة', 32, 'add_roomreview'),
(120, 'Can change مراجعة غرفة', 32, 'change_roomreview'),
(121, 'Can delete مراجعة غرفة', 32, 'delete_roomreview'),
(122, 'Can view مراجعة غرفة', 32, 'view_roomreview'),
(123, 'Can add عرض', 33, 'add_offer'),
(124, 'Can change عرض', 33, 'change_offer'),
(125, 'Can delete عرض', 33, 'delete_offer'),
(126, 'Can view عرض', 33, 'view_offer'),
(127, 'Can add خدمة', 6, 'add_service'),
(128, 'Can change خدمة', 6, 'change_service'),
(129, 'Can delete خدمة', 6, 'delete_service'),
(130, 'Can view خدمة', 6, 'view_service'),
(131, 'Can add تصنيف', 34, 'add_category'),
(132, 'Can change تصنيف', 34, 'change_category'),
(133, 'Can delete تصنيف', 34, 'delete_category'),
(134, 'Can view تصنيف', 34, 'view_category'),
(135, 'Can add تعليق', 35, 'add_comment'),
(136, 'Can change تعليق', 35, 'change_comment'),
(137, 'Can delete تعليق', 35, 'delete_comment'),
(138, 'Can view تعليق', 35, 'view_comment'),
(139, 'Can add مقال', 36, 'add_post'),
(140, 'Can change مقال', 36, 'change_post'),
(141, 'Can delete مقال', 36, 'delete_post'),
(142, 'Can view مقال', 36, 'view_post'),
(143, 'Can add hotel', 37, 'add_hotel'),
(144, 'Can change hotel', 37, 'change_hotel'),
(145, 'Can delete hotel', 37, 'delete_hotel'),
(146, 'Can view hotel', 37, 'view_hotel'),
(147, 'Can add hotel service', 38, 'add_hotelservice'),
(148, 'Can change hotel service', 38, 'change_hotelservice'),
(149, 'Can delete hotel service', 38, 'delete_hotelservice'),
(150, 'Can view hotel service', 38, 'view_hotelservice'),
(151, 'Can add room type service', 39, 'add_roomtypeservice'),
(152, 'Can change room type service', 39, 'change_roomtypeservice'),
(153, 'Can delete room type service', 39, 'delete_roomtypeservice'),
(154, 'Can view room type service', 39, 'view_roomtypeservice'),
(155, 'Can add blacklisted token', 40, 'add_blacklistedtoken'),
(156, 'Can change blacklisted token', 40, 'change_blacklistedtoken'),
(157, 'Can delete blacklisted token', 40, 'delete_blacklistedtoken'),
(158, 'Can view blacklisted token', 40, 'view_blacklistedtoken'),
(159, 'Can add outstanding token', 41, 'add_outstandingtoken'),
(160, 'Can change outstanding token', 41, 'change_outstandingtoken'),
(161, 'Can delete outstanding token', 41, 'delete_outstandingtoken'),
(162, 'Can view outstanding token', 41, 'view_outstandingtoken'),
(163, 'Can add مراجعة', 42, 'add_review'),
(164, 'Can change مراجعة', 42, 'change_review'),
(165, 'Can delete مراجعة', 42, 'delete_review'),
(166, 'Can view مراجعة', 42, 'view_review'),
(167, 'Can add إشعار', 43, 'add_notifications'),
(168, 'Can change إشعار', 43, 'change_notifications'),
(169, 'Can delete إشعار', 43, 'delete_notifications'),
(170, 'Can view إشعار', 43, 'view_notifications');

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
  `status_id` bigint(20) NOT NULL,
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
(1, '2025-01-24 17:26:57.220239', '2', 'asdjka - ahdklk', 3, '', 7, 1),
(2, '2025-01-25 14:32:35.154490', '1', 'غير متوفر (1)', 1, '[{\"added\": {}}]', 22, 1),
(3, '2025-01-25 14:33:04.516344', '1', 'vip - asdjka', 1, '[{\"added\": {}}]', 19, 1),
(4, '2025-01-25 14:33:19.399179', '2', 'normal - asdjka', 1, '[{\"added\": {}}]', 19, 1),
(5, '2025-01-25 14:34:20.009068', '1', 'hotel vip (asdjka)', 1, '[{\"added\": {}}]', 4, 1),
(6, '2025-01-25 14:34:55.745256', '2', 'good normal (asdjka)', 1, '[{\"added\": {}}]', 4, 1),
(7, '2025-01-25 14:35:16.386537', '1', 'hotel vip (asdjka)', 2, '[{\"changed\": {\"fields\": [\"\\u0627\\u0644\\u0633\\u0639\\u0629 \\u0627\\u0644\\u0642\\u0635\\u0648\\u0649\", \"\\u0639\\u062f\\u062f \\u0627\\u0644\\u063a\\u0631\\u0641\"]}}]', 4, 1),
(8, '2025-01-25 14:36:20.501912', '1', 'hotel vip - رئيسية', 1, '[{\"added\": {}}]', 20, 1),
(9, '2025-01-25 14:36:44.229244', '2', 'hotel vip - إضافية', 1, '[{\"added\": {}}]', 20, 1),
(10, '2025-01-28 13:56:58.363477', '2', 'good normal - 5165.00 (2025-01-01 إلى 2025-01-31)', 3, '', 21, 1),
(11, '2025-01-28 14:32:18.786523', '2', 'good normal - 2025-01-28 (3 غرفة متوفرة)', 1, '[{\"added\": {}}]', 18, 1),
(12, '2025-01-28 15:12:40.901568', '3', 'Availability object (3)', 1, '[{\"added\": {}}]', 18, 1),
(13, '2025-01-28 15:41:33.892208', '4', 'Availability object (4)', 1, '[{\"added\": {}}]', 18, 1),
(14, '2025-01-28 15:41:50.993492', '5', 'Availability object (5)', 1, '[{\"added\": {}}]', 18, 1),
(15, '2025-01-28 15:42:08.580208', '5', 'Availability object (5)', 3, '', 18, 1),
(16, '2025-01-28 15:42:28.622479', '6', 'Availability object (6)', 1, '[{\"added\": {}}]', 18, 1),
(17, '2025-01-28 16:10:08.229196', '4', 'good normal - 15 (2025-01-28 إلى 2025-01-31)', 1, '[{\"added\": {}}]', 21, 1);

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
(9, 'auth', 'group'),
(8, 'auth', 'permission'),
(3, 'auth', 'user'),
(34, 'blog', 'category'),
(35, 'blog', 'comment'),
(36, 'blog', 'post'),
(5, 'bookings', 'booking'),
(23, 'bookings', 'bookingdetail'),
(24, 'bookings', 'bookingstatus'),
(25, 'bookings', 'guest'),
(10, 'contenttypes', 'contenttype'),
(13, 'HotelManagement', 'city'),
(14, 'HotelManagement', 'hotel'),
(7, 'HotelManagement', 'hotelrequest'),
(15, 'HotelManagement', 'image'),
(16, 'HotelManagement', 'location'),
(17, 'HotelManagement', 'phone'),
(43, 'notifications', 'notifications'),
(26, 'payments', 'currency'),
(27, 'payments', 'hotelpaymentmethod'),
(29, 'payments', 'payment'),
(28, 'payments', 'paymentoption'),
(30, 'reviews', 'hotelreview'),
(31, 'reviews', 'offer'),
(32, 'reviews', 'roomreview'),
(18, 'rooms', 'availability'),
(19, 'rooms', 'category'),
(42, 'rooms', 'review'),
(20, 'rooms', 'roomimage'),
(21, 'rooms', 'roomprice'),
(22, 'rooms', 'roomstatus'),
(4, 'rooms', 'roomtype'),
(37, 'services', 'hotel'),
(38, 'services', 'hotelservice'),
(33, 'services', 'offer'),
(39, 'services', 'roomtypeservice'),
(6, 'services', 'service'),
(11, 'sessions', 'session'),
(40, 'token_blacklist', 'blacklistedtoken'),
(41, 'token_blacklist', 'outstandingtoken'),
(12, 'users', 'activitylog'),
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
(1, 'contenttypes', '0001_initial', '2025-01-24 17:10:53.393415'),
(2, 'contenttypes', '0002_remove_content_type_name', '2025-01-24 17:10:53.449377'),
(3, 'auth', '0001_initial', '2025-01-24 17:10:53.667006'),
(4, 'auth', '0002_alter_permission_name_max_length', '2025-01-24 17:10:53.715670'),
(5, 'auth', '0003_alter_user_email_max_length', '2025-01-24 17:10:53.720547'),
(6, 'auth', '0004_alter_user_username_opts', '2025-01-24 17:10:53.726404'),
(7, 'auth', '0005_alter_user_last_login_null', '2025-01-24 17:10:53.733236'),
(8, 'auth', '0006_require_contenttypes_0002', '2025-01-24 17:10:53.736164'),
(9, 'auth', '0007_alter_validators_add_error_messages', '2025-01-24 17:10:53.740068'),
(10, 'auth', '0008_alter_user_username_max_length', '2025-01-24 17:10:53.744676'),
(11, 'auth', '0009_alter_user_last_name_max_length', '2025-01-24 17:10:53.751507'),
(12, 'auth', '0010_alter_group_name_max_length', '2025-01-24 17:10:53.759281'),
(13, 'auth', '0011_update_proxy_permissions', '2025-01-24 17:10:53.767086'),
(14, 'auth', '0012_alter_user_first_name_max_length', '2025-01-24 17:10:53.771372'),
(15, 'auth', '0013_alter_permission_options', '2025-01-24 17:10:53.776253'),
(16, 'auth', '0014_alter_permission_options_alter_user_user_permissions', '2025-01-24 17:10:53.784061'),
(17, 'auth', '0015_alter_user_user_permissions', '2025-01-24 17:10:53.789916'),
(18, 'users', '0001_initial', '2025-01-24 17:10:54.170245'),
(19, 'HotelManagement', '0001_initial', '2025-01-24 17:10:54.317329'),
(20, 'HotelManagement', '0002_initial', '2025-01-24 17:10:55.313204'),
(21, 'admin', '0001_initial', '2025-01-24 17:10:55.433873'),
(22, 'admin', '0002_logentry_remove_auto_add', '2025-01-24 17:10:55.445592'),
(23, 'admin', '0003_logentry_add_action_flag_choices', '2025-01-24 17:10:55.458240'),
(24, 'blog', '0001_initial', '2025-01-24 17:10:55.507939'),
(25, 'blog', '0002_initial', '2025-01-24 17:10:55.728020'),
(26, 'services', '0001_initial', '2025-01-24 17:10:55.776454'),
(27, 'rooms', '0001_initial', '2025-01-24 17:10:55.967028'),
(28, 'bookings', '0001_initial', '2025-01-24 17:10:56.073884'),
(29, 'bookings', '0002_initial', '2025-01-24 17:10:57.254672'),
(30, 'payments', '0001_initial', '2025-01-24 17:10:57.659048'),
(31, 'payments', '0002_initial', '2025-01-24 17:10:57.878485'),
(32, 'reviews', '0001_initial', '2025-01-24 17:10:57.950741'),
(33, 'reviews', '0002_initial', '2025-01-24 17:10:58.986044'),
(34, 'rooms', '0002_initial', '2025-01-24 17:11:00.985189'),
(35, 'services', '0002_initial', '2025-01-24 17:11:01.559096'),
(36, 'sessions', '0001_initial', '2025-01-24 17:11:01.589383'),
(37, 'services', '0003_hotel_hotelservice_roomtypeservice_and_more', '2025-01-28 18:34:40.157473'),
(38, 'bookings', '0003_alter_bookingdetail_service', '2025-01-28 18:34:40.748934'),
(39, 'services', '0004_delete_service_roomtypeservice_hotel_and_more', '2025-01-28 18:34:41.304463'),
(40, 'token_blacklist', '0001_initial', '2025-02-21 19:36:46.298483'),
(41, 'token_blacklist', '0002_outstandingtoken_jti_hex', '2025-02-21 19:36:46.393372'),
(42, 'token_blacklist', '0003_auto_20171017_2007', '2025-02-21 19:36:46.542282'),
(43, 'token_blacklist', '0004_auto_20171017_2013', '2025-02-21 19:36:46.701199'),
(44, 'token_blacklist', '0005_remove_outstandingtoken_jti', '2025-02-21 19:36:46.799136'),
(45, 'token_blacklist', '0006_auto_20171017_2113', '2025-02-21 19:36:46.885318'),
(46, 'token_blacklist', '0007_auto_20171017_2214', '2025-02-21 19:36:59.989425'),
(47, 'token_blacklist', '0008_migrate_to_bigautofield', '2025-02-21 19:37:00.889623'),
(48, 'token_blacklist', '0010_fix_migrate_to_bigautofield', '2025-02-21 19:37:01.031202'),
(49, 'token_blacklist', '0011_linearizes_history', '2025-02-21 19:37:01.044492'),
(50, 'token_blacklist', '0012_alter_outstandingtoken_user', '2025-02-21 19:37:01.190775'),
(51, 'notifications', '0001_initial', '2025-02-22 09:20:36.700485'),
(52, 'notifications', '0002_initial', '2025-02-22 09:20:36.862113');

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
('3z4h2ef65kvvzlwlkmhh4e11zv2lli3c', '.eJxVjEEOwiAQRe_C2hAYKgwu3fcMBJipVA0kpV0Z765NutDtf-_9lwhxW0vYOi9hJnERIE6_W4r5wXUHdI_11mRudV3mJHdFHrTLsRE_r4f7d1BiL986KiI3kVXaJY_Js2ZzRpMNaQZQ7LTyCieEwSc03hIM4CwjD9bpzCDeH9lfNyQ:1tbNTQ:OT_HQy7U1bM-5l45GYgNIx-HsR0ivt55z-k-AvbArbM', '2025-02-07 17:28:04.179180'),
('81z10haz5g8nszmf844leq3uueo83kq8', '.eJxVjDsOwjAQBe_iGlnZ9S-hpOcM1tq7xgGUSHFSIe4OkVJA-2bmvVSkba1xa7LEkdVZgTr9bonyQ6Yd8J2m26zzPK3LmPSu6IM2fZ1ZnpfD_Tuo1Oq3RqABJKDPRVjYondogimcCcEGGHxnQBxYix2kBFSYXW_A9VAQyar3B9JsNyI:1tbhBf:ti8Z3VCd8HeeLezVpjTeyx882nRLVyGNxMw2kQjbX50', '2025-02-08 14:31:03.529965'),
('p0qug31jcpoaswzk8ti6u4p49496k16s', '.eJxVjDsOwjAQBe_iGlnZ9S-hpOcM1tq7xgGUSHFSIe4OkVJA-2bmvVSkba1xa7LEkdVZgTr9bonyQ6Yd8J2m26zzPK3LmPSu6IM2fZ1ZnpfD_Tuo1Oq3RqABJKDPRVjYondogimcCcEGGHxnQBxYix2kBFSYXW_A9VAQyar3B9JsNyI:1tbOfW:UNm4LyNKTItjWXFn7cJF8fJ_5WCzIEYPMo6EAqhzCwQ', '2025-02-07 18:44:38.477574'),
('rwqa7qoigwhik8zjhbmbsm7xy7nsaa12', '.eJxVjEsOwiAUAO_C2hAo8ACX7nsG8vhJ1UBS2pXx7pakC93OTOZNHO5bcXtPq1siuRJBLr_MY3imOkR8YL03Glrd1sXTkdDTdjq3mF63s_0bFOxlbCFzY4WeUooGggUw2iKTQkQmZDYKPFqWUR2MH1Rprj1PaCYIEjiQzxe6tzaQ:1tlZ63:hlEf7Eeyded_zzU3TaTPFaqtQeye0lFhFd5AKX78_GU', '2025-03-07 19:54:03.656198');

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
(1, '2025-01-24 17:11:37.109338', '2025-01-24 17:11:37.109338', NULL, 'ibbo-yemen', 'ibbo', 'yemen', NULL, NULL);

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
(1, '2025-01-24 17:26:47.773783', '2025-01-24 17:26:47.773783', NULL, 'asdjka', 'asdjka', 'hotel_requests/profile_pictures/bg.jpg', 'a,sdjsak', '656565', 'hotel_requests/documents/2025/01/24/balcony-cabin.jpg', 1, '2025-01-24 17:26:47.772820', 1, 1, 2, NULL);

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
(1, 'احمد محمد', 'ahmedalgarbani776@gmail.com', 'manager', 'hotel vipp', 'godod hotel', 'hotel_requests/profile_pictures/img20_vF25uAe.jpg', '15155656', 'hotel_requests/documents/2025/01/24/img20_uKimATx.jpg', '\"[{\\\"image_path\\\": \\\"hotels/images/airline-img7.png\\\"}, {\\\"image_path\\\": \\\"hotels/images/airline-img8.png\\\"}, {\\\"image_path\\\": \\\"hotels/images/app-store.png\\\"}]\"', 'yemen', 'ibbo', '', 'taiz street', '+967', '781717609', 0, NULL, '2025-01-24 17:11:37.116172', '2025-01-24 17:11:37.116172', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `hotelmanagement_image`
--

CREATE TABLE `hotelmanagement_image` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `slug` varchar(255) NOT NULL,
  `image_path` varchar(100) DEFAULT NULL,
  `image_url` varchar(3000) DEFAULT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `hotel_id` bigint(20) NOT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `hotelmanagement_image`
--

INSERT INTO `hotelmanagement_image` (`id`, `created_at`, `updated_at`, `deleted_at`, `slug`, `image_path`, `image_url`, `created_by_id`, `hotel_id`, `updated_by_id`) VALUES
(1, '2025-01-24 17:26:47.782545', '2025-01-24 17:26:47.782545', NULL, 'hotelsimagesbgjpg', 'hotels/images/bg.jpg', NULL, 1, 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `hotelmanagement_location`
--

CREATE TABLE `hotelmanagement_location` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `slug` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `city_id` bigint(20) NOT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `hotelmanagement_location`
--

INSERT INTO `hotelmanagement_location` (`id`, `created_at`, `updated_at`, `deleted_at`, `slug`, `address`, `city_id`, `created_by_id`, `updated_by_id`) VALUES
(1, '2025-01-24 17:26:47.769997', '2025-01-24 17:26:47.769997', NULL, 'akhdjhasdh', 'akhdjhasdh', 1, 1, NULL);

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
(1, '2025-01-24 17:26:47.778641', '2025-01-24 17:26:47.778641', NULL, '45454545', '45454545', '+967', 1, 1, NULL);

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

--
-- Dumping data for table `reviews_hotelreview`
--

INSERT INTO `reviews_hotelreview` (`id`, `created_at`, `updated_at`, `deleted_at`, `slug`, `rating_service`, `rating_location`, `rating_value_for_money`, `rating_cleanliness`, `review`, `status`, `created_by_id`, `hotel_id`, `updated_by_id`, `user_id`) VALUES
(1, '2025-01-25 19:50:46.330029', '2025-01-25 19:50:46.330029', NULL, '', 4, 3, 3, 5, 'sadasdas', 1, NULL, 1, NULL, 1);

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
) ;

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
  `room_status_id` bigint(20) NOT NULL,
  `room_type_id` bigint(20) NOT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rooms_availability`
--

INSERT INTO `rooms_availability` (`id`, `created_at`, `updated_at`, `deleted_at`, `availability_date`, `available_rooms`, `notes`, `created_by_id`, `hotel_id`, `room_status_id`, `room_type_id`, `updated_by_id`) VALUES
(1, '0000-00-00 00:00:00.000000', '0000-00-00 00:00:00.000000', NULL, '2025-01-23', 5, 'akshdjkashd', NULL, 1, 1, 1, NULL),
(2, '2025-01-28 14:32:18.783381', '2025-01-28 14:32:18.783381', NULL, '2025-01-28', 3, 'sa', NULL, 1, 1, 2, NULL),
(3, '2025-01-28 15:12:40.900570', '2025-01-28 15:12:40.900570', NULL, '2025-01-28', 4, 'sa', NULL, 1, 1, 1, NULL),
(4, '2025-01-28 15:41:33.891371', '2025-01-28 15:41:33.891371', NULL, '2025-01-29', 5, 'ad', NULL, 1, 1, 2, NULL),
(6, '2025-01-28 15:42:28.621792', '2025-01-28 15:42:28.621792', NULL, '2025-01-30', 5, 'asd', NULL, 1, 1, 2, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `rooms_category`
--

CREATE TABLE `rooms_category` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `slug` varchar(255) NOT NULL,
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
(1, '2025-01-25 14:33:04.516344', '2025-01-25 14:33:04.516344', NULL, 'vip', 'vip', 'vip', NULL, 1, NULL),
(2, '2025-01-25 14:33:19.399179', '2025-01-25 14:33:19.399179', NULL, 'normal', 'normal', 'normal', NULL, 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `rooms_roomimage`
--

CREATE TABLE `rooms_roomimage` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `slug` varchar(255) NOT NULL,
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

INSERT INTO `rooms_roomimage` (`id`, `created_at`, `updated_at`, `deleted_at`, `slug`, `image`, `is_main`, `caption`, `created_by_id`, `hotel_id`, `room_type_id`, `updated_by_id`) VALUES
(1, '2025-01-25 14:36:20.501912', '2025-01-25 14:36:20.501912', NULL, 'hotel-vip', 'room_images/blog-img3.jpg', 1, 'good', NULL, 1, 1, NULL),
(2, '2025-01-25 14:36:44.229244', '2025-01-25 14:36:44.229244', NULL, 'ahmed', 'room_images/app-store.png', 0, 'asdsa', NULL, 1, 1, NULL);

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

--
-- Dumping data for table `rooms_roomprice`
--

INSERT INTO `rooms_roomprice` (`id`, `created_at`, `updated_at`, `deleted_at`, `date_from`, `date_to`, `price`, `is_special_offer`, `created_by_id`, `hotel_id`, `room_type_id`, `updated_by_id`) VALUES
(3, '0000-00-00 00:00:00.000000', '0000-00-00 00:00:00.000000', NULL, '2025-01-01', '2025-01-31', 999.00, 0, NULL, 1, 1, NULL),
(4, '2025-01-28 16:10:08.224084', '2025-01-28 16:10:08.224084', NULL, '2025-01-28', '2025-01-31', 15.00, 0, NULL, 1, 2, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `rooms_roomstatus`
--

CREATE TABLE `rooms_roomstatus` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `slug` varchar(255) NOT NULL,
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
(1, '2025-01-25 14:32:35.154490', '2025-01-25 14:32:35.154490', NULL, 'not-available', '1', 'غير متوفر', 'سشس', 1, NULL, 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `rooms_roomtype`
--

CREATE TABLE `rooms_roomtype` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `slug` varchar(255) NOT NULL,
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

INSERT INTO `rooms_roomtype` (`id`, `created_at`, `updated_at`, `deleted_at`, `slug`, `name`, `description`, `default_capacity`, `max_capacity`, `beds_count`, `rooms_count`, `base_price`, `is_active`, `category_id`, `created_by_id`, `hotel_id`, `updated_by_id`) VALUES
(1, '2025-01-25 14:34:19.993773', '2025-01-25 14:35:16.386537', NULL, 'ahmed-aaaaa', 'hotel vip2025', 'hotel vip', 5, 6, 10, 9, 1500.00, 1, 1, NULL, 1, NULL),
(2, '2025-01-25 14:34:55.745256', '2025-01-25 14:34:55.745256', NULL, 'normal-rooms', 'good normal', 'good normal', 5, 5, 5, 5, 500.00, 1, 2, NULL, 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `services_hotel`
--

CREATE TABLE `services_hotel` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `services_hotelservice`
--

CREATE TABLE `services_hotelservice` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` longtext DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `icon` varchar(100) DEFAULT NULL,
  `hotel_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `services_offer`
--

CREATE TABLE `services_offer` (
  `id` bigint(20) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `offer_name` varchar(255) NOT NULL,
  `offer_description` longtext DEFAULT NULL,
  `offer_start_date` date NOT NULL,
  `offer_end_date` date NOT NULL,
  `hotel_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `services_roomtypeservice`
--

CREATE TABLE `services_roomtypeservice` (
  `id` bigint(20) NOT NULL,
  `room_type` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` longtext DEFAULT NULL,
  `additional_fee` decimal(10,2) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `icon` varchar(100) DEFAULT NULL,
  `hotel_id` bigint(20) NOT NULL
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

--
-- Dumping data for table `token_blacklist_blacklistedtoken`
--

INSERT INTO `token_blacklist_blacklistedtoken` (`id`, `blacklisted_at`, `token_id`) VALUES
(1, '2025-02-21 20:14:07.932094', 5),
(2, '2025-02-22 09:32:58.876528', 12),
(3, '2025-02-22 09:55:53.516440', 16);

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

--
-- Dumping data for table `token_blacklist_outstandingtoken`
--

INSERT INTO `token_blacklist_outstandingtoken` (`id`, `token`, `created_at`, `expires_at`, `user_id`, `jti`) VALUES
(1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc0MDc3Mjc1MSwiaWF0IjoxNzQwMTY3OTUxLCJqdGkiOiI3NzhkNDU3NjRhMjY0NzMxYmEyODlmMmQ3MzZmNzA0OCIsInVzZXJfaWQiOjN9.XvaEFBykzvVeGiN-9aIyol_3DxGkzhOu8j0WedsPwS0', '2025-02-21 19:59:11.521123', '2025-02-28 19:59:11.000000', 3, '778d45764a264731ba289f2d736f7048'),
(2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc0MDc3MjgyNCwiaWF0IjoxNzQwMTY4MDI0LCJqdGkiOiJjNGRhYjZlZDQ4NjA0M2U5OGQ3ODU0ZjA0MTllYjVlNCIsInVzZXJfaWQiOjN9.-mjLVpqSjj_ercVakugiH6udnVk1nx9wfeCI6Gq0eK4', '2025-02-21 20:00:24.192131', '2025-02-28 20:00:24.000000', 3, 'c4dab6ed486043e98d7854f0419eb5e4'),
(3, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc0MDc3MzIwNCwiaWF0IjoxNzQwMTY4NDA0LCJqdGkiOiI5NDEyMjg4YTY4OTE0MzhiOTUwY2RiMjlhZTc4YmFiYSIsInVzZXJfaWQiOjN9.8Dkcor8W6KcRrfSUtjKfLaO7mv0R4UYyBb4kHYCHMIA', '2025-02-21 20:06:44.400112', '2025-02-28 20:06:44.000000', 3, '9412288a6891438b950cdb29ae78baba'),
(4, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc0MDc3MzM5MSwiaWF0IjoxNzQwMTY4NTkxLCJqdGkiOiIxODM2MTBlMzlkYWQ0NTI4YjA0YjE2YTczYTY3MTk2OSIsInVzZXJfaWQiOjN9.8aGGyrO0hn2vtyt1fYmpoVAjydui37FKuUHi5X-98kg', '2025-02-21 20:09:51.631774', '2025-02-28 20:09:51.000000', 3, '183610e39dad4528b04b16a73a671969'),
(5, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc0MDc3MzUyMiwiaWF0IjoxNzQwMTY4NzIyLCJqdGkiOiI4YmVmMTZkZTc5ODA0MDg4OGYwNGRlODdlM2UwMTA3OCIsInVzZXJfaWQiOjN9.oL7wQB9AgSy14zv_NdULXmmKtW9MRoGEuN75UP_O3Qg', '2025-02-21 20:12:02.630203', '2025-02-28 20:12:02.000000', 3, '8bef16de798040888f04de87e3e01078'),
(6, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc0MDc4MDAxNywiaWF0IjoxNzQwMTc1MjE3LCJqdGkiOiIyZWQ2MDhhODEwMWE0ZDNiOGYwZTY0MjA2NGI0NjY5NyIsInVzZXJfaWQiOjN9.wL6T70_c4GeOtqK4jm0BFXD-QFOJREgDKw0kuhBSB40', '2025-02-21 22:00:17.565314', '2025-02-28 22:00:17.000000', 3, '2ed608a8101a4d3b8f0e642064b46697'),
(7, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc0MDc4MDAxNywiaWF0IjoxNzQwMTc1MjE3LCJqdGkiOiI1MGE3NmFiODdkMjQ0NjA5YTZjN2ExMDQ5MTRjMjRkNiIsInVzZXJfaWQiOjN9.pieXU2-U7kZV5csG5wZMcVsKQa3q_5ZjnBtr0Zdzq1Y', '2025-02-21 22:00:17.608456', '2025-02-28 22:00:17.000000', 3, '50a76ab87d244609a6c7a104914c24d6'),
(8, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc0MDc4MDg2NywiaWF0IjoxNzQwMTc2MDY3LCJqdGkiOiIzNDNkZjdkMWVmMmI0YmJlYTVjOTc3MzYxMGEzMDRmMyIsInVzZXJfaWQiOjR9.mE5m_sZn1ZFfFF5zI3bZL7m1SK0ZxQ4guDVqVJPO8Dk', '2025-02-21 22:14:27.611319', '2025-02-28 22:14:27.000000', 4, '343df7d1ef2b4bbea5c9773610a304f3'),
(9, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc0MDc4MDg2NywiaWF0IjoxNzQwMTc2MDY3LCJqdGkiOiJiZWE1ZjNhNzA1MzY0NTQwOGU5YzEyMDdkZjJmOTY3MyIsInVzZXJfaWQiOjR9.FxysKzeN-2zvm8cyguMOQjbX1StGg4gcrUNUSP9puRg', '2025-02-21 22:14:27.652462', '2025-02-28 22:14:27.000000', 4, 'bea5f3a7053645408e9c1207df2f9673'),
(10, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc0MDgyMDg3MCwiaWF0IjoxNzQwMjE2MDcwLCJqdGkiOiIxZDZkM2M2ODc0OWE0MjBjYTRkMWQxNDgyZjA3ZjY4ZCIsInVzZXJfaWQiOjh9.srer_kYN3gU6xC4-Ku2BY2fWKLG9VjSrdaFeMT_4bIo', '2025-02-22 09:21:10.213577', '2025-03-01 09:21:10.000000', 8, '1d6d3c68749a420ca4d1d1482f07f68d'),
(11, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc0MDgyMDg3MCwiaWF0IjoxNzQwMjE2MDcwLCJqdGkiOiJkM2QzODY1NDhjOTg0MTNiYjlkNmI4OGMzZDM3ZjM4OSIsInVzZXJfaWQiOjh9.OZIUSN_3RsrFHTuloVSR-NHiNCoV6bRtXUHA575Hlpw', '2025-02-22 09:21:10.230915', '2025-03-01 09:21:10.000000', 8, 'd3d386548c98413bb9d6b88c3d37f389'),
(12, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc0MDgyMTM5NywiaWF0IjoxNzQwMjE2NTk3LCJqdGkiOiI4MTA1Mzg2OWI0ODI0MDdjYTEyNGMxNDhiNTczYzZkMCIsInVzZXJfaWQiOjh9.dnkqm-Ho7z0GF1Ob6Wz-9xPY2PyRP6IflXv-6eBrAUg', '2025-02-22 09:29:57.946776', '2025-03-01 09:29:57.000000', 8, '81053869b482407ca124c148b573c6d0'),
(13, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc0MDgyMTM5NywiaWF0IjoxNzQwMjE2NTk3LCJqdGkiOiJjZDllYjg3ODdkZTc0ZmNmODY1MDU0M2RmYzUyZDAxOCIsInVzZXJfaWQiOjh9.XMG_jwIjK7qg6LgQnSyw5Cb2lDq4V0fi1YS3joGji8s', '2025-02-22 09:29:57.965104', '2025-03-01 09:29:57.000000', 8, 'cd9eb8787de74fcf8650543dfc52d018'),
(14, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc0MDgyMTczMywiaWF0IjoxNzQwMjE2OTMzLCJqdGkiOiJjNDRlNjQ2ZjRlZTM0ZDMwOTQ1NzQ5YTRjYWYwMDE3YyIsInVzZXJfaWQiOjh9.PD8Lya8FxWrKmWahgp4tVG87LSRBh7toSvLIw1LEKbg', '2025-02-22 09:35:33.135208', '2025-03-01 09:35:33.000000', 8, 'c44e646f4ee34d30945749a4caf0017c'),
(15, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc0MDgyMTczMywiaWF0IjoxNzQwMjE2OTMzLCJqdGkiOiI1MmU3OWY5MThkNmE0MzY0YWJhMDlkZTc1ODNjMmM1MiIsInVzZXJfaWQiOjh9.oOQss6CSXwYouqlpH9sJ2I7ceWtW-FP4M9UdJvEPeZ0', '2025-02-22 09:35:33.150319', '2025-03-01 09:35:33.000000', 8, '52e79f918d6a4364aba09de7583c2c52'),
(16, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc0MDgyMjg3NywiaWF0IjoxNzQwMjE4MDc3LCJqdGkiOiJhNjExZmUyOWY5YzA0Y2E1YTI3M2IyNzkwYTExZTM4NCIsInVzZXJfaWQiOjh9.7QbSegLqnEDWehb_gVrX-6bAJchv9bcls1PtCfkqKqE', '2025-02-22 09:54:37.674965', '2025-03-01 09:54:37.000000', 8, 'a611fe29f9c04ca5a273b2790a11e384'),
(17, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc0MDgyMjg3NywiaWF0IjoxNzQwMjE4MDc3LCJqdGkiOiI3OTdlYTY0MzY0YWU0Y2IzODEwMWE1NDM3MTQwZTc3NiIsInVzZXJfaWQiOjh9.5NolmFhBkMjVROjO6B8lCr7NFzRjmuppduV2YU83siU', '2025-02-22 09:54:37.678191', '2025-03-01 09:54:37.000000', 8, '797ea64364ae4cb38101a5437140e776');

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
(1, 'pbkdf2_sha256$600000$tGyR4a5IoMmqJOG45kmImJ$g157YGdpR4Aqli5SmiTHjXwaDLMZnohE01YfcAFk65s=', '2025-01-25 14:31:03.529965', 1, 'a', '', '', 'a@a.com', 1, '2025-01-24 17:13:04.362082', '2025-01-24 17:13:04.862137', '2025-01-24 17:13:04.862137', '', '', '', 1, NULL),
(2, 'pbkdf2_sha256$600000$9eaBlTjYdHPt8Ltmc0A88O$RKL4PtQCwtlHArIw1tL1RDFMlo0gZIOUL5GU/SWMgvA=', '2025-01-24 17:28:04.176368', 0, 'verefit983@citdaca.com', 'ahdklk', '', 'verefit983@citdaca.com', 1, '2025-01-24 17:26:42.702989', '2025-01-24 17:26:42.703967', '2025-01-24 17:26:43.296793', 'hotel_manager', '', '', 1, NULL),
(3, 'pbkdf2_sha256$600000$OoIosLtrbeZioWst1p1RmZ$EqIUK2MMIWjybWlmr+MolBRP/VKDiggy2YEZe7jl14o=', '2025-02-21 19:54:03.652056', 1, 'b', '', '', 'b@b.com', 1, '2025-02-21 19:48:56.453295', '2025-02-21 19:48:57.181581', '2025-02-21 19:48:57.181581', '', '', '', 1, NULL),
(4, 'pbkdf2_sha256$600000$iw9MEdjJJR0uUuZuJTqN80$5N6lgpHpiM63C5is7isnYFvaddRNGwMXgpNHTMQGz34=', NULL, 0, 'john_doe', 'John', 'Doe', 'john.doe@example.com', 0, '2025-02-21 22:13:11.655525', '2025-02-21 22:13:14.403365', '2025-02-21 22:13:14.403377', '', '', '', 1, NULL),
(5, 'pbkdf2_sha256$600000$8SWXuGgI5Bw8mayGldmM4F$Bwjm3gsVeMTROxZCcTlG99Koj9/IuzsL5j/BN+EgAaA=', NULL, 0, 'ahmed2025', 'ahmed', 'Nasser', 'johnahmed2025.doe@example.com', 0, '2025-02-21 22:19:30.985452', '2025-02-21 22:19:33.464076', '2025-02-21 22:19:33.464076', '', '', '', 1, NULL),
(6, 'pbkdf2_sha256$600000$XRcEqd0c4LXiqa0UAGTwA5$700sdaSdfHmIb92o4nadrYFDjzuI7Kj/2afwzqQzymQ=', NULL, 0, 'ahmed5552025', 'ahmed', 'Nasser', 'johnahme888d2025.doe@example.com', 0, '2025-02-21 22:21:09.969803', '2025-02-21 22:21:12.326093', '2025-02-21 22:21:12.326093', '', '781717609', '', 1, NULL),
(7, 'pbkdf2_sha256$600000$Cv9jJqobBHOgUUykJod2P9$3y+XNKpNGUfweJStYj4a8CQsTQZX1QslxjGoVExRCjM=', NULL, 0, 'ah52025', 'ahmed', 'Nasser', 'johna88d2025.doe@example.com', 0, '2025-02-21 22:23:35.664645', '2025-02-21 22:23:37.720698', '2025-02-21 22:23:37.720779', '', '781717609', '', 1, NULL),
(8, 'pbkdf2_sha256$600000$Mfcg8Cz4Wdyg2T0opTH4hi$822yuUHeaxdSSuG/soPmquQi7R2L9fwvCzoiQJs60m8=', NULL, 0, 'ah1152025', 'ahmed', 'Nasser', 'johna88d2025.d11oe@example.com', 0, '2025-02-21 22:29:20.630741', '2025-02-21 22:29:22.890536', '2025-02-21 22:29:22.890536', 'customer', '781717609', '', 1, NULL);

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
(2, 2, 3);

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
(1, 2, 5);

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
  ADD KEY `bookings_booking_status_id_000bd21d_fk_bookings_bookingstatus_id` (`status_id`),
  ADD KEY `bookings_booking_updated_by_id_6c0bc7d4_fk_users_customuser_id` (`updated_by_id`),
  ADD KEY `bookings_booking_user_id_834dfc23_fk_users_customuser_id` (`user_id`);

--
-- Indexes for table `bookings_bookingdetail`
--
ALTER TABLE `bookings_bookingdetail`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `bookings_bookingdeta_booking_id_12740561_fk_bookings_` (`booking_id`),
  ADD KEY `bookings_bookingdeta_created_by_id_a437326b_fk_users_cus` (`created_by_id`),
  ADD KEY `bookings_bookingdeta_hotel_id_1dc4dae4_fk_HotelMana` (`hotel_id`),
  ADD KEY `bookings_bookingdeta_updated_by_id_263cc972_fk_users_cus` (`updated_by_id`),
  ADD KEY `bookings_bookingdeta_service_id_8dc9681c_fk_services_` (`service_id`);

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
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `HotelManagement_imag_created_by_id_779bde56_fk_users_cus` (`created_by_id`),
  ADD KEY `HotelManagement_imag_hotel_id_e97ababf_fk_HotelMana` (`hotel_id`),
  ADD KEY `HotelManagement_imag_updated_by_id_b3d7d0db_fk_users_cus` (`updated_by_id`);

--
-- Indexes for table `hotelmanagement_location`
--
ALTER TABLE `hotelmanagement_location`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
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
  ADD UNIQUE KEY `unique_room_availability` (`hotel_id`,`room_type_id`,`availability_date`),
  ADD KEY `rooms_availability_created_by_id_168a5943_fk_users_customuser_id` (`created_by_id`),
  ADD KEY `rooms_availability_room_status_id_1add85a0_fk_rooms_roo` (`room_status_id`),
  ADD KEY `rooms_availability_room_type_id_ee87e18f_fk_rooms_roomtype_id` (`room_type_id`),
  ADD KEY `rooms_availability_updated_by_id_f8d6a9d2_fk_users_customuser_id` (`updated_by_id`);

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
-- Indexes for table `services_hotel`
--
ALTER TABLE `services_hotel`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `services_hotelservice`
--
ALTER TABLE `services_hotelservice`
  ADD PRIMARY KEY (`id`),
  ADD KEY `services_hotelservice_hotel_id_c67387c9_fk_services_hotel_id` (`hotel_id`);

--
-- Indexes for table `services_offer`
--
ALTER TABLE `services_offer`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `services_offer_hotel_id_da5add25_fk_services_hotel_id` (`hotel_id`);

--
-- Indexes for table `services_roomtypeservice`
--
ALTER TABLE `services_roomtypeservice`
  ADD PRIMARY KEY (`id`),
  ADD KEY `services_roomtypeservice_hotel_id_163e32a7_fk_services_hotel_id` (`hotel_id`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `hotelmanagement_image`
--
ALTER TABLE `hotelmanagement_image`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `hotelmanagement_location`
--
ALTER TABLE `hotelmanagement_location`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `hotelmanagement_phone`
--
ALTER TABLE `hotelmanagement_phone`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `notifications_notifications`
--
ALTER TABLE `notifications_notifications`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `rooms_category`
--
ALTER TABLE `rooms_category`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `rooms_roomtype`
--
ALTER TABLE `rooms_roomtype`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `services_hotel`
--
ALTER TABLE `services_hotel`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `services_hotelservice`
--
ALTER TABLE `services_hotelservice`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `services_offer`
--
ALTER TABLE `services_offer`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `services_roomtypeservice`
--
ALTER TABLE `services_roomtypeservice`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `token_blacklist_blacklistedtoken`
--
ALTER TABLE `token_blacklist_blacklistedtoken`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `token_blacklist_outstandingtoken`
--
ALTER TABLE `token_blacklist_outstandingtoken`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `users_activitylog`
--
ALTER TABLE `users_activitylog`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users_customuser`
--
ALTER TABLE `users_customuser`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `users_customuser_groups`
--
ALTER TABLE `users_customuser_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users_customuser_user_permissions`
--
ALTER TABLE `users_customuser_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
  ADD CONSTRAINT `services_hotelservice_hotel_id_c67387c9_fk_services_hotel_id` FOREIGN KEY (`hotel_id`) REFERENCES `services_hotel` (`id`);

--
-- Constraints for table `services_offer`
--
ALTER TABLE `services_offer`
  ADD CONSTRAINT `services_offer_hotel_id_da5add25_fk_services_hotel_id` FOREIGN KEY (`hotel_id`) REFERENCES `services_hotel` (`id`);

--
-- Constraints for table `services_roomtypeservice`
--
ALTER TABLE `services_roomtypeservice`
  ADD CONSTRAINT `services_roomtypeservice_hotel_id_163e32a7_fk_services_hotel_id` FOREIGN KEY (`hotel_id`) REFERENCES `services_hotel` (`id`);

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
