-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 03 مايو 2025 الساعة 16:05
-- إصدار الخادم: 10.4.32-MariaDB
-- PHP Version: 8.0.30

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
-- بنية الجدول `accounts_chartofaccounts`
--

CREATE TABLE `accounts_chartofaccounts` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `account_number` varchar(100) NOT NULL,
  `account_name` varchar(100) NOT NULL,
  `account_type` varchar(100) NOT NULL,
  `account_balance` decimal(10,2) NOT NULL,
  `account_description` longtext NOT NULL,
  `account_status` tinyint(1) NOT NULL,
  `account_amount` decimal(10,2) DEFAULT NULL,
  `account_parent_id` bigint(20) DEFAULT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- إرجاع أو استيراد بيانات الجدول `accounts_chartofaccounts`
--

INSERT INTO `accounts_chartofaccounts` (`id`, `created_at`, `updated_at`, `deleted_at`, `account_number`, `account_name`, `account_type`, `account_balance`, `account_description`, `account_status`, `account_amount`, `account_parent_id`, `created_by_id`, `updated_by_id`) VALUES
(1, '2025-05-03 13:57:57.145005', '2025-05-03 13:57:57.145005', NULL, '1100', 'حسابات العملاء', 'Assets', 0.00, 'الحسابات المدينة / العملاء الرئيسية', 1, NULL, NULL, NULL, NULL),
(2, '2025-05-03 13:57:57.152603', '2025-05-03 13:57:57.152603', NULL, '1108467', 'عملاء دائمون -  ', 'Assets', 0.00, 'الحسابات المدينة / العملاء', 1, NULL, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- بنية الجدول `accounts_journalentry`
--

CREATE TABLE `accounts_journalentry` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `journal_entry_number` varchar(100) NOT NULL,
  `journal_entry_date` date NOT NULL,
  `journal_entry_description` longtext NOT NULL,
  `journal_entry_in_amount` decimal(10,2) NOT NULL,
  `journal_entry_out_amount` decimal(10,2) NOT NULL,
  `journal_entry_notes` longtext NOT NULL,
  `journal_entry_currency` varchar(100) NOT NULL,
  `journal_entry_exchange_rate` decimal(10,2) NOT NULL,
  `journal_entry_tax` decimal(10,2) NOT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `journal_entry_account_id` bigint(20) NOT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `authtoken_token`
--

CREATE TABLE `authtoken_token` (
  `key` varchar(40) NOT NULL,
  `created` datetime(6) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- إرجاع أو استيراد بيانات الجدول `auth_group`
--

INSERT INTO `auth_group` (`id`, `name`) VALUES
(1, 'Hotel Managers');

-- --------------------------------------------------------

--
-- بنية الجدول `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- إرجاع أو استيراد بيانات الجدول `auth_group_permissions`
--

INSERT INTO `auth_group_permissions` (`id`, `group_id`, `permission_id`) VALUES
(1, 1, 11),
(2, 1, 12),
(3, 1, 13),
(4, 1, 14),
(8, 1, 31),
(5, 1, 32),
(6, 1, 33),
(7, 1, 34),
(9, 1, 42),
(10, 1, 46),
(11, 1, 51),
(12, 1, 52),
(13, 1, 53),
(14, 1, 54),
(15, 1, 58),
(16, 1, 59),
(17, 1, 60),
(18, 1, 61),
(19, 1, 62),
(20, 1, 63),
(21, 1, 64),
(22, 1, 65),
(23, 1, 66),
(24, 1, 67),
(25, 1, 68),
(26, 1, 69),
(27, 1, 70),
(28, 1, 71),
(29, 1, 72),
(30, 1, 73),
(31, 1, 74),
(32, 1, 75),
(33, 1, 76),
(34, 1, 77),
(35, 1, 78),
(36, 1, 79),
(37, 1, 80),
(38, 1, 81),
(39, 1, 82),
(40, 1, 135),
(41, 1, 136),
(42, 1, 137),
(43, 1, 138),
(44, 1, 139),
(45, 1, 140),
(46, 1, 141),
(47, 1, 142),
(48, 1, 147),
(49, 1, 148),
(50, 1, 149),
(51, 1, 150),
(59, 1, 155),
(60, 1, 156),
(61, 1, 157),
(62, 1, 158),
(63, 1, 159),
(52, 1, 160),
(53, 1, 161),
(54, 1, 162),
(55, 1, 171),
(56, 1, 172),
(57, 1, 173),
(58, 1, 174),
(64, 1, 177),
(65, 1, 178),
(66, 1, 181),
(67, 1, 182),
(72, 1, 187),
(73, 1, 188),
(74, 1, 189),
(75, 1, 190),
(68, 1, 195),
(69, 1, 196),
(70, 1, 197),
(71, 1, 198),
(76, 1, 207),
(77, 1, 208),
(78, 1, 209),
(79, 1, 210),
(80, 1, 211),
(81, 1, 212),
(82, 1, 213),
(83, 1, 214),
(84, 1, 215),
(85, 1, 216),
(86, 1, 217),
(87, 1, 218),
(88, 1, 219),
(89, 1, 220),
(90, 1, 221),
(91, 1, 222);

-- --------------------------------------------------------

--
-- بنية الجدول `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- إرجاع أو استيراد بيانات الجدول `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can approve hotel request', 29, 'can_approve_request'),
(6, 'Can reject hotel request', 29, 'can_reject_request'),
(7, 'Can add permission', 30, 'add_permission'),
(8, 'Can change permission', 30, 'change_permission'),
(9, 'Can delete permission', 30, 'delete_permission'),
(10, 'Can view permission', 30, 'view_permission'),
(11, 'Can add group', 4, 'add_group'),
(12, 'Can change group', 4, 'change_group'),
(13, 'Can delete group', 4, 'delete_group'),
(14, 'Can view group', 4, 'view_group'),
(15, 'Can add content type', 31, 'add_contenttype'),
(16, 'Can change content type', 31, 'change_contenttype'),
(17, 'Can delete content type', 31, 'delete_contenttype'),
(18, 'Can view content type', 31, 'view_contenttype'),
(19, 'Can add session', 32, 'add_session'),
(20, 'Can change session', 32, 'change_session'),
(21, 'Can delete session', 32, 'delete_session'),
(22, 'Can view session', 32, 'view_session'),
(23, 'Can add chart of accounts', 33, 'add_chartofaccounts'),
(24, 'Can change chart of accounts', 33, 'change_chartofaccounts'),
(25, 'Can delete chart of accounts', 33, 'delete_chartofaccounts'),
(26, 'Can view chart of accounts', 33, 'view_chartofaccounts'),
(27, 'Can add journal entry', 34, 'add_journalentry'),
(28, 'Can change journal entry', 34, 'change_journalentry'),
(29, 'Can delete journal entry', 34, 'delete_journalentry'),
(30, 'Can view journal entry', 34, 'view_journalentry'),
(31, 'Can add مستخدم', 2, 'add_customuser'),
(32, 'Can change مستخدم', 2, 'change_customuser'),
(33, 'Can delete مستخدم', 2, 'delete_customuser'),
(34, 'Can view مستخدم', 2, 'view_customuser'),
(35, 'Can add سجل النشاط', 35, 'add_activitylog'),
(36, 'Can change سجل النشاط', 35, 'change_activitylog'),
(37, 'Can delete سجل النشاط', 35, 'delete_activitylog'),
(38, 'Can view سجل النشاط', 35, 'view_activitylog'),
(39, 'Can add منطقه', 20, 'add_city'),
(40, 'Can change منطقه', 20, 'change_city'),
(41, 'Can delete منطقه', 20, 'delete_city'),
(42, 'Can view منطقه', 20, 'view_city'),
(43, 'Can add فندق', 17, 'add_hotel'),
(44, 'Can change فندق', 17, 'change_hotel'),
(45, 'Can delete فندق', 17, 'delete_hotel'),
(46, 'Can view فندق', 17, 'view_hotel'),
(47, 'Can add طلب إضافة فندق', 29, 'add_hotelrequest'),
(48, 'Can change طلب إضافة فندق', 29, 'change_hotelrequest'),
(49, 'Can delete طلب إضافة فندق', 29, 'delete_hotelrequest'),
(50, 'Can view طلب إضافة فندق', 29, 'view_hotelrequest'),
(51, 'Can add صورة', 18, 'add_image'),
(52, 'Can change صورة', 18, 'change_image'),
(53, 'Can delete صورة', 18, 'delete_image'),
(54, 'Can view صورة', 18, 'view_image'),
(55, 'Can add الموقع', 21, 'add_location'),
(56, 'Can change الموقع', 21, 'change_location'),
(57, 'Can delete الموقع', 21, 'delete_location'),
(58, 'Can view الموقع', 21, 'view_location'),
(59, 'Can add رقم هاتف', 19, 'add_phone'),
(60, 'Can change رقم هاتف', 19, 'change_phone'),
(61, 'Can delete رقم هاتف', 19, 'delete_phone'),
(62, 'Can view رقم هاتف', 19, 'view_phone'),
(63, 'Can add توفر الغرف', 9, 'add_availability'),
(64, 'Can change توفر الغرف', 9, 'change_availability'),
(65, 'Can delete توفر الغرف', 9, 'delete_availability'),
(66, 'Can view توفر الغرف', 9, 'view_availability'),
(67, 'Can add تصنيف', 6, 'add_category'),
(68, 'Can change تصنيف', 6, 'change_category'),
(69, 'Can delete تصنيف', 6, 'delete_category'),
(70, 'Can view تصنيف', 6, 'view_category'),
(71, 'Can add صورة الغرفة', 7, 'add_roomimage'),
(72, 'Can change صورة الغرفة', 7, 'change_roomimage'),
(73, 'Can delete صورة الغرفة', 7, 'delete_roomimage'),
(74, 'Can view صورة الغرفة', 7, 'view_roomimage'),
(75, 'Can add سعر الغرفة', 8, 'add_roomprice'),
(76, 'Can change سعر الغرفة', 8, 'change_roomprice'),
(77, 'Can delete سعر الغرفة', 8, 'delete_roomprice'),
(78, 'Can view سعر الغرفة', 8, 'view_roomprice'),
(79, 'Can add نوع الغرفة', 5, 'add_roomtype'),
(80, 'Can change نوع الغرفة', 5, 'change_roomtype'),
(81, 'Can delete نوع الغرفة', 5, 'delete_roomtype'),
(82, 'Can view نوع الغرفة', 5, 'view_roomtype'),
(83, 'Can add contact message', 36, 'add_contactmessage'),
(84, 'Can change contact message', 36, 'change_contactmessage'),
(85, 'Can delete contact message', 36, 'delete_contactmessage'),
(86, 'Can view contact message', 36, 'view_contactmessage'),
(87, 'Can add hero slider', 37, 'add_heroslider'),
(88, 'Can change hero slider', 37, 'change_heroslider'),
(89, 'Can delete hero slider', 37, 'delete_heroslider'),
(90, 'Can view hero slider', 37, 'view_heroslider'),
(91, 'Can add info box', 38, 'add_infobox'),
(92, 'Can change info box', 38, 'change_infobox'),
(93, 'Can delete info box', 38, 'delete_infobox'),
(94, 'Can view info box', 38, 'view_infobox'),
(95, 'Can add partner', 39, 'add_partner'),
(96, 'Can change partner', 39, 'change_partner'),
(97, 'Can delete partner', 39, 'delete_partner'),
(98, 'Can view partner', 39, 'view_partner'),
(99, 'Can add paymen policy', 40, 'add_paymenpolicy'),
(100, 'Can change paymen policy', 40, 'change_paymenpolicy'),
(101, 'Can delete paymen policy', 40, 'delete_paymenpolicy'),
(102, 'Can view paymen policy', 40, 'view_paymenpolicy'),
(103, 'Can add pricing plan', 41, 'add_pricingplan'),
(104, 'Can change pricing plan', 41, 'change_pricingplan'),
(105, 'Can delete pricing plan', 41, 'delete_pricingplan'),
(106, 'Can view pricing plan', 41, 'view_pricingplan'),
(107, 'Can add privacy policy', 42, 'add_privacypolicy'),
(108, 'Can change privacy policy', 42, 'change_privacypolicy'),
(109, 'Can delete privacy policy', 42, 'delete_privacypolicy'),
(110, 'Can view privacy policy', 42, 'view_privacypolicy'),
(111, 'Can add room type home', 43, 'add_roomtypehome'),
(112, 'Can change room type home', 43, 'change_roomtypehome'),
(113, 'Can delete room type home', 43, 'delete_roomtypehome'),
(114, 'Can view room type home', 43, 'view_roomtypehome'),
(115, 'Can add setting', 44, 'add_setting'),
(116, 'Can change setting', 44, 'change_setting'),
(117, 'Can delete setting', 44, 'delete_setting'),
(118, 'Can view setting', 44, 'view_setting'),
(119, 'Can add social media link', 45, 'add_socialmedialink'),
(120, 'Can change social media link', 45, 'change_socialmedialink'),
(121, 'Can delete social media link', 45, 'delete_socialmedialink'),
(122, 'Can view social media link', 45, 'view_socialmedialink'),
(123, 'Can add team member', 46, 'add_teammember'),
(124, 'Can change team member', 46, 'change_teammember'),
(125, 'Can delete team member', 46, 'delete_teammember'),
(126, 'Can view team member', 46, 'view_teammember'),
(127, 'Can add terms conditions', 47, 'add_termsconditions'),
(128, 'Can change terms conditions', 47, 'change_termsconditions'),
(129, 'Can delete terms conditions', 47, 'delete_termsconditions'),
(130, 'Can view terms conditions', 47, 'view_termsconditions'),
(131, 'Can add testimonial', 48, 'add_testimonial'),
(132, 'Can change testimonial', 48, 'change_testimonial'),
(133, 'Can delete testimonial', 48, 'delete_testimonial'),
(134, 'Can view testimonial', 48, 'view_testimonial'),
(135, 'Can add حجز', 12, 'add_booking'),
(136, 'Can change حجز', 12, 'change_booking'),
(137, 'Can delete حجز', 12, 'delete_booking'),
(138, 'Can view حجز', 12, 'view_booking'),
(139, 'Can add تفصيل الحجز', 13, 'add_bookingdetail'),
(140, 'Can change تفصيل الحجز', 13, 'change_bookingdetail'),
(141, 'Can delete تفصيل الحجز', 13, 'delete_bookingdetail'),
(142, 'Can view تفصيل الحجز', 13, 'view_bookingdetail'),
(143, 'Can add سجل الحجز', 49, 'add_bookinghistory'),
(144, 'Can change سجل الحجز', 49, 'change_bookinghistory'),
(145, 'Can delete سجل الحجز', 49, 'delete_bookinghistory'),
(146, 'Can view سجل الحجز', 49, 'view_bookinghistory'),
(147, 'Can add extension movement', 14, 'add_extensionmovement'),
(148, 'Can change extension movement', 14, 'change_extensionmovement'),
(149, 'Can delete extension movement', 14, 'delete_extensionmovement'),
(150, 'Can view extension movement', 14, 'view_extensionmovement'),
(151, 'Can add ضيف', 50, 'add_guest'),
(152, 'Can change ضيف', 50, 'change_guest'),
(153, 'Can delete ضيف', 50, 'delete_guest'),
(154, 'Can view ضيف', 50, 'view_guest'),
(155, 'Can add عملة', 26, 'add_currency'),
(156, 'Can change عملة', 26, 'change_currency'),
(157, 'Can delete عملة', 26, 'delete_currency'),
(158, 'Can view عملة', 26, 'view_currency'),
(159, 'Can add طريقة دفع الفندق', 28, 'add_hotelpaymentmethod'),
(160, 'Can change طريقة دفع الفندق', 28, 'change_hotelpaymentmethod'),
(161, 'Can delete طريقة دفع الفندق', 28, 'delete_hotelpaymentmethod'),
(162, 'Can view طريقة دفع الفندق', 28, 'view_hotelpaymentmethod'),
(163, 'Can add دفعة', 51, 'add_payment'),
(164, 'Can change دفعة', 51, 'change_payment'),
(165, 'Can delete دفعة', 51, 'delete_payment'),
(166, 'Can view دفعة', 51, 'view_payment'),
(167, 'Can add سجل الدفعة', 52, 'add_paymenthistory'),
(168, 'Can change سجل الدفعة', 52, 'change_paymenthistory'),
(169, 'Can delete سجل الدفعة', 52, 'delete_paymenthistory'),
(170, 'Can view سجل الدفعة', 52, 'view_paymenthistory'),
(171, 'Can add طريقة دفع', 27, 'add_paymentoption'),
(172, 'Can change طريقة دفع', 27, 'change_paymentoption'),
(173, 'Can delete طريقة دفع', 27, 'delete_paymentoption'),
(174, 'Can view طريقة دفع', 27, 'view_paymentoption'),
(175, 'Can add مراجعة فندق', 16, 'add_hotelreview'),
(176, 'Can change مراجعة فندق', 16, 'change_hotelreview'),
(177, 'Can delete مراجعة فندق', 16, 'delete_hotelreview'),
(178, 'Can view مراجعة فندق', 16, 'view_hotelreview'),
(179, 'Can add مراجعة غرفة', 15, 'add_roomreview'),
(180, 'Can change مراجعة غرفة', 15, 'change_roomreview'),
(181, 'Can delete مراجعة غرفة', 15, 'delete_roomreview'),
(182, 'Can view مراجعة غرفة', 15, 'view_roomreview'),
(183, 'Can add coupon', 53, 'add_coupon'),
(184, 'Can change coupon', 53, 'change_coupon'),
(185, 'Can delete coupon', 53, 'delete_coupon'),
(186, 'Can view coupon', 53, 'view_coupon'),
(187, 'Can add خدمة فندقية', 11, 'add_hotelservice'),
(188, 'Can change خدمة فندقية', 11, 'change_hotelservice'),
(189, 'Can delete خدمة فندقية', 11, 'delete_hotelservice'),
(190, 'Can view خدمة فندقية', 11, 'view_hotelservice'),
(191, 'Can add عرض', 54, 'add_offer'),
(192, 'Can change عرض', 54, 'change_offer'),
(193, 'Can delete عرض', 54, 'delete_offer'),
(194, 'Can view عرض', 54, 'view_offer'),
(195, 'Can add خدمة نوع الغرفة', 10, 'add_roomtypeservice'),
(196, 'Can change خدمة نوع الغرفة', 10, 'change_roomtypeservice'),
(197, 'Can delete خدمة نوع الغرفة', 10, 'delete_roomtypeservice'),
(198, 'Can view خدمة نوع الغرفة', 10, 'view_roomtypeservice'),
(199, 'Can add blacklisted token', 55, 'add_blacklistedtoken'),
(200, 'Can change blacklisted token', 55, 'change_blacklistedtoken'),
(201, 'Can delete blacklisted token', 55, 'delete_blacklistedtoken'),
(202, 'Can view blacklisted token', 55, 'view_blacklistedtoken'),
(203, 'Can add outstanding token', 56, 'add_outstandingtoken'),
(204, 'Can change outstanding token', 56, 'change_outstandingtoken'),
(205, 'Can delete outstanding token', 56, 'delete_outstandingtoken'),
(206, 'Can view outstanding token', 56, 'view_outstandingtoken'),
(207, 'Can add تصنيف', 24, 'add_category'),
(208, 'Can change تصنيف', 24, 'change_category'),
(209, 'Can delete تصنيف', 24, 'delete_category'),
(210, 'Can view تصنيف', 24, 'view_category'),
(211, 'Can add تعليق', 23, 'add_comment'),
(212, 'Can change تعليق', 23, 'change_comment'),
(213, 'Can delete تعليق', 23, 'delete_comment'),
(214, 'Can view تعليق', 23, 'view_comment'),
(215, 'Can add مقال', 22, 'add_post'),
(216, 'Can change مقال', 22, 'change_post'),
(217, 'Can delete مقال', 22, 'delete_post'),
(218, 'Can view مقال', 22, 'view_post'),
(219, 'Can add وسم', 25, 'add_tag'),
(220, 'Can change وسم', 25, 'change_tag'),
(221, 'Can delete وسم', 25, 'delete_tag'),
(222, 'Can view وسم', 25, 'view_tag'),
(223, 'Can add إشعار', 57, 'add_notifications'),
(224, 'Can change إشعار', 57, 'change_notifications'),
(225, 'Can delete إشعار', 57, 'delete_notifications'),
(226, 'Can view إشعار', 57, 'view_notifications'),
(227, 'Can add المفضلات', 58, 'add_favourites'),
(228, 'Can change المفضلات', 58, 'change_favourites'),
(229, 'Can delete المفضلات', 58, 'delete_favourites'),
(230, 'Can view المفضلات', 58, 'view_favourites'),
(231, 'Can add crontab', 59, 'add_crontabschedule'),
(232, 'Can change crontab', 59, 'change_crontabschedule'),
(233, 'Can delete crontab', 59, 'delete_crontabschedule'),
(234, 'Can view crontab', 59, 'view_crontabschedule'),
(235, 'Can add interval', 60, 'add_intervalschedule'),
(236, 'Can change interval', 60, 'change_intervalschedule'),
(237, 'Can delete interval', 60, 'delete_intervalschedule'),
(238, 'Can view interval', 60, 'view_intervalschedule'),
(239, 'Can add periodic task', 61, 'add_periodictask'),
(240, 'Can change periodic task', 61, 'change_periodictask'),
(241, 'Can delete periodic task', 61, 'delete_periodictask'),
(242, 'Can view periodic task', 61, 'view_periodictask'),
(243, 'Can add periodic task track', 62, 'add_periodictasks'),
(244, 'Can change periodic task track', 62, 'change_periodictasks'),
(245, 'Can delete periodic task track', 62, 'delete_periodictasks'),
(246, 'Can view periodic task track', 62, 'view_periodictasks'),
(247, 'Can add solar event', 63, 'add_solarschedule'),
(248, 'Can change solar event', 63, 'change_solarschedule'),
(249, 'Can delete solar event', 63, 'delete_solarschedule'),
(250, 'Can view solar event', 63, 'view_solarschedule'),
(251, 'Can add clocked', 64, 'add_clockedschedule'),
(252, 'Can change clocked', 64, 'change_clockedschedule'),
(253, 'Can delete clocked', 64, 'delete_clockedschedule'),
(254, 'Can view clocked', 64, 'view_clockedschedule'),
(255, 'Can add Token', 65, 'add_token'),
(256, 'Can change Token', 65, 'change_token'),
(257, 'Can delete Token', 65, 'delete_token'),
(258, 'Can view Token', 65, 'view_token'),
(259, 'Can add token', 66, 'add_tokenproxy'),
(260, 'Can change token', 66, 'change_tokenproxy'),
(261, 'Can delete token', 66, 'delete_tokenproxy'),
(262, 'Can view token', 66, 'view_tokenproxy'),
(263, 'Can add association', 67, 'add_association'),
(264, 'Can change association', 67, 'change_association'),
(265, 'Can delete association', 67, 'delete_association'),
(266, 'Can view association', 67, 'view_association'),
(267, 'Can add code', 68, 'add_code'),
(268, 'Can change code', 68, 'change_code'),
(269, 'Can delete code', 68, 'delete_code'),
(270, 'Can view code', 68, 'view_code'),
(271, 'Can add nonce', 69, 'add_nonce'),
(272, 'Can change nonce', 69, 'change_nonce'),
(273, 'Can delete nonce', 69, 'delete_nonce'),
(274, 'Can view nonce', 69, 'view_nonce'),
(275, 'Can add user social auth', 70, 'add_usersocialauth'),
(276, 'Can change user social auth', 70, 'change_usersocialauth'),
(277, 'Can delete user social auth', 70, 'delete_usersocialauth'),
(278, 'Can view user social auth', 70, 'view_usersocialauth'),
(279, 'Can add partial', 71, 'add_partial'),
(280, 'Can change partial', 71, 'change_partial'),
(281, 'Can delete partial', 71, 'delete_partial'),
(282, 'Can view partial', 71, 'view_partial'),
(283, 'Can add application', 72, 'add_application'),
(284, 'Can change application', 72, 'change_application'),
(285, 'Can delete application', 72, 'delete_application'),
(286, 'Can view application', 72, 'view_application'),
(287, 'Can add access token', 73, 'add_accesstoken'),
(288, 'Can change access token', 73, 'change_accesstoken'),
(289, 'Can delete access token', 73, 'delete_accesstoken'),
(290, 'Can view access token', 73, 'view_accesstoken'),
(291, 'Can add grant', 74, 'add_grant'),
(292, 'Can change grant', 74, 'change_grant'),
(293, 'Can delete grant', 74, 'delete_grant'),
(294, 'Can view grant', 74, 'view_grant'),
(295, 'Can add refresh token', 75, 'add_refreshtoken'),
(296, 'Can change refresh token', 75, 'change_refreshtoken'),
(297, 'Can delete refresh token', 75, 'delete_refreshtoken'),
(298, 'Can view refresh token', 75, 'view_refreshtoken'),
(299, 'Can add id token', 76, 'add_idtoken'),
(300, 'Can change id token', 76, 'change_idtoken'),
(301, 'Can delete id token', 76, 'delete_idtoken'),
(302, 'Can view id token', 76, 'view_idtoken');

-- --------------------------------------------------------

--
-- بنية الجدول `blog_category`
--

CREATE TABLE `blog_category` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `description` longtext NOT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `blog_comment`
--

CREATE TABLE `blog_comment` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `content` longtext NOT NULL,
  `is_approved` tinyint(1) NOT NULL,
  `author_id` bigint(20) NOT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `post_id` bigint(20) NOT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `blog_post`
--

CREATE TABLE `blog_post` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `title` varchar(200) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `content` longtext NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  `published_at` datetime(6) NOT NULL,
  `is_published` tinyint(1) NOT NULL,
  `views` int(10) UNSIGNED NOT NULL CHECK (`views` >= 0),
  `author_id` bigint(20) NOT NULL,
  `category_id` bigint(20) DEFAULT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `blog_post_tags`
--

CREATE TABLE `blog_post_tags` (
  `id` bigint(20) NOT NULL,
  `post_id` bigint(20) NOT NULL,
  `tag_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `blog_tag`
--

CREATE TABLE `blog_tag` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `bookings_booking`
--

CREATE TABLE `bookings_booking` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
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
-- بنية الجدول `bookings_bookingdetail`
--

CREATE TABLE `bookings_bookingdetail` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
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
-- بنية الجدول `bookings_bookinghistory`
--

CREATE TABLE `bookings_bookinghistory` (
  `id` bigint(20) NOT NULL,
  `history_date` datetime(6) NOT NULL,
  `previous_status` varchar(10) DEFAULT NULL,
  `new_status` varchar(10) NOT NULL,
  `check_in_date` datetime(6) DEFAULT NULL,
  `check_out_date` datetime(6) DEFAULT NULL,
  `actual_check_out_date` datetime(6) DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL,
  `account_status` tinyint(1) NOT NULL,
  `rooms_booked` int(10) UNSIGNED NOT NULL CHECK (`rooms_booked` >= 0),
  `booking_id` bigint(20) NOT NULL,
  `changed_by_id` bigint(20) DEFAULT NULL,
  `hotel_id` bigint(20) NOT NULL,
  `parent_booking_id` bigint(20) DEFAULT NULL,
  `room_id` bigint(20) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `bookings_extensionmovement`
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
-- بنية الجدول `bookings_guest`
--

CREATE TABLE `bookings_guest` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `name` varchar(150) NOT NULL,
  `phone_number` varchar(14) NOT NULL,
  `id_card_image` varchar(100) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `birthday_date` date DEFAULT NULL,
  `check_in_date` datetime(6) DEFAULT NULL,
  `check_out_date` datetime(6) DEFAULT NULL,
  `booking_id` bigint(20) NOT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `hotel_id` bigint(20) NOT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `customer_favourites`
--

CREATE TABLE `customer_favourites` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `hotel_id` bigint(20) NOT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `django_admin_log`
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
-- إرجاع أو استيراد بيانات الجدول `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
(1, '2025-05-03 13:58:29.968327', '1', 'sanaa, sanaa, اليمن', 1, '[{\"added\": {}}]', 20, 1),
(2, '2025-05-03 13:58:45.649603', '1', 'وسط المدينة، بالقرب من الدائري', 1, '[{\"added\": {}}]', 21, 1);

-- --------------------------------------------------------

--
-- بنية الجدول `django_celery_beat_clockedschedule`
--

CREATE TABLE `django_celery_beat_clockedschedule` (
  `id` int(11) NOT NULL,
  `clocked_time` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `django_celery_beat_crontabschedule`
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
-- بنية الجدول `django_celery_beat_intervalschedule`
--

CREATE TABLE `django_celery_beat_intervalschedule` (
  `id` int(11) NOT NULL,
  `every` int(11) NOT NULL,
  `period` varchar(24) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `django_celery_beat_periodictask`
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
-- بنية الجدول `django_celery_beat_periodictasks`
--

CREATE TABLE `django_celery_beat_periodictasks` (
  `ident` smallint(6) NOT NULL,
  `last_update` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `django_celery_beat_solarschedule`
--

CREATE TABLE `django_celery_beat_solarschedule` (
  `id` int(11) NOT NULL,
  `event` varchar(24) NOT NULL,
  `latitude` decimal(9,6) NOT NULL,
  `longitude` decimal(9,6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- إرجاع أو استيراد بيانات الجدول `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(33, 'accounts', 'chartofaccounts'),
(34, 'accounts', 'journalentry'),
(1, 'admin', 'logentry'),
(4, 'auth', 'group'),
(30, 'auth', 'permission'),
(3, 'auth', 'user'),
(65, 'authtoken', 'token'),
(66, 'authtoken', 'tokenproxy'),
(24, 'blog', 'category'),
(23, 'blog', 'comment'),
(22, 'blog', 'post'),
(25, 'blog', 'tag'),
(12, 'bookings', 'booking'),
(13, 'bookings', 'bookingdetail'),
(49, 'bookings', 'bookinghistory'),
(14, 'bookings', 'extensionmovement'),
(50, 'bookings', 'guest'),
(31, 'contenttypes', 'contenttype'),
(58, 'customer', 'favourites'),
(64, 'django_celery_beat', 'clockedschedule'),
(59, 'django_celery_beat', 'crontabschedule'),
(60, 'django_celery_beat', 'intervalschedule'),
(61, 'django_celery_beat', 'periodictask'),
(62, 'django_celery_beat', 'periodictasks'),
(63, 'django_celery_beat', 'solarschedule'),
(36, 'home', 'contactmessage'),
(37, 'home', 'heroslider'),
(38, 'home', 'infobox'),
(39, 'home', 'partner'),
(40, 'home', 'paymenpolicy'),
(41, 'home', 'pricingplan'),
(42, 'home', 'privacypolicy'),
(43, 'home', 'roomtypehome'),
(44, 'home', 'setting'),
(45, 'home', 'socialmedialink'),
(46, 'home', 'teammember'),
(47, 'home', 'termsconditions'),
(48, 'home', 'testimonial'),
(20, 'HotelManagement', 'city'),
(17, 'HotelManagement', 'hotel'),
(29, 'HotelManagement', 'hotelrequest'),
(18, 'HotelManagement', 'image'),
(21, 'HotelManagement', 'location'),
(19, 'HotelManagement', 'phone'),
(57, 'notifications', 'notifications'),
(73, 'oauth2_provider', 'accesstoken'),
(72, 'oauth2_provider', 'application'),
(74, 'oauth2_provider', 'grant'),
(76, 'oauth2_provider', 'idtoken'),
(75, 'oauth2_provider', 'refreshtoken'),
(26, 'payments', 'currency'),
(28, 'payments', 'hotelpaymentmethod'),
(51, 'payments', 'payment'),
(52, 'payments', 'paymenthistory'),
(27, 'payments', 'paymentoption'),
(16, 'reviews', 'hotelreview'),
(15, 'reviews', 'roomreview'),
(9, 'rooms', 'availability'),
(6, 'rooms', 'category'),
(7, 'rooms', 'roomimage'),
(8, 'rooms', 'roomprice'),
(5, 'rooms', 'roomtype'),
(53, 'services', 'coupon'),
(11, 'services', 'hotelservice'),
(54, 'services', 'offer'),
(10, 'services', 'roomtypeservice'),
(32, 'sessions', 'session'),
(67, 'social_django', 'association'),
(68, 'social_django', 'code'),
(69, 'social_django', 'nonce'),
(71, 'social_django', 'partial'),
(70, 'social_django', 'usersocialauth'),
(55, 'token_blacklist', 'blacklistedtoken'),
(56, 'token_blacklist', 'outstandingtoken'),
(35, 'users', 'activitylog'),
(2, 'users', 'customuser');

-- --------------------------------------------------------

--
-- بنية الجدول `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- إرجاع أو استيراد بيانات الجدول `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2025-05-03 13:53:59.637213'),
(2, 'contenttypes', '0002_remove_content_type_name', '2025-05-03 13:53:59.736573'),
(3, 'auth', '0001_initial', '2025-05-03 13:54:00.058859'),
(4, 'auth', '0002_alter_permission_name_max_length', '2025-05-03 13:54:00.138604'),
(5, 'auth', '0003_alter_user_email_max_length', '2025-05-03 13:54:00.146602'),
(6, 'auth', '0004_alter_user_username_opts', '2025-05-03 13:54:00.155230'),
(7, 'auth', '0005_alter_user_last_login_null', '2025-05-03 13:54:00.166884'),
(8, 'auth', '0006_require_contenttypes_0002', '2025-05-03 13:54:00.171627'),
(9, 'auth', '0007_alter_validators_add_error_messages', '2025-05-03 13:54:00.180857'),
(10, 'auth', '0008_alter_user_username_max_length', '2025-05-03 13:54:00.198282'),
(11, 'auth', '0009_alter_user_last_name_max_length', '2025-05-03 13:54:00.215280'),
(12, 'auth', '0010_alter_group_name_max_length', '2025-05-03 13:54:00.240390'),
(13, 'auth', '0011_update_proxy_permissions', '2025-05-03 13:54:00.253860'),
(14, 'auth', '0012_alter_user_first_name_max_length', '2025-05-03 13:54:00.262865'),
(15, 'accounts', '0001_initial', '2025-05-03 13:54:00.312888'),
(16, 'users', '0001_initial', '2025-05-03 13:54:01.187331'),
(17, 'HotelManagement', '0001_initial', '2025-05-03 13:54:01.438238'),
(18, 'HotelManagement', '0002_initial', '2025-05-03 13:54:03.186365'),
(19, 'accounts', '0002_initial', '2025-05-03 13:54:03.735366'),
(20, 'admin', '0001_initial', '2025-05-03 13:54:03.950678'),
(21, 'admin', '0002_logentry_remove_auto_add', '2025-05-03 13:54:03.971772'),
(22, 'admin', '0003_logentry_add_action_flag_choices', '2025-05-03 13:54:03.996784'),
(23, 'authtoken', '0001_initial', '2025-05-03 13:54:04.184993'),
(24, 'authtoken', '0002_auto_20160226_1747', '2025-05-03 13:54:04.296951'),
(25, 'authtoken', '0003_tokenproxy', '2025-05-03 13:54:04.302970'),
(26, 'blog', '0001_initial', '2025-05-03 13:54:04.419412'),
(27, 'blog', '0002_initial', '2025-05-03 13:54:05.836568'),
(28, 'services', '0001_initial', '2025-05-03 13:54:05.946591'),
(29, 'rooms', '0001_initial', '2025-05-03 13:54:06.119850'),
(30, 'payments', '0001_initial', '2025-05-03 13:54:06.220863'),
(31, 'bookings', '0001_initial', '2025-05-03 13:54:06.386158'),
(32, 'bookings', '0002_initial', '2025-05-03 13:54:08.848114'),
(33, 'customer', '0001_initial', '2025-05-03 13:54:08.887708'),
(34, 'customer', '0002_initial', '2025-05-03 13:54:09.381500'),
(35, 'django_celery_beat', '0001_initial', '2025-05-03 13:54:09.625548'),
(36, 'django_celery_beat', '0002_auto_20161118_0346', '2025-05-03 13:54:09.737421'),
(37, 'django_celery_beat', '0003_auto_20161209_0049', '2025-05-03 13:54:09.782115'),
(38, 'django_celery_beat', '0004_auto_20170221_0000', '2025-05-03 13:54:09.788431'),
(39, 'django_celery_beat', '0005_add_solarschedule_events_choices', '2025-05-03 13:54:09.822075'),
(40, 'django_celery_beat', '0006_auto_20180322_0932', '2025-05-03 13:54:10.002995'),
(41, 'django_celery_beat', '0007_auto_20180521_0826', '2025-05-03 13:54:10.054897'),
(42, 'django_celery_beat', '0008_auto_20180914_1922', '2025-05-03 13:54:10.142474'),
(43, 'django_celery_beat', '0006_auto_20180210_1226', '2025-05-03 13:54:10.183342'),
(44, 'django_celery_beat', '0006_periodictask_priority', '2025-05-03 13:54:10.208736'),
(45, 'django_celery_beat', '0009_periodictask_headers', '2025-05-03 13:54:10.248169'),
(46, 'django_celery_beat', '0010_auto_20190429_0326', '2025-05-03 13:54:10.541942'),
(47, 'django_celery_beat', '0011_auto_20190508_0153', '2025-05-03 13:54:10.670887'),
(48, 'django_celery_beat', '0012_periodictask_expire_seconds', '2025-05-03 13:54:10.704842'),
(49, 'django_celery_beat', '0013_auto_20200609_0727', '2025-05-03 13:54:10.721926'),
(50, 'django_celery_beat', '0014_remove_clockedschedule_enabled', '2025-05-03 13:54:10.754140'),
(51, 'django_celery_beat', '0015_edit_solarschedule_events_choices', '2025-05-03 13:54:10.771170'),
(52, 'django_celery_beat', '0016_alter_crontabschedule_timezone', '2025-05-03 13:54:10.813328'),
(53, 'django_celery_beat', '0017_alter_crontabschedule_month_of_year', '2025-05-03 13:54:10.846594'),
(54, 'django_celery_beat', '0018_improve_crontab_helptext', '2025-05-03 13:54:10.879082'),
(55, 'django_celery_beat', '0019_alter_periodictasks_options', '2025-05-03 13:54:10.879082'),
(56, 'home', '0001_initial', '2025-05-03 13:54:11.178084'),
(57, 'home', '0002_initial', '2025-05-03 13:54:11.872352'),
(58, 'notifications', '0001_initial', '2025-05-03 13:54:11.902019'),
(59, 'notifications', '0002_initial', '2025-05-03 13:54:12.412584'),
(60, 'oauth2_provider', '0001_initial', '2025-05-03 13:54:13.456766'),
(61, 'oauth2_provider', '0002_auto_20190406_1805', '2025-05-03 13:54:13.588853'),
(62, 'oauth2_provider', '0003_auto_20201211_1314', '2025-05-03 13:54:13.720079'),
(63, 'oauth2_provider', '0004_auto_20200902_2022', '2025-05-03 13:54:14.367304'),
(64, 'oauth2_provider', '0005_auto_20211222_2352', '2025-05-03 13:54:14.614844'),
(65, 'oauth2_provider', '0006_alter_application_client_secret', '2025-05-03 13:54:14.754300'),
(66, 'oauth2_provider', '0007_application_post_logout_redirect_uris', '2025-05-03 13:54:14.825333'),
(67, 'oauth2_provider', '0008_alter_accesstoken_token', '2025-05-03 13:54:15.001276'),
(68, 'oauth2_provider', '0009_add_hash_client_secret', '2025-05-03 13:54:15.072162'),
(69, 'oauth2_provider', '0010_application_allowed_origins', '2025-05-03 13:54:15.173752'),
(70, 'payments', '0002_initial', '2025-05-03 13:54:17.649709'),
(71, 'reviews', '0001_initial', '2025-05-03 13:54:17.705550'),
(72, 'reviews', '0002_initial', '2025-05-03 13:54:19.087229'),
(73, 'rooms', '0002_initial', '2025-05-03 13:54:21.721911'),
(74, 'services', '0002_initial', '2025-05-03 13:54:23.619820'),
(75, 'sessions', '0001_initial', '2025-05-03 13:54:23.673023'),
(76, 'default', '0001_initial', '2025-05-03 13:54:24.024576'),
(77, 'social_auth', '0001_initial', '2025-05-03 13:54:24.024576'),
(78, 'default', '0002_add_related_name', '2025-05-03 13:54:24.130418'),
(79, 'social_auth', '0002_add_related_name', '2025-05-03 13:54:24.136419'),
(80, 'default', '0003_alter_email_max_length', '2025-05-03 13:54:24.154136'),
(81, 'social_auth', '0003_alter_email_max_length', '2025-05-03 13:54:24.159615'),
(82, 'default', '0004_auto_20160423_0400', '2025-05-03 13:54:24.335188'),
(83, 'social_auth', '0004_auto_20160423_0400', '2025-05-03 13:54:24.350781'),
(84, 'social_auth', '0005_auto_20160727_2333', '2025-05-03 13:54:24.373664'),
(85, 'social_django', '0006_partial', '2025-05-03 13:54:24.439273'),
(86, 'social_django', '0007_code_timestamp', '2025-05-03 13:54:24.500241'),
(87, 'social_django', '0008_partial_timestamp', '2025-05-03 13:54:24.557340'),
(88, 'social_django', '0009_auto_20191118_0520', '2025-05-03 13:54:24.717714'),
(89, 'social_django', '0010_uid_db_index', '2025-05-03 13:54:24.831971'),
(90, 'social_django', '0011_alter_id_fields', '2025-05-03 13:54:25.266856'),
(91, 'social_django', '0012_usersocialauth_extra_data_new', '2025-05-03 13:54:25.386324'),
(92, 'social_django', '0013_migrate_extra_data', '2025-05-03 13:54:25.489458'),
(93, 'social_django', '0014_remove_usersocialauth_extra_data', '2025-05-03 13:54:25.589402'),
(94, 'social_django', '0015_rename_extra_data_new_usersocialauth_extra_data', '2025-05-03 13:54:25.831494'),
(95, 'social_django', '0016_alter_usersocialauth_extra_data', '2025-05-03 13:54:25.922237'),
(96, 'token_blacklist', '0001_initial', '2025-05-03 13:54:26.332508'),
(97, 'token_blacklist', '0002_outstandingtoken_jti_hex', '2025-05-03 13:54:26.444025'),
(98, 'token_blacklist', '0003_auto_20171017_2007', '2025-05-03 13:54:26.555125'),
(99, 'token_blacklist', '0004_auto_20171017_2013', '2025-05-03 13:54:26.772105'),
(100, 'token_blacklist', '0005_remove_outstandingtoken_jti', '2025-05-03 13:54:26.872799'),
(101, 'token_blacklist', '0006_auto_20171017_2113', '2025-05-03 13:54:26.964711'),
(102, 'token_blacklist', '0007_auto_20171017_2214', '2025-05-03 13:54:27.503494'),
(103, 'token_blacklist', '0008_migrate_to_bigautofield', '2025-05-03 13:54:28.041995'),
(104, 'token_blacklist', '0010_fix_migrate_to_bigautofield', '2025-05-03 13:54:28.148108'),
(105, 'token_blacklist', '0011_linearizes_history', '2025-05-03 13:54:28.156101'),
(106, 'token_blacklist', '0012_alter_outstandingtoken_user', '2025-05-03 13:54:28.245963'),
(107, 'social_django', '0004_auto_20160423_0400', '2025-05-03 13:54:28.256044'),
(108, 'social_django', '0005_auto_20160727_2333', '2025-05-03 13:54:28.256044'),
(109, 'social_django', '0003_alter_email_max_length', '2025-05-03 13:54:28.256044'),
(110, 'social_django', '0002_add_related_name', '2025-05-03 13:54:28.276028'),
(111, 'social_django', '0001_initial', '2025-05-03 13:54:28.279737');

-- --------------------------------------------------------

--
-- بنية الجدول `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- إرجاع أو استيراد بيانات الجدول `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('0owe6yi3i0ni9fotkh66r6zskjth0ejg', 'e30:1uBDKr:N8XFy__4jnTsFwN5uP2GNJRCReOiB939uoOPRcJYllE', '2025-05-17 13:55:21.989086'),
('dxq1c9igy9xoickj5rwt8l6y45rxnwjx', '.eJxVjDsOwjAQRO_iGln-JJtPSc8ZrI13TQzIjuJEAiHuTiKlgG408-a9hcN1Gd1aeHaRRC-0OP12A_o7p32gG6Zrlj6nZY6D3BF5rEVeMvHjfLB_ghHLuL3b1hKGSoNHQgPGgu8CKWuqUFfQKWXRkNqCD3UIrKEBXUOjiRlsp5tdWriUmJPj5xTnl-jV5wt1HD6E:1uBDPl:3CgEWV8sZY8jVtJthKpV_q7yaJAuoqPlq1ap4n9fmsg', '2025-05-17 14:00:25.090568'),
('g9nhx6hto6djk2luyrc0m1ldm9tnvjx0', 'e30:1uBDLS:xeqflpyx5aUDKx8lOTW2QaUVyGdFf4WzVN_x8bfmD3E', '2025-05-17 13:55:58.134004'),
('gyxx7xwcvuadt7h0yc1eyf54cq620482', 'e30:1uBDLe:F5Fm80TbHNonyAZh4XCuLyV726B_ADPh4bWBLefxYmY', '2025-05-17 13:56:10.169472'),
('t0lhd7czt98iylaw35bo0mqx8vu3i4io', 'e30:1uBDLI:bJBE3dU6vJFjI438W9iBzFERBU5sKRxZCnyEHSdOGBg', '2025-05-17 13:55:48.197031'),
('wkkqfcfs1fq0p1mhwu4clz38iilfulwf', 'e30:1uBDKy:ZFRsDkbdevUns3a7V8iYMw9LdgBTYmBoVOhY5ZM4kHY', '2025-05-17 13:55:28.441413');

-- --------------------------------------------------------

--
-- بنية الجدول `home_contactmessage`
--

CREATE TABLE `home_contactmessage` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(254) NOT NULL,
  `message` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `is_read` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `home_heroslider`
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
-- بنية الجدول `home_infobox`
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
-- بنية الجدول `home_partner`
--

CREATE TABLE `home_partner` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` longtext NOT NULL,
  `image` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `home_paymenpolicy`
--

CREATE TABLE `home_paymenpolicy` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `name` varchar(150) NOT NULL,
  `content` longtext NOT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `home_pricingplan`
--

CREATE TABLE `home_pricingplan` (
  `id` bigint(20) NOT NULL,
  `title` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `duration` varchar(50) NOT NULL,
  `features` longtext NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_primary` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `home_privacypolicy`
--

CREATE TABLE `home_privacypolicy` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `name` varchar(150) NOT NULL,
  `content` longtext NOT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `home_roomtypehome`
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
-- بنية الجدول `home_setting`
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
-- بنية الجدول `home_socialmedialink`
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
-- بنية الجدول `home_teammember`
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
-- بنية الجدول `home_termsconditions`
--

CREATE TABLE `home_termsconditions` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `name` varchar(150) NOT NULL,
  `content` longtext NOT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `home_testimonial`
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
-- بنية الجدول `hotelmanagement_city`
--

CREATE TABLE `hotelmanagement_city` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `state` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `country` varchar(255) NOT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- إرجاع أو استيراد بيانات الجدول `hotelmanagement_city`
--

INSERT INTO `hotelmanagement_city` (`id`, `created_at`, `updated_at`, `deleted_at`, `state`, `slug`, `country`, `created_by_id`, `updated_by_id`) VALUES
(1, '2025-05-03 13:58:29.968327', '2025-05-03 13:58:29.968327', NULL, 'sanaa, sanaa', 'ssss', 'اليمن', NULL, NULL);

-- --------------------------------------------------------

--
-- بنية الجدول `hotelmanagement_hotel`
--

CREATE TABLE `hotelmanagement_hotel` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
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
-- إرجاع أو استيراد بيانات الجدول `hotelmanagement_hotel`
--

INSERT INTO `hotelmanagement_hotel` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `slug`, `profile_picture`, `description`, `business_license_number`, `document_path`, `is_verified`, `verification_date`, `created_by_id`, `location_id`, `manager_id`, `updated_by_id`) VALUES
(1, '2025-05-03 14:00:46.750768', '2025-05-03 14:00:46.750768', NULL, 'فندق عمار', '', 'hotel_requests/profile_pictures/ammarcv_QEyzv6F.png', 'الالاا', 'hgkfvhs', 'hotel_requests/documents/2025/05/03/ammarcv.png', 1, '2025-05-03 14:00:46.750768', 1, 1, 2, NULL);

-- --------------------------------------------------------

--
-- بنية الجدول `hotelmanagement_hotelrequest`
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
-- إرجاع أو استيراد بيانات الجدول `hotelmanagement_hotelrequest`
--

INSERT INTO `hotelmanagement_hotelrequest` (`id`, `name`, `email`, `role`, `hotel_name`, `description`, `profile_picture`, `business_license_number`, `document_path`, `additional_images`, `country`, `state`, `city_name`, `address`, `country_code`, `phone_number`, `is_approved`, `approved_at`, `created_at`, `updated_at`, `approved_by_id`, `created_by_id`, `updated_by_id`) VALUES
(1, 'فندق النبراس', 'ammar@test.com', 'مدير فندق', 'فندق عمار', 'الالاا', 'hotel_requests/profile_pictures/ammarcv_QEyzv6F.png', 'hgkfvhs', 'hotel_requests/documents/2025/05/03/ammarcv.png', '\"[{\\\"image_path\\\": \\\"hotels/images/ammarcv.png\\\"}]\"', 'اليمن', 'sanaa, sanaa', '', 'وسط المدينة، بالقرب من الدائري', 'اليمن', '0777782439', 1, '2025-05-03 14:00:46.784371', '2025-05-03 14:00:18.317378', '2025-05-03 14:00:46.784371', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- بنية الجدول `hotelmanagement_image`
--

CREATE TABLE `hotelmanagement_image` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `image_path` varchar(100) DEFAULT NULL,
  `image_url` varchar(3000) DEFAULT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `hotel_id` bigint(20) NOT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- إرجاع أو استيراد بيانات الجدول `hotelmanagement_image`
--

INSERT INTO `hotelmanagement_image` (`id`, `created_at`, `updated_at`, `deleted_at`, `image_path`, `image_url`, `created_by_id`, `hotel_id`, `updated_by_id`) VALUES
(1, '2025-05-03 14:00:46.776933', '2025-05-03 14:00:46.776933', NULL, 'hotels/images/ammarcv.png', NULL, 1, 1, NULL);

-- --------------------------------------------------------

--
-- بنية الجدول `hotelmanagement_location`
--

CREATE TABLE `hotelmanagement_location` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `address` varchar(255) NOT NULL,
  `city_id` bigint(20) NOT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- إرجاع أو استيراد بيانات الجدول `hotelmanagement_location`
--

INSERT INTO `hotelmanagement_location` (`id`, `created_at`, `updated_at`, `deleted_at`, `address`, `city_id`, `created_by_id`, `updated_by_id`) VALUES
(1, '2025-05-03 13:58:45.638642', '2025-05-03 13:58:45.638642', NULL, 'وسط المدينة، بالقرب من الدائري', 1, NULL, 1);

-- --------------------------------------------------------

--
-- بنية الجدول `hotelmanagement_phone`
--

CREATE TABLE `hotelmanagement_phone` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `phone_number` varchar(10) NOT NULL,
  `country_code` varchar(5) NOT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `hotel_id` bigint(20) NOT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- إرجاع أو استيراد بيانات الجدول `hotelmanagement_phone`
--

INSERT INTO `hotelmanagement_phone` (`id`, `created_at`, `updated_at`, `deleted_at`, `phone_number`, `country_code`, `created_by_id`, `hotel_id`, `updated_by_id`) VALUES
(1, '2025-05-03 14:00:46.766353', '2025-05-03 14:00:46.766353', NULL, '0777782439', 'اليمن', 1, 1, NULL);

-- --------------------------------------------------------

--
-- بنية الجدول `notifications_notifications`
--

CREATE TABLE `notifications_notifications` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `recipient_type` varchar(50) NOT NULL,
  `title` varchar(255) NOT NULL,
  `message` longtext NOT NULL,
  `send_time` datetime(6) NOT NULL,
  `status` varchar(50) NOT NULL,
  `notification_type` varchar(50) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `action_url` varchar(255) DEFAULT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `sender_id` bigint(20) NOT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `oauth2_provider_accesstoken`
--

CREATE TABLE `oauth2_provider_accesstoken` (
  `id` bigint(20) NOT NULL,
  `token` varchar(255) NOT NULL,
  `expires` datetime(6) NOT NULL,
  `scope` longtext NOT NULL,
  `application_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `source_refresh_token_id` bigint(20) DEFAULT NULL,
  `id_token_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `oauth2_provider_application`
--

CREATE TABLE `oauth2_provider_application` (
  `id` bigint(20) NOT NULL,
  `client_id` varchar(100) NOT NULL,
  `redirect_uris` longtext NOT NULL,
  `client_type` varchar(32) NOT NULL,
  `authorization_grant_type` varchar(32) NOT NULL,
  `client_secret` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `skip_authorization` tinyint(1) NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `algorithm` varchar(5) NOT NULL,
  `post_logout_redirect_uris` longtext NOT NULL,
  `hash_client_secret` tinyint(1) NOT NULL,
  `allowed_origins` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `oauth2_provider_grant`
--

CREATE TABLE `oauth2_provider_grant` (
  `id` bigint(20) NOT NULL,
  `code` varchar(255) NOT NULL,
  `expires` datetime(6) NOT NULL,
  `redirect_uri` longtext NOT NULL,
  `scope` longtext NOT NULL,
  `application_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `code_challenge` varchar(128) NOT NULL,
  `code_challenge_method` varchar(10) NOT NULL,
  `nonce` varchar(255) NOT NULL,
  `claims` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `oauth2_provider_idtoken`
--

CREATE TABLE `oauth2_provider_idtoken` (
  `id` bigint(20) NOT NULL,
  `jti` char(32) NOT NULL,
  `expires` datetime(6) NOT NULL,
  `scope` longtext NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `application_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `oauth2_provider_refreshtoken`
--

CREATE TABLE `oauth2_provider_refreshtoken` (
  `id` bigint(20) NOT NULL,
  `token` varchar(255) NOT NULL,
  `access_token_id` bigint(20) DEFAULT NULL,
  `application_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `revoked` datetime(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `payments_currency`
--

CREATE TABLE `payments_currency` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `currency_name` varchar(50) NOT NULL,
  `currency_symbol` varchar(10) NOT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `hotel_id` bigint(20) NOT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `payments_hotelpaymentmethod`
--

CREATE TABLE `payments_hotelpaymentmethod` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `account_name` varchar(100) DEFAULT NULL,
  `account_number` varchar(50) DEFAULT NULL,
  `iban` varchar(50) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `hotel_id` bigint(20) NOT NULL,
  `payment_option_id` bigint(20) NOT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `payments_payment`
--

CREATE TABLE `payments_payment` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
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
  `payment_discount_code` varchar(100) DEFAULT NULL,
  `booking_id` bigint(20) NOT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `payment_method_id` bigint(20) NOT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `payments_paymenthistory`
--

CREATE TABLE `payments_paymenthistory` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `history_date` datetime(6) NOT NULL,
  `previous_payment_status` int(11) DEFAULT NULL,
  `new_payment_status` int(11) NOT NULL,
  `previous_payment_totalamount` decimal(10,2) DEFAULT NULL,
  `new_payment_totalamount` decimal(10,2) NOT NULL,
  `previous_payment_discount` decimal(10,2) DEFAULT NULL,
  `new_payment_discount` decimal(10,2) NOT NULL,
  `previous_payment_discount_code` varchar(100) DEFAULT NULL,
  `new_payment_discount_code` varchar(100) DEFAULT NULL,
  `note` longtext DEFAULT NULL,
  `changed_by_id` bigint(20) DEFAULT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `payment_id` bigint(20) NOT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `payments_paymentoption`
--

CREATE TABLE `payments_paymentoption` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `method_name` varchar(100) NOT NULL,
  `logo` varchar(100) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `currency_id` bigint(20) NOT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `reviews_hotelreview`
--

CREATE TABLE `reviews_hotelreview` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
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
-- بنية الجدول `reviews_roomreview`
--

CREATE TABLE `reviews_roomreview` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
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
-- بنية الجدول `rooms_availability`
--

CREATE TABLE `rooms_availability` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `availability_date` date NOT NULL,
  `available_rooms` int(10) UNSIGNED NOT NULL CHECK (`available_rooms` >= 0),
  `notes` longtext DEFAULT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `hotel_id` bigint(20) NOT NULL,
  `room_type_id` bigint(20) NOT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `rooms_category`
--

CREATE TABLE `rooms_category` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` longtext DEFAULT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `rooms_roomimage`
--

CREATE TABLE `rooms_roomimage` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `image` varchar(100) NOT NULL,
  `is_main` tinyint(1) NOT NULL,
  `caption` varchar(255) DEFAULT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `hotel_id` bigint(20) NOT NULL,
  `room_type_id` bigint(20) NOT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `rooms_roomprice`
--

CREATE TABLE `rooms_roomprice` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
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
-- بنية الجدول `rooms_roomtype`
--

CREATE TABLE `rooms_roomtype` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
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

-- --------------------------------------------------------

--
-- بنية الجدول `services_coupon`
--

CREATE TABLE `services_coupon` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `quantity` int(11) NOT NULL,
  `min_purchase_amount` int(11) NOT NULL,
  `expired_date` date NOT NULL,
  `discount_type` varchar(10) NOT NULL,
  `discount` double NOT NULL,
  `status` tinyint(1) NOT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `hotel_id` bigint(20) NOT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `services_hotelservice`
--

CREATE TABLE `services_hotelservice` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `icon` varchar(100) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `hotel_id` bigint(20) NOT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `services_roomtypeservice`
--

CREATE TABLE `services_roomtypeservice` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `icon` varchar(100) DEFAULT NULL,
  `additional_fee` double NOT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `hotel_id` bigint(20) NOT NULL,
  `room_type_id` bigint(20) NOT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `service_offers`
--

CREATE TABLE `service_offers` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
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
-- بنية الجدول `social_auth_association`
--

CREATE TABLE `social_auth_association` (
  `id` bigint(20) NOT NULL,
  `server_url` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `secret` varchar(255) NOT NULL,
  `issued` int(11) NOT NULL,
  `lifetime` int(11) NOT NULL,
  `assoc_type` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `social_auth_code`
--

CREATE TABLE `social_auth_code` (
  `id` bigint(20) NOT NULL,
  `email` varchar(254) NOT NULL,
  `code` varchar(32) NOT NULL,
  `verified` tinyint(1) NOT NULL,
  `timestamp` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `social_auth_nonce`
--

CREATE TABLE `social_auth_nonce` (
  `id` bigint(20) NOT NULL,
  `server_url` varchar(255) NOT NULL,
  `timestamp` int(11) NOT NULL,
  `salt` varchar(65) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `social_auth_partial`
--

CREATE TABLE `social_auth_partial` (
  `id` bigint(20) NOT NULL,
  `token` varchar(32) NOT NULL,
  `next_step` smallint(5) UNSIGNED NOT NULL CHECK (`next_step` >= 0),
  `backend` varchar(32) NOT NULL,
  `timestamp` datetime(6) NOT NULL,
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`data`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `social_auth_usersocialauth`
--

CREATE TABLE `social_auth_usersocialauth` (
  `id` bigint(20) NOT NULL,
  `provider` varchar(32) NOT NULL,
  `uid` varchar(255) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `extra_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`extra_data`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `token_blacklist_blacklistedtoken`
--

CREATE TABLE `token_blacklist_blacklistedtoken` (
  `id` bigint(20) NOT NULL,
  `blacklisted_at` datetime(6) NOT NULL,
  `token_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `token_blacklist_outstandingtoken`
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
-- بنية الجدول `users_activitylog`
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
-- بنية الجدول `users_customuser`
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
  `image` varchar(100) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `otp_code` varchar(6) DEFAULT NULL,
  `otp_created_at` datetime(6) DEFAULT NULL,
  `chart_id` bigint(20) DEFAULT NULL,
  `chield_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- إرجاع أو استيراد بيانات الجدول `users_customuser`
--

INSERT INTO `users_customuser` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `date_joined`, `created_at`, `updated_at`, `user_type`, `phone`, `image`, `gender`, `birth_date`, `is_active`, `otp_code`, `otp_created_at`, `chart_id`, `chield_id`) VALUES
(1, 'pbkdf2_sha256$600000$5NkgWsG6f1Uzykr3AQjU9G$Hol2951Tu7Wrtvq7Nhhv3bVnzcZvrMX1z1SEak8jnBY=', '2025-05-03 14:00:25.089510', 1, 'ali', '', '', '', 1, '2025-05-03 13:54:50.163280', '2025-05-03 13:54:50.850830', '2025-05-03 13:57:57.155595', '', '', '', NULL, NULL, 1, NULL, NULL, 2, NULL),
(2, 'pbkdf2_sha256$600000$cmlD1sVBykSVQ4d4hzsdjH$581QrLaybWQmimFxNKnLLUHO7SN4kXzExyib0qRnf4Y=', NULL, 0, 'ammar@test.com', 'فندق النبراس', '', 'ammar@test.com', 1, '2025-05-03 14:00:42.542957', '2025-05-03 14:00:42.556200', '2025-05-03 14:00:43.356959', 'hotel_manager', '', '', NULL, NULL, 1, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- بنية الجدول `users_customuser_groups`
--

CREATE TABLE `users_customuser_groups` (
  `id` bigint(20) NOT NULL,
  `customuser_id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- إرجاع أو استيراد بيانات الجدول `users_customuser_groups`
--

INSERT INTO `users_customuser_groups` (`id`, `customuser_id`, `group_id`) VALUES
(1, 2, 1);

-- --------------------------------------------------------

--
-- بنية الجدول `users_customuser_user_permissions`
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
-- Indexes for table `accounts_chartofaccounts`
--
ALTER TABLE `accounts_chartofaccounts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `accounts_chartofacco_account_parent_id_aab27f60_fk_accounts_` (`account_parent_id`),
  ADD KEY `accounts_chartofacco_created_by_id_f216d28f_fk_users_cus` (`created_by_id`),
  ADD KEY `accounts_chartofacco_updated_by_id_aa33c263_fk_users_cus` (`updated_by_id`);

--
-- Indexes for table `accounts_journalentry`
--
ALTER TABLE `accounts_journalentry`
  ADD PRIMARY KEY (`id`),
  ADD KEY `accounts_journalentr_created_by_id_c9c8bf66_fk_users_cus` (`created_by_id`),
  ADD KEY `accounts_journalentr_journal_entry_accoun_31c22020_fk_accounts_` (`journal_entry_account_id`),
  ADD KEY `accounts_journalentr_updated_by_id_83723a94_fk_users_cus` (`updated_by_id`);

--
-- Indexes for table `authtoken_token`
--
ALTER TABLE `authtoken_token`
  ADD PRIMARY KEY (`key`),
  ADD UNIQUE KEY `user_id` (`user_id`);

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
  ADD PRIMARY KEY (`id`),
  ADD KEY `blog_category_created_by_id_5babffa5_fk_users_customuser_id` (`created_by_id`),
  ADD KEY `blog_category_updated_by_id_623e0d89_fk_users_customuser_id` (`updated_by_id`);

--
-- Indexes for table `blog_comment`
--
ALTER TABLE `blog_comment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `blog_comment_author_id_4f11e2e0_fk_users_customuser_id` (`author_id`),
  ADD KEY `blog_comment_created_by_id_bb8e38a4_fk_users_customuser_id` (`created_by_id`),
  ADD KEY `blog_comment_post_id_580e96ef_fk_blog_post_id` (`post_id`),
  ADD KEY `blog_comment_updated_by_id_383aa587_fk_users_customuser_id` (`updated_by_id`);

--
-- Indexes for table `blog_post`
--
ALTER TABLE `blog_post`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `blog_post_author_id_dd7a8485_fk_users_customuser_id` (`author_id`),
  ADD KEY `blog_post_category_id_c326dbf8_fk_blog_category_id` (`category_id`),
  ADD KEY `blog_post_created_by_id_eebead11_fk_users_customuser_id` (`created_by_id`),
  ADD KEY `blog_post_updated_by_id_022b627c_fk_users_customuser_id` (`updated_by_id`);

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
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `blog_tag_created_by_id_7bba8b04_fk_users_customuser_id` (`created_by_id`),
  ADD KEY `blog_tag_updated_by_id_1fbc3911_fk_users_customuser_id` (`updated_by_id`);

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
-- Indexes for table `bookings_bookinghistory`
--
ALTER TABLE `bookings_bookinghistory`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bookings_bookinghist_booking_id_3d73917f_fk_bookings_` (`booking_id`),
  ADD KEY `bookings_bookinghist_changed_by_id_7771323e_fk_users_cus` (`changed_by_id`),
  ADD KEY `bookings_bookinghist_hotel_id_fedbba66_fk_HotelMana` (`hotel_id`),
  ADD KEY `bookings_bookinghist_parent_booking_id_81c27856_fk_bookings_` (`parent_booking_id`),
  ADD KEY `bookings_bookinghistory_room_id_2b335d40_fk_rooms_roomtype_id` (`room_id`),
  ADD KEY `bookings_bookinghistory_user_id_631b8526_fk_users_customuser_id` (`user_id`);

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
  ADD KEY `bookings_guest_created_by_id_0cc0af08_fk_users_customuser_id` (`created_by_id`),
  ADD KEY `bookings_guest_hotel_id_333c72e5_fk_HotelManagement_hotel_id` (`hotel_id`),
  ADD KEY `bookings_guest_updated_by_id_7fb9973c_fk_users_customuser_id` (`updated_by_id`);

--
-- Indexes for table `customer_favourites`
--
ALTER TABLE `customer_favourites`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_user_hotel` (`user_id`,`hotel_id`),
  ADD KEY `customer_favourites_created_by_id_577ea231_fk_users_cus` (`created_by_id`),
  ADD KEY `customer_favourites_hotel_id_8c26062f_fk_HotelMana` (`hotel_id`),
  ADD KEY `customer_favourites_updated_by_id_0fef4026_fk_users_cus` (`updated_by_id`);

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
-- Indexes for table `home_contactmessage`
--
ALTER TABLE `home_contactmessage`
  ADD PRIMARY KEY (`id`);

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
-- Indexes for table `home_paymenpolicy`
--
ALTER TABLE `home_paymenpolicy`
  ADD PRIMARY KEY (`id`),
  ADD KEY `home_paymenpolicy_created_by_id_4d3ce878_fk_users_customuser_id` (`created_by_id`),
  ADD KEY `home_paymenpolicy_updated_by_id_1bb28913_fk_users_customuser_id` (`updated_by_id`);

--
-- Indexes for table `home_pricingplan`
--
ALTER TABLE `home_pricingplan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `home_privacypolicy`
--
ALTER TABLE `home_privacypolicy`
  ADD PRIMARY KEY (`id`),
  ADD KEY `home_privacypolicy_created_by_id_10a1cb37_fk_users_customuser_id` (`created_by_id`),
  ADD KEY `home_privacypolicy_updated_by_id_2722d998_fk_users_customuser_id` (`updated_by_id`);

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
-- Indexes for table `home_termsconditions`
--
ALTER TABLE `home_termsconditions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `home_termsconditions_created_by_id_41b47c7f_fk_users_cus` (`created_by_id`),
  ADD KEY `home_termsconditions_updated_by_id_a2f80cee_fk_users_cus` (`updated_by_id`);

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
  ADD UNIQUE KEY `HotelManagement_location_address_city_id_020279b6_uniq` (`address`,`city_id`),
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
  ADD KEY `notifications_notifi_created_by_id_17bcaf8b_fk_users_cus` (`created_by_id`),
  ADD KEY `notifications_notifi_sender_id_c6ee4409_fk_users_cus` (`sender_id`),
  ADD KEY `notifications_notifi_updated_by_id_cb05afb1_fk_users_cus` (`updated_by_id`),
  ADD KEY `notifications_notifi_user_id_429b0a5e_fk_users_cus` (`user_id`);

--
-- Indexes for table `oauth2_provider_accesstoken`
--
ALTER TABLE `oauth2_provider_accesstoken`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `token` (`token`),
  ADD UNIQUE KEY `source_refresh_token_id` (`source_refresh_token_id`),
  ADD UNIQUE KEY `id_token_id` (`id_token_id`),
  ADD KEY `oauth2_provider_acce_application_id_b22886e1_fk_oauth2_pr` (`application_id`),
  ADD KEY `oauth2_provider_acce_user_id_6e4c9a65_fk_users_cus` (`user_id`);

--
-- Indexes for table `oauth2_provider_application`
--
ALTER TABLE `oauth2_provider_application`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `client_id` (`client_id`),
  ADD KEY `oauth2_provider_appl_user_id_79829054_fk_users_cus` (`user_id`),
  ADD KEY `oauth2_provider_application_client_secret_53133678` (`client_secret`);

--
-- Indexes for table `oauth2_provider_grant`
--
ALTER TABLE `oauth2_provider_grant`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`),
  ADD KEY `oauth2_provider_gran_application_id_81923564_fk_oauth2_pr` (`application_id`),
  ADD KEY `oauth2_provider_grant_user_id_e8f62af8_fk_users_customuser_id` (`user_id`);

--
-- Indexes for table `oauth2_provider_idtoken`
--
ALTER TABLE `oauth2_provider_idtoken`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `jti` (`jti`),
  ADD KEY `oauth2_provider_idto_application_id_08c5ff4f_fk_oauth2_pr` (`application_id`),
  ADD KEY `oauth2_provider_idtoken_user_id_dd512b59_fk_users_customuser_id` (`user_id`);

--
-- Indexes for table `oauth2_provider_refreshtoken`
--
ALTER TABLE `oauth2_provider_refreshtoken`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `access_token_id` (`access_token_id`),
  ADD UNIQUE KEY `oauth2_provider_refreshtoken_token_revoked_af8a5134_uniq` (`token`,`revoked`),
  ADD KEY `oauth2_provider_refr_application_id_2d1c311b_fk_oauth2_pr` (`application_id`),
  ADD KEY `oauth2_provider_refr_user_id_da837fce_fk_users_cus` (`user_id`);

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
  ADD KEY `payments_hotelpaymen_created_by_id_4ddb7640_fk_users_cus` (`created_by_id`),
  ADD KEY `payments_hotelpaymen_payment_option_id_4b539d55_fk_payments_` (`payment_option_id`),
  ADD KEY `payments_hotelpaymen_updated_by_id_0daaca89_fk_users_cus` (`updated_by_id`);

--
-- Indexes for table `payments_payment`
--
ALTER TABLE `payments_payment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `payments_payment_booking_id_2a46974b_fk_bookings_booking_id` (`booking_id`),
  ADD KEY `payments_payment_created_by_id_28f0e284_fk_users_customuser_id` (`created_by_id`),
  ADD KEY `payments_payment_payment_method_id_c909ff25_fk_payments_` (`payment_method_id`),
  ADD KEY `payments_payment_updated_by_id_379a95eb_fk_users_customuser_id` (`updated_by_id`),
  ADD KEY `payments_payment_user_id_f9db060a_fk_users_customuser_id` (`user_id`);

--
-- Indexes for table `payments_paymenthistory`
--
ALTER TABLE `payments_paymenthistory`
  ADD PRIMARY KEY (`id`),
  ADD KEY `payments_paymenthist_changed_by_id_bc229b93_fk_users_cus` (`changed_by_id`),
  ADD KEY `payments_paymenthist_created_by_id_e1a215ba_fk_users_cus` (`created_by_id`),
  ADD KEY `payments_paymenthist_payment_id_4b5c9d14_fk_payments_` (`payment_id`),
  ADD KEY `payments_paymenthist_updated_by_id_f0bf4c7d_fk_users_cus` (`updated_by_id`);

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
  ADD KEY `rooms_availability_room_type_id_ee87e18f_fk_rooms_roomtype_id` (`room_type_id`),
  ADD KEY `rooms_availability_updated_by_id_f8d6a9d2_fk_users_customuser_id` (`updated_by_id`);

--
-- Indexes for table `rooms_category`
--
ALTER TABLE `rooms_category`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_hotel_category` (`name`),
  ADD KEY `rooms_category_created_by_id_c539b61c_fk_users_customuser_id` (`created_by_id`),
  ADD KEY `rooms_category_updated_by_id_85bbbd5a_fk_users_customuser_id` (`updated_by_id`);

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
-- Indexes for table `rooms_roomtype`
--
ALTER TABLE `rooms_roomtype`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rooms_roomtype_category_id_3203b18b_fk_rooms_category_id` (`category_id`),
  ADD KEY `rooms_roomtype_created_by_id_42c3bbaa_fk_users_customuser_id` (`created_by_id`),
  ADD KEY `rooms_roomtype_hotel_id_25b4be35_fk_HotelManagement_hotel_id` (`hotel_id`),
  ADD KEY `rooms_roomtype_updated_by_id_b5be2b42_fk_users_customuser_id` (`updated_by_id`);

--
-- Indexes for table `services_coupon`
--
ALTER TABLE `services_coupon`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`),
  ADD KEY `services_coupon_created_by_id_77380f73_fk_users_customuser_id` (`created_by_id`),
  ADD KEY `services_coupon_hotel_id_27b305f4_fk_HotelManagement_hotel_id` (`hotel_id`),
  ADD KEY `services_coupon_updated_by_id_d8030238_fk_users_customuser_id` (`updated_by_id`);

--
-- Indexes for table `services_hotelservice`
--
ALTER TABLE `services_hotelservice`
  ADD PRIMARY KEY (`id`),
  ADD KEY `services_hotelservic_created_by_id_58582781_fk_users_cus` (`created_by_id`),
  ADD KEY `services_hotelservic_hotel_id_c67387c9_fk_HotelMana` (`hotel_id`),
  ADD KEY `services_hotelservic_updated_by_id_01238d0f_fk_users_cus` (`updated_by_id`);

--
-- Indexes for table `services_roomtypeservice`
--
ALTER TABLE `services_roomtypeservice`
  ADD PRIMARY KEY (`id`),
  ADD KEY `services_roomtypeser_created_by_id_ef053406_fk_users_cus` (`created_by_id`),
  ADD KEY `services_roomtypeser_hotel_id_163e32a7_fk_HotelMana` (`hotel_id`),
  ADD KEY `services_roomtypeser_room_type_id_f15253ec_fk_rooms_roo` (`room_type_id`),
  ADD KEY `services_roomtypeser_updated_by_id_ce869b8f_fk_users_cus` (`updated_by_id`);

--
-- Indexes for table `service_offers`
--
ALTER TABLE `service_offers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `service_offers_created_by_id_8ca73e25_fk_users_customuser_id` (`created_by_id`),
  ADD KEY `service_offers_hotel_id_d29c1d1e_fk_HotelManagement_hotel_id` (`hotel_id`),
  ADD KEY `service_offers_updated_by_id_42cd54e5_fk_users_customuser_id` (`updated_by_id`);

--
-- Indexes for table `social_auth_association`
--
ALTER TABLE `social_auth_association`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `social_auth_association_server_url_handle_078befa2_uniq` (`server_url`,`handle`);

--
-- Indexes for table `social_auth_code`
--
ALTER TABLE `social_auth_code`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `social_auth_code_email_code_801b2d02_uniq` (`email`,`code`),
  ADD KEY `social_auth_code_code_a2393167` (`code`),
  ADD KEY `social_auth_code_timestamp_176b341f` (`timestamp`);

--
-- Indexes for table `social_auth_nonce`
--
ALTER TABLE `social_auth_nonce`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `social_auth_nonce_server_url_timestamp_salt_f6284463_uniq` (`server_url`,`timestamp`,`salt`);

--
-- Indexes for table `social_auth_partial`
--
ALTER TABLE `social_auth_partial`
  ADD PRIMARY KEY (`id`),
  ADD KEY `social_auth_partial_token_3017fea3` (`token`),
  ADD KEY `social_auth_partial_timestamp_50f2119f` (`timestamp`);

--
-- Indexes for table `social_auth_usersocialauth`
--
ALTER TABLE `social_auth_usersocialauth`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `social_auth_usersocialauth_provider_uid_e6b5e668_uniq` (`provider`,`uid`),
  ADD KEY `social_auth_usersoci_user_id_17d28448_fk_users_cus` (`user_id`),
  ADD KEY `social_auth_usersocialauth_uid_796e51dc` (`uid`);

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
  ADD KEY `users_customuser_chart_id_e799e924_fk_accounts_` (`chart_id`),
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
-- AUTO_INCREMENT for table `accounts_chartofaccounts`
--
ALTER TABLE `accounts_chartofaccounts`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `accounts_journalentry`
--
ALTER TABLE `accounts_journalentry`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=92;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=303;

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bookings_bookingdetail`
--
ALTER TABLE `bookings_bookingdetail`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bookings_bookinghistory`
--
ALTER TABLE `bookings_bookinghistory`
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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=112;

--
-- AUTO_INCREMENT for table `home_contactmessage`
--
ALTER TABLE `home_contactmessage`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

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
-- AUTO_INCREMENT for table `home_paymenpolicy`
--
ALTER TABLE `home_paymenpolicy`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `home_pricingplan`
--
ALTER TABLE `home_pricingplan`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `home_privacypolicy`
--
ALTER TABLE `home_privacypolicy`
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
-- AUTO_INCREMENT for table `home_termsconditions`
--
ALTER TABLE `home_termsconditions`
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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
-- AUTO_INCREMENT for table `oauth2_provider_accesstoken`
--
ALTER TABLE `oauth2_provider_accesstoken`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oauth2_provider_application`
--
ALTER TABLE `oauth2_provider_application`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oauth2_provider_grant`
--
ALTER TABLE `oauth2_provider_grant`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oauth2_provider_idtoken`
--
ALTER TABLE `oauth2_provider_idtoken`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oauth2_provider_refreshtoken`
--
ALTER TABLE `oauth2_provider_refreshtoken`
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
-- AUTO_INCREMENT for table `payments_paymenthistory`
--
ALTER TABLE `payments_paymenthistory`
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
-- AUTO_INCREMENT for table `reviews_roomreview`
--
ALTER TABLE `reviews_roomreview`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rooms_availability`
--
ALTER TABLE `rooms_availability`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rooms_category`
--
ALTER TABLE `rooms_category`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rooms_roomimage`
--
ALTER TABLE `rooms_roomimage`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rooms_roomprice`
--
ALTER TABLE `rooms_roomprice`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rooms_roomtype`
--
ALTER TABLE `rooms_roomtype`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `services_coupon`
--
ALTER TABLE `services_coupon`
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
-- AUTO_INCREMENT for table `social_auth_association`
--
ALTER TABLE `social_auth_association`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `social_auth_code`
--
ALTER TABLE `social_auth_code`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `social_auth_nonce`
--
ALTER TABLE `social_auth_nonce`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `social_auth_partial`
--
ALTER TABLE `social_auth_partial`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `social_auth_usersocialauth`
--
ALTER TABLE `social_auth_usersocialauth`
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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users_customuser_groups`
--
ALTER TABLE `users_customuser_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users_customuser_user_permissions`
--
ALTER TABLE `users_customuser_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- قيود الجداول المُلقاة.
--

--
-- قيود الجداول `accounts_chartofaccounts`
--
ALTER TABLE `accounts_chartofaccounts`
  ADD CONSTRAINT `accounts_chartofacco_account_parent_id_aab27f60_fk_accounts_` FOREIGN KEY (`account_parent_id`) REFERENCES `accounts_chartofaccounts` (`id`),
  ADD CONSTRAINT `accounts_chartofacco_created_by_id_f216d28f_fk_users_cus` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `accounts_chartofacco_updated_by_id_aa33c263_fk_users_cus` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- قيود الجداول `accounts_journalentry`
--
ALTER TABLE `accounts_journalentry`
  ADD CONSTRAINT `accounts_journalentr_created_by_id_c9c8bf66_fk_users_cus` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `accounts_journalentr_journal_entry_accoun_31c22020_fk_accounts_` FOREIGN KEY (`journal_entry_account_id`) REFERENCES `accounts_chartofaccounts` (`id`),
  ADD CONSTRAINT `accounts_journalentr_updated_by_id_83723a94_fk_users_cus` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- قيود الجداول `authtoken_token`
--
ALTER TABLE `authtoken_token`
  ADD CONSTRAINT `authtoken_token_user_id_35299eff_fk_users_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_customuser` (`id`);

--
-- قيود الجداول `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- قيود الجداول `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- قيود الجداول `blog_category`
--
ALTER TABLE `blog_category`
  ADD CONSTRAINT `blog_category_created_by_id_5babffa5_fk_users_customuser_id` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `blog_category_updated_by_id_623e0d89_fk_users_customuser_id` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- قيود الجداول `blog_comment`
--
ALTER TABLE `blog_comment`
  ADD CONSTRAINT `blog_comment_author_id_4f11e2e0_fk_users_customuser_id` FOREIGN KEY (`author_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `blog_comment_created_by_id_bb8e38a4_fk_users_customuser_id` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `blog_comment_post_id_580e96ef_fk_blog_post_id` FOREIGN KEY (`post_id`) REFERENCES `blog_post` (`id`),
  ADD CONSTRAINT `blog_comment_updated_by_id_383aa587_fk_users_customuser_id` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- قيود الجداول `blog_post`
--
ALTER TABLE `blog_post`
  ADD CONSTRAINT `blog_post_author_id_dd7a8485_fk_users_customuser_id` FOREIGN KEY (`author_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `blog_post_category_id_c326dbf8_fk_blog_category_id` FOREIGN KEY (`category_id`) REFERENCES `blog_category` (`id`),
  ADD CONSTRAINT `blog_post_created_by_id_eebead11_fk_users_customuser_id` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `blog_post_updated_by_id_022b627c_fk_users_customuser_id` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- قيود الجداول `blog_post_tags`
--
ALTER TABLE `blog_post_tags`
  ADD CONSTRAINT `blog_post_tags_post_id_a1c71c8a_fk_blog_post_id` FOREIGN KEY (`post_id`) REFERENCES `blog_post` (`id`),
  ADD CONSTRAINT `blog_post_tags_tag_id_0875c551_fk_blog_tag_id` FOREIGN KEY (`tag_id`) REFERENCES `blog_tag` (`id`);

--
-- قيود الجداول `blog_tag`
--
ALTER TABLE `blog_tag`
  ADD CONSTRAINT `blog_tag_created_by_id_7bba8b04_fk_users_customuser_id` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `blog_tag_updated_by_id_1fbc3911_fk_users_customuser_id` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- قيود الجداول `bookings_booking`
--
ALTER TABLE `bookings_booking`
  ADD CONSTRAINT `bookings_booking_created_by_id_d8a2f432_fk_users_customuser_id` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `bookings_booking_hotel_id_e1f8132f_fk_HotelManagement_hotel_id` FOREIGN KEY (`hotel_id`) REFERENCES `hotelmanagement_hotel` (`id`),
  ADD CONSTRAINT `bookings_booking_parent_booking_id_7c358175_fk_bookings_` FOREIGN KEY (`parent_booking_id`) REFERENCES `bookings_booking` (`id`),
  ADD CONSTRAINT `bookings_booking_room_id_6f0fa517_fk_rooms_roomtype_id` FOREIGN KEY (`room_id`) REFERENCES `rooms_roomtype` (`id`),
  ADD CONSTRAINT `bookings_booking_updated_by_id_6c0bc7d4_fk_users_customuser_id` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `bookings_booking_user_id_834dfc23_fk_users_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_customuser` (`id`);

--
-- قيود الجداول `bookings_bookingdetail`
--
ALTER TABLE `bookings_bookingdetail`
  ADD CONSTRAINT `bookings_bookingdeta_booking_id_12740561_fk_bookings_` FOREIGN KEY (`booking_id`) REFERENCES `bookings_booking` (`id`),
  ADD CONSTRAINT `bookings_bookingdeta_created_by_id_a437326b_fk_users_cus` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `bookings_bookingdeta_hotel_id_1dc4dae4_fk_HotelMana` FOREIGN KEY (`hotel_id`) REFERENCES `hotelmanagement_hotel` (`id`),
  ADD CONSTRAINT `bookings_bookingdeta_service_id_8dc9681c_fk_services_` FOREIGN KEY (`service_id`) REFERENCES `services_roomtypeservice` (`id`),
  ADD CONSTRAINT `bookings_bookingdeta_updated_by_id_263cc972_fk_users_cus` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- قيود الجداول `bookings_bookinghistory`
--
ALTER TABLE `bookings_bookinghistory`
  ADD CONSTRAINT `bookings_bookinghist_booking_id_3d73917f_fk_bookings_` FOREIGN KEY (`booking_id`) REFERENCES `bookings_booking` (`id`),
  ADD CONSTRAINT `bookings_bookinghist_changed_by_id_7771323e_fk_users_cus` FOREIGN KEY (`changed_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `bookings_bookinghist_hotel_id_fedbba66_fk_HotelMana` FOREIGN KEY (`hotel_id`) REFERENCES `hotelmanagement_hotel` (`id`),
  ADD CONSTRAINT `bookings_bookinghist_parent_booking_id_81c27856_fk_bookings_` FOREIGN KEY (`parent_booking_id`) REFERENCES `bookings_booking` (`id`),
  ADD CONSTRAINT `bookings_bookinghistory_room_id_2b335d40_fk_rooms_roomtype_id` FOREIGN KEY (`room_id`) REFERENCES `rooms_roomtype` (`id`),
  ADD CONSTRAINT `bookings_bookinghistory_user_id_631b8526_fk_users_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_customuser` (`id`);

--
-- قيود الجداول `bookings_extensionmovement`
--
ALTER TABLE `bookings_extensionmovement`
  ADD CONSTRAINT `bookings_extensionmo_booking_id_dd6b5f8f_fk_bookings_` FOREIGN KEY (`booking_id`) REFERENCES `bookings_booking` (`id`),
  ADD CONSTRAINT `bookings_extensionmo_payment_receipt_id_009ef854_fk_payments_` FOREIGN KEY (`payment_receipt_id`) REFERENCES `payments_payment` (`id`);

--
-- قيود الجداول `bookings_guest`
--
ALTER TABLE `bookings_guest`
  ADD CONSTRAINT `bookings_guest_booking_id_b8c4c07b_fk_bookings_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `bookings_booking` (`id`),
  ADD CONSTRAINT `bookings_guest_created_by_id_0cc0af08_fk_users_customuser_id` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `bookings_guest_hotel_id_333c72e5_fk_HotelManagement_hotel_id` FOREIGN KEY (`hotel_id`) REFERENCES `hotelmanagement_hotel` (`id`),
  ADD CONSTRAINT `bookings_guest_updated_by_id_7fb9973c_fk_users_customuser_id` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- قيود الجداول `customer_favourites`
--
ALTER TABLE `customer_favourites`
  ADD CONSTRAINT `customer_favourites_created_by_id_577ea231_fk_users_cus` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `customer_favourites_hotel_id_8c26062f_fk_HotelMana` FOREIGN KEY (`hotel_id`) REFERENCES `hotelmanagement_hotel` (`id`),
  ADD CONSTRAINT `customer_favourites_updated_by_id_0fef4026_fk_users_cus` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `customer_favourites_user_id_b1b2dc31_fk_users_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_customuser` (`id`);

--
-- قيود الجداول `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_users_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_customuser` (`id`);

--
-- قيود الجداول `django_celery_beat_periodictask`
--
ALTER TABLE `django_celery_beat_periodictask`
  ADD CONSTRAINT `django_celery_beat_p_clocked_id_47a69f82_fk_django_ce` FOREIGN KEY (`clocked_id`) REFERENCES `django_celery_beat_clockedschedule` (`id`),
  ADD CONSTRAINT `django_celery_beat_p_crontab_id_d3cba168_fk_django_ce` FOREIGN KEY (`crontab_id`) REFERENCES `django_celery_beat_crontabschedule` (`id`),
  ADD CONSTRAINT `django_celery_beat_p_interval_id_a8ca27da_fk_django_ce` FOREIGN KEY (`interval_id`) REFERENCES `django_celery_beat_intervalschedule` (`id`),
  ADD CONSTRAINT `django_celery_beat_p_solar_id_a87ce72c_fk_django_ce` FOREIGN KEY (`solar_id`) REFERENCES `django_celery_beat_solarschedule` (`id`);

--
-- قيود الجداول `home_paymenpolicy`
--
ALTER TABLE `home_paymenpolicy`
  ADD CONSTRAINT `home_paymenpolicy_created_by_id_4d3ce878_fk_users_customuser_id` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `home_paymenpolicy_updated_by_id_1bb28913_fk_users_customuser_id` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- قيود الجداول `home_privacypolicy`
--
ALTER TABLE `home_privacypolicy`
  ADD CONSTRAINT `home_privacypolicy_created_by_id_10a1cb37_fk_users_customuser_id` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `home_privacypolicy_updated_by_id_2722d998_fk_users_customuser_id` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- قيود الجداول `home_termsconditions`
--
ALTER TABLE `home_termsconditions`
  ADD CONSTRAINT `home_termsconditions_created_by_id_41b47c7f_fk_users_cus` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `home_termsconditions_updated_by_id_a2f80cee_fk_users_cus` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- قيود الجداول `hotelmanagement_city`
--
ALTER TABLE `hotelmanagement_city`
  ADD CONSTRAINT `HotelManagement_city_created_by_id_567287e5_fk_users_cus` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `HotelManagement_city_updated_by_id_5eeb09c7_fk_users_cus` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- قيود الجداول `hotelmanagement_hotel`
--
ALTER TABLE `hotelmanagement_hotel`
  ADD CONSTRAINT `HotelManagement_hote_created_by_id_58e7b497_fk_users_cus` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `HotelManagement_hote_location_id_2f7c61ed_fk_HotelMana` FOREIGN KEY (`location_id`) REFERENCES `hotelmanagement_location` (`id`),
  ADD CONSTRAINT `HotelManagement_hote_updated_by_id_9c63fc69_fk_users_cus` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `HotelManagement_hotel_manager_id_1bbe4f12_fk_users_customuser_id` FOREIGN KEY (`manager_id`) REFERENCES `users_customuser` (`id`);

--
-- قيود الجداول `hotelmanagement_hotelrequest`
--
ALTER TABLE `hotelmanagement_hotelrequest`
  ADD CONSTRAINT `HotelManagement_hote_approved_by_id_337f6c49_fk_users_cus` FOREIGN KEY (`approved_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `HotelManagement_hote_created_by_id_f618f76f_fk_users_cus` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `HotelManagement_hote_updated_by_id_eceb12d5_fk_users_cus` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- قيود الجداول `hotelmanagement_image`
--
ALTER TABLE `hotelmanagement_image`
  ADD CONSTRAINT `HotelManagement_imag_created_by_id_779bde56_fk_users_cus` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `HotelManagement_imag_hotel_id_e97ababf_fk_HotelMana` FOREIGN KEY (`hotel_id`) REFERENCES `hotelmanagement_hotel` (`id`),
  ADD CONSTRAINT `HotelManagement_imag_updated_by_id_b3d7d0db_fk_users_cus` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- قيود الجداول `hotelmanagement_location`
--
ALTER TABLE `hotelmanagement_location`
  ADD CONSTRAINT `HotelManagement_loca_city_id_ae155d2c_fk_HotelMana` FOREIGN KEY (`city_id`) REFERENCES `hotelmanagement_city` (`id`),
  ADD CONSTRAINT `HotelManagement_loca_created_by_id_10ae04e2_fk_users_cus` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `HotelManagement_loca_updated_by_id_26f3a4d4_fk_users_cus` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- قيود الجداول `hotelmanagement_phone`
--
ALTER TABLE `hotelmanagement_phone`
  ADD CONSTRAINT `HotelManagement_phon_created_by_id_34b06bb1_fk_users_cus` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `HotelManagement_phon_hotel_id_67f340f6_fk_HotelMana` FOREIGN KEY (`hotel_id`) REFERENCES `hotelmanagement_hotel` (`id`),
  ADD CONSTRAINT `HotelManagement_phon_updated_by_id_114868f0_fk_users_cus` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- قيود الجداول `notifications_notifications`
--
ALTER TABLE `notifications_notifications`
  ADD CONSTRAINT `notifications_notifi_created_by_id_17bcaf8b_fk_users_cus` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `notifications_notifi_sender_id_c6ee4409_fk_users_cus` FOREIGN KEY (`sender_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `notifications_notifi_updated_by_id_cb05afb1_fk_users_cus` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `notifications_notifi_user_id_429b0a5e_fk_users_cus` FOREIGN KEY (`user_id`) REFERENCES `users_customuser` (`id`);

--
-- قيود الجداول `oauth2_provider_accesstoken`
--
ALTER TABLE `oauth2_provider_accesstoken`
  ADD CONSTRAINT `oauth2_provider_acce_application_id_b22886e1_fk_oauth2_pr` FOREIGN KEY (`application_id`) REFERENCES `oauth2_provider_application` (`id`),
  ADD CONSTRAINT `oauth2_provider_acce_id_token_id_85db651b_fk_oauth2_pr` FOREIGN KEY (`id_token_id`) REFERENCES `oauth2_provider_idtoken` (`id`),
  ADD CONSTRAINT `oauth2_provider_acce_source_refresh_token_e66fbc72_fk_oauth2_pr` FOREIGN KEY (`source_refresh_token_id`) REFERENCES `oauth2_provider_refreshtoken` (`id`),
  ADD CONSTRAINT `oauth2_provider_acce_user_id_6e4c9a65_fk_users_cus` FOREIGN KEY (`user_id`) REFERENCES `users_customuser` (`id`);

--
-- قيود الجداول `oauth2_provider_application`
--
ALTER TABLE `oauth2_provider_application`
  ADD CONSTRAINT `oauth2_provider_appl_user_id_79829054_fk_users_cus` FOREIGN KEY (`user_id`) REFERENCES `users_customuser` (`id`);

--
-- قيود الجداول `oauth2_provider_grant`
--
ALTER TABLE `oauth2_provider_grant`
  ADD CONSTRAINT `oauth2_provider_gran_application_id_81923564_fk_oauth2_pr` FOREIGN KEY (`application_id`) REFERENCES `oauth2_provider_application` (`id`),
  ADD CONSTRAINT `oauth2_provider_grant_user_id_e8f62af8_fk_users_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_customuser` (`id`);

--
-- قيود الجداول `oauth2_provider_idtoken`
--
ALTER TABLE `oauth2_provider_idtoken`
  ADD CONSTRAINT `oauth2_provider_idto_application_id_08c5ff4f_fk_oauth2_pr` FOREIGN KEY (`application_id`) REFERENCES `oauth2_provider_application` (`id`),
  ADD CONSTRAINT `oauth2_provider_idtoken_user_id_dd512b59_fk_users_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_customuser` (`id`);

--
-- قيود الجداول `oauth2_provider_refreshtoken`
--
ALTER TABLE `oauth2_provider_refreshtoken`
  ADD CONSTRAINT `oauth2_provider_refr_access_token_id_775e84e8_fk_oauth2_pr` FOREIGN KEY (`access_token_id`) REFERENCES `oauth2_provider_accesstoken` (`id`),
  ADD CONSTRAINT `oauth2_provider_refr_application_id_2d1c311b_fk_oauth2_pr` FOREIGN KEY (`application_id`) REFERENCES `oauth2_provider_application` (`id`),
  ADD CONSTRAINT `oauth2_provider_refr_user_id_da837fce_fk_users_cus` FOREIGN KEY (`user_id`) REFERENCES `users_customuser` (`id`);

--
-- قيود الجداول `payments_currency`
--
ALTER TABLE `payments_currency`
  ADD CONSTRAINT `payments_currency_created_by_id_69658f49_fk_users_customuser_id` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `payments_currency_hotel_id_51cc1abb_fk_HotelManagement_hotel_id` FOREIGN KEY (`hotel_id`) REFERENCES `hotelmanagement_hotel` (`id`),
  ADD CONSTRAINT `payments_currency_updated_by_id_d0a4bce8_fk_users_customuser_id` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- قيود الجداول `payments_hotelpaymentmethod`
--
ALTER TABLE `payments_hotelpaymentmethod`
  ADD CONSTRAINT `payments_hotelpaymen_created_by_id_4ddb7640_fk_users_cus` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `payments_hotelpaymen_hotel_id_ce0a1829_fk_HotelMana` FOREIGN KEY (`hotel_id`) REFERENCES `hotelmanagement_hotel` (`id`),
  ADD CONSTRAINT `payments_hotelpaymen_payment_option_id_4b539d55_fk_payments_` FOREIGN KEY (`payment_option_id`) REFERENCES `payments_paymentoption` (`id`),
  ADD CONSTRAINT `payments_hotelpaymen_updated_by_id_0daaca89_fk_users_cus` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- قيود الجداول `payments_payment`
--
ALTER TABLE `payments_payment`
  ADD CONSTRAINT `payments_payment_booking_id_2a46974b_fk_bookings_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `bookings_booking` (`id`),
  ADD CONSTRAINT `payments_payment_created_by_id_28f0e284_fk_users_customuser_id` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `payments_payment_payment_method_id_c909ff25_fk_payments_` FOREIGN KEY (`payment_method_id`) REFERENCES `payments_hotelpaymentmethod` (`id`),
  ADD CONSTRAINT `payments_payment_updated_by_id_379a95eb_fk_users_customuser_id` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `payments_payment_user_id_f9db060a_fk_users_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_customuser` (`id`);

--
-- قيود الجداول `payments_paymenthistory`
--
ALTER TABLE `payments_paymenthistory`
  ADD CONSTRAINT `payments_paymenthist_changed_by_id_bc229b93_fk_users_cus` FOREIGN KEY (`changed_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `payments_paymenthist_created_by_id_e1a215ba_fk_users_cus` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `payments_paymenthist_payment_id_4b5c9d14_fk_payments_` FOREIGN KEY (`payment_id`) REFERENCES `payments_payment` (`id`),
  ADD CONSTRAINT `payments_paymenthist_updated_by_id_f0bf4c7d_fk_users_cus` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- قيود الجداول `payments_paymentoption`
--
ALTER TABLE `payments_paymentoption`
  ADD CONSTRAINT `payments_paymentopti_created_by_id_e8b0d9da_fk_users_cus` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `payments_paymentopti_currency_id_9986031a_fk_payments_` FOREIGN KEY (`currency_id`) REFERENCES `payments_currency` (`id`),
  ADD CONSTRAINT `payments_paymentopti_updated_by_id_29eee1b1_fk_users_cus` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- قيود الجداول `reviews_hotelreview`
--
ALTER TABLE `reviews_hotelreview`
  ADD CONSTRAINT `reviews_hotelreview_created_by_id_fbc20ee8_fk_users_cus` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `reviews_hotelreview_hotel_id_6819d0d9_fk_HotelMana` FOREIGN KEY (`hotel_id`) REFERENCES `hotelmanagement_hotel` (`id`),
  ADD CONSTRAINT `reviews_hotelreview_updated_by_id_2fbc72a0_fk_users_cus` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `reviews_hotelreview_user_id_b1101c52_fk_users_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_customuser` (`id`);

--
-- قيود الجداول `reviews_roomreview`
--
ALTER TABLE `reviews_roomreview`
  ADD CONSTRAINT `reviews_roomreview_created_by_id_5e598a2a_fk_users_customuser_id` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `reviews_roomreview_hotel_id_5aff88ca_fk_HotelManagement_hotel_id` FOREIGN KEY (`hotel_id`) REFERENCES `hotelmanagement_hotel` (`id`),
  ADD CONSTRAINT `reviews_roomreview_room_type_id_b2e4f814_fk_rooms_roomtype_id` FOREIGN KEY (`room_type_id`) REFERENCES `rooms_roomtype` (`id`),
  ADD CONSTRAINT `reviews_roomreview_updated_by_id_a7d246e6_fk_users_customuser_id` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `reviews_roomreview_user_id_bd90336f_fk_users_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_customuser` (`id`);

--
-- قيود الجداول `rooms_availability`
--
ALTER TABLE `rooms_availability`
  ADD CONSTRAINT `rooms_availability_created_by_id_168a5943_fk_users_customuser_id` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `rooms_availability_hotel_id_e9028aaa_fk_HotelManagement_hotel_id` FOREIGN KEY (`hotel_id`) REFERENCES `hotelmanagement_hotel` (`id`),
  ADD CONSTRAINT `rooms_availability_room_type_id_ee87e18f_fk_rooms_roomtype_id` FOREIGN KEY (`room_type_id`) REFERENCES `rooms_roomtype` (`id`),
  ADD CONSTRAINT `rooms_availability_updated_by_id_f8d6a9d2_fk_users_customuser_id` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- قيود الجداول `rooms_category`
--
ALTER TABLE `rooms_category`
  ADD CONSTRAINT `rooms_category_created_by_id_c539b61c_fk_users_customuser_id` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `rooms_category_updated_by_id_85bbbd5a_fk_users_customuser_id` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- قيود الجداول `rooms_roomimage`
--
ALTER TABLE `rooms_roomimage`
  ADD CONSTRAINT `rooms_roomimage_created_by_id_168789df_fk_users_customuser_id` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `rooms_roomimage_hotel_id_13fbdfad_fk_HotelManagement_hotel_id` FOREIGN KEY (`hotel_id`) REFERENCES `hotelmanagement_hotel` (`id`),
  ADD CONSTRAINT `rooms_roomimage_room_type_id_d35f7810_fk_rooms_roomtype_id` FOREIGN KEY (`room_type_id`) REFERENCES `rooms_roomtype` (`id`),
  ADD CONSTRAINT `rooms_roomimage_updated_by_id_c3e3a6e5_fk_users_customuser_id` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- قيود الجداول `rooms_roomprice`
--
ALTER TABLE `rooms_roomprice`
  ADD CONSTRAINT `rooms_roomprice_created_by_id_7459c49f_fk_users_customuser_id` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `rooms_roomprice_hotel_id_bfc064b3_fk_HotelManagement_hotel_id` FOREIGN KEY (`hotel_id`) REFERENCES `hotelmanagement_hotel` (`id`),
  ADD CONSTRAINT `rooms_roomprice_room_type_id_b8f396b9_fk_rooms_roomtype_id` FOREIGN KEY (`room_type_id`) REFERENCES `rooms_roomtype` (`id`),
  ADD CONSTRAINT `rooms_roomprice_updated_by_id_20da56f3_fk_users_customuser_id` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- قيود الجداول `rooms_roomtype`
--
ALTER TABLE `rooms_roomtype`
  ADD CONSTRAINT `rooms_roomtype_category_id_3203b18b_fk_rooms_category_id` FOREIGN KEY (`category_id`) REFERENCES `rooms_category` (`id`),
  ADD CONSTRAINT `rooms_roomtype_created_by_id_42c3bbaa_fk_users_customuser_id` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `rooms_roomtype_hotel_id_25b4be35_fk_HotelManagement_hotel_id` FOREIGN KEY (`hotel_id`) REFERENCES `hotelmanagement_hotel` (`id`),
  ADD CONSTRAINT `rooms_roomtype_updated_by_id_b5be2b42_fk_users_customuser_id` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- قيود الجداول `services_coupon`
--
ALTER TABLE `services_coupon`
  ADD CONSTRAINT `services_coupon_created_by_id_77380f73_fk_users_customuser_id` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `services_coupon_hotel_id_27b305f4_fk_HotelManagement_hotel_id` FOREIGN KEY (`hotel_id`) REFERENCES `hotelmanagement_hotel` (`id`),
  ADD CONSTRAINT `services_coupon_updated_by_id_d8030238_fk_users_customuser_id` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- قيود الجداول `services_hotelservice`
--
ALTER TABLE `services_hotelservice`
  ADD CONSTRAINT `services_hotelservic_created_by_id_58582781_fk_users_cus` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `services_hotelservic_hotel_id_c67387c9_fk_HotelMana` FOREIGN KEY (`hotel_id`) REFERENCES `hotelmanagement_hotel` (`id`),
  ADD CONSTRAINT `services_hotelservic_updated_by_id_01238d0f_fk_users_cus` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- قيود الجداول `services_roomtypeservice`
--
ALTER TABLE `services_roomtypeservice`
  ADD CONSTRAINT `services_roomtypeser_created_by_id_ef053406_fk_users_cus` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `services_roomtypeser_hotel_id_163e32a7_fk_HotelMana` FOREIGN KEY (`hotel_id`) REFERENCES `hotelmanagement_hotel` (`id`),
  ADD CONSTRAINT `services_roomtypeser_room_type_id_f15253ec_fk_rooms_roo` FOREIGN KEY (`room_type_id`) REFERENCES `rooms_roomtype` (`id`),
  ADD CONSTRAINT `services_roomtypeser_updated_by_id_ce869b8f_fk_users_cus` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- قيود الجداول `service_offers`
--
ALTER TABLE `service_offers`
  ADD CONSTRAINT `service_offers_created_by_id_8ca73e25_fk_users_customuser_id` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `service_offers_hotel_id_d29c1d1e_fk_HotelManagement_hotel_id` FOREIGN KEY (`hotel_id`) REFERENCES `hotelmanagement_hotel` (`id`),
  ADD CONSTRAINT `service_offers_updated_by_id_42cd54e5_fk_users_customuser_id` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- قيود الجداول `social_auth_usersocialauth`
--
ALTER TABLE `social_auth_usersocialauth`
  ADD CONSTRAINT `social_auth_usersoci_user_id_17d28448_fk_users_cus` FOREIGN KEY (`user_id`) REFERENCES `users_customuser` (`id`);

--
-- قيود الجداول `token_blacklist_blacklistedtoken`
--
ALTER TABLE `token_blacklist_blacklistedtoken`
  ADD CONSTRAINT `token_blacklist_blacklistedtoken_token_id_3cc7fe56_fk` FOREIGN KEY (`token_id`) REFERENCES `token_blacklist_outstandingtoken` (`id`);

--
-- قيود الجداول `token_blacklist_outstandingtoken`
--
ALTER TABLE `token_blacklist_outstandingtoken`
  ADD CONSTRAINT `token_blacklist_outs_user_id_83bc629a_fk_users_cus` FOREIGN KEY (`user_id`) REFERENCES `users_customuser` (`id`);

--
-- قيود الجداول `users_activitylog`
--
ALTER TABLE `users_activitylog`
  ADD CONSTRAINT `users_activitylog_user_id_4eb4b36f_fk_users_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_customuser` (`id`);

--
-- قيود الجداول `users_customuser`
--
ALTER TABLE `users_customuser`
  ADD CONSTRAINT `users_customuser_chart_id_e799e924_fk_accounts_` FOREIGN KEY (`chart_id`) REFERENCES `accounts_chartofaccounts` (`id`),
  ADD CONSTRAINT `users_customuser_chield_id_8f3dc45a_fk_users_customuser_id` FOREIGN KEY (`chield_id`) REFERENCES `users_customuser` (`id`);

--
-- قيود الجداول `users_customuser_groups`
--
ALTER TABLE `users_customuser_groups`
  ADD CONSTRAINT `users_customuser_gro_customuser_id_958147bf_fk_users_cus` FOREIGN KEY (`customuser_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `users_customuser_groups_group_id_01390b14_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- قيود الجداول `users_customuser_user_permissions`
--
ALTER TABLE `users_customuser_user_permissions`
  ADD CONSTRAINT `users_customuser_use_customuser_id_5771478b_fk_users_cus` FOREIGN KEY (`customuser_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `users_customuser_use_permission_id_baaa2f74_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
