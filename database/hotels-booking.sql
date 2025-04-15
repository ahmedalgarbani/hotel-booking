-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 15, 2025 at 08:41 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.12

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
-- Table structure for table `accounts_chartofaccounts`
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
-- Dumping data for table `accounts_chartofaccounts`
--

INSERT INTO `accounts_chartofaccounts` (`id`, `created_at`, `updated_at`, `deleted_at`, `account_number`, `account_name`, `account_type`, `account_balance`, `account_description`, `account_status`, `account_amount`, `account_parent_id`, `created_by_id`, `updated_by_id`) VALUES
(1, NULL, NULL, NULL, '1000', 'الأصول', 'Assets', 0.00, 'جميع الأصول التي تملكها الشركة', 1, NULL, NULL, NULL, NULL),
(2, NULL, NULL, NULL, '2000', 'الخصوم', 'Liabilities', 0.00, 'الخصوم', 1, NULL, NULL, NULL, NULL),
(3, NULL, NULL, NULL, '3000', 'حقوق الملكية', 'Equity', 0.00, 'تمثل حقوق الملاك أو حقوق المساهمين في الشركة', 1, NULL, NULL, NULL, NULL),
(4, NULL, NULL, NULL, '4000', 'الإيرادات', 'Revenue', 0.00, 'تمثل الدخل الناتج عن عمليات البيع وتقديم الخدمات', 1, NULL, NULL, NULL, NULL),
(6, NULL, NULL, NULL, '5000', 'المصاريف', 'Expenses', 0.00, 'تمثل جميع النفقات التشغيلية وغير التشغيلية للشركة', 1, NULL, NULL, NULL, NULL),
(7, NULL, NULL, NULL, '1100', 'الأصول المتداولة', 'Assets', 0.00, 'الأصول التي يتم تحويلها إلى نقد خلال عام', 1, NULL, 1, NULL, NULL),
(8, NULL, NULL, NULL, '1200', 'الأصول الثابتة', 'Assets', 0.00, 'الأصول التي تملكها الشركة على المدى الطويل', 1, NULL, 1, NULL, NULL),
(9, NULL, '2025-04-14 08:46:20.498937', NULL, '1101', 'النقد وما يعادله', 'Assets', 0.00, 'النقدية وما يعادلها من أصول سائلة', 1, 0.00, 7, NULL, NULL),
(10, NULL, NULL, NULL, '1102', 'النقدية في الصندوق', 'Assets', 0.00, 'النقدية المتوفرة في صندوق الشركة', 0, NULL, 7, NULL, NULL),
(11, NULL, '2025-04-15 11:35:57.478644', NULL, '1103', 'البنوك والتحويلات- الحساب الجاري', 'Assets', 0.00, 'الحساب الجاري في البنك الأهلي', 1, 0.00, 7, NULL, NULL),
(12, NULL, NULL, NULL, '1104', 'المدينون والعملاء', 'Assets', 0.00, 'ذمم العملاء والمدينون', 0, NULL, 7, NULL, NULL),
(13, NULL, NULL, NULL, '1105', 'عملاء محليون', 'Assets', 0.00, 'ذمم العملاء المحليين', 0, NULL, 7, NULL, NULL),
(14, NULL, NULL, NULL, '1106', 'عملاء دوليون', 'Assets', 0.00, 'ذمم العملاء الدوليين', 0, NULL, 7, NULL, NULL),
(15, NULL, NULL, NULL, '1107', 'المخزون', 'Assets', 0.00, 'مخزون المواد والبضائع', 0, NULL, 7, NULL, NULL),
(16, NULL, NULL, NULL, '1108', 'مخزون المواد الخام', 'Assets', 0.00, 'مواد خام غير مصنعة', 0, NULL, 7, NULL, NULL),
(17, NULL, NULL, NULL, '1109', 'مخزون البضاعة التامة', 'Assets', 0.00, 'بضاعة جاهزة للبيع', 0, NULL, 7, NULL, NULL),
(18, NULL, NULL, NULL, '1110', 'المباني والآلات', 'Assets', 0.00, 'المباني والآلات والمعدات', 0, NULL, 7, NULL, NULL),
(19, NULL, NULL, NULL, '1111', 'الأراضي', 'Assets', 0.00, 'أراضي مملوكة للشركة', 0, NULL, 7, NULL, NULL),
(20, NULL, NULL, NULL, '1112', 'المباني', 'Assets', 0.00, 'مباني مملوكة للشركة', 0, NULL, 7, NULL, NULL),
(21, NULL, NULL, NULL, '1120', 'المركبات', 'Assets', 0.00, 'مركبات الشركة', 0, NULL, 7, NULL, NULL),
(22, NULL, NULL, NULL, '1130', 'مجمع الإهلاك', 'Assets', 0.00, 'مجمع إهلاك الأصول الثابتة', 0, NULL, 7, NULL, NULL),
(23, NULL, '2025-04-14 08:44:57.973301', NULL, '1201', 'الأصول غير الملموسة', 'Assets', 0.00, 'براءات الاختراع والعلامات التجارية', 1, 0.00, 8, NULL, NULL),
(24, NULL, '2025-04-14 08:45:15.145294', NULL, '1202', 'استثمارات طويلة الأجل', 'Assets', 0.00, 'استثمارات لأكثر من سنة', 1, 0.00, 8, NULL, NULL),
(25, NULL, NULL, NULL, '2100', 'الخصوم المتداولة', 'Liabilities', 0.00, 'الخصوم المتداولة قصيرة الأجل', 0, NULL, 2, NULL, NULL),
(26, NULL, NULL, NULL, '2200', 'الخصوم غير المتداولة', 'Liabilities', 0.00, 'الخصوم طويلة الأجل', 0, NULL, 2, NULL, NULL),
(27, NULL, NULL, NULL, '2101', 'الحسابات الدائنة', 'Liabilities', 0.00, 'المبالغ المستحقة على الشركة للموردين', 0, NULL, 25, NULL, NULL),
(28, NULL, NULL, NULL, '2102', 'القروض قصيرة الأجل', 'Liabilities', 0.00, 'القروض التي يجب سدادها خلال عام', 0, NULL, 25, NULL, NULL),
(29, NULL, NULL, NULL, '2103', 'المصروفات المستحقة', 'Liabilities', 0.00, 'المصروفات التي تم تكبدها ولم تسدد بعد', 0, NULL, 25, NULL, NULL),
(30, NULL, NULL, NULL, '2201', 'القروض طويلة الأجل', 'Liabilities', 0.00, 'القروض التي يجب سدادها بعد أكثر من عام', 0, NULL, 26, NULL, NULL),
(31, NULL, NULL, NULL, '2202', 'الذمم المدينة طويلة الأجل', 'Liabilities', 0.00, 'المبالغ المستحقة على الشركة التي سيتم تسديدها بعد أكثر من عام', 0, NULL, 26, NULL, NULL),
(32, NULL, NULL, NULL, '2203', 'الالتزامات الضريبية طويلة الأجل', 'Liabilities', 0.00, 'الضرائب المستحقة التي سيتم دفعها بعد أكثر من عام', 0, NULL, 26, NULL, NULL),
(33, NULL, NULL, NULL, '3100', 'الأسهم العادية', 'Equity', 0.00, 'رأس المال الذي استثمره الملاك أو المساهمون', 0, NULL, 3, NULL, NULL),
(34, NULL, NULL, NULL, '3200', 'الأرباح المحتجزة', 'Equity', 0.00, 'الأرباح أو الخسائر المتراكمة التي لم يتم توزيعها', 0, NULL, 3, NULL, NULL),
(35, NULL, NULL, NULL, '3300', 'رأس المال المدفوع الإضافي', 'Equity', 0.00, 'المبالغ المدفوعة من المساهمين بما يتجاوز القيمة الاسمية للأسهم', 0, NULL, 3, NULL, NULL),
(36, NULL, NULL, NULL, '3400', 'الأسهم المستعادة', 'Equity', 0.00, 'الأسهم التي تم شراؤها مرة أخرى من السوق المفتوحة', 0, NULL, 3, NULL, NULL),
(37, NULL, NULL, NULL, '3500', 'احتياطي الطوارئ', 'Equity', 0.00, 'الاحتياطي المخصص للتعامل مع الحالات الطارئة', 0, NULL, 3, NULL, NULL),
(38, NULL, NULL, NULL, '3600', 'الاحتياطي القانوني', 'Equity', 0.00, 'الاحتياطي المخصص لتلبية المتطلبات القانونية', 0, NULL, 3, NULL, NULL),
(39, NULL, NULL, NULL, '3700', 'الاحتياطي العام', 'Equity', 0.00, 'الاحتياطي العام لتعزيز رأس المال', 0, NULL, 3, NULL, NULL),
(40, NULL, NULL, NULL, '4100', 'إيرادات المبيعات', 'Revenue', 0.00, 'الإيرادات الناتجة عن مبيعات المنتجات', 0, NULL, 4, NULL, NULL),
(41, NULL, NULL, NULL, '4200', 'إيرادات الخدمات', 'Revenue', 0.00, 'الإيرادات الناتجة عن تقديم الخدمات', 0, NULL, 4, NULL, NULL),
(42, NULL, NULL, NULL, '4300', 'إيرادات أخرى', 'Revenue', 0.00, 'إيرادات غير رئيسية مثل الفوائد أو الإيجارات', 0, NULL, 4, NULL, NULL),
(43, NULL, NULL, NULL, '4400', 'إيرادات الاستثمار', 'Revenue', 0.00, 'الإيرادات الناتجة عن الاستثمارات والعوائد المالية', 0, NULL, 4, NULL, NULL),
(44, NULL, NULL, NULL, '4500', 'إيرادات الخصومات', 'Revenue', 0.00, 'الإيرادات الناتجة عن الخصومات المقدمة للعملاء', 0, NULL, 4, NULL, NULL),
(45, NULL, NULL, NULL, '5100', 'تكلفة البضائع المباعة', 'Expenses', 0.00, 'التكاليف المباشرة المرتبطة بإنتاج السلع المباعة', 0, NULL, 6, NULL, NULL),
(46, NULL, NULL, NULL, '5200', 'المصاريف التشغيلية', 'Expenses', 0.00, 'النفقات المتعلقة بتشغيل الشركة اليومية', 0, NULL, 6, NULL, NULL),
(47, NULL, NULL, NULL, '5300', 'مصاريف الرواتب والأجور', 'Expenses', 0.00, 'تكاليف دفع الرواتب والأجور للموظفين', 0, NULL, 6, NULL, NULL),
(48, NULL, NULL, NULL, '5400', 'مصاريف الإيجار', 'Expenses', 0.00, 'تكاليف استئجار المكاتب أو المنشآت', 0, NULL, 6, NULL, NULL),
(49, NULL, NULL, NULL, '5500', 'مصاريف المرافق', 'Expenses', 0.00, 'تكاليف فواتير المرافق مثل الكهرباء والمياه والإنترنت', 0, NULL, 6, NULL, NULL),
(50, NULL, NULL, NULL, '5600', 'مصاريف التسويق والإعلان', 'Expenses', 0.00, 'تكاليف الحملات التسويقية والإعلانية', 0, NULL, 6, NULL, NULL),
(51, NULL, NULL, NULL, '5700', 'مصاريف أخرى', 'Expenses', 0.00, 'مصاريف أخرى غير مصنفة', 0, NULL, 6, NULL, NULL),
(52, '2025-04-14 09:36:49.911434', '2025-04-14 09:36:49.911434', NULL, '1106621', 'عملاء دائمون - ahsdajk5as5d5as', 'Asset', 0.00, 'الحسابات المدينة / العملاء', 1, NULL, 7, NULL, NULL),
(53, '2025-04-14 09:56:33.279378', '2025-04-14 09:56:33.279378', NULL, '1101443', 'عملاء دائمون - akshdkjaskdj8888', 'Asset', 0.00, 'الحسابات المدينة / العملاء', 1, NULL, 7, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `accounts_journalentry`
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

--
-- Dumping data for table `accounts_journalentry`
--

INSERT INTO `accounts_journalentry` (`id`, `created_at`, `updated_at`, `deleted_at`, `journal_entry_number`, `journal_entry_date`, `journal_entry_description`, `journal_entry_in_amount`, `journal_entry_out_amount`, `journal_entry_notes`, `journal_entry_currency`, `journal_entry_exchange_rate`, `journal_entry_tax`, `created_by_id`, `journal_entry_account_id`, `updated_by_id`) VALUES
(1, '2025-04-15 11:46:33.713778', '2025-04-15 11:46:33.713778', NULL, 'ENT-6731', '2025-04-15', '', 0.00, 0.00, 'مقابل دفع حجز', 'RY', 1.00, 0.00, NULL, 53, NULL),
(2, '2025-04-15 11:46:33.715710', '2025-04-15 11:46:33.715710', NULL, 'ENT-6731', '2025-04-15', '', 0.00, 0.00, 'مقابل دفع حواله', 'RY', 1.00, 0.00, NULL, 11, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `authtoken_token`
--

CREATE TABLE `authtoken_token` (
  `key` varchar(40) NOT NULL,
  `created` datetime(6) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
(97, 1, 253),
(98, 1, 254),
(99, 1, 255),
(96, 1, 256),
(100, 1, 265),
(101, 1, 266),
(102, 1, 267),
(103, 1, 268),
(110, 1, 276),
(111, 1, 280),
(112, 1, 285),
(113, 1, 286),
(114, 1, 287),
(104, 1, 288),
(105, 1, 292),
(106, 1, 293),
(107, 1, 294),
(108, 1, 295),
(109, 1, 296),
(115, 1, 297),
(116, 1, 298),
(117, 1, 299),
(118, 1, 300),
(119, 1, 301),
(120, 1, 302),
(121, 1, 303),
(122, 1, 304),
(123, 1, 305),
(124, 1, 306),
(125, 1, 307),
(126, 1, 308),
(127, 1, 309),
(128, 1, 310),
(129, 1, 311),
(130, 1, 312),
(131, 1, 313),
(132, 1, 314),
(133, 1, 315),
(134, 1, 316),
(135, 1, 317),
(136, 1, 318),
(137, 1, 319),
(138, 1, 320),
(139, 1, 361),
(140, 1, 362),
(141, 1, 363),
(142, 1, 364),
(143, 1, 365),
(144, 1, 366),
(145, 1, 367),
(146, 1, 368),
(147, 1, 373),
(148, 1, 374),
(149, 1, 375),
(150, 1, 376),
(156, 1, 377),
(157, 1, 378),
(158, 1, 379),
(159, 1, 380),
(160, 1, 381),
(161, 1, 382),
(162, 1, 383),
(151, 1, 384),
(152, 1, 389),
(153, 1, 390),
(154, 1, 391),
(155, 1, 392),
(164, 1, 395),
(165, 1, 396),
(166, 1, 399),
(163, 1, 400),
(168, 1, 405),
(169, 1, 406),
(170, 1, 407),
(171, 1, 408),
(172, 1, 413),
(173, 1, 414),
(174, 1, 415),
(167, 1, 416),
(175, 1, 425),
(176, 1, 426),
(177, 1, 427),
(178, 1, 428),
(179, 1, 429),
(180, 1, 430),
(181, 1, 431),
(182, 1, 432),
(183, 1, 433),
(184, 1, 434),
(185, 1, 435),
(186, 1, 436),
(187, 1, 437),
(188, 1, 438),
(189, 1, 439),
(190, 1, 440);

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
(243, 'Can add log entry', 1, 'add_logentry'),
(244, 'Can change log entry', 1, 'change_logentry'),
(245, 'Can delete log entry', 1, 'delete_logentry'),
(246, 'Can view log entry', 1, 'view_logentry'),
(247, 'Can approve hotel request', 30, 'can_approve_request'),
(248, 'Can reject hotel request', 30, 'can_reject_request'),
(249, 'Can add permission', 31, 'add_permission'),
(250, 'Can change permission', 31, 'change_permission'),
(251, 'Can delete permission', 31, 'delete_permission'),
(252, 'Can view permission', 31, 'view_permission'),
(253, 'Can add group', 4, 'add_group'),
(254, 'Can change group', 4, 'change_group'),
(255, 'Can delete group', 4, 'delete_group'),
(256, 'Can view group', 4, 'view_group'),
(257, 'Can add content type', 32, 'add_contenttype'),
(258, 'Can change content type', 32, 'change_contenttype'),
(259, 'Can delete content type', 32, 'delete_contenttype'),
(260, 'Can view content type', 32, 'view_contenttype'),
(261, 'Can add session', 33, 'add_session'),
(262, 'Can change session', 33, 'change_session'),
(263, 'Can delete session', 33, 'delete_session'),
(264, 'Can view session', 33, 'view_session'),
(265, 'Can add مستخدم', 2, 'add_customuser'),
(266, 'Can change مستخدم', 2, 'change_customuser'),
(267, 'Can delete مستخدم', 2, 'delete_customuser'),
(268, 'Can view مستخدم', 2, 'view_customuser'),
(269, 'Can add سجل النشاط', 34, 'add_activitylog'),
(270, 'Can change سجل النشاط', 34, 'change_activitylog'),
(271, 'Can delete سجل النشاط', 34, 'delete_activitylog'),
(272, 'Can view سجل النشاط', 34, 'view_activitylog'),
(273, 'Can add منطقه', 21, 'add_city'),
(274, 'Can change منطقه', 21, 'change_city'),
(275, 'Can delete منطقه', 21, 'delete_city'),
(276, 'Can view منطقه', 21, 'view_city'),
(277, 'Can add فندق', 18, 'add_hotel'),
(278, 'Can change فندق', 18, 'change_hotel'),
(279, 'Can delete فندق', 18, 'delete_hotel'),
(280, 'Can view فندق', 18, 'view_hotel'),
(281, 'Can add طلب إضافة فندق', 30, 'add_hotelrequest'),
(282, 'Can change طلب إضافة فندق', 30, 'change_hotelrequest'),
(283, 'Can delete طلب إضافة فندق', 30, 'delete_hotelrequest'),
(284, 'Can view طلب إضافة فندق', 30, 'view_hotelrequest'),
(285, 'Can add صورة', 19, 'add_image'),
(286, 'Can change صورة', 19, 'change_image'),
(287, 'Can delete صورة', 19, 'delete_image'),
(288, 'Can view صورة', 19, 'view_image'),
(289, 'Can add الموقع', 22, 'add_location'),
(290, 'Can change الموقع', 22, 'change_location'),
(291, 'Can delete الموقع', 22, 'delete_location'),
(292, 'Can view الموقع', 22, 'view_location'),
(293, 'Can add رقم هاتف', 20, 'add_phone'),
(294, 'Can change رقم هاتف', 20, 'change_phone'),
(295, 'Can delete رقم هاتف', 20, 'delete_phone'),
(296, 'Can view رقم هاتف', 20, 'view_phone'),
(297, 'Can add توفر الغرف', 9, 'add_availability'),
(298, 'Can change توفر الغرف', 9, 'change_availability'),
(299, 'Can delete توفر الغرف', 9, 'delete_availability'),
(300, 'Can view توفر الغرف', 9, 'view_availability'),
(301, 'Can add تصنيف', 6, 'add_category'),
(302, 'Can change تصنيف', 6, 'change_category'),
(303, 'Can delete تصنيف', 6, 'delete_category'),
(304, 'Can view تصنيف', 6, 'view_category'),
(305, 'Can add صورة الغرفة', 7, 'add_roomimage'),
(306, 'Can change صورة الغرفة', 7, 'change_roomimage'),
(307, 'Can delete صورة الغرفة', 7, 'delete_roomimage'),
(308, 'Can view صورة الغرفة', 7, 'view_roomimage'),
(309, 'Can add سعر الغرفة', 8, 'add_roomprice'),
(310, 'Can change سعر الغرفة', 8, 'change_roomprice'),
(311, 'Can delete سعر الغرفة', 8, 'delete_roomprice'),
(312, 'Can view سعر الغرفة', 8, 'view_roomprice'),
(313, 'Can add حالة الغرفة', 10, 'add_roomstatus'),
(314, 'Can change حالة الغرفة', 10, 'change_roomstatus'),
(315, 'Can delete حالة الغرفة', 10, 'delete_roomstatus'),
(316, 'Can view حالة الغرفة', 10, 'view_roomstatus'),
(317, 'Can add نوع الغرفة', 5, 'add_roomtype'),
(318, 'Can change نوع الغرفة', 5, 'change_roomtype'),
(319, 'Can delete نوع الغرفة', 5, 'delete_roomtype'),
(320, 'Can view نوع الغرفة', 5, 'view_roomtype'),
(321, 'Can add contact message', 36, 'add_contactmessage'),
(322, 'Can change contact message', 36, 'change_contactmessage'),
(323, 'Can delete contact message', 36, 'delete_contactmessage'),
(324, 'Can view contact message', 36, 'view_contactmessage'),
(325, 'Can add hero slider', 37, 'add_heroslider'),
(326, 'Can change hero slider', 37, 'change_heroslider'),
(327, 'Can delete hero slider', 37, 'delete_heroslider'),
(328, 'Can view hero slider', 37, 'view_heroslider'),
(329, 'Can add info box', 38, 'add_infobox'),
(330, 'Can change info box', 38, 'change_infobox'),
(331, 'Can delete info box', 38, 'delete_infobox'),
(332, 'Can view info box', 38, 'view_infobox'),
(333, 'Can add partner', 39, 'add_partner'),
(334, 'Can change partner', 39, 'change_partner'),
(335, 'Can delete partner', 39, 'delete_partner'),
(336, 'Can view partner', 39, 'view_partner'),
(337, 'Can add pricing plan', 40, 'add_pricingplan'),
(338, 'Can change pricing plan', 40, 'change_pricingplan'),
(339, 'Can delete pricing plan', 40, 'delete_pricingplan'),
(340, 'Can view pricing plan', 40, 'view_pricingplan'),
(341, 'Can add room type home', 41, 'add_roomtypehome'),
(342, 'Can change room type home', 41, 'change_roomtypehome'),
(343, 'Can delete room type home', 41, 'delete_roomtypehome'),
(344, 'Can view room type home', 41, 'view_roomtypehome'),
(345, 'Can add setting', 42, 'add_setting'),
(346, 'Can change setting', 42, 'change_setting'),
(347, 'Can delete setting', 42, 'delete_setting'),
(348, 'Can view setting', 42, 'view_setting'),
(349, 'Can add social media link', 43, 'add_socialmedialink'),
(350, 'Can change social media link', 43, 'change_socialmedialink'),
(351, 'Can delete social media link', 43, 'delete_socialmedialink'),
(352, 'Can view social media link', 43, 'view_socialmedialink'),
(353, 'Can add team member', 44, 'add_teammember'),
(354, 'Can change team member', 44, 'change_teammember'),
(355, 'Can delete team member', 44, 'delete_teammember'),
(356, 'Can view team member', 44, 'view_teammember'),
(357, 'Can add testimonial', 45, 'add_testimonial'),
(358, 'Can change testimonial', 45, 'change_testimonial'),
(359, 'Can delete testimonial', 45, 'delete_testimonial'),
(360, 'Can view testimonial', 45, 'view_testimonial'),
(361, 'Can add حجز', 13, 'add_booking'),
(362, 'Can change حجز', 13, 'change_booking'),
(363, 'Can delete حجز', 13, 'delete_booking'),
(364, 'Can view حجز', 13, 'view_booking'),
(365, 'Can add تفصيل الحجز', 14, 'add_bookingdetail'),
(366, 'Can change تفصيل الحجز', 14, 'change_bookingdetail'),
(367, 'Can delete تفصيل الحجز', 14, 'delete_bookingdetail'),
(368, 'Can view تفصيل الحجز', 14, 'view_bookingdetail'),
(369, 'Can add ضيف', 46, 'add_guest'),
(370, 'Can change ضيف', 46, 'change_guest'),
(371, 'Can delete ضيف', 46, 'delete_guest'),
(372, 'Can view ضيف', 46, 'view_guest'),
(373, 'Can add extension movement', 15, 'add_extensionmovement'),
(374, 'Can change extension movement', 15, 'change_extensionmovement'),
(375, 'Can delete extension movement', 15, 'delete_extensionmovement'),
(376, 'Can view extension movement', 15, 'view_extensionmovement'),
(377, 'Can add عملة', 27, 'add_currency'),
(378, 'Can change عملة', 27, 'change_currency'),
(379, 'Can delete عملة', 27, 'delete_currency'),
(380, 'Can view عملة', 27, 'view_currency'),
(381, 'Can add طريقة دفع الفندق', 29, 'add_hotelpaymentmethod'),
(382, 'Can change طريقة دفع الفندق', 29, 'change_hotelpaymentmethod'),
(383, 'Can delete طريقة دفع الفندق', 29, 'delete_hotelpaymentmethod'),
(384, 'Can view طريقة دفع الفندق', 29, 'view_hotelpaymentmethod'),
(385, 'Can add دفعة', 47, 'add_payment'),
(386, 'Can change دفعة', 47, 'change_payment'),
(387, 'Can delete دفعة', 47, 'delete_payment'),
(388, 'Can view دفعة', 47, 'view_payment'),
(389, 'Can add طريقة دفع', 28, 'add_paymentoption'),
(390, 'Can change طريقة دفع', 28, 'change_paymentoption'),
(391, 'Can delete طريقة دفع', 28, 'delete_paymentoption'),
(392, 'Can view طريقة دفع', 28, 'view_paymentoption'),
(393, 'Can add مراجعة فندق', 17, 'add_hotelreview'),
(394, 'Can change مراجعة فندق', 17, 'change_hotelreview'),
(395, 'Can delete مراجعة فندق', 17, 'delete_hotelreview'),
(396, 'Can view مراجعة فندق', 17, 'view_hotelreview'),
(397, 'Can add مراجعة غرفة', 16, 'add_roomreview'),
(398, 'Can change مراجعة غرفة', 16, 'change_roomreview'),
(399, 'Can delete مراجعة غرفة', 16, 'delete_roomreview'),
(400, 'Can view مراجعة غرفة', 16, 'view_roomreview'),
(401, 'Can add coupon', 48, 'add_coupon'),
(402, 'Can change coupon', 48, 'change_coupon'),
(403, 'Can delete coupon', 48, 'delete_coupon'),
(404, 'Can view coupon', 48, 'view_coupon'),
(405, 'Can add خدمة فندقية', 12, 'add_hotelservice'),
(406, 'Can change خدمة فندقية', 12, 'change_hotelservice'),
(407, 'Can delete خدمة فندقية', 12, 'delete_hotelservice'),
(408, 'Can view خدمة فندقية', 12, 'view_hotelservice'),
(409, 'Can add عرض', 49, 'add_offer'),
(410, 'Can change عرض', 49, 'change_offer'),
(411, 'Can delete عرض', 49, 'delete_offer'),
(412, 'Can view عرض', 49, 'view_offer'),
(413, 'Can add خدمة نوع الغرفة', 11, 'add_roomtypeservice'),
(414, 'Can change خدمة نوع الغرفة', 11, 'change_roomtypeservice'),
(415, 'Can delete خدمة نوع الغرفة', 11, 'delete_roomtypeservice'),
(416, 'Can view خدمة نوع الغرفة', 11, 'view_roomtypeservice'),
(417, 'Can add blacklisted token', 50, 'add_blacklistedtoken'),
(418, 'Can change blacklisted token', 50, 'change_blacklistedtoken'),
(419, 'Can delete blacklisted token', 50, 'delete_blacklistedtoken'),
(420, 'Can view blacklisted token', 50, 'view_blacklistedtoken'),
(421, 'Can add outstanding token', 51, 'add_outstandingtoken'),
(422, 'Can change outstanding token', 51, 'change_outstandingtoken'),
(423, 'Can delete outstanding token', 51, 'delete_outstandingtoken'),
(424, 'Can view outstanding token', 51, 'view_outstandingtoken'),
(425, 'Can add تصنيف', 25, 'add_category'),
(426, 'Can change تصنيف', 25, 'change_category'),
(427, 'Can delete تصنيف', 25, 'delete_category'),
(428, 'Can view تصنيف', 25, 'view_category'),
(429, 'Can add تعليق', 24, 'add_comment'),
(430, 'Can change تعليق', 24, 'change_comment'),
(431, 'Can delete تعليق', 24, 'delete_comment'),
(432, 'Can view تعليق', 24, 'view_comment'),
(433, 'Can add مقال', 23, 'add_post'),
(434, 'Can change مقال', 23, 'change_post'),
(435, 'Can delete مقال', 23, 'delete_post'),
(436, 'Can view مقال', 23, 'view_post'),
(437, 'Can add وسم', 26, 'add_tag'),
(438, 'Can change وسم', 26, 'change_tag'),
(439, 'Can delete وسم', 26, 'delete_tag'),
(440, 'Can view وسم', 26, 'view_tag'),
(441, 'Can add إشعار', 52, 'add_notifications'),
(442, 'Can change إشعار', 52, 'change_notifications'),
(443, 'Can delete إشعار', 52, 'delete_notifications'),
(444, 'Can view إشعار', 52, 'view_notifications'),
(445, 'Can add المفضلات', 53, 'add_favourites'),
(446, 'Can change المفضلات', 53, 'change_favourites'),
(447, 'Can delete المفضلات', 53, 'delete_favourites'),
(448, 'Can view المفضلات', 53, 'view_favourites'),
(449, 'Can add crontab', 54, 'add_crontabschedule'),
(450, 'Can change crontab', 54, 'change_crontabschedule'),
(451, 'Can delete crontab', 54, 'delete_crontabschedule'),
(452, 'Can view crontab', 54, 'view_crontabschedule'),
(453, 'Can add interval', 55, 'add_intervalschedule'),
(454, 'Can change interval', 55, 'change_intervalschedule'),
(455, 'Can delete interval', 55, 'delete_intervalschedule'),
(456, 'Can view interval', 55, 'view_intervalschedule'),
(457, 'Can add periodic task', 56, 'add_periodictask'),
(458, 'Can change periodic task', 56, 'change_periodictask'),
(459, 'Can delete periodic task', 56, 'delete_periodictask'),
(460, 'Can view periodic task', 56, 'view_periodictask'),
(461, 'Can add periodic task track', 57, 'add_periodictasks'),
(462, 'Can change periodic task track', 57, 'change_periodictasks'),
(463, 'Can delete periodic task track', 57, 'delete_periodictasks'),
(464, 'Can view periodic task track', 57, 'view_periodictasks'),
(465, 'Can add solar event', 58, 'add_solarschedule'),
(466, 'Can change solar event', 58, 'change_solarschedule'),
(467, 'Can delete solar event', 58, 'delete_solarschedule'),
(468, 'Can view solar event', 58, 'view_solarschedule'),
(469, 'Can add clocked', 59, 'add_clockedschedule'),
(470, 'Can change clocked', 59, 'change_clockedschedule'),
(471, 'Can delete clocked', 59, 'delete_clockedschedule'),
(472, 'Can view clocked', 59, 'view_clockedschedule'),
(473, 'Can add chart of accounts', 60, 'add_chartofaccounts'),
(474, 'Can change chart of accounts', 60, 'change_chartofaccounts'),
(475, 'Can delete chart of accounts', 60, 'delete_chartofaccounts'),
(476, 'Can view chart of accounts', 60, 'view_chartofaccounts'),
(477, 'Can add journal entry', 61, 'add_journalentry'),
(478, 'Can change journal entry', 61, 'change_journalentry'),
(479, 'Can delete journal entry', 61, 'delete_journalentry'),
(480, 'Can view journal entry', 61, 'view_journalentry'),
(481, 'Can add سجل الحجز', 62, 'add_bookinghistory'),
(482, 'Can change سجل الحجز', 62, 'change_bookinghistory'),
(483, 'Can delete سجل الحجز', 62, 'delete_bookinghistory'),
(484, 'Can view سجل الحجز', 62, 'view_bookinghistory'),
(485, 'Can add سجل الدفعة', 63, 'add_paymenthistory'),
(486, 'Can change سجل الدفعة', 63, 'change_paymenthistory'),
(487, 'Can delete سجل الدفعة', 63, 'delete_paymenthistory'),
(488, 'Can view سجل الدفعة', 63, 'view_paymenthistory'),
(489, 'Can add privacy policy', 64, 'add_privacypolicy'),
(490, 'Can change privacy policy', 64, 'change_privacypolicy'),
(491, 'Can delete privacy policy', 64, 'delete_privacypolicy'),
(492, 'Can view privacy policy', 64, 'view_privacypolicy'),
(493, 'Can add terms conditions', 65, 'add_termsconditions'),
(494, 'Can change terms conditions', 65, 'change_termsconditions'),
(495, 'Can delete terms conditions', 65, 'delete_termsconditions'),
(496, 'Can view terms conditions', 65, 'view_termsconditions'),
(497, 'Can add paymen policy', 66, 'add_paymenpolicy'),
(498, 'Can change paymen policy', 66, 'change_paymenpolicy'),
(499, 'Can delete paymen policy', 66, 'delete_paymenpolicy'),
(500, 'Can view paymen policy', 66, 'view_paymenpolicy'),
(501, 'Can add Token', 67, 'add_token'),
(502, 'Can change Token', 67, 'change_token'),
(503, 'Can delete Token', 67, 'delete_token'),
(504, 'Can view Token', 67, 'view_token'),
(505, 'Can add Token', 68, 'add_tokenproxy'),
(506, 'Can change Token', 68, 'change_tokenproxy'),
(507, 'Can delete Token', 68, 'delete_tokenproxy'),
(508, 'Can view Token', 68, 'view_tokenproxy'),
(509, 'Can add association', 69, 'add_association'),
(510, 'Can change association', 69, 'change_association'),
(511, 'Can delete association', 69, 'delete_association'),
(512, 'Can view association', 69, 'view_association'),
(513, 'Can add code', 70, 'add_code'),
(514, 'Can change code', 70, 'change_code'),
(515, 'Can delete code', 70, 'delete_code'),
(516, 'Can view code', 70, 'view_code'),
(517, 'Can add nonce', 71, 'add_nonce'),
(518, 'Can change nonce', 71, 'change_nonce'),
(519, 'Can delete nonce', 71, 'delete_nonce'),
(520, 'Can view nonce', 71, 'view_nonce'),
(521, 'Can add user social auth', 72, 'add_usersocialauth'),
(522, 'Can change user social auth', 72, 'change_usersocialauth'),
(523, 'Can delete user social auth', 72, 'delete_usersocialauth'),
(524, 'Can view user social auth', 72, 'view_usersocialauth'),
(525, 'Can add partial', 73, 'add_partial'),
(526, 'Can change partial', 73, 'change_partial'),
(527, 'Can delete partial', 73, 'delete_partial'),
(528, 'Can view partial', 73, 'view_partial'),
(529, 'Can add site', 74, 'add_site'),
(530, 'Can change site', 74, 'change_site'),
(531, 'Can delete site', 74, 'delete_site'),
(532, 'Can view site', 74, 'view_site'),
(533, 'Can add application', 75, 'add_application'),
(534, 'Can change application', 75, 'change_application'),
(535, 'Can delete application', 75, 'delete_application'),
(536, 'Can view application', 75, 'view_application'),
(537, 'Can add access token', 76, 'add_accesstoken'),
(538, 'Can change access token', 76, 'change_accesstoken'),
(539, 'Can delete access token', 76, 'delete_accesstoken'),
(540, 'Can view access token', 76, 'view_accesstoken'),
(541, 'Can add grant', 77, 'add_grant'),
(542, 'Can change grant', 77, 'change_grant'),
(543, 'Can delete grant', 77, 'delete_grant'),
(544, 'Can view grant', 77, 'view_grant'),
(545, 'Can add refresh token', 78, 'add_refreshtoken'),
(546, 'Can change refresh token', 78, 'change_refreshtoken'),
(547, 'Can delete refresh token', 78, 'delete_refreshtoken'),
(548, 'Can view refresh token', 78, 'view_refreshtoken'),
(549, 'Can add id token', 79, 'add_idtoken'),
(550, 'Can change id token', 79, 'change_idtoken'),
(551, 'Can delete id token', 79, 'delete_idtoken'),
(552, 'Can view id token', 79, 'view_idtoken');

-- --------------------------------------------------------

--
-- Table structure for table `blog_category`
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
-- Table structure for table `blog_comment`
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
-- Table structure for table `blog_post`
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
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bookings_booking`
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

--
-- Dumping data for table `bookings_booking`
--

INSERT INTO `bookings_booking` (`id`, `created_at`, `updated_at`, `deleted_at`, `check_in_date`, `check_out_date`, `actual_check_out_date`, `amount`, `status`, `account_status`, `rooms_booked`, `created_by_id`, `hotel_id`, `parent_booking_id`, `room_id`, `updated_by_id`, `user_id`) VALUES
(1, '2025-04-01 22:54:09.479536', '2025-04-09 09:57:45.224056', NULL, '2025-04-01 22:53:52.000000', '2025-04-09 11:25:57.000000', NULL, 193.00, '2', 1, 1, NULL, 1, NULL, 1, NULL, 12),
(2, '2025-04-06 10:18:14.846826', '2025-04-09 09:57:35.164748', NULL, '2025-04-07 08:52:23.000000', '2025-04-09 13:50:27.000000', NULL, 500.00, '0', 1, 1, NULL, 1, NULL, 1, NULL, 5),
(3, '2025-04-09 09:54:08.148171', '2025-04-09 10:20:59.911062', NULL, '2025-04-08 09:53:00.000000', '2025-04-09 14:55:05.000000', NULL, 111.00, '0', 1, 1, NULL, 1, NULL, 1, NULL, 5),
(5, '2025-04-09 10:17:54.329465', '2025-04-09 10:21:09.576864', NULL, '2025-04-07 10:17:31.000000', '2025-04-09 10:18:33.000000', NULL, 99.00, '0', 1, 2, NULL, 1, NULL, 1, NULL, 5),
(7, '2025-04-09 10:26:55.856738', '2025-04-09 10:45:30.176573', NULL, '2025-04-07 10:26:29.000000', '2025-04-09 15:30:37.000000', NULL, 99.00, '0', 1, 1, NULL, 1, NULL, 1, NULL, 5),
(9, '2025-04-09 10:56:59.805559', '2025-04-09 11:05:33.291198', NULL, '2025-04-07 10:56:42.000000', '2025-04-09 10:58:45.000000', NULL, 66.00, '2', 1, 1, NULL, 1, NULL, 1, NULL, 5),
(10, '2025-04-09 11:06:47.520593', '2025-04-09 11:17:30.353369', NULL, '2025-04-07 11:06:22.000000', '2025-04-09 16:08:27.000000', NULL, 15.00, '2', 1, 1, NULL, 1, NULL, 1, NULL, 5),
(12, '2025-04-09 11:22:11.969607', '2025-04-09 11:23:10.125066', NULL, '2025-04-09 11:21:48.000000', '2025-04-09 16:23:10.000000', NULL, 66.00, '1', 1, 1, NULL, 1, NULL, 1, NULL, 5),
(13, '2025-04-09 11:26:33.564688', '2025-04-09 11:26:51.257373', NULL, '2025-04-09 11:25:58.000000', '2025-04-09 16:40:00.000000', NULL, 94.00, '1', 1, 1, NULL, 1, NULL, 1, NULL, 5),
(14, '2025-04-11 18:56:33.354568', '2025-04-11 18:57:34.015704', NULL, '2025-04-11 00:00:00.000000', '2025-04-12 00:00:00.000000', NULL, 2550.00, '2', 1, 5, NULL, 1, NULL, 1, NULL, 1),
(15, '2025-04-12 21:49:48.854959', '2025-04-15 11:16:52.447612', NULL, '2025-04-13 00:00:00.000000', '2025-04-14 00:00:00.000000', NULL, 15.00, '1', 1, 1, NULL, 1, NULL, 1, NULL, 5),
(16, '2025-04-12 21:52:57.100321', '2025-04-15 11:46:33.727327', NULL, '2025-04-13 00:00:00.000000', '2025-04-14 00:00:00.000000', NULL, 25.00, '1', 1, 1, NULL, 1, NULL, 1, NULL, 24),
(17, '2025-04-14 11:53:59.218695', '2025-04-14 16:29:12.018475', NULL, '2025-11-02 00:00:00.000000', '2025-11-06 00:00:00.000000', NULL, 160.00, '2', 1, 1, NULL, 1, NULL, 1, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `bookings_bookingdetail`
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

--
-- Dumping data for table `bookings_bookingdetail`
--

INSERT INTO `bookings_bookingdetail` (`id`, `created_at`, `updated_at`, `deleted_at`, `quantity`, `price`, `total`, `notes`, `booking_id`, `created_by_id`, `hotel_id`, `service_id`, `updated_by_id`) VALUES
(1, '2025-04-07 20:42:08.696496', '2025-04-07 20:42:08.696496', NULL, 2, 80.00, 160.00, 'advanced', 1, 1, 1, 1, 1),
(2, '2025-04-07 20:42:28.090072', '2025-04-07 20:42:28.090072', NULL, 2, 80.00, 160.00, 'advanced', 2, 1, 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `bookings_bookinghistory`
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

--
-- Dumping data for table `bookings_bookinghistory`
--

INSERT INTO `bookings_bookinghistory` (`id`, `history_date`, `previous_status`, `new_status`, `check_in_date`, `check_out_date`, `actual_check_out_date`, `amount`, `account_status`, `rooms_booked`, `booking_id`, `changed_by_id`, `hotel_id`, `parent_booking_id`, `room_id`, `user_id`) VALUES
(1, '2025-04-01 22:54:33.035731', '0', '1', '2025-04-01 22:53:52.000000', '2025-04-02 22:53:54.000000', NULL, 193.00, 1, 1, 1, 12, 1, NULL, 1, 12),
(2, '2025-04-01 22:57:17.086497', '1', '1', '2025-04-01 22:53:52.000000', '2025-04-02 22:53:54.000000', NULL, 193.00, 1, 1, 1, 12, 1, NULL, 1, 12),
(3, '2025-04-01 22:57:41.949606', '1', '1', '2025-04-01 22:53:52.000000', '2025-04-02 22:53:54.000000', '2025-04-01 22:57:41.921859', 193.00, 1, 1, 1, 12, 1, NULL, 1, 12),
(5, '2025-04-09 09:01:22.869681', '0', '1', '2025-04-07 08:52:23.000000', '2025-04-09 13:50:27.000000', NULL, 500.00, 1, 1, 2, 1, 1, NULL, 1, 1),
(6, '2025-04-09 09:26:07.495135', '1', '1', '2025-04-01 22:53:52.000000', '2025-04-09 11:25:57.000000', NULL, 193.00, 1, 1, 1, 12, 1, NULL, 1, 12),
(7, '2025-04-09 09:57:35.170888', '1', '0', '2025-04-07 08:52:23.000000', '2025-04-09 13:50:27.000000', NULL, 500.00, 1, 1, 2, 5, 1, NULL, 1, 5),
(8, '2025-04-09 09:57:45.237350', '1', '2', '2025-04-01 22:53:52.000000', '2025-04-09 11:25:57.000000', NULL, 193.00, 1, 1, 1, 12, 1, NULL, 1, 12),
(9, '2025-04-09 10:20:59.918941', '1', '0', '2025-04-08 09:53:00.000000', '2025-04-09 14:55:05.000000', NULL, 111.00, 1, 1, 3, 5, 1, NULL, 1, 5),
(10, '2025-04-09 10:21:09.582567', '1', '0', '2025-04-07 10:17:31.000000', '2025-04-09 10:18:33.000000', NULL, 99.00, 1, 2, 5, 5, 1, NULL, 1, 5),
(11, '2025-04-09 10:45:30.176573', '1', '0', '2025-04-07 10:26:29.000000', '2025-04-09 15:30:37.000000', NULL, 99.00, 1, 1, 7, 5, 1, NULL, 1, 5),
(13, '2025-04-09 11:05:33.304119', '1', '2', '2025-04-07 10:56:42.000000', '2025-04-09 10:58:45.000000', NULL, 66.00, 1, 1, 9, 5, 1, NULL, 1, 5),
(14, '2025-04-09 11:17:30.360238', '1', '2', '2025-04-07 11:06:22.000000', '2025-04-09 16:08:27.000000', NULL, 15.00, 1, 1, 10, 5, 1, NULL, 1, 5),
(15, '2025-04-09 11:26:51.269644', '0', '1', '2025-04-09 11:25:58.000000', '2025-04-09 16:40:00.000000', NULL, 94.00, 1, 1, 13, 5, 1, NULL, 1, 5),
(16, '2025-04-11 18:57:34.020618', '0', '2', '2025-04-11 00:00:00.000000', '2025-04-12 00:00:00.000000', NULL, 2550.00, 1, 5, 14, 1, 1, NULL, 1, 1),
(17, '2025-04-13 21:28:32.329757', '0', '1', '2025-04-13 00:00:00.000000', '2025-04-14 00:00:00.000000', NULL, 25.00, 1, 1, 16, 5, 1, NULL, 1, 5),
(18, '2025-04-14 16:29:12.031055', '0', '2', '2025-11-02 00:00:00.000000', '2025-11-06 00:00:00.000000', NULL, 160.00, 1, 1, 17, 1, 1, NULL, 1, 1),
(19, '2025-04-15 11:16:52.447612', '0', '1', '2025-04-13 00:00:00.000000', '2025-04-14 00:00:00.000000', NULL, 15.00, 1, 1, 15, 5, 1, NULL, 1, 5),
(21, '2025-04-15 11:38:57.939328', '1', '0', '2025-04-13 00:00:00.000000', '2025-04-14 00:00:00.000000', NULL, 25.00, 1, 1, 16, 5, 1, NULL, 1, 5),
(22, '2025-04-15 11:39:30.099669', '0', '1', '2025-04-13 00:00:00.000000', '2025-04-14 00:00:00.000000', NULL, 25.00, 1, 1, 16, 5, 1, NULL, 1, 5);

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

--
-- Dumping data for table `bookings_extensionmovement`
--

INSERT INTO `bookings_extensionmovement` (`movement_number`, `original_departure`, `extension_date`, `new_departure`, `reason`, `extension_year`, `duration`, `booking_id`, `payment_receipt_id`) VALUES
(1, '2025-04-14', '2025-04-13', '2025-04-17', 'personal', 2025, 3, 16, NULL),
(2, '2025-04-17', '2025-04-13', '2025-04-17', 'personal', 2025, 0, 16, NULL),
(3, '2025-04-17', '2025-04-13', '2025-04-17', 'personal', 2025, 0, 16, NULL),
(4, '2025-04-17', '2025-04-13', '2025-04-18', 'personal', 2025, 1, 16, NULL),
(5, '2025-04-18', '2025-04-13', '2025-04-19', 'personal', 2025, 1, 16, NULL),
(6, '2025-04-19', '2025-04-13', '2025-04-20', 'personal', 2025, 1, 16, 8);

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
  `hotel_id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bookings_guest`
--

INSERT INTO `bookings_guest` (`id`, `name`, `phone_number`, `id_card_image`, `gender`, `birthday_date`, `check_in_date`, `check_out_date`, `booking_id`, `hotel_id`, `created_at`, `created_by_id`, `deleted_at`, `updated_at`, `updated_by_id`) VALUES
(1, 'ahmed mohamed', '781717609', 'guests/id_card_images/alamo.png', 'male', '2002-04-07', '2025-04-07 20:51:05.000000', '2025-04-19 20:51:04.000000', 2, 1, '2025-04-13 21:17:51.188896', NULL, NULL, '2025-04-13 21:17:51.684130', NULL),
(2, 'ahmed', '16156161516', 'guests/id_card_images/bg.jpg', 'male', '2025-04-22', '2025-04-09 11:25:58.000000', '2025-04-09 16:40:00.000000', 13, 1, '2025-04-13 21:17:51.188896', NULL, NULL, '2025-04-13 21:17:51.684130', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `customer_favourites`
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

--
-- Dumping data for table `customer_favourites`
--

INSERT INTO `customer_favourites` (`id`, `created_at`, `updated_at`, `deleted_at`, `created_by_id`, `hotel_id`, `updated_by_id`, `user_id`) VALUES
(1, '2025-04-01 00:24:39.320663', '2025-04-01 00:24:39.320663', NULL, 1, 1, 1, 14),
(57, '2025-04-04 21:45:45.521085', '2025-04-04 21:45:45.521085', NULL, NULL, 2, NULL, 5),
(61, '2025-04-11 20:11:32.685861', '2025-04-11 20:11:32.685861', NULL, NULL, 1, NULL, 1),
(62, '2025-04-15 09:09:06.534621', '2025-04-15 09:09:06.534621', NULL, NULL, 2, NULL, 1);

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
(1, '2025-04-01 00:24:39.322998', '1', ' - احمد', 1, '[{\"added\": {}}]', 53, 1),
(2, '2025-04-01 00:25:20.913442', '14', 'c', 2, '[{\"changed\": {\"fields\": [\"Groups\"]}}]', 2, 1),
(3, '2025-04-01 00:26:23.956918', '1', 'Hotel Managers', 2, '[{\"changed\": {\"fields\": [\"Permissions\"]}}]', 4, 1),
(4, '2025-04-01 00:26:59.043384', '1', 'إشعار من a إلى c - 1', 1, '[{\"added\": {}}]', 52, 1),
(5, '2025-04-01 00:27:14.798855', '2', 'إشعار من a إلى ammar alwan - 2', 1, '[{\"added\": {}}]', 52, 1),
(6, '2025-04-01 00:28:01.538582', '1', 'Hotel Managers', 2, '[{\"changed\": {\"fields\": [\"Permissions\"]}}]', 4, 1),
(7, '2025-04-01 00:29:02.883231', '1', 'إشعار من a إلى a - 1', 2, '[{\"changed\": {\"fields\": [\"\\u0627\\u0644\\u0645\\u0633\\u062a\\u0644\\u0645\"]}}]', 52, 14),
(8, '2025-04-01 00:29:41.453537', '1', 'إشعار من a إلى c - 1', 2, '[{\"changed\": {\"fields\": [\"\\u0627\\u0644\\u0645\\u0633\\u062a\\u0644\\u0645\"]}}]', 52, 1),
(9, '2025-04-01 22:54:09.498035', '1', 'Booking #1 - room vip 2025 (1 rooms)', 1, '[{\"added\": {}}]', 13, 1),
(10, '2025-04-01 22:57:17.102621', '1', 'Booking #1 - room vip 2025 (1 rooms)', 2, '[{\"changed\": {\"fields\": [\"\\u062a\\u0627\\u0631\\u064a\\u062e \\u0627\\u0644\\u0645\\u063a\\u0627\\u062f\\u0631\\u0629 \\u0627\\u0644\\u0641\\u0639\\u0644\\u064a\"]}}]', 13, 1),
(11, '2025-04-01 23:42:01.987544', '1', 'دفعة #1 لحجز 1', 1, '[{\"added\": {}}]', 47, 1),
(12, '2025-04-01 23:45:09.019906', '2', 'دفعة #2 لحجز 2', 1, '[{\"added\": {}}]', 47, 1),
(13, '2025-04-01 23:57:21.638032', '1', 'room vip 2025 - 500 (2025-04-01 إلى 2025-04-11)', 1, '[{\"added\": {}}]', 8, 1),
(14, '2025-04-02 00:00:51.030698', '1', 'ahmed', 1, '[{\"added\": {}}]', 48, 1),
(15, '2025-04-02 00:01:14.396725', '1', 'ahmed', 2, '[{\"changed\": {\"fields\": [\"Min purchase amount\"]}}]', 48, 1),
(16, '2025-04-02 00:01:29.128987', '1', 'ahmed', 2, '[]', 48, 1),
(17, '2025-04-02 00:12:05.657169', '2', 'new ---', 1, '[{\"added\": {}}]', 48, 1),
(18, '2025-04-03 17:25:16.807787', '1', 'ammar alwan - احمد (5 نجوم)', 1, '[{\"added\": {}}]', 17, 1),
(19, '2025-04-03 17:46:35.262010', 'None', 'إشعار من a إلى كل مديري الفنادق - 1', 1, '[{\"added\": {}}]', 52, 1),
(20, '2025-04-03 17:52:05.554302', 'None', 'إشعار من a إلى كل العملاء - 2', 1, '[{\"added\": {}}]', 52, 1),
(21, '2025-04-03 17:55:52.531821', '21', 'إشعار من a إلى كل العملاء - 2', 3, '', 52, 1),
(22, '2025-04-03 17:55:52.535772', '20', 'إشعار من a إلى كل العملاء - 2', 3, '', 52, 1),
(23, '2025-04-03 17:55:52.543749', '19', 'إشعار من a إلى كل العملاء - 2', 3, '', 52, 1),
(24, '2025-04-03 17:55:52.547738', '18', 'إشعار من a إلى كل العملاء - 2', 3, '', 52, 1),
(25, '2025-04-03 17:55:52.549770', '17', 'إشعار من a إلى كل العملاء - 2', 3, '', 52, 1),
(26, '2025-04-03 17:55:52.552760', '16', 'إشعار من a إلى كل العملاء - 2', 3, '', 52, 1),
(27, '2025-04-03 17:55:52.555758', '15', 'إشعار من a إلى كل العملاء - 2', 3, '', 52, 1),
(28, '2025-04-03 17:55:52.558711', '14', 'إشعار من a إلى كل العملاء - 2', 3, '', 52, 1),
(29, '2025-04-03 17:55:52.561961', '13', 'إشعار من a إلى كل مديري الفنادق - 1', 3, '', 52, 1),
(30, '2025-04-03 17:55:52.564963', '12', 'إشعار من a إلى كل مديري الفنادق - 1', 3, '', 52, 1),
(31, '2025-04-03 17:55:52.566953', '11', 'إشعار من a إلى كل مديري الفنادق - 1', 3, '', 52, 1),
(32, '2025-04-03 17:55:52.572938', '10', 'إشعار من ammar alwan إلى ammar alwan - 1', 3, '', 52, 1),
(33, '2025-04-03 17:55:52.575930', '9', 'إشعار من ammar alwan إلى ammar alwan - 1', 3, '', 52, 1),
(34, '2025-04-03 17:55:52.578923', '8', 'إشعار من ammar alwan إلى ammar alwan - 1', 3, '', 52, 1),
(35, '2025-04-03 17:55:52.581931', '7', 'إشعار من ammar alwan إلى ammar alwan - 1', 3, '', 52, 1),
(36, '2025-04-03 17:55:52.583944', '6', 'إشعار من ammar alwan إلى ammar alwan - 1', 3, '', 52, 1),
(37, '2025-04-03 17:55:52.586936', '5', 'إشعار من ammar alwan إلى ammar alwan - 1', 3, '', 52, 1),
(38, '2025-04-03 17:55:52.589345', '4', 'إشعار من ammar alwan إلى ammar alwan - 1', 3, '', 52, 1),
(39, '2025-04-03 17:55:52.591891', '3', 'إشعار من ammar alwan إلى ammar alwan - 1', 3, '', 52, 1),
(40, '2025-04-03 17:55:52.594959', '2', 'إشعار من a إلى ammar alwan - 2', 3, '', 52, 1),
(41, '2025-04-03 17:55:52.597907', '1', 'إشعار من a إلى c - 1', 3, '', 52, 1),
(42, '2025-04-03 17:56:07.255323', '22', 'إشعار من a إلى mosa mohamed - 1', 1, '[{\"added\": {}}]', 52, 1),
(43, '2025-04-03 17:56:36.037334', 'None', 'إشعار من a إلى كل العملاء - 2', 1, '[{\"added\": {}}]', 52, 1),
(44, '2025-04-03 20:29:27.330760', '1', 'gggs', 1, '[{\"added\": {}}]', 37, 1),
(45, '2025-04-03 22:28:22.450565', '45', 'mosa - sami', 3, '', 53, 1),
(46, '2025-04-04 21:50:12.631031', '2', 'room vip 2025 - 330 (2025-04-04 إلى 2025-04-05)', 1, '[{\"added\": {}}]', 8, 1),
(47, '2025-04-04 21:50:28.376228', '2', 'room vip 2025 - 330.00 (2025-04-04 إلى 2025-04-05)', 2, '[{\"changed\": {\"fields\": [\"\\u0627\\u0644\\u0641\\u0646\\u062f\\u0642\"]}}]', 8, 1),
(48, '2025-04-06 10:00:18.824861', '1', 'wifi', 1, '[{\"added\": {}}]', 12, 1),
(49, '2025-04-06 10:00:44.581010', '2', 'pool', 1, '[{\"added\": {}}]', 12, 1),
(50, '2025-04-06 10:01:55.802040', '1', 'free message', 1, '[{\"added\": {}}]', 11, 1),
(51, '2025-04-06 10:02:22.066808', '2', 'good view', 1, '[{\"added\": {}}]', 11, 1),
(52, '2025-04-07 20:42:08.700645', '1', 'free message - 1', 1, '[{\"added\": {}}]', 14, 1),
(53, '2025-04-07 20:42:28.092074', '2', 'free message - 2', 2, '[{\"changed\": {\"fields\": [\"\\u0627\\u0644\\u062d\\u062c\\u0632\"]}}]', 14, 1),
(54, '2025-04-07 20:51:07.451852', '1', 'ahmed mohamed - 1', 1, '[{\"added\": {}}]', 46, 1),
(55, '2025-04-09 07:49:55.118717', '2', 'Booking #2 - room vip 2025 (1 rooms)', 2, '[{\"changed\": {\"fields\": [\"\\u062a\\u0627\\u0631\\u064a\\u062e \\u062a\\u0633\\u062c\\u064a\\u0644 \\u0627\\u0644\\u062e\\u0631\\u0648\\u062c\"]}}]', 13, 1),
(56, '2025-04-09 08:04:27.685412', '30', 'إشعار من a إلى mosa mohamed - 2', 3, '', 52, 1),
(57, '2025-04-09 08:04:27.685412', '29', 'إشعار من a إلى mosaa1 - 2', 3, '', 52, 1),
(58, '2025-04-09 08:04:27.685412', '28', 'إشعار من a إلى asdjsk - 2', 3, '', 52, 1),
(59, '2025-04-09 08:04:27.695460', '27', 'إشعار من a إلى ahmed mohamed - 2', 3, '', 52, 1),
(60, '2025-04-09 08:04:27.695460', '26', 'إشعار من a إلى askja kksskks - 2', 3, '', 52, 1),
(61, '2025-04-09 08:04:27.695460', '25', 'إشعار من a إلى ajshdkajs aksljdlas - 2', 3, '', 52, 1),
(62, '2025-04-09 08:04:27.695460', '24', 'إشعار من a إلى ammar alwan - 2', 3, '', 52, 1),
(63, '2025-04-09 08:04:27.695460', '23', 'إشعار من a إلى asjdhjkash asdas - 2', 3, '', 52, 1),
(64, '2025-04-09 08:04:27.695460', '22', 'إشعار من a إلى mosa mohamed - 1', 3, '', 52, 1),
(65, '2025-04-09 08:52:44.705109', '2', 'Booking #2 - room vip 2025 (1 rooms)', 2, '[{\"changed\": {\"fields\": [\"\\u062a\\u0627\\u0631\\u064a\\u062e \\u062a\\u0633\\u062c\\u064a\\u0644 \\u0627\\u0644\\u062f\\u062e\\u0648\\u0644\", \"\\u062a\\u0627\\u0631\\u064a\\u062e \\u062a\\u0633\\u062c\\u064a\\u0644 \\u0627\\u0644\\u062e\\u0631\\u0648\\u062c\"]}}]', 13, 1),
(66, '2025-04-09 09:01:22.877869', '2', 'Booking #2 - room vip 2025 (1 rooms)', 2, '[{\"changed\": {\"fields\": [\"\\u062d\\u0627\\u0644\\u0629 \\u0627\\u0644\\u062d\\u062c\\u0632\"]}}]', 13, 1),
(67, '2025-04-09 09:26:07.518414', '1', 'Booking #1 - room vip 2025 (1 rooms)', 2, '[{\"changed\": {\"fields\": [\"\\u062a\\u0627\\u0631\\u064a\\u062e \\u062a\\u0633\\u062c\\u064a\\u0644 \\u0627\\u0644\\u062e\\u0631\\u0648\\u062c\", \"\\u062a\\u0627\\u0631\\u064a\\u062e \\u0627\\u0644\\u0645\\u063a\\u0627\\u062f\\u0631\\u0629 \\u0627\\u0644\\u0641\\u0639\\u0644\\u064a\"]}}]', 13, 1),
(68, '2025-04-09 09:26:38.883711', '2', 'Booking #2 - room vip 2025 (1 rooms)', 2, '[{\"changed\": {\"fields\": [\"\\u0627\\u0644\\u0645\\u0633\\u062a\\u062e\\u062f\\u0645\"]}}]', 13, 1),
(69, '2025-04-09 09:27:06.179024', '5', 'mosa mohamed', 2, '[{\"changed\": {\"fields\": [\"Email address\"]}}]', 2, 1),
(70, '2025-04-09 09:54:08.191304', '3', 'Booking #3 - room vip 2025 (1 rooms)', 1, '[{\"added\": {}}]', 13, 1),
(71, '2025-04-09 09:57:35.210050', '2', 'Booking #2 - room vip 2025 (1 rooms)', 2, '[{\"changed\": {\"fields\": [\"\\u062d\\u0627\\u0644\\u0629 \\u0627\\u0644\\u062d\\u062c\\u0632\"]}}]', 13, 1),
(72, '2025-04-09 09:57:45.268034', '1', 'Booking #1 - room vip 2025 (1 rooms)', 2, '[{\"changed\": {\"fields\": [\"\\u062d\\u0627\\u0644\\u0629 \\u0627\\u0644\\u062d\\u062c\\u0632\"]}}]', 13, 1),
(73, '2025-04-09 10:14:44.198052', '69', 'إشعار من mosa mohamed إلى mosa mohamed - 1', 3, '', 52, 1),
(74, '2025-04-09 10:14:44.204804', '68', 'إشعار من mosa mohamed إلى mosa mohamed - 1', 3, '', 52, 1),
(75, '2025-04-09 10:14:44.209514', '67', 'إشعار من b إلى mosa mohamed - 0', 3, '', 52, 1),
(76, '2025-04-09 10:14:44.212572', '66', 'إشعار من mosa mohamed إلى mosa mohamed - 1', 3, '', 52, 1),
(77, '2025-04-09 10:14:44.212572', '65', 'إشعار من ammar alwan إلى ammar alwan - 1', 3, '', 52, 1),
(78, '2025-04-09 10:14:44.220374', '64', 'إشعار من ammar alwan إلى ammar alwan - 1', 3, '', 52, 1),
(79, '2025-04-09 10:14:44.230207', '63', 'إشعار من b إلى ammar alwan - 0', 3, '', 52, 1),
(80, '2025-04-09 10:14:44.230207', '62', 'إشعار من mosa mohamed إلى mosa mohamed - 1', 3, '', 52, 1),
(81, '2025-04-09 10:14:44.239221', '61', 'إشعار من mosa mohamed إلى mosa mohamed - 1', 3, '', 52, 1),
(82, '2025-04-09 10:14:44.244050', '60', 'إشعار من b إلى mosa mohamed - 0', 3, '', 52, 1),
(83, '2025-04-09 10:14:44.245049', '59', 'إشعار من ammar alwan إلى ammar alwan - 1', 3, '', 52, 1),
(84, '2025-04-09 10:14:44.251491', '58', 'إشعار من ammar alwan إلى ammar alwan - 1', 3, '', 52, 1),
(85, '2025-04-09 10:14:44.255879', '57', 'إشعار من b إلى ammar alwan - 0', 3, '', 52, 1),
(86, '2025-04-09 10:14:44.260478', '56', 'إشعار من mosa mohamed إلى mosa mohamed - 1', 3, '', 52, 1),
(87, '2025-04-09 10:14:44.264050', '55', 'إشعار من mosa mohamed إلى mosa mohamed - 1', 3, '', 52, 1),
(88, '2025-04-09 10:14:44.267721', '54', 'إشعار من b إلى mosa mohamed - 0', 3, '', 52, 1),
(89, '2025-04-09 10:14:44.271546', '53', 'إشعار من ammar alwan إلى ammar alwan - 1', 3, '', 52, 1),
(90, '2025-04-09 10:14:44.276423', '52', 'إشعار من ammar alwan إلى ammar alwan - 1', 3, '', 52, 1),
(91, '2025-04-09 10:14:44.277647', '51', 'إشعار من b إلى ammar alwan - 0', 3, '', 52, 1),
(92, '2025-04-09 10:14:44.277647', '50', 'إشعار من mosa mohamed إلى mosa mohamed - 1', 3, '', 52, 1),
(93, '2025-04-09 10:14:44.288121', '49', 'إشعار من mosa mohamed إلى mosa mohamed - 1', 3, '', 52, 1),
(94, '2025-04-09 10:14:44.292597', '48', 'إشعار من b إلى mosa mohamed - 0', 3, '', 52, 1),
(95, '2025-04-09 10:14:44.297523', '47', 'إشعار من ammar alwan إلى ammar alwan - 1', 3, '', 52, 1),
(96, '2025-04-09 10:14:44.300796', '46', 'إشعار من ammar alwan إلى ammar alwan - 1', 3, '', 52, 1),
(97, '2025-04-09 10:14:44.304703', '45', 'إشعار من b إلى ammar alwan - 0', 3, '', 52, 1),
(98, '2025-04-09 10:14:44.308727', '44', 'إشعار من mosa mohamed إلى mosa mohamed - 1', 3, '', 52, 1),
(99, '2025-04-09 10:14:44.312860', '43', 'إشعار من mosa mohamed إلى mosa mohamed - 1', 3, '', 52, 1),
(100, '2025-04-09 10:14:44.313906', '42', 'إشعار من b إلى mosa mohamed - 0', 3, '', 52, 1),
(101, '2025-04-09 10:14:44.321339', '41', 'إشعار من mosa mohamed إلى mosa mohamed - 1', 3, '', 52, 1),
(102, '2025-04-09 10:14:44.327082', '40', 'إشعار من mosa mohamed إلى mosa mohamed - 1', 3, '', 52, 1),
(103, '2025-04-09 10:14:44.334173', '39', 'إشعار من ammar alwan إلى ammar alwan - 1', 3, '', 52, 1),
(104, '2025-04-09 10:14:44.338464', '38', 'إشعار من ammar alwan إلى ammar alwan - 1', 3, '', 52, 1),
(105, '2025-04-09 10:14:44.342645', '37', 'إشعار من a إلى a - 1', 3, '', 52, 1),
(106, '2025-04-09 10:14:44.347044', '36', 'إشعار من a إلى a - 1', 3, '', 52, 1),
(107, '2025-04-09 10:14:44.348098', '35', 'إشعار من b إلى a - 0', 3, '', 52, 1),
(108, '2025-04-09 10:14:44.354767', '34', 'إشعار من a إلى a - 1', 3, '', 52, 1),
(109, '2025-04-09 10:14:44.358703', '33', 'إشعار من a إلى a - 1', 3, '', 52, 1),
(110, '2025-04-09 10:17:55.024989', '5', 'Booking #5 - room vip 2025 (2 rooms)', 1, '[{\"added\": {}}]', 13, 1),
(111, '2025-04-09 10:20:59.962588', '3', 'Booking #3 - room vip 2025 (1 rooms)', 2, '[{\"changed\": {\"fields\": [\"\\u062d\\u0627\\u0644\\u0629 \\u0627\\u0644\\u062d\\u062c\\u0632\"]}}]', 13, 1),
(112, '2025-04-09 10:21:09.615616', '5', 'Booking #5 - room vip 2025 (2 rooms)', 2, '[{\"changed\": {\"fields\": [\"\\u062d\\u0627\\u0644\\u0629 \\u0627\\u0644\\u062d\\u062c\\u0632\"]}}]', 13, 1),
(113, '2025-04-09 10:22:00.219062', '71', 'إشعار من mosa mohamed إلى mosa mohamed - 1', 3, '', 52, 1),
(114, '2025-04-09 10:22:00.231431', '70', 'إشعار من b إلى mosa mohamed - 0', 3, '', 52, 1),
(115, '2025-04-09 10:22:53.838744', '6', 'Booking #6 - room vip 2025 (2 rooms)', 1, '[{\"added\": {}}]', 13, 1),
(116, '2025-04-09 10:26:15.537470', '6', 'Booking #6 - room vip 2025 (2 rooms)', 3, '', 13, 1),
(117, '2025-04-09 10:26:56.117647', '7', 'Booking #7 - room vip 2025 (1 rooms)', 1, '[{\"added\": {}}]', 13, 1),
(118, '2025-04-09 10:45:19.714691', '8', 'Booking #8 - room vip 2025 (1 rooms)', 1, '[{\"added\": {}}]', 13, 1),
(119, '2025-04-09 10:45:30.176573', '7', 'Booking #7 - room vip 2025 (1 rooms)', 2, '[{\"changed\": {\"fields\": [\"\\u062d\\u0627\\u0644\\u0629 \\u0627\\u0644\\u062d\\u062c\\u0632\"]}}]', 13, 1),
(120, '2025-04-09 10:54:44.907922', '8', 'Booking #8 - room vip 2025 (1 rooms)', 3, '', 13, 1),
(121, '2025-04-09 10:56:24.149195', '18', 'room vip 2025 - 6 rooms available on 2025-04-09', 2, '[{\"changed\": {\"fields\": [\"\\u0639\\u062f\\u062f \\u0627\\u0644\\u063a\\u0631\\u0641 \\u0627\\u0644\\u0645\\u062a\\u0648\\u0641\\u0631\\u0629\"]}}]', 9, 1),
(122, '2025-04-09 10:57:00.259936', '9', 'Booking #9 - room vip 2025 (1 rooms)', 1, '[{\"added\": {}}]', 13, 1),
(123, '2025-04-09 11:06:48.182575', '10', 'Booking #10 - room vip 2025 (1 rooms)', 1, '[{\"added\": {}}]', 13, 1),
(124, '2025-04-09 11:07:55.400751', '97', 'إشعار من mosa mohamed إلى mosa mohamed - 1', 3, '', 52, 1),
(125, '2025-04-09 11:07:55.406054', '96', 'إشعار من mosa mohamed إلى mosa mohamed - 1', 3, '', 52, 1),
(126, '2025-04-09 11:07:55.409852', '95', 'إشعار من b إلى mosa mohamed - 0', 3, '', 52, 1),
(127, '2025-04-09 11:07:55.412969', '94', 'إشعار من mosa mohamed إلى mosa mohamed - 1', 3, '', 52, 1),
(128, '2025-04-09 11:07:55.417522', '93', 'إشعار من b إلى mosa mohamed - 0', 3, '', 52, 1),
(129, '2025-04-09 11:07:55.422161', '92', 'إشعار من mosa mohamed إلى mosa mohamed - 1', 3, '', 52, 1),
(130, '2025-04-09 11:07:55.426608', '91', 'إشعار من b إلى mosa mohamed - 0', 3, '', 52, 1),
(131, '2025-04-09 11:07:55.429668', '90', 'إشعار من mosa mohamed إلى mosa mohamed - 1', 3, '', 52, 1),
(132, '2025-04-09 11:07:55.433380', '89', 'إشعار من b إلى mosa mohamed - 0', 3, '', 52, 1),
(133, '2025-04-09 11:07:55.438368', '88', 'إشعار من mosa mohamed إلى mosa mohamed - 1', 3, '', 52, 1),
(134, '2025-04-09 11:07:55.442159', '87', 'إشعار من b إلى mosa mohamed - 0', 3, '', 52, 1),
(135, '2025-04-09 11:07:55.446005', '86', 'إشعار من mosa mohamed إلى mosa mohamed - 1', 3, '', 52, 1),
(136, '2025-04-09 11:07:55.449941', '85', 'إشعار من b إلى mosa mohamed - 0', 3, '', 52, 1),
(137, '2025-04-09 11:07:55.453947', '84', 'إشعار من mosa mohamed إلى mosa mohamed - 1', 3, '', 52, 1),
(138, '2025-04-09 11:07:55.458091', '83', 'إشعار من b إلى mosa mohamed - 0', 3, '', 52, 1),
(139, '2025-04-09 11:07:55.462074', '82', 'إشعار من mosa mohamed إلى mosa mohamed - 1', 3, '', 52, 1),
(140, '2025-04-09 11:07:55.469156', '81', 'إشعار من b إلى mosa mohamed - 0', 3, '', 52, 1),
(141, '2025-04-09 11:07:55.474381', '80', 'إشعار من mosa mohamed إلى mosa mohamed - 1', 3, '', 52, 1),
(142, '2025-04-09 11:07:55.478343', '79', 'إشعار من b إلى mosa mohamed - 0', 3, '', 52, 1),
(143, '2025-04-09 11:07:55.479661', '78', 'إشعار من mosa mohamed إلى mosa mohamed - 1', 3, '', 52, 1),
(144, '2025-04-09 11:07:55.485447', '77', 'إشعار من b إلى mosa mohamed - 0', 3, '', 52, 1),
(145, '2025-04-09 11:07:55.489440', '76', 'إشعار من mosa mohamed إلى mosa mohamed - 1', 3, '', 52, 1),
(146, '2025-04-09 11:07:55.493552', '75', 'إشعار من b إلى mosa mohamed - 0', 3, '', 52, 1),
(147, '2025-04-09 11:07:55.496625', '74', 'إشعار من mosa mohamed إلى mosa mohamed - 1', 3, '', 52, 1),
(148, '2025-04-09 11:07:55.501353', '73', 'إشعار من b إلى mosa mohamed - 0', 3, '', 52, 1),
(149, '2025-04-09 11:07:55.505443', '72', 'إشعار من mosa mohamed إلى mosa mohamed - 1', 3, '', 52, 1),
(150, '2025-04-09 11:17:07.468263', '113', 'إشعار من mosa mohamed إلى mosa mohamed - 1', 3, '', 52, 1),
(151, '2025-04-09 11:17:07.478876', '112', 'إشعار من b إلى mosa mohamed - 0', 3, '', 52, 1),
(152, '2025-04-09 11:17:07.481958', '111', 'إشعار من mosa mohamed إلى mosa mohamed - 1', 3, '', 52, 1),
(153, '2025-04-09 11:17:07.486869', '110', 'إشعار من b إلى mosa mohamed - 0', 3, '', 52, 1),
(154, '2025-04-09 11:17:07.490868', '109', 'إشعار من mosa mohamed إلى mosa mohamed - 1', 3, '', 52, 1),
(155, '2025-04-09 11:17:07.493868', '108', 'إشعار من b إلى mosa mohamed - 0', 3, '', 52, 1),
(156, '2025-04-09 11:17:07.497297', '107', 'إشعار من mosa mohamed إلى mosa mohamed - 1', 3, '', 52, 1),
(157, '2025-04-09 11:17:07.506872', '106', 'إشعار من b إلى mosa mohamed - 0', 3, '', 52, 1),
(158, '2025-04-09 11:17:07.510868', '105', 'إشعار من mosa mohamed إلى mosa mohamed - 1', 3, '', 52, 1),
(159, '2025-04-09 11:17:07.513942', '104', 'إشعار من b إلى mosa mohamed - 0', 3, '', 52, 1),
(160, '2025-04-09 11:17:07.519079', '103', 'إشعار من mosa mohamed إلى mosa mohamed - 1', 3, '', 52, 1),
(161, '2025-04-09 11:17:07.522867', '102', 'إشعار من b إلى mosa mohamed - 0', 3, '', 52, 1),
(162, '2025-04-09 11:17:07.526870', '101', 'إشعار من mosa mohamed إلى mosa mohamed - 1', 3, '', 52, 1),
(163, '2025-04-09 11:17:07.529868', '100', 'إشعار من b إلى mosa mohamed - 0', 3, '', 52, 1),
(164, '2025-04-09 11:17:07.534882', '99', 'إشعار من mosa mohamed إلى mosa mohamed - 1', 3, '', 52, 1),
(165, '2025-04-09 11:17:07.539162', '98', 'إشعار من b إلى mosa mohamed - 0', 3, '', 52, 1),
(166, '2025-04-09 11:17:17.632078', '117', 'إشعار من mosa mohamed إلى mosa mohamed - 1', 3, '', 52, 1),
(167, '2025-04-09 11:17:17.638067', '116', 'إشعار من b إلى mosa mohamed - 0', 3, '', 52, 1),
(168, '2025-04-09 11:17:17.642110', '115', 'إشعار من mosa mohamed إلى mosa mohamed - 1', 3, '', 52, 1),
(169, '2025-04-09 11:17:17.647286', '114', 'إشعار من b إلى mosa mohamed - 0', 3, '', 52, 1),
(170, '2025-04-09 11:18:10.728028', '11', 'Booking #11 - room vip 2025 (1 rooms)', 1, '[{\"added\": {}}]', 13, 1),
(171, '2025-04-09 11:21:32.264820', '11', 'Booking #11 - room vip 2025 (1 rooms)', 3, '', 13, 1),
(172, '2025-04-09 11:22:12.100255', '12', 'Booking #12 - room vip 2025 (1 rooms)', 1, '[{\"added\": {}}]', 13, 1),
(173, '2025-04-09 11:26:33.586655', '13', 'Booking #13 - room vip 2025 (1 rooms)', 1, '[{\"added\": {}}]', 13, 1),
(174, '2025-04-11 12:29:06.785198', '16', 'joker Games', 3, '', 2, 1),
(175, '2025-04-11 12:29:06.796346', '15', 'صديق الطالب', 3, '', 2, 1),
(176, '2025-04-11 12:38:40.120556', '18', 'مارس - Mars', 3, '', 2, 1),
(177, '2025-04-11 12:38:40.135510', '17', 'سكاي تو - SKY 2', 3, '', 2, 1),
(178, '2025-04-11 18:58:13.047969', '18', 'room vip 2025 - 5 rooms available on 2025-04-09', 3, '', 9, 1),
(179, '2025-04-11 18:58:13.053935', '17', 'room vip 2025 - 14 rooms available on 2025-04-06', 3, '', 9, 1),
(180, '2025-04-11 18:58:13.053935', '16', 'room vip 2025 - 18 rooms available on 2025-04-01', 3, '', 9, 1),
(181, '2025-04-11 18:58:13.059523', '15', 'room vip 2025 - 11 rooms available on 2025-03-31', 3, '', 9, 1),
(182, '2025-04-11 18:58:13.062609', '14', 'room vip 2025 - 3 rooms available on 2025-03-22', 3, '', 9, 1),
(183, '2025-04-12 21:26:44.554023', '2', 'احمد - al akwa', 2, '[{\"changed\": {\"fields\": [\"\\u0646\\u0634\\u0637\"]}}]', 29, 1),
(184, '2025-04-12 21:26:50.131588', '1', 'احمد - al najim', 2, '[{\"changed\": {\"fields\": [\"\\u0646\\u0634\\u0637\"]}}]', 29, 1),
(185, '2025-04-12 21:38:32.194343', '4', 'كاش - dollar (مفعّل)', 1, '[{\"added\": {}}]', 28, 1),
(186, '2025-04-12 21:44:33.455565', '4', 'احمد - كاش', 1, '[{\"added\": {}}]', 29, 1),
(187, '2025-04-12 21:44:40.834739', '1', 'احمد - al najim', 2, '[{\"changed\": {\"fields\": [\"\\u0646\\u0634\\u0637\"]}}]', 29, 1),
(188, '2025-04-13 21:28:32.341635', '16', 'Booking #16 - room vip 2025 (1 rooms)', 2, '[{\"changed\": {\"fields\": [\"\\u062d\\u0627\\u0644\\u0629 \\u0627\\u0644\\u062d\\u062c\\u0632\"]}}]', 13, 1),
(189, '2025-04-13 21:34:31.770207', '4', 'متاح (3)', 1, '[{\"added\": {}}]', 10, 1),
(190, '2025-04-14 08:44:57.973301', '23', 'الأصول غير الملموسة', 2, '[{\"changed\": {\"fields\": [\"Account parent\", \"Account status\", \"Account amount\"]}}]', 60, 1),
(191, '2025-04-14 08:45:15.145294', '24', 'استثمارات طويلة الأجل', 2, '[{\"changed\": {\"fields\": [\"Account parent\", \"Account status\", \"Account amount\"]}}]', 60, 1),
(192, '2025-04-14 08:46:20.515727', '9', 'النقد وما يعادله', 2, '[{\"changed\": {\"fields\": [\"Account parent\", \"Account status\", \"Account amount\"]}}]', 60, 1),
(193, '2025-04-14 10:20:42.993987', '24', 'akshdkj askdj8888', 2, '[{\"changed\": {\"fields\": [\"Email address\"]}}]', 2, 1),
(194, '2025-04-15 09:45:07.396750', '3', 'فندق قصر سبأ صنعاء', 2, '[{\"changed\": {\"fields\": [\"Profile picture\"]}}]', 18, 1),
(195, '2025-04-15 09:45:23.701854', '4', 'فندق أمواج عدن', 2, '[{\"changed\": {\"fields\": [\"Profile picture\"]}}]', 18, 1),
(196, '2025-04-15 09:45:36.074834', '6', 'نزل سقطرى البيئي', 2, '[{\"changed\": {\"fields\": [\"Profile picture\"]}}]', 18, 1),
(197, '2025-04-15 09:45:49.132912', '7', 'فندق برج السلام تعز', 2, '[{\"changed\": {\"fields\": [\"Profile picture\"]}}]', 18, 1),
(198, '2025-04-15 09:46:09.536928', '8', 'فندق إب جراند', 2, '[]', 18, 1),
(199, '2025-04-15 11:16:52.466789', '15', 'Booking #15 - room vip 2025 (1 rooms)', 2, '[{\"changed\": {\"fields\": [\"\\u062d\\u0627\\u0644\\u0629 \\u0627\\u0644\\u062d\\u062c\\u0632\"]}}]', 13, 1),
(200, '2025-04-15 11:17:50.384226', '6', 'دفعة #6 لحجز 6', 2, '[{\"changed\": {\"fields\": [\"\\u0627\\u0644\\u062d\\u062c\\u0632\", \"\\u062d\\u0627\\u0644\\u0629 \\u0627\\u0644\\u062f\\u0641\\u0639\", \"\\u0645\\u0644\\u0627\\u062d\\u0638\\u0627\\u062a \\u0627\\u0644\\u062f\\u0641\\u0639\", \"\\u0643\\u0648\\u062f \\u0627\\u0644\\u062e\\u0635\\u0645\"]}}]', 47, 1),
(201, '2025-04-15 11:35:57.482512', '11', 'البنوك والتحويلات- الحساب الجاري', 2, '[{\"changed\": {\"fields\": [\"Account name\", \"Account status\", \"Account amount\"]}}]', 60, 1),
(202, '2025-04-15 11:38:57.954950', '16', 'Booking #16 - room vip 2025 (1 rooms)', 2, '[{\"changed\": {\"fields\": [\"\\u062d\\u0627\\u0644\\u0629 \\u0627\\u0644\\u062d\\u062c\\u0632\"]}}]', 13, 1),
(203, '2025-04-15 11:39:30.099669', '16', 'Booking #16 - room vip 2025 (1 rooms)', 2, '[{\"changed\": {\"fields\": [\"\\u062d\\u0627\\u0644\\u0629 \\u0627\\u0644\\u062d\\u062c\\u0632\"]}}]', 13, 1),
(204, '2025-04-15 11:42:07.065895', '8', 'دفعة #8 لحجز 8', 2, '[{\"changed\": {\"fields\": [\"\\u0627\\u0644\\u0645\\u0633\\u062a\\u062e\\u062f\\u0645\", \"\\u0643\\u0648\\u062f \\u0627\\u0644\\u062e\\u0635\\u0645\"]}}]', 47, 1),
(205, '2025-04-15 11:42:23.192115', '16', 'Booking #16 - room vip 2025 (1 rooms)', 2, '[{\"changed\": {\"fields\": [\"\\u0627\\u0644\\u0645\\u0633\\u062a\\u062e\\u062f\\u0645\"]}}]', 13, 1),
(206, '2025-04-15 11:46:33.727327', '8', 'دفعة #8 لحجز 8', 2, '[{\"changed\": {\"fields\": [\"\\u062d\\u0627\\u0644\\u0629 \\u0627\\u0644\\u062f\\u0641\\u0639\"]}}]', 47, 1);

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
(60, 'accounts', 'chartofaccounts'),
(61, 'accounts', 'journalentry'),
(1, 'admin', 'logentry'),
(4, 'auth', 'group'),
(31, 'auth', 'permission'),
(3, 'auth', 'user'),
(67, 'authtoken', 'token'),
(68, 'authtoken', 'tokenproxy'),
(25, 'blog', 'category'),
(24, 'blog', 'comment'),
(23, 'blog', 'post'),
(26, 'blog', 'tag'),
(13, 'bookings', 'booking'),
(14, 'bookings', 'bookingdetail'),
(62, 'bookings', 'bookinghistory'),
(15, 'bookings', 'extensionmovement'),
(46, 'bookings', 'guest'),
(32, 'contenttypes', 'contenttype'),
(53, 'customer', 'favourites'),
(59, 'django_celery_beat', 'clockedschedule'),
(54, 'django_celery_beat', 'crontabschedule'),
(55, 'django_celery_beat', 'intervalschedule'),
(56, 'django_celery_beat', 'periodictask'),
(57, 'django_celery_beat', 'periodictasks'),
(58, 'django_celery_beat', 'solarschedule'),
(36, 'home', 'contactmessage'),
(37, 'home', 'heroslider'),
(38, 'home', 'infobox'),
(39, 'home', 'partner'),
(66, 'home', 'paymenpolicy'),
(40, 'home', 'pricingplan'),
(64, 'home', 'privacypolicy'),
(41, 'home', 'roomtypehome'),
(42, 'home', 'setting'),
(43, 'home', 'socialmedialink'),
(44, 'home', 'teammember'),
(65, 'home', 'termsconditions'),
(45, 'home', 'testimonial'),
(21, 'HotelManagement', 'city'),
(18, 'HotelManagement', 'hotel'),
(30, 'HotelManagement', 'hotelrequest'),
(19, 'HotelManagement', 'image'),
(22, 'HotelManagement', 'location'),
(20, 'HotelManagement', 'phone'),
(52, 'notifications', 'notifications'),
(76, 'oauth2_provider', 'accesstoken'),
(75, 'oauth2_provider', 'application'),
(77, 'oauth2_provider', 'grant'),
(79, 'oauth2_provider', 'idtoken'),
(78, 'oauth2_provider', 'refreshtoken'),
(27, 'payments', 'currency'),
(29, 'payments', 'hotelpaymentmethod'),
(47, 'payments', 'payment'),
(63, 'payments', 'paymenthistory'),
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
(48, 'services', 'coupon'),
(12, 'services', 'hotelservice'),
(49, 'services', 'offer'),
(11, 'services', 'roomtypeservice'),
(33, 'sessions', 'session'),
(74, 'sites', 'site'),
(69, 'social_django', 'association'),
(70, 'social_django', 'code'),
(71, 'social_django', 'nonce'),
(73, 'social_django', 'partial'),
(72, 'social_django', 'usersocialauth'),
(50, 'token_blacklist', 'blacklistedtoken'),
(51, 'token_blacklist', 'outstandingtoken'),
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
(1, 'contenttypes', '0001_initial', '2025-04-01 00:07:34.651272'),
(2, 'contenttypes', '0002_remove_content_type_name', '2025-04-01 00:07:34.748019'),
(3, 'auth', '0001_initial', '2025-04-01 00:07:35.122987'),
(4, 'auth', '0002_alter_permission_name_max_length', '2025-04-01 00:07:35.195077'),
(5, 'auth', '0003_alter_user_email_max_length', '2025-04-01 00:07:35.206704'),
(6, 'auth', '0004_alter_user_username_opts', '2025-04-01 00:07:35.217541'),
(7, 'auth', '0005_alter_user_last_login_null', '2025-04-01 00:07:35.228288'),
(8, 'auth', '0006_require_contenttypes_0002', '2025-04-01 00:07:35.233570'),
(9, 'auth', '0007_alter_validators_add_error_messages', '2025-04-01 00:07:35.244241'),
(10, 'auth', '0008_alter_user_username_max_length', '2025-04-01 00:07:35.257476'),
(11, 'auth', '0009_alter_user_last_name_max_length', '2025-04-01 00:07:35.267413'),
(12, 'auth', '0010_alter_group_name_max_length', '2025-04-01 00:07:35.286294'),
(13, 'auth', '0011_update_proxy_permissions', '2025-04-01 00:07:35.301672'),
(14, 'auth', '0012_alter_user_first_name_max_length', '2025-04-01 00:07:35.314520'),
(15, 'auth', '0013_alter_permission_options', '2025-04-01 00:07:35.325484'),
(16, 'auth', '0014_alter_permission_options_alter_user_user_permissions', '2025-04-01 00:07:35.342437'),
(17, 'auth', '0015_alter_user_user_permissions', '2025-04-01 00:07:35.352415'),
(18, 'users', '0001_initial', '2025-04-01 00:07:35.960068'),
(19, 'HotelManagement', '0001_initial', '2025-04-01 00:07:36.208719'),
(20, 'HotelManagement', '0002_initial', '2025-04-01 00:07:38.921204'),
(21, 'admin', '0001_initial', '2025-04-01 00:07:39.308117'),
(22, 'admin', '0002_logentry_remove_auto_add', '2025-04-01 00:07:39.358801'),
(23, 'admin', '0003_logentry_add_action_flag_choices', '2025-04-01 00:07:39.412713'),
(24, 'blog', '0001_initial', '2025-04-01 00:07:39.577946'),
(25, 'blog', '0002_initial', '2025-04-01 00:07:41.556877'),
(26, 'services', '0001_initial', '2025-04-01 00:07:41.670735'),
(27, 'rooms', '0001_initial', '2025-04-01 00:07:41.859080'),
(28, 'payments', '0001_initial', '2025-04-01 00:07:41.938771'),
(29, 'bookings', '0001_initial', '2025-04-01 00:07:42.688013'),
(30, 'bookings', '0002_initial', '2025-04-01 00:07:43.056088'),
(31, 'bookings', '0003_initial', '2025-04-01 00:07:44.513069'),
(32, 'customer', '0001_initial', '2025-04-01 00:07:45.056020'),
(33, 'customer', '0002_auto_20250401_0255', '2025-04-01 00:07:45.061035'),
(34, 'django_celery_beat', '0001_initial', '2025-04-01 00:07:45.352098'),
(35, 'django_celery_beat', '0002_auto_20161118_0346', '2025-04-01 00:07:45.470219'),
(36, 'django_celery_beat', '0003_auto_20161209_0049', '2025-04-01 00:07:45.535722'),
(37, 'django_celery_beat', '0004_auto_20170221_0000', '2025-04-01 00:07:45.557042'),
(38, 'django_celery_beat', '0005_add_solarschedule_events_choices', '2025-04-01 00:07:45.578575'),
(39, 'django_celery_beat', '0006_auto_20180322_0932', '2025-04-01 00:07:45.741869'),
(40, 'django_celery_beat', '0007_auto_20180521_0826', '2025-04-01 00:07:45.842670'),
(41, 'django_celery_beat', '0008_auto_20180914_1922', '2025-04-01 00:07:45.940847'),
(42, 'django_celery_beat', '0006_auto_20180210_1226', '2025-04-01 00:07:45.972015'),
(43, 'django_celery_beat', '0006_periodictask_priority', '2025-04-01 00:07:46.011788'),
(44, 'django_celery_beat', '0009_periodictask_headers', '2025-04-01 00:07:46.062013'),
(45, 'django_celery_beat', '0010_auto_20190429_0326', '2025-04-01 00:07:46.742022'),
(46, 'django_celery_beat', '0011_auto_20190508_0153', '2025-04-01 00:07:46.979672'),
(47, 'django_celery_beat', '0012_periodictask_expire_seconds', '2025-04-01 00:07:47.029133'),
(48, 'django_celery_beat', '0013_auto_20200609_0727', '2025-04-01 00:07:47.057636'),
(49, 'django_celery_beat', '0014_remove_clockedschedule_enabled', '2025-04-01 00:07:47.088573'),
(50, 'django_celery_beat', '0015_edit_solarschedule_events_choices', '2025-04-01 00:07:47.103113'),
(51, 'django_celery_beat', '0016_alter_crontabschedule_timezone', '2025-04-01 00:07:47.126623'),
(52, 'django_celery_beat', '0017_alter_crontabschedule_month_of_year', '2025-04-01 00:07:47.156728'),
(53, 'django_celery_beat', '0018_improve_crontab_helptext', '2025-04-01 00:07:47.176007'),
(54, 'django_celery_beat', '0019_alter_periodictasks_options', '2025-04-01 00:07:47.188114'),
(55, 'home', '0001_initial', '2025-04-01 00:07:47.439234'),
(56, 'notifications', '0001_initial', '2025-04-01 00:07:47.462568'),
(57, 'notifications', '0002_initial', '2025-04-01 00:07:47.808315'),
(58, 'payments', '0002_initial', '2025-04-01 00:07:50.485536'),
(59, 'payments', '0003_alter_payment_payment_date', '2025-04-01 00:07:50.557857'),
(60, 'payments', '0004_alter_payment_payment_date', '2025-04-01 00:07:50.629131'),
(61, 'payments', '0005_alter_payment_payment_date', '2025-04-01 00:07:50.693048'),
(62, 'payments', '0006_alter_payment_payment_date', '2025-04-01 00:07:50.773456'),
(63, 'payments', '0007_alter_payment_payment_date', '2025-04-01 00:07:50.839775'),
(64, 'reviews', '0001_initial', '2025-04-01 00:07:50.898198'),
(65, 'reviews', '0002_initial', '2025-04-01 00:07:52.510348'),
(66, 'rooms', '0002_initial', '2025-04-01 00:07:58.086348'),
(67, 'services', '0002_initial', '2025-04-01 00:08:01.073250'),
(68, 'sessions', '0001_initial', '2025-04-01 00:08:01.156179'),
(69, 'token_blacklist', '0001_initial', '2025-04-01 00:08:01.637029'),
(70, 'token_blacklist', '0002_outstandingtoken_jti_hex', '2025-04-01 00:08:01.791544'),
(71, 'token_blacklist', '0003_auto_20171017_2007', '2025-04-01 00:08:01.977327'),
(72, 'token_blacklist', '0004_auto_20171017_2013', '2025-04-01 00:08:02.291635'),
(73, 'token_blacklist', '0005_remove_outstandingtoken_jti', '2025-04-01 00:08:02.471446'),
(74, 'token_blacklist', '0006_auto_20171017_2113', '2025-04-01 00:08:02.598652'),
(75, 'token_blacklist', '0007_auto_20171017_2214', '2025-04-01 00:08:03.592691'),
(76, 'token_blacklist', '0008_migrate_to_bigautofield', '2025-04-01 00:08:04.150082'),
(77, 'token_blacklist', '0010_fix_migrate_to_bigautofield', '2025-04-01 00:08:04.295226'),
(78, 'token_blacklist', '0011_linearizes_history', '2025-04-01 00:08:04.307429'),
(79, 'token_blacklist', '0012_alter_outstandingtoken_user', '2025-04-01 00:08:04.429308'),
(80, 'notifications', '0003_notifications_created_at_notifications_created_by_and_more', '2025-04-01 00:18:50.671046'),
(81, 'rooms', '0003_delete_review', '2025-04-01 00:18:50.703948'),
(82, 'bookings', '0004_bookinghistory', '2025-04-01 22:31:39.209526'),
(83, 'payments', '0008_paymenthistory', '2025-04-01 23:37:11.738040'),
(84, 'payments', '0009_remove_paymenthistory_new_status_and_more', '2025-04-01 23:51:03.963333'),
(85, 'services', '0003_coupon_description', '2025-04-02 00:03:01.943859'),
(86, 'services', '0004_alter_coupon_description', '2025-04-02 00:06:15.693092'),
(87, 'notifications', '0004_notifications_recipient_type_and_more', '2025-04-03 17:44:07.963114'),
(88, 'home', '0002_termsconditions_privacypolicy', '2025-04-03 18:06:27.445755'),
(89, 'home', '0003_paymenpolicy', '2025-04-03 20:17:38.995453'),
(90, 'services', '0005_alter_coupon_description', '2025-04-07 20:24:20.035224'),
(91, 'notifications', '0005_notifications_title', '2025-04-09 09:16:23.410067'),
(92, 'accounts', '0001_initial', '2025-04-09 11:33:35.922237'),
(93, 'authtoken', '0001_initial', '2025-04-11 11:07:00.742230'),
(94, 'authtoken', '0002_auto_20160226_1747', '2025-04-11 11:07:01.115131'),
(95, 'authtoken', '0003_tokenproxy', '2025-04-11 11:07:01.137317'),
(96, 'authtoken', '0004_alter_tokenproxy_options', '2025-04-11 11:07:01.161416'),
(97, 'sites', '0001_initial', '2025-04-11 11:07:01.216041'),
(98, 'sites', '0002_alter_domain_unique', '2025-04-11 11:07:01.298298'),
(99, 'default', '0001_initial', '2025-04-11 11:07:01.971729'),
(100, 'social_auth', '0001_initial', '2025-04-11 11:07:01.983673'),
(101, 'default', '0002_add_related_name', '2025-04-11 11:07:02.152691'),
(102, 'social_auth', '0002_add_related_name', '2025-04-11 11:07:02.165946'),
(103, 'default', '0003_alter_email_max_length', '2025-04-11 11:07:02.197261'),
(104, 'social_auth', '0003_alter_email_max_length', '2025-04-11 11:07:02.208838'),
(105, 'default', '0004_auto_20160423_0400', '2025-04-11 11:07:02.338848'),
(106, 'social_auth', '0004_auto_20160423_0400', '2025-04-11 11:07:02.344743'),
(107, 'social_auth', '0005_auto_20160727_2333', '2025-04-11 11:07:02.370068'),
(108, 'social_django', '0006_partial', '2025-04-11 11:07:02.407870'),
(109, 'social_django', '0007_code_timestamp', '2025-04-11 11:07:02.451184'),
(110, 'social_django', '0008_partial_timestamp', '2025-04-11 11:07:02.491302'),
(111, 'social_django', '0009_auto_20191118_0520', '2025-04-11 11:07:02.665777'),
(112, 'social_django', '0010_uid_db_index', '2025-04-11 11:07:02.782702'),
(113, 'social_django', '0011_alter_id_fields', '2025-04-11 11:07:03.303320'),
(114, 'social_django', '0012_usersocialauth_extra_data_new', '2025-04-11 11:07:03.414750'),
(115, 'social_django', '0013_migrate_extra_data', '2025-04-11 11:07:03.664046'),
(116, 'social_django', '0014_remove_usersocialauth_extra_data', '2025-04-11 11:07:03.880040'),
(117, 'social_django', '0015_rename_extra_data_new_usersocialauth_extra_data', '2025-04-11 11:07:04.346780'),
(118, 'social_django', '0016_alter_usersocialauth_extra_data', '2025-04-11 11:07:04.425381'),
(119, 'social_django', '0003_alter_email_max_length', '2025-04-11 11:07:04.438929'),
(120, 'social_django', '0002_add_related_name', '2025-04-11 11:07:04.446880'),
(121, 'social_django', '0004_auto_20160423_0400', '2025-04-11 11:07:04.454728'),
(122, 'social_django', '0001_initial', '2025-04-11 11:07:04.461080'),
(123, 'social_django', '0005_auto_20160727_2333', '2025-04-11 11:07:04.465061'),
(124, 'oauth2_provider', '0001_initial', '2025-04-11 11:11:47.759803'),
(125, 'oauth2_provider', '0002_auto_20190406_1805', '2025-04-11 11:11:48.054406'),
(126, 'oauth2_provider', '0003_auto_20201211_1314', '2025-04-11 11:11:48.332423'),
(127, 'oauth2_provider', '0004_auto_20200902_2022', '2025-04-11 11:11:49.574251'),
(128, 'oauth2_provider', '0005_auto_20211222_2352', '2025-04-11 11:11:50.042241'),
(129, 'oauth2_provider', '0006_alter_application_client_secret', '2025-04-11 11:11:50.354662'),
(130, 'oauth2_provider', '0007_application_post_logout_redirect_uris', '2025-04-11 11:11:50.485986'),
(131, 'oauth2_provider', '0008_alter_accesstoken_token', '2025-04-11 11:11:50.602633'),
(132, 'oauth2_provider', '0009_add_hash_client_secret', '2025-04-11 11:11:50.845928'),
(133, 'oauth2_provider', '0010_application_allowed_origins', '2025-04-11 11:11:50.947445'),
(134, 'oauth2_provider', '0011_refreshtoken_token_family', '2025-04-11 11:11:51.096203'),
(135, 'oauth2_provider', '0012_add_token_checksum', '2025-04-11 11:11:58.098357'),
(136, 'accounts', '0002_remove_journalentry_journal_entry_created_at_and_more', '2025-04-11 12:25:43.844075'),
(137, 'payments', '0010_alter_hotelpaymentmethod_account_name_and_more', '2025-04-12 21:40:20.677213'),
(138, 'payments', '0011_alter_hotelpaymentmethod_account_name_and_more', '2025-04-12 21:43:52.276933'),
(139, 'bookings', '0005_guest_created_at_guest_created_by_guest_deleted_at_and_more', '2025-04-13 21:17:51.861039'),
(140, 'users', '0002_customuser_chart_alter_customuser_user_type', '2025-04-14 09:52:53.644766'),
(141, 'users', '0003_customuser_otp_code_customuser_otp_created_at', '2025-04-14 10:11:35.442213');

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
('0yl931fcaoku6bj97llo093n65ytagii', '.eJxVjEEOwiAQAP_C2RAWqEs9evcNBHZBqgaS0p6MfzckPeh1ZjJv4cO-Fb_3tPqFxUWAOP2yGOiZ6hD8CPXeJLW6rUuUI5GH7fLWOL2uR_s3KKGXsVWsM2iasj2jw2zQGYcEhiNoO-eETMgzQtZogZXKbAEnUkYzRdLi8wXI_Tdw:1u0pEu:p0tPXMJ-0aU94H6G8gQssRGU0PA-O6PBufjO-g6P0X8', '2025-04-18 22:10:16.094012'),
('2fi5eeu4ipz2yla6vdqafugd8qfe2zzd', '.eJxVjEEOwiAQRe_C2hBaoKRduvcMZJgZLGrAlDapMd7dNulCt_-9_97CwzKPfqk8-URiEFacfrcAeOe8A7pBvhaJJc9TCnJX5EGrvBTix_lw_wIj1HF7x87aVmtNCnvXIZDqrAtKO2CFHAhjBCRyxmhqGxtpU3Vka6Kj3thmj1auNZXseX2m6SUG9fkCrIc_zg:1u3isS:-N3eGd25LioxNTDcHW2AOcR1-a54-IMK2CQY2EQ9W2k', '2025-04-26 21:59:04.548651'),
('36a5zqbpvthu744luvy0c5wf05bpw2sq', '.eJxVjMsKwjAQRf8lawlp86Iu3fsNYTIzsVFJpGlBEf_dFrrQ7T3nnrcIsMxjWBpPIZM4CisOv1sEvHHZAF2hXKrEWuYpR7kpcqdNnivx_bS7f4ER2ri-k7O211qTwsE7BFLO-qi0B1bIkTAlQCJvjKa-s4lWVSe2JnkajO22aOPWci2Bn488vcSx69XglPp8AS32QQA:1tzlxv:E8740pbH4c2SDPh1MrvLtFcga4CrMuTtVTzTSg6Kszg', '2025-04-16 00:28:23.262162'),
('4qwidslc5rv5bwnnn9vojw17lac024x2', '.eJxVjEsOwiAUAO_C2hB-9bVduvcMBN4Dixow0CYa490NSRe6nZnMm1m3rYvdWqg2EZuZZIdf5h3eQu6Cri5fCseS15o87wnfbePnQuF-2tu_weLa0reCVJQKh2iOMELUMOoRUGryUpkpBiAEmkBGBUaSEJGMhAGFVoQeVZ-20Foq2YbnI9UXm8XnC2gTPq0:1u1Qis:2IExrJIyDL02aZFFhIG1ebU90iA7VXyoH31wv3f9jvs', '2025-04-20 14:11:42.423432'),
('97vtz13dazlvyaxrciygorp88umw38fx', '.eJxVjEEOwiAQAP_C2RAWqEs9evcNBHZBqgaS0p6MfzckPeh1ZjJv4cO-Fb_3tPqFxUWAOP2yGOiZ6hD8CPXeJLW6rUuUI5GH7fLWOL2uR_s3KKGXsVWsM2iasj2jw2zQGYcEhiNoO-eETMgzQtZogZXKbAEnUkYzRdLi8wXI_Tdw:1u4c8x:vsSM0XDbPnXbEpcZGkSqQykWXwnU_tPcTUkeV7o9GN4', '2025-04-29 08:59:47.795984'),
('9gbgf7ayr4f7hqr52htplmecg9e65d5x', '.eJxVjEEOwiAQRe_C2hBaoKRduvcMZJgZLGrAlDapMd7dNulCt_-9_97CwzKPfqk8-URiEFacfrcAeOe8A7pBvhaJJc9TCnJX5EGrvBTix_lw_wIj1HF7x87aVmtNCnvXIZDqrAtKO2CFHAhjBCRyxmhqGxtpU3Vka6Kj3thmj1auNZXseX2m6SUG9fkCrIc_zg:1u2SSk:DTRMdhRPYKDJ5lRlRKTuiuLteuMx-Cd8rdyB1r6LpGE', '2025-04-23 10:15:18.561767'),
('9gp052mwzhajr8onfp6tsv354is0lli4', '.eJxVjEEOwiAQAP_C2RAWqEs9evcNBHZBqgaS0p6MfzckPeh1ZjJv4cO-Fb_3tPqFxUWAOP2yGOiZ6hD8CPXeJLW6rUuUI5GH7fLWOL2uR_s3KKGXsVWsM2iasj2jw2zQGYcEhiNoO-eETMgzQtZogZXKbAEnUkYzRdLi8wXI_Tdw:1u44hB:41QOxSiCEpEOsIu5Pr_I59IPbrv4UCnZAKslv4DIVC0', '2025-04-27 21:16:53.259829'),
('ijjs6o02bw4j18j0vaamteyz1u6evyxe', '.eJxVjEsOwiAUAO_C2hB-9bVduvcMBN4Dixow0CYa490NSRe6nZnMm1m3rYvdWqg2EZuZZIdf5h3eQu6Cri5fCseS15o87wnfbePnQuF-2tu_weLa0reCVJQKh2iOMELUMOoRUGryUpkpBiAEmkBGBUaSEJGMhAGFVoQeVZ-20Foq2YbnI9UXm8XnC2gTPq0:1u4Mg9:ll10r26ZqeitzSHykqy66SbiO9YhoRRN-LLuFeYQX1o', '2025-04-28 16:29:01.713175'),
('jv45xb43mzicwywb7r05tyzrv4jtvn0n', '.eJxVjEEOwiAQAP_C2RAWqEs9evcNBHZBqgaS0p6MfzckPeh1ZjJv4cO-Fb_3tPqFxUWAOP2yGOiZ6hD8CPXeJLW6rUuUI5GH7fLWOL2uR_s3KKGXsVWsM2iasj2jw2zQGYcEhiNoO-eETMgzQtZogZXKbAEnUkYzRdLi8wXI_Tdw:1tzPPv:xQX2Ir4KW2I8JiVl-DDx4EGxDyqojrQQ_60_rDAm7eo', '2025-04-15 00:23:47.372092'),
('m788aphwuw44cfx943r9xipcmv6w8nk6', '.eJxVjEEOwiAQAP_C2RAWqEs9evcNBHZBqgaS0p6MfzckPeh1ZjJv4cO-Fb_3tPqFxUWAOP2yGOiZ6hD8CPXeJLW6rUuUI5GH7fLWOL2uR_s3KKGXsVWsM2iasj2jw2zQGYcEhiNoO-eETMgzQtZogZXKbAEnUkYzRdLi8wXI_Tdw:1u3iMT:tnM0yzWYG1AqtvTiGnGKTJ3_5yN_HVRlSoF_1adb_bk', '2025-04-26 21:26:01.087376'),
('mgrmv5gfbspwnr9mt07o8wit9i8col80', '.eJxVjEEOwiAQAP_C2RAWqEs9evcNBHZBqgaS0p6MfzckPeh1ZjJv4cO-Fb_3tPqFxUWAOP2yGOiZ6hD8CPXeJLW6rUuUI5GH7fLWOL2uR_s3KKGXsVWsM2iasj2jw2zQGYcEhiNoO-eETMgzQtZogZXKbAEnUkYzRdLi8wXI_Tdw:1u0STl:6_0JM_-2J4eq3DJZpuP3LL9VOyCbIoCjx-T4xwEO8VQ', '2025-04-17 21:52:05.094323'),
('pv11uhp3xweuaxxzlq1o8wcjadrs35h9', '.eJxVjEEOwiAQAP_C2RAWqEs9evcNBHZBqgaS0p6MfzckPeh1ZjJv4cO-Fb_3tPqFxUWAOP2yGOiZ6hD8CPXeJLW6rUuUI5GH7fLWOL2uR_s3KKGXsVWsM2iasj2jw2zQGYcEhiNoO-eETMgzQtZogZXKbAEnUkYzRdLi8wXI_Tdw:1u4PJu:KFK451I2i6qE7XGcnePrVFdlomAA_W_AZpmUP5FOuAU', '2025-04-28 19:18:14.781481'),
('rmynaz3o2mktwqryu7zuuh89ontkl1v5', '.eJxVjEEOwiAQRe_C2hBaoKRduvcMZJgZLGrAlDapMd7dNulCt_-9_97CwzKPfqk8-URiEFacfrcAeOe8A7pBvhaJJc9TCnJX5EGrvBTix_lw_wIj1HF7x87aVmtNCnvXIZDqrAtKO2CFHAhjBCRyxmhqGxtpU3Vka6Kj3thmj1auNZXseX2m6SUG9fkCrIc_zg:1u44ef:hHgqAl37h7iVDJ0NDYqprJgNnn4I7I5LE0TviXqHkX4', '2025-04-27 21:14:17.200467'),
('vh5jd1dq55mqytjnhcmwd43mlo75wrfi', '.eJxVjEEOwiAQRe_C2hBaoKRduvcMZJgZLGrAlDapMd7dNulCt_-9_97CwzKPfqk8-URiEFacfrcAeOe8A7pBvhaJJc9TCnJX5EGrvBTix_lw_wIj1HF7x87aVmtNCnvXIZDqrAtKO2CFHAhjBCRyxmhqGxtpU3Vka6Kj3thmj1auNZXseX2m6SUG9fkCrIc_zg:1u0Ofx:wf5WQCnxzxcv203VOMrkmi-9aX5j9zVWv9dWX_ViC5k', '2025-04-17 17:48:25.276072'),
('w64itva0ea4mhf9b42xyqdiiifrgpo05', '.eJxVjEEOwiAQRe_C2hBaoKRduvcMZJgZLGrAlDapMd7dNulCt_-9_97CwzKPfqk8-URiEFacfrcAeOe8A7pBvhaJJc9TCnJX5EGrvBTix_lw_wIj1HF7x87aVmtNCnvXIZDqrAtKO2CFHAhjBCRyxmhqGxtpU3Vka6Kj3thmj1auNZXseX2m6SUG9fkCrIc_zg:1u1Ldm:sdSGsrBa8G7PrrjxJakSGFK4THg-yQ6j3OQdFmqwMrk', '2025-04-20 08:46:06.802097'),
('wtvilv2rep1vicsotb4as8ywisw6iwb6', '.eJxVjEEOwiAQAP_C2RAWqEs9evcNBHZBqgaS0p6MfzckPeh1ZjJv4cO-Fb_3tPqFxUWAOP2yGOiZ6hD8CPXeJLW6rUuUI5GH7fLWOL2uR_s3KKGXsVWsM2iasj2jw2zQGYcEhiNoO-eETMgzQtZogZXKbAEnUkYzRdLi8wXI_Tdw:1u0ou8:gImGXUz9OMti1QvvoSMavgZJa4itx4rtIymywuzpikM', '2025-04-18 21:48:48.642060'),
('yginkza1urshcwvas0ishc08cta7f1g0', '.eJxVjEEOwiAQAP_C2RAWqEs9evcNBHZBqgaS0p6MfzckPeh1ZjJv4cO-Fb_3tPqFxUWAOP2yGOiZ6hD8CPXeJLW6rUuUI5GH7fLWOL2uR_s3KKGXsVWsM2iasj2jw2zQGYcEhiNoO-eETMgzQtZogZXKbAEnUkYzRdLi8wXI_Tdw:1u2S6q:y80qUqZwUVdWHnjB5uVazMo5mBPS2z6lfv_R8W_LYno', '2025-04-23 09:52:40.489327');

-- --------------------------------------------------------

--
-- Table structure for table `django_site`
--

CREATE TABLE `django_site` (
  `id` int(11) NOT NULL,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_site`
--

INSERT INTO `django_site` (`id`, `domain`, `name`) VALUES
(1, 'example.com', 'example.com');

-- --------------------------------------------------------

--
-- Table structure for table `home_contactmessage`
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

--
-- Dumping data for table `home_heroslider`
--

INSERT INTO `home_heroslider` (`id`, `image1`, `image2`, `image3`, `title`, `description`, `is_active`) VALUES
(1, 'slider_images/infor.jpg', 'slider_images/infor_nWWVJDc.jpg', 'slider_images/infor_1XFJlK5.jpg', 'gggs', 'aslkjdlksajdlk', 1);

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
-- Table structure for table `home_paymenpolicy`
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
-- Table structure for table `home_pricingplan`
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
-- Table structure for table `home_privacypolicy`
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
-- Table structure for table `home_termsconditions`
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
-- Dumping data for table `hotelmanagement_city`
--

INSERT INTO `hotelmanagement_city` (`id`, `created_at`, `updated_at`, `deleted_at`, `state`, `slug`, `country`, `created_by_id`, `updated_by_id`) VALUES
(1, '2025-03-20 20:56:26.264276', '2025-03-20 20:56:26.264276', NULL, 'sanaa', 'sanaa', 'sanaa', NULL, NULL),
(2, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, 'عدن', 'aden', 'Yemen', 1, 1),
(3, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, 'حضرموت', 'hadramaut', 'Yemen', 1, 1),
(4, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, 'أرخبيل سقطرى', 'socotra', 'Yemen', 1, 1),
(5, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, 'تعز', 'taiz', 'Yemen', 1, 1),
(6, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, 'إب', 'ibb', 'Yemen', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `hotelmanagement_hotel`
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
-- Dumping data for table `hotelmanagement_hotel`
--

INSERT INTO `hotelmanagement_hotel` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `slug`, `profile_picture`, `description`, `business_license_number`, `document_path`, `is_verified`, `verification_date`, `created_by_id`, `location_id`, `manager_id`, `updated_by_id`) VALUES
(1, '2025-03-01 19:06:29.271764', '2025-03-22 19:20:42.029802', NULL, 'احمد', 'ahmed-vip', 'hotels/images/image_picker_input.dart.png', 'aggggggggggggggggggg', '1515453432132', 'hotel_documents/2025/03/01/image_picker_input.dart.png', 1, '2025-03-01 19:06:26.000000', 1, 1, 2, 1),
(2, '2025-03-01 19:06:29.271764', '2025-03-07 22:21:49.143958', NULL, 'sami', 'saaa55-vip', 'hotels/images/image_picker_input.dart.png', 'kkkkkk', '1515453432132', 'hotel_documents/2025/03/01/image_picker_input.dart.png', 1, '2025-03-01 19:06:26.000000', 1, 1, 14, 1),
(3, '2025-04-15 01:56:01.000000', '2025-04-15 09:45:07.387266', NULL, 'فندق قصر سبأ صنعاء', 'sheba-palace-sanaa', 'hotels/images/discount-hotel-img.jpg', 'فندق فاخر في قلب صنعاء يتميز بالعمارة اليمنية التقليدية الأصيلة. يقدم خدمات متكاملة وراحة للنزلاء.', 'BUS-SN-101', 'docs/licenses/sheba_sanaa.pdf', 1, '2025-04-15 01:56:01.000000', 1, 1, 8, 1),
(4, '2025-04-15 01:56:01.000000', '2025-04-15 09:45:23.691919', NULL, 'فندق أمواج عدن', 'aden-waves', 'hotels/images/airline-img10.png', 'فندق حديث يطل على بحر العرب في عدن. يوفر إطلالات خلابة وغرف مريحة.', 'BUS-AD-205', 'docs/licenses/aden_waves.pdf', 1, '2025-04-15 01:56:01.000000', 1, 2, 19, 1),
(5, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, 'منتجع لؤلؤة المكلا', 'mukalla-pearl', 'images/hotels/mukalla_pearl.jpg', 'منتجع شاطئي يقع على ساحل حضرموت. مثالي للاسترخاء والاستمتاع بالطبيعة.', NULL, NULL, 0, NULL, 1, 3, NULL, 1),
(6, '2025-04-15 01:56:01.000000', '2025-04-15 09:45:36.065320', NULL, 'نزل سقطرى البيئي', 'socotra-eco-lodge', 'hotels/images/img15.jpg', 'تجربة إقامة مستدامة وسط التنوع البيولوجي الفريد لسقطرى. مناسب لمحبي الطبيعة والمغامرة.', 'BUS-SO-001', 'docs/licenses/socotra_eco.pdf', 1, '2025-04-15 01:56:01.000000', 1, 4, 20, 1),
(7, '2025-04-15 01:56:01.000000', '2025-04-15 09:45:49.124712', NULL, 'فندق برج السلام تعز', 'salam-tower-taiz', 'hotels/images/airline-img5.png', 'فندق عصري في مدينة تعز يوفر إقامة مريحة وخدمات مميزة لرجال الأعمال والسياح.', 'BUS-TZ-310', 'docs/licenses/salam_taiz.pdf', 1, '2025-04-15 01:56:01.000000', 1, 5, 21, 1),
(8, '2025-04-15 01:56:01.000000', '2025-04-15 09:46:09.525694', NULL, 'فندق إب جراند', 'ibb-grand-hotel', 'images/hotels/ibb_grand.jpg', 'يقع في مدينة إب الخضراء، يوفر الفندق جواً هادئاً ومريحاً للزوار.', 'BUS-IB-402', 'docs/licenses/ibb_grand.pdf', 0, NULL, 1, 6, 22, 1);

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
  `additional_images` longtext NOT NULL CHECK (json_valid(`additional_images`)),
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
-- Dumping data for table `hotelmanagement_image`
--

INSERT INTO `hotelmanagement_image` (`id`, `created_at`, `updated_at`, `deleted_at`, `image_path`, `image_url`, `created_by_id`, `hotel_id`, `updated_by_id`) VALUES
(1, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, 'images/hotels/sheba_sanaa_lobby.jpg', NULL, 2, 1, 2),
(2, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, 'images/hotels/sheba_sanaa_room1.jpg', NULL, 2, 1, 2),
(3, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, 'images/hotels/aden_waves_view.jpg', NULL, 3, 2, 3),
(4, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, 'images/hotels/aden_waves_pool.jpg', NULL, 3, 2, 3),
(5, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, 'images/hotels/socotra_eco_exterior.jpg', NULL, 6, 4, 6),
(6, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, 'images/hotels/socotra_eco_interior.jpg', NULL, 6, 4, 6);

-- --------------------------------------------------------

--
-- Table structure for table `hotelmanagement_location`
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
-- Dumping data for table `hotelmanagement_location`
--

INSERT INTO `hotelmanagement_location` (`id`, `created_at`, `updated_at`, `deleted_at`, `address`, `city_id`, `created_by_id`, `updated_by_id`) VALUES
(1, '2025-03-01 19:00:56.470001', '2025-03-01 19:00:56.470001', NULL, 'shomaila', 1, 1, 1),
(2, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, 'شارع حدة، بالقرب من فندق شهران', 1, 1, 1),
(3, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, 'مديرية كريتر، الشارع الرئيسي', 2, 1, 1),
(4, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, 'كورنيش المكلا، مقابل البحر', 3, 1, 1),
(5, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, 'حديبو، الطريق العام', 4, 1, 1),
(6, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, 'شارع جمال عبدالناصر', 5, 1, 1),
(7, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, 'وسط المدينة، بالقرب من الدائري', 6, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `hotelmanagement_phone`
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
  `user_id` bigint(20) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL,
  `recipient_type` varchar(50) NOT NULL,
  `title` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notifications_notifications`
--

INSERT INTO `notifications_notifications` (`id`, `message`, `send_time`, `status`, `notification_type`, `is_active`, `action_url`, `sender_id`, `user_id`, `created_at`, `created_by_id`, `deleted_at`, `updated_at`, `updated_by_id`, `recipient_type`, `title`) VALUES
(118, 'سينتهي حجزك في الغرفة room vip 2025 (احمد) في تمام الساعة 2025-04-09 16:19:50+00:00. هل تريد التمديد؟', '2025-04-09 11:19:50.017815', '0', '0', 1, '/', 2, 9, '2025-04-09 11:19:50.017815', NULL, NULL, '2025-04-09 11:19:50.017815', NULL, 'single_user', 'تذكير بانتهاء الحجز'),
(119, 'يرجى إضافة الضيوف لحجزك.', '2025-04-09 11:19:50.059276', '0', '1', 1, '/payments/add_guest/1/', 9, 9, '2025-04-09 11:19:50.059276', NULL, NULL, '2025-04-09 11:19:50.059276', NULL, 'single_user', 'اشعار اتمام الحجز'),
(120, 'سينتهي حجزك في الغرفة room vip 2025 (احمد) في تمام الساعة 2025-04-09 16:23:10+00:00. هل تريد التمديد؟', '2025-04-09 11:23:10.020955', '1', '0', 1, '/', 2, 5, '2025-04-09 11:23:10.020955', NULL, NULL, '2025-04-09 11:23:10.020955', NULL, 'single_user', 'تذكير بانتهاء الحجز'),
(121, 'يرجى إضافة الضيوف لحجزك.', '2025-04-09 11:23:10.287891', '1', '1', 1, '/payments/add_guest/1/', 5, 5, '2025-04-09 11:23:10.287891', NULL, NULL, '2025-04-09 11:23:10.287891', NULL, 'single_user', 'اشعار اتمام الحجز'),
(122, 'يرجى إضافة الضيوف لحجزك.', '2025-04-09 11:26:51.275733', '1', '1', 1, '/payments/add_guest/1/', 5, 5, '2025-04-09 11:26:51.275085', NULL, NULL, '2025-04-09 11:26:51.275733', NULL, 'single_user', 'اشعار اتمام الحجز'),
(123, 'يرجى إضافة الضيوف لحجزك.', '2025-04-13 21:28:32.335042', '0', '1', 1, '/payments/add_guest/1/', 5, 5, '2025-04-13 21:28:32.335042', NULL, NULL, '2025-04-13 21:28:32.335042', NULL, 'single_user', 'اشعار اتمام الحجز'),
(124, 'يرجى إضافة الضيوف لحجزك.', '2025-04-15 11:16:52.466789', '0', '1', 1, '/payments/add_guest/1/', 5, 5, '2025-04-15 11:16:52.466789', NULL, NULL, '2025-04-15 11:16:52.466789', NULL, 'single_user', 'اشعار اتمام الحجز'),
(125, 'يرجى إضافة الضيوف لحجزك.', '2025-04-15 11:39:30.099669', '0', '1', 1, '/payments/add_guest/1/', 5, 5, '2025-04-15 11:39:30.099669', NULL, NULL, '2025-04-15 11:39:30.099669', NULL, 'single_user', 'اشعار اتمام الحجز'),
(126, 'يرجى إضافة الضيوف لحجزك.', '2025-04-15 11:42:23.176493', '0', '1', 1, '/payments/add_guest/1/', 24, 24, '2025-04-15 11:42:23.176493', NULL, NULL, '2025-04-15 11:42:23.176493', NULL, 'single_user', 'اشعار اتمام الحجز'),
(127, 'يرجى إضافة الضيوف لحجزك.', '2025-04-15 11:46:33.727327', '0', '1', 1, '/payments/add_guest/1/', 24, 24, '2025-04-15 11:46:33.727327', NULL, NULL, '2025-04-15 11:46:33.727327', NULL, 'single_user', 'اشعار اتمام الحجز');

-- --------------------------------------------------------

--
-- Table structure for table `oauth2_provider_accesstoken`
--

CREATE TABLE `oauth2_provider_accesstoken` (
  `id` bigint(20) NOT NULL,
  `token` longtext NOT NULL,
  `expires` datetime(6) NOT NULL,
  `scope` longtext NOT NULL,
  `application_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `source_refresh_token_id` bigint(20) DEFAULT NULL,
  `id_token_id` bigint(20) DEFAULT NULL,
  `token_checksum` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth2_provider_application`
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
-- Table structure for table `oauth2_provider_grant`
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
-- Table structure for table `oauth2_provider_idtoken`
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
-- Table structure for table `oauth2_provider_refreshtoken`
--

CREATE TABLE `oauth2_provider_refreshtoken` (
  `id` bigint(20) NOT NULL,
  `token` varchar(255) NOT NULL,
  `access_token_id` bigint(20) DEFAULT NULL,
  `application_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `revoked` datetime(6) DEFAULT NULL,
  `token_family` char(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payments_currency`
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

--
-- Dumping data for table `payments_currency`
--

INSERT INTO `payments_currency` (`id`, `created_at`, `updated_at`, `deleted_at`, `currency_name`, `currency_symbol`, `created_by_id`, `hotel_id`, `updated_by_id`) VALUES
(1, '2025-03-01 19:14:12.848277', '2025-03-01 19:14:12.848277', NULL, 'dollar', '$', 1, 1, 1),
(2, '2025-03-10 14:41:32.412347', '2025-03-10 14:41:32.412347', NULL, 'SAR', 'sa', 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `payments_hotelpaymentmethod`
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

--
-- Dumping data for table `payments_hotelpaymentmethod`
--

INSERT INTO `payments_hotelpaymentmethod` (`id`, `created_at`, `updated_at`, `deleted_at`, `account_name`, `account_number`, `iban`, `description`, `is_active`, `created_by_id`, `hotel_id`, `payment_option_id`, `updated_by_id`) VALUES
(1, NULL, '2025-04-12 21:44:40.831877', NULL, 'ahmed mohamed ahmed', '111111111', '01111111', 'asdsa\r\nasdas\r\nasdsac\r\nczczx', 1, NULL, 1, 1, 1),
(2, NULL, '2025-04-12 21:26:44.541421', NULL, 'sami saleh', '0006565884', '00556516', 'asdasdsa', 0, NULL, 1, 2, 1),
(3, '0000-00-00 00:00:00.000000', '0000-00-00 00:00:00.000000', NULL, 'ahmed alKuraimi', '53153135', '0031561615', 'dasd\r\n444asd\r\nsadas5das6d5', 0, NULL, 1, 3, NULL),
(4, '2025-04-12 21:44:33.442216', '2025-04-12 21:44:33.442216', NULL, NULL, NULL, NULL, 'pay when you came', 1, 1, 1, 4, 1);

-- --------------------------------------------------------

--
-- Table structure for table `payments_payment`
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

--
-- Dumping data for table `payments_payment`
--

INSERT INTO `payments_payment` (`id`, `created_at`, `updated_at`, `deleted_at`, `transfer_image`, `payment_status`, `payment_date`, `payment_subtotal`, `payment_totalamount`, `payment_currency`, `payment_type`, `payment_note`, `payment_discount`, `payment_discount_code`, `booking_id`, `created_by_id`, `payment_method_id`, `updated_by_id`, `user_id`) VALUES
(1, '2025-04-01 23:42:01.973721', '2025-04-11 18:19:28.046667', NULL, 'payments/transfer/transfer_image/infor.jpg', 0, '2025-04-01 23:41:17.000000', 140.00, 150.00, 'dolar', 'e_pay', 'ajkshdkhas', 10.00, 'aa', 1, 1, 1, 1, 12),
(2, '2025-04-01 23:45:09.001660', '2025-04-01 23:47:37.149928', NULL, 'payments/transfer/transfer_image/infor_zxe8Yu0.jpg', 1, '2025-04-01 23:44:41.000000', 111.00, 12.00, '$', 'e_pay', 'asjdasjhj', 10.00, '11ass', 1, 1, 2, 1, 12),
(3, '2025-04-06 10:18:14.932174', '2025-04-06 10:18:14.932174', NULL, 'payments/transfer/transfer_image/app-store.png', 0, '2025-04-06 10:18:14.928098', 510.00, 500.00, '$', 'e_pay', 'تم التحويل بواسطة: kajshdjkask - رقم التحويل: 151651616', 10.00, 'sms', 2, NULL, 1, NULL, 1),
(4, '2025-04-11 18:56:33.452439', '2025-04-11 18:57:34.058359', NULL, 'payments/transfer/transfer_image/bg.jpg', 2, '2025-04-11 18:56:33.439916', 2550.00, 2550.00, '$', 'e_pay', 'تم التحويل بواسطة: sjsdhkfhsk - رقم التحويل: 65151561651', 0.00, '', 14, NULL, 1, NULL, 1),
(5, '2025-04-12 21:49:48.889019', '2025-04-12 21:49:48.889019', NULL, '', 0, '2025-04-12 21:49:48.880391', 15.00, 15.00, '$', 'e_pay', 'تم التحويل بواسطة: mosa mohamed - ', 0.00, '', 15, NULL, 4, NULL, 5),
(6, '2025-04-12 21:52:57.134413', '2025-04-15 11:17:50.373201', NULL, '', 1, '2025-04-12 21:52:57.000000', 25.00, 25.00, '$', 'cash', 'تم التحويل بواسطة: mosa mohamed -', 0.00, '0', 2, NULL, 4, NULL, 5),
(7, '2025-04-13 19:55:57.390962', '2025-04-13 19:55:57.390962', NULL, '', 0, '2025-04-13 19:55:57.390962', 100.00, 120.00, 'USD', 'cache', 'Payment for hotel booking', 10.00, NULL, 1, NULL, 1, NULL, 1),
(8, '2025-04-13 21:39:32.498833', '2025-04-15 11:46:33.708106', NULL, '', 1, '2025-04-13 21:39:32.000000', 0.00, 0.00, '$', 'cash', 'ss', 25.00, '-', 16, NULL, 1, NULL, 24);

-- --------------------------------------------------------

--
-- Table structure for table `payments_paymenthistory`
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

--
-- Dumping data for table `payments_paymenthistory`
--

INSERT INTO `payments_paymenthistory` (`id`, `created_at`, `updated_at`, `deleted_at`, `history_date`, `previous_payment_status`, `new_payment_status`, `previous_payment_totalamount`, `new_payment_totalamount`, `previous_payment_discount`, `new_payment_discount`, `previous_payment_discount_code`, `new_payment_discount_code`, `note`, `changed_by_id`, `created_by_id`, `payment_id`, `updated_by_id`) VALUES
(1, '2025-04-01 23:47:37.159981', '2025-04-01 23:47:37.159981', NULL, '2025-04-01 23:47:37.160510', 0, 1, 12.00, 12.00, 10.00, 10.00, '11ass', '11ass', 'Payment updated on 2025-04-01 23:47:37.157066+00:00', 12, NULL, 2, NULL),
(2, '2025-04-11 18:19:28.055142', '2025-04-11 18:19:28.055769', NULL, '2025-04-11 18:19:28.055769', 2, 0, 150.00, 150.00, 10.00, 10.00, 'aa', 'aa', 'Payment updated on 2025-04-11 18:19:28.054092+00:00', 12, NULL, 1, NULL),
(3, '2025-04-11 18:57:34.066264', '2025-04-11 18:57:34.067305', NULL, '2025-04-11 18:57:34.067305', 0, 2, 2550.00, 2550.00, 0.00, 0.00, '', '', 'Payment updated on 2025-04-11 18:57:34.066264+00:00', 1, NULL, 4, NULL),
(4, '2025-04-15 11:17:50.376712', '2025-04-15 11:17:50.376712', NULL, '2025-04-15 11:17:50.376712', 0, 1, 25.00, 25.00, 0.00, 0.00, '', '0', 'Payment updated on 2025-04-15 11:17:50.376712+00:00', 5, NULL, 6, NULL),
(7, '2025-04-15 11:42:07.065895', '2025-04-15 11:42:07.065895', NULL, '2025-04-15 11:42:07.065895', 0, 0, 0.00, 0.00, 25.00, 25.00, NULL, '-', 'Payment updated on 2025-04-15 11:42:07.065895+00:00', 24, NULL, 8, NULL),
(10, '2025-04-15 11:46:33.712132', '2025-04-15 11:46:33.712132', NULL, '2025-04-15 11:46:33.712132', 0, 1, 0.00, 0.00, 25.00, 25.00, '-', '-', 'Payment updated on 2025-04-15 11:46:33.712132+00:00', 24, NULL, 8, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `payments_paymentoption`
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

--
-- Dumping data for table `payments_paymentoption`
--

INSERT INTO `payments_paymentoption` (`id`, `created_at`, `updated_at`, `deleted_at`, `method_name`, `logo`, `is_active`, `created_by_id`, `currency_id`, `updated_by_id`) VALUES
(1, '0000-00-00 00:00:00.000000', '0000-00-00 00:00:00.000000', NULL, 'al najim', 'payment_logos/najim.jpg', 1, NULL, 1, NULL),
(2, '0000-00-00 00:00:00.000000', '0000-00-00 00:00:00.000000', NULL, 'al akwa', 'payment_logos/akwa.jpg', 1, NULL, 1, NULL),
(3, '0000-00-00 00:00:00.000000', '0000-00-00 00:00:00.000000', NULL, 'kuraimi', 'payment_logos/alkuraimi.png', 1, NULL, 1, NULL),
(4, '2025-04-12 21:38:32.190353', '2025-04-12 21:38:32.190353', NULL, 'كاش', 'payment_logos/Cashondelivery.jpg', 1, 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `reviews_hotelreview`
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

--
-- Dumping data for table `reviews_hotelreview`
--

INSERT INTO `reviews_hotelreview` (`id`, `created_at`, `updated_at`, `deleted_at`, `rating_service`, `rating_location`, `rating_value_for_money`, `rating_cleanliness`, `review`, `status`, `created_by_id`, `hotel_id`, `updated_by_id`, `user_id`) VALUES
(1, '2025-04-03 17:25:16.802853', '2025-04-03 17:25:16.802853', NULL, 5, 5, 5, 5, 'ahmed', 1, 1, 1, 1, 12);

-- --------------------------------------------------------

--
-- Table structure for table `reviews_roomreview`
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

--
-- Dumping data for table `reviews_roomreview`
--

INSERT INTO `reviews_roomreview` (`id`, `created_at`, `updated_at`, `deleted_at`, `rating`, `review`, `status`, `created_by_id`, `hotel_id`, `room_type_id`, `updated_by_id`, `user_id`) VALUES
(1, '2025-04-03 20:32:08.487554', '2025-04-03 20:32:08.487554', NULL, 3, 'sajkdhask', 1, NULL, 1, 1, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `rooms_availability`
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
  `room_status_id` bigint(20) NOT NULL,
  `room_type_id` bigint(20) NOT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rooms_availability`
--

INSERT INTO `rooms_availability` (`id`, `created_at`, `updated_at`, `deleted_at`, `availability_date`, `available_rooms`, `notes`, `created_by_id`, `hotel_id`, `room_status_id`, `room_type_id`, `updated_by_id`) VALUES
(23, '2025-04-15 11:38:57.939328', '2025-04-15 11:38:57.954950', NULL, '2025-04-15', 13, 'Updated due to booking #16', NULL, 1, 3, 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `rooms_category`
--

CREATE TABLE `rooms_category` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
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
(1, '2025-03-01 19:18:19.935767', '2025-03-01 19:18:46.244395', NULL, 'vip', 'شسيسشيش', NULL, 1, NULL),
(2, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, 'قياسي', 'غرف مريحة بمواصفات أساسية', 2, 1, 2),
(3, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, 'جناح', 'أجنحة واسعة مع منطقة جلوس منفصلة', 2, 1, 2),
(4, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, 'غرفة ديلوكس', 'غرف بمساحة أكبر وتجهيزات إضافية', 3, 2, 3),
(5, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, 'غرفة مطلة على البحر', 'غرف تتمتع بإطلالة مباشرة على البحر', 3, 2, 3),
(6, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, 'كوخ بيئي', 'أكواخ بسيطة وصديقة للبيئة', 6, 4, 6),
(7, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, 'قياسي', 'غرف مريحة بمواصفات أساسية', 3, 2, 3),
(8, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, 'قياسي', 'غرف مريحة بمواصفات أساسية', 6, 4, 6);

-- --------------------------------------------------------

--
-- Table structure for table `rooms_roomimage`
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

--
-- Dumping data for table `rooms_roomimage`
--

INSERT INTO `rooms_roomimage` (`id`, `created_at`, `updated_at`, `deleted_at`, `image`, `is_main`, `caption`, `created_by_id`, `hotel_id`, `room_type_id`, `updated_by_id`) VALUES
(1, '2025-03-01 19:22:07.144698', '2025-03-01 19:22:07.144698', NULL, 'room_images/wasell.jpg', 1, 'sssssssss', 2, 1, 1, 2),
(2, '2025-03-01 19:22:24.536866', '2025-03-01 19:22:24.536866', NULL, 'room_images/search.jpg', 0, 'saa', 2, 1, 1, 2),
(3, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, 'images/rooms/sheba_std_double_1.jpg', 1, 'غرفة قياسية مزدوجة في فندق قصر سبأ', 2, 1, 2, 2),
(4, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, 'images/rooms/sheba_std_double_2.jpg', 0, 'حمام الغرفة القياسية المزدوجة', 2, 1, 2, 2),
(5, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, 'images/rooms/aden_seaview_1.jpg', 1, 'إطلالة من غرفة مطلة على البحر في فندق أمواج عدن', 3, 2, 5, 3),
(6, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, 'images/rooms/aden_seaview_2.jpg', 0, 'سرير مزدوج في غرفة مطلة على البحر', 3, 2, 5, 3),
(7, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, 'images/rooms/socotra_eco_hut_1.jpg', 1, 'كوخ بيئي مزدوج في نزل سقطرى', 6, 4, 6, 6);

-- --------------------------------------------------------

--
-- Table structure for table `rooms_roomprice`
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rooms_roomprice`
--

INSERT INTO `rooms_roomprice` (`id`, `created_at`, `updated_at`, `deleted_at`, `date_from`, `date_to`, `price`, `is_special_offer`, `created_by_id`, `hotel_id`, `room_type_id`, `updated_by_id`) VALUES
(1, '2025-04-01 23:57:21.633047', '2025-04-01 23:57:21.633047', NULL, '2025-04-01', '2025-04-11', 500.00, 0, 1, 1, 1, 1),
(2, '2025-04-04 21:50:12.631031', '2025-04-04 21:50:28.360614', NULL, '2025-04-04', '2025-04-05', 330.00, 0, 1, 2, 1, 1),
(3, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, '2025-04-15', '2025-12-31', 50000.00, 0, 2, 1, 2, 2),
(4, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, '2025-04-15', '2025-12-31', 75000.00, 0, 3, 2, 5, 3),
(5, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, '2025-07-01', '2025-08-31', 55000.00, 1, 2, 1, 2, 2),
(6, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, '2025-04-15', '2025-12-31', 40000.00, 0, 6, 4, 6, 6);

-- --------------------------------------------------------

--
-- Table structure for table `rooms_roomstatus`
--

CREATE TABLE `rooms_roomstatus` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
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
(3, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, 'AV', 'متاحة', 'الغرفة جاهزة للحجز', 1, 2, 1, 2),
(4, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, 'OC', 'مشغولة', 'الغرفة مسكونة حالياً', 0, 2, 1, 2),
(5, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, 'CL', 'تحت التنظيف', 'الغرفة قيد التنظيف', 0, 2, 1, 2),
(6, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, 'OO', 'خارج الخدمة', 'الغرفة غير متاحة للصيانة', 0, 2, 1, 2),
(7, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, 'AV', 'متاحة', 'الغرفة جاهزة للحجز', 1, 3, 2, 3),
(8, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, 'OC', 'مشغولة', 'الغرفة مسكونة حالياً', 0, 3, 2, 3),
(9, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, 'CL', 'تحت التنظيف', 'الغرفة قيد التنظيف', 0, 3, 2, 3),
(10, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, 'AV', 'متاحة', 'الغرفة جاهزة للحجز', 1, 6, 4, 6),
(11, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, 'OC', 'مشغولة', 'الغرفة مسكونة حالياً', 0, 6, 4, 6);

-- --------------------------------------------------------

--
-- Table structure for table `rooms_roomtype`
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rooms_roomtype`
--

INSERT INTO `rooms_roomtype` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `description`, `default_capacity`, `max_capacity`, `beds_count`, `rooms_count`, `base_price`, `is_active`, `category_id`, `created_by_id`, `hotel_id`, `updated_by_id`) VALUES
(1, '2025-03-01 19:21:28.984379', '2025-03-25 18:41:12.396279', NULL, 'room vip 2025', 'asdaskdjhsa', 4, 4, 6, 15, 15.00, 1, 1, 2, 1, 1),
(2, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, 'غرفة قياسية مفردة', 'غرفة مريحة لشخص واحد', 1, 1, 1, 10, 35000.00, 1, 1, 2, 1, 2),
(3, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, 'غرفة قياسية مزدوجة', 'غرفة مريحة لشخصين بسرير مزدوج أو سريرين منفصلين', 2, 3, 2, 15, 50000.00, 1, 1, 2, 1, 2),
(4, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, 'جناح جونيور', 'جناح أنيق مع منطقة جلوس صغيرة', 2, 3, 1, 5, 80000.00, 1, 2, 2, 1, 2),
(5, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, 'غرفة ديلوكس مزدوجة', 'غرفة واسعة مع تجهيزات محسنة لشخصين', 2, 3, 1, 8, 60000.00, 1, 3, 3, 2, 3),
(6, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, 'غرفة مزدوجة مطلة على البحر', 'غرفة لشخصين بإطلالة بحرية رائعة', 2, 2, 1, 12, 75000.00, 1, 4, 3, 2, 3),
(7, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, 'كوخ بيئي مزدوج', 'كوخ بسيط ومستدام لشخصين', 2, 2, 2, 6, 40000.00, 1, 5, 6, 4, 6),
(8, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, 'غرفة قياسية مزدوجة', 'غرفة أساسية ومريحة لشخصين', 2, 3, 2, 10, 45000.00, 1, 6, 3, 2, 3);

-- --------------------------------------------------------

--
-- Table structure for table `services_coupon`
--

CREATE TABLE `services_coupon` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `quantity` int(11) NOT NULL,
  `min_purchase_amount` int(11) NOT NULL,
  `expired_date` date NOT NULL,
  `discount_type` varchar(10) NOT NULL,
  `discount` double NOT NULL,
  `status` tinyint(1) NOT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `hotel_id` bigint(20) NOT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL,
  `description` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `services_coupon`
--

INSERT INTO `services_coupon` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `code`, `quantity`, `min_purchase_amount`, `expired_date`, `discount_type`, `discount`, `status`, `created_by_id`, `hotel_id`, `updated_by_id`, `description`) VALUES
(1, '2025-04-02 00:00:51.028703', '2025-04-02 00:01:29.126328', NULL, 'ahmed', 'a1', 9, 100, '2025-04-15', 'amount', 150, 1, 1, 1, 1, 'sadas'),
(2, '2025-04-02 00:12:05.651295', '2025-04-02 00:12:05.651295', NULL, 'new ---', 'sms', 10, 30, '2025-04-10', 'amount', 10, 1, 1, 1, 1, '<p><big>عرض جديد بمناسبه العيد بكود خصم <strong><span style=\"color:#e74c3c\">sms&nbsp; </span></strong><img alt=\"heart\" src=\"http://127.0.0.1:8000/static/ckeditor/ckeditor/plugins/smiley/images/heart.png\" style=\"height:23px; width:23px\" title=\"heart\" /><img alt=\"yes\" src=\"http://127.0.0.1:8000/static/ckeditor/ckeditor/plugins/smiley/images/thumbs_up.png\" style=\"height:23px; width:23px\" title=\"yes\" />تنتهي نهايه العام 2025</big></p>');

-- --------------------------------------------------------

--
-- Table structure for table `services_hotelservice`
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

--
-- Dumping data for table `services_hotelservice`
--

INSERT INTO `services_hotelservice` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `description`, `icon`, `is_active`, `created_by_id`, `hotel_id`, `updated_by_id`) VALUES
(1, '2025-04-06 10:00:18.817702', '2025-04-06 10:00:18.817702', NULL, 'wifi', 'goood', 'service/hotel/icon/infor.jpg', 1, 1, 1, 1),
(2, '2025-04-06 10:00:44.573600', '2025-04-06 10:00:44.573600', NULL, 'pool', 'pooling', 'service/hotel/icon/avatar.jpeg', 1, 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `services_roomtypeservice`
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

--
-- Dumping data for table `services_roomtypeservice`
--

INSERT INTO `services_roomtypeservice` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `description`, `is_active`, `icon`, `additional_fee`, `created_by_id`, `hotel_id`, `room_type_id`, `updated_by_id`) VALUES
(1, '2025-04-06 10:01:55.789614', '2025-04-06 10:01:55.789614', NULL, 'free message', 'free message', 1, 'service/roomtype/icon/client-logo4.png', 10, 1, 1, 1, 1),
(2, '2025-04-06 10:02:22.060206', '2025-04-06 10:02:22.060206', NULL, 'good view', 'good view', 1, 'service/roomtype/icon/seat1.png', 0, 1, 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `service_offers`
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
-- Table structure for table `social_auth_association`
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
-- Table structure for table `social_auth_code`
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
-- Table structure for table `social_auth_nonce`
--

CREATE TABLE `social_auth_nonce` (
  `id` bigint(20) NOT NULL,
  `server_url` varchar(255) NOT NULL,
  `timestamp` int(11) NOT NULL,
  `salt` varchar(65) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `social_auth_partial`
--

CREATE TABLE `social_auth_partial` (
  `id` bigint(20) NOT NULL,
  `token` varchar(32) NOT NULL,
  `next_step` smallint(5) UNSIGNED NOT NULL CHECK (`next_step` >= 0),
  `backend` varchar(32) NOT NULL,
  `timestamp` datetime(6) NOT NULL,
  `data` longtext NOT NULL CHECK (json_valid(`data`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `social_auth_usersocialauth`
--

CREATE TABLE `social_auth_usersocialauth` (
  `id` bigint(20) NOT NULL,
  `provider` varchar(32) NOT NULL,
  `uid` varchar(255) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `extra_data` longtext NOT NULL CHECK (json_valid(`extra_data`))
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

--
-- Dumping data for table `token_blacklist_outstandingtoken`
--

INSERT INTO `token_blacklist_outstandingtoken` (`id`, `token`, `created_at`, `expires_at`, `user_id`, `jti`) VALUES
(1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc0NDQ2NTczMSwiaWF0IjoxNzQzODYwOTMxLCJqdGkiOiIxY2Y0NGNiZmE3MzQ0ZGM1ODc0YjcxZmUxODczNzgxMyIsInVzZXJfaWQiOjF9.2xW-D2AulXtYC9LAW2OEAU0S5qmHnVMuacQl-mYrLN8', '2025-04-05 13:48:51.985296', '2025-04-12 13:48:51.000000', 1, '1cf44cbfa7344dc5874b71fe18737813'),
(2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc0NDY2MjM4NywiaWF0IjoxNzQ0MDU3NTg3LCJqdGkiOiJhMWJmMDBhZmEwMTk0NDc2OWJkOTIzOWI1NGEzZjE3NCIsInVzZXJfaWQiOjF9.HAx5vW6jcvn4TjM_t47K05MUiUCzT6XtKOnz8Ei84dY', '2025-04-07 20:26:27.401240', '2025-04-14 20:26:27.000000', 1, 'a1bf00afa01944769bd9239b54a3f174'),
(3, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc0NTE3ODg1MywiaWF0IjoxNzQ0NTc0MDUzLCJqdGkiOiI4M2M1YjM0OWJkYzE0YTYzOGM4OWIxZGQ4N2ZiNmYwZSIsInVzZXJfaWQiOjF9.rvQuuVnWCjvZBSayUzMPQFdKgCwpX5YFKvqW15knL0s', '2025-04-13 19:54:13.205594', '2025-04-20 19:54:13.000000', 1, '83c5b349bdc14a638c89b1dd87fb6f0e'),
(4, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc0NTIzNjMxMywiaWF0IjoxNzQ0NjMxNTEzLCJqdGkiOiIyMzljNmY2NDI5NmY0MmEwYmIyYTg2OTU5M2YyODU0NyIsInVzZXJfaWQiOjF9.ciwMZrPtWZEXcyYwE1vqX1ggp_5E7rB25CGYw-K_wv4', '2025-04-14 11:51:53.854538', '2025-04-21 11:51:53.000000', 1, '239c6f64296f42a0bb2a869593f28547');

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
  `details` longtext DEFAULT NULL CHECK (json_valid(`details`)),
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
  `chield_id` bigint(20) DEFAULT NULL,
  `chart_id` bigint(20) DEFAULT NULL,
  `otp_code` varchar(6) DEFAULT NULL,
  `otp_created_at` datetime(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users_customuser`
--

INSERT INTO `users_customuser` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `date_joined`, `created_at`, `updated_at`, `user_type`, `phone`, `image`, `gender`, `birth_date`, `is_active`, `chield_id`, `chart_id`, `otp_code`, `otp_created_at`) VALUES
(1, 'pbkdf2_sha256$600000$WiLeYKRGdIKtWxdmTAtOmU$KTRRkjHfaMrfsm0s9x9BjNoJSbF/vkwNCqNRJNelKoI=', '2025-04-15 08:59:47.790875', 1, 'a', '', '', 'a@a.com', 1, '2025-03-20 20:53:38.214703', '2025-03-20 20:53:39.041969', '2025-03-20 20:53:39.041969', '', '', '', NULL, NULL, 1, NULL, NULL, NULL, NULL),
(2, 'pbkdf2_sha256$600000$mRv4uTHEeVZ15lsGse5C0D$hF0CKJC3qr2/+yCUM252q7NnSKiBR3C+X1CTuLAv7WI=', '2025-03-22 19:47:22.367954', 0, 'b', '', '', 'b@b.com', 1, '2025-03-21 12:48:09.506849', '2025-03-21 12:48:10.018701', '2025-03-22 19:21:25.333335', 'hotel_manager', '', '', NULL, NULL, 1, NULL, NULL, NULL, NULL),
(3, 'pbkdf2_sha256$600000$HDDXD5Lhdd8rcHhLG8UYVl$Q8FJflDelq1YQWUDvzR/2zhtU7X8maa5nF3lcjo0XlA=', '2025-03-01 22:40:14.016174', 0, 'motasem', '', '', 'motasem@motasem.com', 0, '2025-03-01 22:21:39.232835', '2025-03-01 22:21:41.258606', '2025-03-01 22:21:41.258606', 'user', '', '', NULL, NULL, 1, NULL, NULL, NULL, NULL),
(4, 'pbkdf2_sha256$600000$69WafNQFxgQDN0ybf7EQYW$qearY4fO/keI64yiOKwtTlw4JsxM0IK+xRJFrCut2lo=', '2025-03-04 19:13:37.238210', 0, 'kakaka', '', '', 'kakaka@kakaka.kakaka', 0, '2025-03-04 19:06:56.842290', '2025-03-04 19:06:58.774589', '2025-03-04 19:06:58.774589', 'user', '', '', NULL, NULL, 1, NULL, NULL, NULL, NULL),
(5, 'pbkdf2_sha256$600000$wp2FpScP9Phmy67xyNNudv$l8vyvhwQ4ldfSqQMUJueUTXRfzu479WTOV8Nx7qEoNQ=', '2025-04-13 21:14:17.194714', 0, 'mosaa', 'mosa', 'mohamed', '773081924k@gmail.com', 0, '2025-03-05 20:10:14.486479', '2025-03-05 20:10:16.220927', '2025-04-09 09:27:06.163091', 'customer', '', 'users/2025/03/12/img27.jpg', NULL, NULL, 1, NULL, NULL, NULL, NULL),
(6, 'pbkdf2_sha256$600000$BbNnejHpZOfDP6VnObjVcz$nhsPttz7Xm4OTIK/zOWG0MrrT6q9PAv0jTWQyIffer0=', '2025-03-05 20:13:43.403102', 0, 'mosaa1', '', '', 'mosaa1@mosaa1.com', 0, '2025-03-05 20:13:41.381311', '2025-03-05 20:13:43.386627', '2025-03-05 20:13:43.386627', 'customer', '', '', NULL, NULL, 1, NULL, NULL, NULL, NULL),
(7, 'pbkdf2_sha256$600000$vUeJuKMqNFAu6egbZVxQ85$uQPUm3C2c/AmXPOaKjFVNqCkRpV44XZB+IcyyRoeX9I=', '2025-03-06 08:09:12.614518', 0, 'asdjsk', '', '', 'asdjsk@asdjsk.com', 0, '2025-03-06 08:09:10.785662', '2025-03-06 08:09:12.595928', '2025-03-06 08:09:12.595928', 'customer', '', '', NULL, NULL, 1, NULL, NULL, NULL, NULL),
(8, 'pbkdf2_sha256$600000$EWBPrY4FupGVI4TQNhXc0c$34BYeYmfyKXBq+wd4pmTAYBvOg94iuzQIzR0t+6EmlM=', '2025-03-08 23:09:07.660012', 0, 'alslslsl', '', '', 'alslslsl@alslslsl.com', 0, '2025-03-08 23:09:05.884851', '2025-03-08 23:09:07.648169', '2025-03-22 19:39:25.883858', 'hotel_manager', '', '', NULL, NULL, 1, NULL, NULL, NULL, NULL),
(9, 'pbkdf2_sha256$600000$YyHz1TprqrLxB9Zn86sIJu$VtH3gk7SGQu97sevo51XO3ovW0MjMaVmvTMX/jtAI54=', '2025-03-11 13:39:22.061710', 0, 'ahmed1555', 'ahmed', 'mohamed', 'ahmed1555@gmail.com', 0, '2025-03-11 13:05:30.020217', '2025-03-11 13:05:30.536114', '2025-03-11 13:05:30.536114', 'customer', '781717609', 'users/2025/03/11/topdoctors.jpg', NULL, NULL, 1, NULL, NULL, NULL, NULL),
(10, 'pbkdf2_sha256$600000$JInLxld88le5EonOREI0JQ$FvAY9r/CHudvTsSBOxEfZob1jwsvvzgpRAWPsDM6szE=', '2025-03-11 13:24:43.650477', 0, 'sakjds888', 'askja', 'kksskks', 'sakjds888@cc.com', 0, '2025-03-11 13:24:32.822351', '2025-03-11 13:24:33.340511', '2025-03-11 13:24:33.340511', 'customer', '123123132132', 'users/2025/03/11/topdoctors_qb7Dipr.jpg', NULL, NULL, 1, NULL, NULL, NULL, NULL),
(11, 'pbkdf2_sha256$600000$RQcyfOrNwaARSe90TzIKBU$90MYq5xmhjWGc+keDWcELY1dkohhCW05pO8C2RgP+xA=', '2025-03-11 14:11:34.650871', 0, 'asjldhask15', 'ajshdkajs', 'aksljdlas', 'asjldhask15@asd.co', 0, '2025-03-11 14:11:32.868092', '2025-03-11 14:11:34.630556', '2025-03-11 14:11:34.630556', 'customer', '21215151515', 'users/2025/03/11/topdoctors_5NSVJtE.jpg', 'Female', '2025-03-09', 1, NULL, NULL, NULL, NULL),
(12, 'pbkdf2_sha256$600000$cyoobnnbnn1veqfofkr18v$Q3A3UVNX8rMFNQOeuwLDAxNV9v68C9+85WPeG58gGsQ=', '2025-03-11 15:03:22.973314', 0, 'ammaralwan', 'ammar', 'alwan', 'ammaralwan@ss.com', 0, '2025-03-11 15:03:07.343237', '2025-03-11 15:03:09.211771', '2025-03-11 15:03:09.211771', 'customer', '781717177', 'users/2025/03/11/terms.jpg', 'Female', '1996-04-18', 1, NULL, NULL, NULL, NULL),
(13, 'pbkdf2_sha256$600000$FqqK1ybDPJVmeLbEpH5xM5$XxlG67Ut3xXs/TN8aC0TcX2qZMHyLlyXteu8KboTH60=', '2025-03-11 15:07:08.449784', 0, 'asdjhasj', 'asjdhjkash', 'asdas', 'sajh@asd.cc', 0, '2025-03-11 15:07:06.624072', '2025-03-11 15:07:08.427732', '2025-03-11 15:07:08.427732', 'customer', '88186541312', 'users/2025/03/11/terms_iJzbCqG.jpg', 'Female', '2003-03-13', 1, NULL, NULL, NULL, NULL),
(14, 'pbkdf2_sha256$600000$YnIbgLo63DhZI2tNuYeVVW$uG9BZ9YIOFennwzEZmG/A8lTZvE7Ptg0deSs7OWZ8Fw=', '2025-04-01 00:25:41.994904', 0, 'c', '', '', '', 1, '2025-03-22 19:41:27.289430', '2025-03-22 19:41:28.023706', '2025-04-01 00:25:20.895010', 'hotel_manager', '', '', NULL, NULL, 1, NULL, NULL, NULL, NULL),
(19, 'pbkdf2_sha256$600000$5btSIZ0meGoH7mIdZnZ2pq$pU2k/iJgQJupEIDPLMwvsD2VYGNs0C0I6xaarKIDRUw=', NULL, 0, 'ahmed55', 'ahmed', 'mohamed', 'ahmed55@gmail.com', 0, '2025-04-14 08:59:30.196083', '2025-04-14 08:59:30.695011', '2025-04-14 08:59:30.695011', 'hotel_manager', '781717609', 'users/2025/04/14/balcony-cabin.jpg', 'Male', '2002-04-16', 1, NULL, NULL, NULL, NULL),
(20, 'pbkdf2_sha256$600000$5rzSsIknevW8wjtyR2OSK4$wia+D6BMbFGN0tobMrPbr9Yl7eQv9Qu0lrf+o+McRt0=', NULL, 0, 'asdj99', 'kashd', 'kahsdk', 'aksjh@ad.com', 0, '2025-04-14 09:18:17.227642', '2025-04-14 09:18:17.732487', '2025-04-14 09:18:17.732487', 'hotel_manager', '944546546546', 'users/2025/04/14/balcony-cabin_8Leghw0.jpg', 'Male', '2000-11-11', 1, NULL, NULL, NULL, NULL),
(21, 'pbkdf2_sha256$600000$w6YKTc69n9HZ2zgYTs3zWd$8OSkKjnCDWKJ0vSE95QIo2GkLr59wYufN/SScIh77ik=', '2025-04-14 09:22:48.126297', 0, 'aslkdjaskldj', 'jskdhakhs', 'klasjdlaj', 'aslkdjaskldj@asdkhask.com', 0, '2025-04-14 09:22:47.610283', '2025-04-14 09:22:48.126297', '2025-04-14 09:22:48.126297', 'hotel_manager', '54545615165155', 'users/2025/04/14/airline-img7.png', 'Male', '2000-04-17', 1, NULL, NULL, NULL, NULL),
(22, 'pbkdf2_sha256$600000$WowJQYcWmNPQRq75m9DBwD$sFpU5VAB1yykG0t+eYrClT1NP0FyKbed5QjN/eLpLuw=', NULL, 0, 'aksjhd888', 'askldhal', '51sa65d1', 'aksjhd888@gmail.com', 0, '2025-04-14 09:24:54.398287', '2025-04-14 09:24:54.906295', '2025-04-14 09:24:54.906295', 'hotel_manager', '156161616516', 'users/2025/04/14/alamo.png', 'Male', '2000-11-11', 1, NULL, NULL, NULL, NULL),
(23, 'pbkdf2_sha256$600000$lh8yo0GMTQ6nPaGh4diOpi$05NWcRu04df9nfhdFEp8QYCPan1HIx54H9ojRG7bqGg=', '2025-04-14 09:36:49.911434', 0, 'sldasjk7888', 'ahsdajk', '5as5d5as', 'sldasjk7888@gmail.com', 0, '2025-04-14 09:36:49.383620', '2025-04-14 09:36:49.901501', '2025-04-14 09:36:49.901501', 'hotel_manager', '94861564564564', 'users/2025/04/14/balcony-cabin_55yeNlS.jpg', 'Male', '2000-11-11', 1, NULL, NULL, NULL, NULL),
(24, 'pbkdf2_sha256$600000$9QN4xmuJkVLcJFk99RYcpL$rOJkveBdmC4qHWGvR8TFoVMyLmh0nhdyy4myMntSRvU=', '2025-04-14 11:20:16.025710', 0, 'aklsdj888888888', 'akshdkj', 'askdj8888', 'kwownon@gmail.com', 0, '2025-04-14 09:56:33.354379', '2025-04-14 09:56:33.885576', '2025-04-14 10:20:42.993987', 'customer', '11111111113', 'users/2025/04/14/airline-img3.png', 'Male', '2000-02-11', 1, NULL, 53, NULL, NULL);

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
(1, 14, 1);

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
  ADD KEY `bookings_guest_hotel_id_333c72e5_fk_HotelManagement_hotel_id` (`hotel_id`),
  ADD KEY `bookings_guest_created_by_id_0cc0af08_fk_users_customuser_id` (`created_by_id`),
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
-- Indexes for table `django_site`
--
ALTER TABLE `django_site`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_site_domain_a2e37b91_uniq` (`domain`);

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
  ADD KEY `notifications_notifi_created_by_id_17bcaf8b_fk_users_cus` (`created_by_id`),
  ADD KEY `notifications_notifi_updated_by_id_cb05afb1_fk_users_cus` (`updated_by_id`),
  ADD KEY `notifications_notifi_user_id_429b0a5e_fk_users_cus` (`user_id`);

--
-- Indexes for table `oauth2_provider_accesstoken`
--
ALTER TABLE `oauth2_provider_accesstoken`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `oauth2_provider_accesstoken_token_checksum_85319a26_uniq` (`token_checksum`),
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
  ADD KEY `users_customuser_chield_id_8f3dc45a_fk_users_customuser_id` (`chield_id`),
  ADD KEY `users_customuser_chart_id_e799e924_fk_accounts_` (`chart_id`);

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `accounts_journalentry`
--
ALTER TABLE `accounts_journalentry`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=195;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=553;

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `bookings_bookingdetail`
--
ALTER TABLE `bookings_bookingdetail`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `bookings_bookinghistory`
--
ALTER TABLE `bookings_bookinghistory`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `bookings_extensionmovement`
--
ALTER TABLE `bookings_extensionmovement`
  MODIFY `movement_number` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `bookings_guest`
--
ALTER TABLE `bookings_guest`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `customer_favourites`
--
ALTER TABLE `customer_favourites`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=207;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=80;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=142;

--
-- AUTO_INCREMENT for table `django_site`
--
ALTER TABLE `django_site`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `home_contactmessage`
--
ALTER TABLE `home_contactmessage`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `home_heroslider`
--
ALTER TABLE `home_heroslider`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `hotelmanagement_hotel`
--
ALTER TABLE `hotelmanagement_hotel`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `hotelmanagement_hotelrequest`
--
ALTER TABLE `hotelmanagement_hotelrequest`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hotelmanagement_image`
--
ALTER TABLE `hotelmanagement_image`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `hotelmanagement_location`
--
ALTER TABLE `hotelmanagement_location`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `hotelmanagement_phone`
--
ALTER TABLE `hotelmanagement_phone`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notifications_notifications`
--
ALTER TABLE `notifications_notifications`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=128;

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `payments_hotelpaymentmethod`
--
ALTER TABLE `payments_hotelpaymentmethod`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `payments_payment`
--
ALTER TABLE `payments_payment`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `payments_paymenthistory`
--
ALTER TABLE `payments_paymenthistory`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `payments_paymentoption`
--
ALTER TABLE `payments_paymentoption`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `reviews_hotelreview`
--
ALTER TABLE `reviews_hotelreview`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `reviews_roomreview`
--
ALTER TABLE `reviews_roomreview`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `rooms_availability`
--
ALTER TABLE `rooms_availability`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `rooms_category`
--
ALTER TABLE `rooms_category`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `rooms_roomimage`
--
ALTER TABLE `rooms_roomimage`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `rooms_roomprice`
--
ALTER TABLE `rooms_roomprice`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `rooms_roomstatus`
--
ALTER TABLE `rooms_roomstatus`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `rooms_roomtype`
--
ALTER TABLE `rooms_roomtype`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `services_coupon`
--
ALTER TABLE `services_coupon`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `services_hotelservice`
--
ALTER TABLE `services_hotelservice`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `services_roomtypeservice`
--
ALTER TABLE `services_roomtypeservice`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `token_blacklist_blacklistedtoken`
--
ALTER TABLE `token_blacklist_blacklistedtoken`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `token_blacklist_outstandingtoken`
--
ALTER TABLE `token_blacklist_outstandingtoken`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users_activitylog`
--
ALTER TABLE `users_activitylog`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users_customuser`
--
ALTER TABLE `users_customuser`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `users_customuser_groups`
--
ALTER TABLE `users_customuser_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users_customuser_user_permissions`
--
ALTER TABLE `users_customuser_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `accounts_chartofaccounts`
--
ALTER TABLE `accounts_chartofaccounts`
  ADD CONSTRAINT `accounts_chartofacco_account_parent_id_aab27f60_fk_accounts_` FOREIGN KEY (`account_parent_id`) REFERENCES `accounts_chartofaccounts` (`id`),
  ADD CONSTRAINT `accounts_chartofacco_created_by_id_f216d28f_fk_users_cus` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `accounts_chartofacco_updated_by_id_aa33c263_fk_users_cus` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- Constraints for table `accounts_journalentry`
--
ALTER TABLE `accounts_journalentry`
  ADD CONSTRAINT `accounts_journalentr_created_by_id_c9c8bf66_fk_users_cus` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `accounts_journalentr_journal_entry_accoun_31c22020_fk_accounts_` FOREIGN KEY (`journal_entry_account_id`) REFERENCES `accounts_chartofaccounts` (`id`),
  ADD CONSTRAINT `accounts_journalentr_updated_by_id_83723a94_fk_users_cus` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- Constraints for table `authtoken_token`
--
ALTER TABLE `authtoken_token`
  ADD CONSTRAINT `authtoken_token_user_id_35299eff_fk_users_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_customuser` (`id`);

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
-- Constraints for table `blog_category`
--
ALTER TABLE `blog_category`
  ADD CONSTRAINT `blog_category_created_by_id_5babffa5_fk_users_customuser_id` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `blog_category_updated_by_id_623e0d89_fk_users_customuser_id` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- Constraints for table `blog_comment`
--
ALTER TABLE `blog_comment`
  ADD CONSTRAINT `blog_comment_author_id_4f11e2e0_fk_users_customuser_id` FOREIGN KEY (`author_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `blog_comment_created_by_id_bb8e38a4_fk_users_customuser_id` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `blog_comment_post_id_580e96ef_fk_blog_post_id` FOREIGN KEY (`post_id`) REFERENCES `blog_post` (`id`),
  ADD CONSTRAINT `blog_comment_updated_by_id_383aa587_fk_users_customuser_id` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- Constraints for table `blog_post`
--
ALTER TABLE `blog_post`
  ADD CONSTRAINT `blog_post_author_id_dd7a8485_fk_users_customuser_id` FOREIGN KEY (`author_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `blog_post_category_id_c326dbf8_fk_blog_category_id` FOREIGN KEY (`category_id`) REFERENCES `blog_category` (`id`),
  ADD CONSTRAINT `blog_post_created_by_id_eebead11_fk_users_customuser_id` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `blog_post_updated_by_id_022b627c_fk_users_customuser_id` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- Constraints for table `blog_post_tags`
--
ALTER TABLE `blog_post_tags`
  ADD CONSTRAINT `blog_post_tags_post_id_a1c71c8a_fk_blog_post_id` FOREIGN KEY (`post_id`) REFERENCES `blog_post` (`id`),
  ADD CONSTRAINT `blog_post_tags_tag_id_0875c551_fk_blog_tag_id` FOREIGN KEY (`tag_id`) REFERENCES `blog_tag` (`id`);

--
-- Constraints for table `blog_tag`
--
ALTER TABLE `blog_tag`
  ADD CONSTRAINT `blog_tag_created_by_id_7bba8b04_fk_users_customuser_id` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `blog_tag_updated_by_id_1fbc3911_fk_users_customuser_id` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

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
-- Constraints for table `bookings_bookinghistory`
--
ALTER TABLE `bookings_bookinghistory`
  ADD CONSTRAINT `bookings_bookinghist_booking_id_3d73917f_fk_bookings_` FOREIGN KEY (`booking_id`) REFERENCES `bookings_booking` (`id`),
  ADD CONSTRAINT `bookings_bookinghist_changed_by_id_7771323e_fk_users_cus` FOREIGN KEY (`changed_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `bookings_bookinghist_hotel_id_fedbba66_fk_HotelMana` FOREIGN KEY (`hotel_id`) REFERENCES `hotelmanagement_hotel` (`id`),
  ADD CONSTRAINT `bookings_bookinghist_parent_booking_id_81c27856_fk_bookings_` FOREIGN KEY (`parent_booking_id`) REFERENCES `bookings_booking` (`id`),
  ADD CONSTRAINT `bookings_bookinghistory_room_id_2b335d40_fk_rooms_roomtype_id` FOREIGN KEY (`room_id`) REFERENCES `rooms_roomtype` (`id`),
  ADD CONSTRAINT `bookings_bookinghistory_user_id_631b8526_fk_users_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_customuser` (`id`);

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
  ADD CONSTRAINT `bookings_guest_created_by_id_0cc0af08_fk_users_customuser_id` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `bookings_guest_hotel_id_333c72e5_fk_HotelManagement_hotel_id` FOREIGN KEY (`hotel_id`) REFERENCES `hotelmanagement_hotel` (`id`),
  ADD CONSTRAINT `bookings_guest_updated_by_id_7fb9973c_fk_users_customuser_id` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- Constraints for table `customer_favourites`
--
ALTER TABLE `customer_favourites`
  ADD CONSTRAINT `customer_favourites_created_by_id_577ea231_fk_users_cus` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `customer_favourites_hotel_id_8c26062f_fk_HotelMana` FOREIGN KEY (`hotel_id`) REFERENCES `hotelmanagement_hotel` (`id`),
  ADD CONSTRAINT `customer_favourites_updated_by_id_0fef4026_fk_users_cus` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`),
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
-- Constraints for table `home_paymenpolicy`
--
ALTER TABLE `home_paymenpolicy`
  ADD CONSTRAINT `home_paymenpolicy_created_by_id_4d3ce878_fk_users_customuser_id` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `home_paymenpolicy_updated_by_id_1bb28913_fk_users_customuser_id` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- Constraints for table `home_privacypolicy`
--
ALTER TABLE `home_privacypolicy`
  ADD CONSTRAINT `home_privacypolicy_created_by_id_10a1cb37_fk_users_customuser_id` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `home_privacypolicy_updated_by_id_2722d998_fk_users_customuser_id` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- Constraints for table `home_termsconditions`
--
ALTER TABLE `home_termsconditions`
  ADD CONSTRAINT `home_termsconditions_created_by_id_41b47c7f_fk_users_cus` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `home_termsconditions_updated_by_id_a2f80cee_fk_users_cus` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

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
  ADD CONSTRAINT `notifications_notifi_created_by_id_17bcaf8b_fk_users_cus` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `notifications_notifi_sender_id_c6ee4409_fk_users_cus` FOREIGN KEY (`sender_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `notifications_notifi_updated_by_id_cb05afb1_fk_users_cus` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `notifications_notifi_user_id_429b0a5e_fk_users_cus` FOREIGN KEY (`user_id`) REFERENCES `users_customuser` (`id`);

--
-- Constraints for table `oauth2_provider_accesstoken`
--
ALTER TABLE `oauth2_provider_accesstoken`
  ADD CONSTRAINT `oauth2_provider_acce_application_id_b22886e1_fk_oauth2_pr` FOREIGN KEY (`application_id`) REFERENCES `oauth2_provider_application` (`id`),
  ADD CONSTRAINT `oauth2_provider_acce_id_token_id_85db651b_fk_oauth2_pr` FOREIGN KEY (`id_token_id`) REFERENCES `oauth2_provider_idtoken` (`id`),
  ADD CONSTRAINT `oauth2_provider_acce_source_refresh_token_e66fbc72_fk_oauth2_pr` FOREIGN KEY (`source_refresh_token_id`) REFERENCES `oauth2_provider_refreshtoken` (`id`),
  ADD CONSTRAINT `oauth2_provider_acce_user_id_6e4c9a65_fk_users_cus` FOREIGN KEY (`user_id`) REFERENCES `users_customuser` (`id`);

--
-- Constraints for table `oauth2_provider_application`
--
ALTER TABLE `oauth2_provider_application`
  ADD CONSTRAINT `oauth2_provider_appl_user_id_79829054_fk_users_cus` FOREIGN KEY (`user_id`) REFERENCES `users_customuser` (`id`);

--
-- Constraints for table `oauth2_provider_grant`
--
ALTER TABLE `oauth2_provider_grant`
  ADD CONSTRAINT `oauth2_provider_gran_application_id_81923564_fk_oauth2_pr` FOREIGN KEY (`application_id`) REFERENCES `oauth2_provider_application` (`id`),
  ADD CONSTRAINT `oauth2_provider_grant_user_id_e8f62af8_fk_users_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_customuser` (`id`);

--
-- Constraints for table `oauth2_provider_idtoken`
--
ALTER TABLE `oauth2_provider_idtoken`
  ADD CONSTRAINT `oauth2_provider_idto_application_id_08c5ff4f_fk_oauth2_pr` FOREIGN KEY (`application_id`) REFERENCES `oauth2_provider_application` (`id`),
  ADD CONSTRAINT `oauth2_provider_idtoken_user_id_dd512b59_fk_users_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_customuser` (`id`);

--
-- Constraints for table `oauth2_provider_refreshtoken`
--
ALTER TABLE `oauth2_provider_refreshtoken`
  ADD CONSTRAINT `oauth2_provider_refr_access_token_id_775e84e8_fk_oauth2_pr` FOREIGN KEY (`access_token_id`) REFERENCES `oauth2_provider_accesstoken` (`id`),
  ADD CONSTRAINT `oauth2_provider_refr_application_id_2d1c311b_fk_oauth2_pr` FOREIGN KEY (`application_id`) REFERENCES `oauth2_provider_application` (`id`),
  ADD CONSTRAINT `oauth2_provider_refr_user_id_da837fce_fk_users_cus` FOREIGN KEY (`user_id`) REFERENCES `users_customuser` (`id`);

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
  ADD CONSTRAINT `payments_payment_updated_by_id_379a95eb_fk_users_customuser_id` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `payments_payment_user_id_f9db060a_fk_users_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_customuser` (`id`);

--
-- Constraints for table `payments_paymenthistory`
--
ALTER TABLE `payments_paymenthistory`
  ADD CONSTRAINT `payments_paymenthist_changed_by_id_bc229b93_fk_users_cus` FOREIGN KEY (`changed_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `payments_paymenthist_created_by_id_e1a215ba_fk_users_cus` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `payments_paymenthist_payment_id_4b5c9d14_fk_payments_` FOREIGN KEY (`payment_id`) REFERENCES `payments_payment` (`id`),
  ADD CONSTRAINT `payments_paymenthist_updated_by_id_f0bf4c7d_fk_users_cus` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

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
-- Constraints for table `services_coupon`
--
ALTER TABLE `services_coupon`
  ADD CONSTRAINT `services_coupon_created_by_id_77380f73_fk_users_customuser_id` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `services_coupon_hotel_id_27b305f4_fk_HotelManagement_hotel_id` FOREIGN KEY (`hotel_id`) REFERENCES `hotelmanagement_hotel` (`id`),
  ADD CONSTRAINT `services_coupon_updated_by_id_d8030238_fk_users_customuser_id` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- Constraints for table `services_hotelservice`
--
ALTER TABLE `services_hotelservice`
  ADD CONSTRAINT `services_hotelservic_created_by_id_58582781_fk_users_cus` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `services_hotelservic_hotel_id_c67387c9_fk_HotelMana` FOREIGN KEY (`hotel_id`) REFERENCES `hotelmanagement_hotel` (`id`),
  ADD CONSTRAINT `services_hotelservic_updated_by_id_01238d0f_fk_users_cus` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- Constraints for table `services_roomtypeservice`
--
ALTER TABLE `services_roomtypeservice`
  ADD CONSTRAINT `services_roomtypeser_created_by_id_ef053406_fk_users_cus` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `services_roomtypeser_hotel_id_163e32a7_fk_HotelMana` FOREIGN KEY (`hotel_id`) REFERENCES `hotelmanagement_hotel` (`id`),
  ADD CONSTRAINT `services_roomtypeser_room_type_id_f15253ec_fk_rooms_roo` FOREIGN KEY (`room_type_id`) REFERENCES `rooms_roomtype` (`id`),
  ADD CONSTRAINT `services_roomtypeser_updated_by_id_ce869b8f_fk_users_cus` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- Constraints for table `service_offers`
--
ALTER TABLE `service_offers`
  ADD CONSTRAINT `service_offers_created_by_id_8ca73e25_fk_users_customuser_id` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `service_offers_hotel_id_d29c1d1e_fk_HotelManagement_hotel_id` FOREIGN KEY (`hotel_id`) REFERENCES `hotelmanagement_hotel` (`id`),
  ADD CONSTRAINT `service_offers_updated_by_id_42cd54e5_fk_users_customuser_id` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- Constraints for table `social_auth_usersocialauth`
--
ALTER TABLE `social_auth_usersocialauth`
  ADD CONSTRAINT `social_auth_usersoci_user_id_17d28448_fk_users_cus` FOREIGN KEY (`user_id`) REFERENCES `users_customuser` (`id`);

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
  ADD CONSTRAINT `users_customuser_chart_id_e799e924_fk_accounts_` FOREIGN KEY (`chart_id`) REFERENCES `accounts_chartofaccounts` (`id`),
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
