-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 16, 2025 at 04:41 PM
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
(53, '2025-04-14 09:56:33.279378', '2025-04-14 09:56:33.279378', NULL, '1101443', 'عملاء دائمون - akshdkjaskdj8888', 'Asset', 0.00, 'الحسابات المدينة / العملاء', 1, NULL, 7, NULL, NULL),
(54, '2025-04-16 12:20:30.120259', '2025-04-16 12:20:30.120259', NULL, '1104319', 'عملاء دائمون - ajkhdk kajshdask', 'Asset', 0.00, 'الحسابات المدينة / العملاء', 1, NULL, 7, NULL, NULL),
(55, '2025-04-16 12:21:28.287097', '2025-04-16 12:21:28.287097', NULL, '1102770', 'عملاء دائمون - test tset', 'Asset', 0.00, 'الحسابات المدينة / العملاء', 1, NULL, 7, NULL, NULL);

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
(40, 1, 83),
(41, 1, 84),
(42, 1, 85),
(43, 1, 86),
(44, 1, 139),
(45, 1, 140),
(46, 1, 141),
(47, 1, 142),
(48, 1, 143),
(49, 1, 144),
(50, 1, 145),
(51, 1, 146),
(52, 1, 151),
(53, 1, 152),
(54, 1, 153),
(55, 1, 154),
(67, 1, 159),
(56, 1, 160),
(57, 1, 161),
(58, 1, 162),
(59, 1, 163),
(60, 1, 164),
(61, 1, 165),
(62, 1, 166),
(63, 1, 175),
(64, 1, 176),
(65, 1, 177),
(66, 1, 178),
(70, 1, 181),
(71, 1, 182),
(68, 1, 185),
(69, 1, 186),
(79, 1, 191),
(72, 1, 192),
(73, 1, 193),
(74, 1, 194),
(75, 1, 199),
(76, 1, 200),
(77, 1, 201),
(78, 1, 202),
(83, 1, 211),
(84, 1, 212),
(85, 1, 213),
(86, 1, 214),
(87, 1, 215),
(88, 1, 216),
(89, 1, 217),
(90, 1, 218),
(91, 1, 219),
(92, 1, 220),
(93, 1, 221),
(94, 1, 222),
(95, 1, 223),
(80, 1, 224),
(81, 1, 225),
(82, 1, 226);

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
(23, 'Can add chart of accounts', 34, 'add_chartofaccounts'),
(24, 'Can change chart of accounts', 34, 'change_chartofaccounts'),
(25, 'Can delete chart of accounts', 34, 'delete_chartofaccounts'),
(26, 'Can view chart of accounts', 34, 'view_chartofaccounts'),
(27, 'Can add journal entry', 35, 'add_journalentry'),
(28, 'Can change journal entry', 35, 'change_journalentry'),
(29, 'Can delete journal entry', 35, 'delete_journalentry'),
(30, 'Can view journal entry', 35, 'view_journalentry'),
(31, 'Can add مستخدم', 2, 'add_customuser'),
(32, 'Can change مستخدم', 2, 'change_customuser'),
(33, 'Can delete مستخدم', 2, 'delete_customuser'),
(34, 'Can view مستخدم', 2, 'view_customuser'),
(35, 'Can add سجل النشاط', 36, 'add_activitylog'),
(36, 'Can change سجل النشاط', 36, 'change_activitylog'),
(37, 'Can delete سجل النشاط', 36, 'delete_activitylog'),
(38, 'Can view سجل النشاط', 36, 'view_activitylog'),
(39, 'Can add منطقه', 21, 'add_city'),
(40, 'Can change منطقه', 21, 'change_city'),
(41, 'Can delete منطقه', 21, 'delete_city'),
(42, 'Can view منطقه', 21, 'view_city'),
(43, 'Can add فندق', 18, 'add_hotel'),
(44, 'Can change فندق', 18, 'change_hotel'),
(45, 'Can delete فندق', 18, 'delete_hotel'),
(46, 'Can view فندق', 18, 'view_hotel'),
(47, 'Can add طلب إضافة فندق', 30, 'add_hotelrequest'),
(48, 'Can change طلب إضافة فندق', 30, 'change_hotelrequest'),
(49, 'Can delete طلب إضافة فندق', 30, 'delete_hotelrequest'),
(50, 'Can view طلب إضافة فندق', 30, 'view_hotelrequest'),
(51, 'Can add صورة', 19, 'add_image'),
(52, 'Can change صورة', 19, 'change_image'),
(53, 'Can delete صورة', 19, 'delete_image'),
(54, 'Can view صورة', 19, 'view_image'),
(55, 'Can add الموقع', 22, 'add_location'),
(56, 'Can change الموقع', 22, 'change_location'),
(57, 'Can delete الموقع', 22, 'delete_location'),
(58, 'Can view الموقع', 22, 'view_location'),
(59, 'Can add رقم هاتف', 20, 'add_phone'),
(60, 'Can change رقم هاتف', 20, 'change_phone'),
(61, 'Can delete رقم هاتف', 20, 'delete_phone'),
(62, 'Can view رقم هاتف', 20, 'view_phone'),
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
(79, 'Can add حالة الغرفة', 10, 'add_roomstatus'),
(80, 'Can change حالة الغرفة', 10, 'change_roomstatus'),
(81, 'Can delete حالة الغرفة', 10, 'delete_roomstatus'),
(82, 'Can view حالة الغرفة', 10, 'view_roomstatus'),
(83, 'Can add نوع الغرفة', 5, 'add_roomtype'),
(84, 'Can change نوع الغرفة', 5, 'change_roomtype'),
(85, 'Can delete نوع الغرفة', 5, 'delete_roomtype'),
(86, 'Can view نوع الغرفة', 5, 'view_roomtype'),
(87, 'Can add contact message', 37, 'add_contactmessage'),
(88, 'Can change contact message', 37, 'change_contactmessage'),
(89, 'Can delete contact message', 37, 'delete_contactmessage'),
(90, 'Can view contact message', 37, 'view_contactmessage'),
(91, 'Can add hero slider', 38, 'add_heroslider'),
(92, 'Can change hero slider', 38, 'change_heroslider'),
(93, 'Can delete hero slider', 38, 'delete_heroslider'),
(94, 'Can view hero slider', 38, 'view_heroslider'),
(95, 'Can add info box', 39, 'add_infobox'),
(96, 'Can change info box', 39, 'change_infobox'),
(97, 'Can delete info box', 39, 'delete_infobox'),
(98, 'Can view info box', 39, 'view_infobox'),
(99, 'Can add partner', 40, 'add_partner'),
(100, 'Can change partner', 40, 'change_partner'),
(101, 'Can delete partner', 40, 'delete_partner'),
(102, 'Can view partner', 40, 'view_partner'),
(103, 'Can add paymen policy', 41, 'add_paymenpolicy'),
(104, 'Can change paymen policy', 41, 'change_paymenpolicy'),
(105, 'Can delete paymen policy', 41, 'delete_paymenpolicy'),
(106, 'Can view paymen policy', 41, 'view_paymenpolicy'),
(107, 'Can add pricing plan', 42, 'add_pricingplan'),
(108, 'Can change pricing plan', 42, 'change_pricingplan'),
(109, 'Can delete pricing plan', 42, 'delete_pricingplan'),
(110, 'Can view pricing plan', 42, 'view_pricingplan'),
(111, 'Can add privacy policy', 43, 'add_privacypolicy'),
(112, 'Can change privacy policy', 43, 'change_privacypolicy'),
(113, 'Can delete privacy policy', 43, 'delete_privacypolicy'),
(114, 'Can view privacy policy', 43, 'view_privacypolicy'),
(115, 'Can add room type home', 44, 'add_roomtypehome'),
(116, 'Can change room type home', 44, 'change_roomtypehome'),
(117, 'Can delete room type home', 44, 'delete_roomtypehome'),
(118, 'Can view room type home', 44, 'view_roomtypehome'),
(119, 'Can add setting', 45, 'add_setting'),
(120, 'Can change setting', 45, 'change_setting'),
(121, 'Can delete setting', 45, 'delete_setting'),
(122, 'Can view setting', 45, 'view_setting'),
(123, 'Can add social media link', 46, 'add_socialmedialink'),
(124, 'Can change social media link', 46, 'change_socialmedialink'),
(125, 'Can delete social media link', 46, 'delete_socialmedialink'),
(126, 'Can view social media link', 46, 'view_socialmedialink'),
(127, 'Can add team member', 47, 'add_teammember'),
(128, 'Can change team member', 47, 'change_teammember'),
(129, 'Can delete team member', 47, 'delete_teammember'),
(130, 'Can view team member', 47, 'view_teammember'),
(131, 'Can add terms conditions', 48, 'add_termsconditions'),
(132, 'Can change terms conditions', 48, 'change_termsconditions'),
(133, 'Can delete terms conditions', 48, 'delete_termsconditions'),
(134, 'Can view terms conditions', 48, 'view_termsconditions'),
(135, 'Can add testimonial', 49, 'add_testimonial'),
(136, 'Can change testimonial', 49, 'change_testimonial'),
(137, 'Can delete testimonial', 49, 'delete_testimonial'),
(138, 'Can view testimonial', 49, 'view_testimonial'),
(139, 'Can add حجز', 13, 'add_booking'),
(140, 'Can change حجز', 13, 'change_booking'),
(141, 'Can delete حجز', 13, 'delete_booking'),
(142, 'Can view حجز', 13, 'view_booking'),
(143, 'Can add تفصيل الحجز', 14, 'add_bookingdetail'),
(144, 'Can change تفصيل الحجز', 14, 'change_bookingdetail'),
(145, 'Can delete تفصيل الحجز', 14, 'delete_bookingdetail'),
(146, 'Can view تفصيل الحجز', 14, 'view_bookingdetail'),
(147, 'Can add سجل الحجز', 50, 'add_bookinghistory'),
(148, 'Can change سجل الحجز', 50, 'change_bookinghistory'),
(149, 'Can delete سجل الحجز', 50, 'delete_bookinghistory'),
(150, 'Can view سجل الحجز', 50, 'view_bookinghistory'),
(151, 'Can add extension movement', 15, 'add_extensionmovement'),
(152, 'Can change extension movement', 15, 'change_extensionmovement'),
(153, 'Can delete extension movement', 15, 'delete_extensionmovement'),
(154, 'Can view extension movement', 15, 'view_extensionmovement'),
(155, 'Can add ضيف', 51, 'add_guest'),
(156, 'Can change ضيف', 51, 'change_guest'),
(157, 'Can delete ضيف', 51, 'delete_guest'),
(158, 'Can view ضيف', 51, 'view_guest'),
(159, 'Can add عملة', 27, 'add_currency'),
(160, 'Can change عملة', 27, 'change_currency'),
(161, 'Can delete عملة', 27, 'delete_currency'),
(162, 'Can view عملة', 27, 'view_currency'),
(163, 'Can add طريقة دفع الفندق', 29, 'add_hotelpaymentmethod'),
(164, 'Can change طريقة دفع الفندق', 29, 'change_hotelpaymentmethod'),
(165, 'Can delete طريقة دفع الفندق', 29, 'delete_hotelpaymentmethod'),
(166, 'Can view طريقة دفع الفندق', 29, 'view_hotelpaymentmethod'),
(167, 'Can add دفعة', 52, 'add_payment'),
(168, 'Can change دفعة', 52, 'change_payment'),
(169, 'Can delete دفعة', 52, 'delete_payment'),
(170, 'Can view دفعة', 52, 'view_payment'),
(171, 'Can add سجل الدفعة', 53, 'add_paymenthistory'),
(172, 'Can change سجل الدفعة', 53, 'change_paymenthistory'),
(173, 'Can delete سجل الدفعة', 53, 'delete_paymenthistory'),
(174, 'Can view سجل الدفعة', 53, 'view_paymenthistory'),
(175, 'Can add طريقة دفع', 28, 'add_paymentoption'),
(176, 'Can change طريقة دفع', 28, 'change_paymentoption'),
(177, 'Can delete طريقة دفع', 28, 'delete_paymentoption'),
(178, 'Can view طريقة دفع', 28, 'view_paymentoption'),
(179, 'Can add مراجعة فندق', 17, 'add_hotelreview'),
(180, 'Can change مراجعة فندق', 17, 'change_hotelreview'),
(181, 'Can delete مراجعة فندق', 17, 'delete_hotelreview'),
(182, 'Can view مراجعة فندق', 17, 'view_hotelreview'),
(183, 'Can add مراجعة غرفة', 16, 'add_roomreview'),
(184, 'Can change مراجعة غرفة', 16, 'change_roomreview'),
(185, 'Can delete مراجعة غرفة', 16, 'delete_roomreview'),
(186, 'Can view مراجعة غرفة', 16, 'view_roomreview'),
(187, 'Can add coupon', 54, 'add_coupon'),
(188, 'Can change coupon', 54, 'change_coupon'),
(189, 'Can delete coupon', 54, 'delete_coupon'),
(190, 'Can view coupon', 54, 'view_coupon'),
(191, 'Can add خدمة فندقية', 12, 'add_hotelservice'),
(192, 'Can change خدمة فندقية', 12, 'change_hotelservice'),
(193, 'Can delete خدمة فندقية', 12, 'delete_hotelservice'),
(194, 'Can view خدمة فندقية', 12, 'view_hotelservice'),
(195, 'Can add عرض', 55, 'add_offer'),
(196, 'Can change عرض', 55, 'change_offer'),
(197, 'Can delete عرض', 55, 'delete_offer'),
(198, 'Can view عرض', 55, 'view_offer'),
(199, 'Can add خدمة نوع الغرفة', 11, 'add_roomtypeservice'),
(200, 'Can change خدمة نوع الغرفة', 11, 'change_roomtypeservice'),
(201, 'Can delete خدمة نوع الغرفة', 11, 'delete_roomtypeservice'),
(202, 'Can view خدمة نوع الغرفة', 11, 'view_roomtypeservice'),
(203, 'Can add blacklisted token', 56, 'add_blacklistedtoken'),
(204, 'Can change blacklisted token', 56, 'change_blacklistedtoken'),
(205, 'Can delete blacklisted token', 56, 'delete_blacklistedtoken'),
(206, 'Can view blacklisted token', 56, 'view_blacklistedtoken'),
(207, 'Can add outstanding token', 57, 'add_outstandingtoken'),
(208, 'Can change outstanding token', 57, 'change_outstandingtoken'),
(209, 'Can delete outstanding token', 57, 'delete_outstandingtoken'),
(210, 'Can view outstanding token', 57, 'view_outstandingtoken'),
(211, 'Can add تصنيف', 25, 'add_category'),
(212, 'Can change تصنيف', 25, 'change_category'),
(213, 'Can delete تصنيف', 25, 'delete_category'),
(214, 'Can view تصنيف', 25, 'view_category'),
(215, 'Can add تعليق', 24, 'add_comment'),
(216, 'Can change تعليق', 24, 'change_comment'),
(217, 'Can delete تعليق', 24, 'delete_comment'),
(218, 'Can view تعليق', 24, 'view_comment'),
(219, 'Can add مقال', 23, 'add_post'),
(220, 'Can change مقال', 23, 'change_post'),
(221, 'Can delete مقال', 23, 'delete_post'),
(222, 'Can view مقال', 23, 'view_post'),
(223, 'Can add وسم', 26, 'add_tag'),
(224, 'Can change وسم', 26, 'change_tag'),
(225, 'Can delete وسم', 26, 'delete_tag'),
(226, 'Can view وسم', 26, 'view_tag'),
(227, 'Can add إشعار', 58, 'add_notifications'),
(228, 'Can change إشعار', 58, 'change_notifications'),
(229, 'Can delete إشعار', 58, 'delete_notifications'),
(230, 'Can view إشعار', 58, 'view_notifications'),
(231, 'Can add المفضلات', 59, 'add_favourites'),
(232, 'Can change المفضلات', 59, 'change_favourites'),
(233, 'Can delete المفضلات', 59, 'delete_favourites'),
(234, 'Can view المفضلات', 59, 'view_favourites'),
(235, 'Can add crontab', 60, 'add_crontabschedule'),
(236, 'Can change crontab', 60, 'change_crontabschedule'),
(237, 'Can delete crontab', 60, 'delete_crontabschedule'),
(238, 'Can view crontab', 60, 'view_crontabschedule'),
(239, 'Can add interval', 61, 'add_intervalschedule'),
(240, 'Can change interval', 61, 'change_intervalschedule'),
(241, 'Can delete interval', 61, 'delete_intervalschedule'),
(242, 'Can view interval', 61, 'view_intervalschedule'),
(243, 'Can add periodic task', 62, 'add_periodictask'),
(244, 'Can change periodic task', 62, 'change_periodictask'),
(245, 'Can delete periodic task', 62, 'delete_periodictask'),
(246, 'Can view periodic task', 62, 'view_periodictask'),
(247, 'Can add periodic task track', 63, 'add_periodictasks'),
(248, 'Can change periodic task track', 63, 'change_periodictasks'),
(249, 'Can delete periodic task track', 63, 'delete_periodictasks'),
(250, 'Can view periodic task track', 63, 'view_periodictasks'),
(251, 'Can add solar event', 64, 'add_solarschedule'),
(252, 'Can change solar event', 64, 'change_solarschedule'),
(253, 'Can delete solar event', 64, 'delete_solarschedule'),
(254, 'Can view solar event', 64, 'view_solarschedule'),
(255, 'Can add clocked', 65, 'add_clockedschedule'),
(256, 'Can change clocked', 65, 'change_clockedschedule'),
(257, 'Can delete clocked', 65, 'delete_clockedschedule'),
(258, 'Can view clocked', 65, 'view_clockedschedule'),
(259, 'Can add Token', 66, 'add_token'),
(260, 'Can change Token', 66, 'change_token'),
(261, 'Can delete Token', 66, 'delete_token'),
(262, 'Can view Token', 66, 'view_token'),
(263, 'Can add Token', 67, 'add_tokenproxy'),
(264, 'Can change Token', 67, 'change_tokenproxy'),
(265, 'Can delete Token', 67, 'delete_tokenproxy'),
(266, 'Can view Token', 67, 'view_tokenproxy'),
(267, 'Can add association', 68, 'add_association'),
(268, 'Can change association', 68, 'change_association'),
(269, 'Can delete association', 68, 'delete_association'),
(270, 'Can view association', 68, 'view_association'),
(271, 'Can add code', 69, 'add_code'),
(272, 'Can change code', 69, 'change_code'),
(273, 'Can delete code', 69, 'delete_code'),
(274, 'Can view code', 69, 'view_code'),
(275, 'Can add nonce', 70, 'add_nonce'),
(276, 'Can change nonce', 70, 'change_nonce'),
(277, 'Can delete nonce', 70, 'delete_nonce'),
(278, 'Can view nonce', 70, 'view_nonce'),
(279, 'Can add user social auth', 71, 'add_usersocialauth'),
(280, 'Can change user social auth', 71, 'change_usersocialauth'),
(281, 'Can delete user social auth', 71, 'delete_usersocialauth'),
(282, 'Can view user social auth', 71, 'view_usersocialauth'),
(283, 'Can add partial', 72, 'add_partial'),
(284, 'Can change partial', 72, 'change_partial'),
(285, 'Can delete partial', 72, 'delete_partial'),
(286, 'Can view partial', 72, 'view_partial'),
(287, 'Can add application', 73, 'add_application'),
(288, 'Can change application', 73, 'change_application'),
(289, 'Can delete application', 73, 'delete_application'),
(290, 'Can view application', 73, 'view_application'),
(291, 'Can add access token', 74, 'add_accesstoken'),
(292, 'Can change access token', 74, 'change_accesstoken'),
(293, 'Can delete access token', 74, 'delete_accesstoken'),
(294, 'Can view access token', 74, 'view_accesstoken'),
(295, 'Can add grant', 75, 'add_grant'),
(296, 'Can change grant', 75, 'change_grant'),
(297, 'Can delete grant', 75, 'delete_grant'),
(298, 'Can view grant', 75, 'view_grant'),
(299, 'Can add refresh token', 76, 'add_refreshtoken'),
(300, 'Can change refresh token', 76, 'change_refreshtoken'),
(301, 'Can delete refresh token', 76, 'delete_refreshtoken'),
(302, 'Can view refresh token', 76, 'view_refreshtoken'),
(303, 'Can add id token', 77, 'add_idtoken'),
(304, 'Can change id token', 77, 'change_idtoken'),
(305, 'Can delete id token', 77, 'delete_idtoken'),
(306, 'Can view id token', 77, 'view_idtoken');

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
(1, '2025-04-16 12:13:49.882602', '2025-04-16 12:13:49.882602', NULL, '2025-04-18 00:00:00.000000', '2025-04-30 00:00:00.000000', NULL, 2640000.00, '0', 1, 4, NULL, 1, NULL, 2, NULL, 1);

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
(1, '2025-04-15 22:12:15.648799', '2025-04-15 22:12:15.648799', NULL, NULL, 2, NULL, 1);

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
(1, '2025-04-15 22:04:49.661479', '8', 'غرفة قياسية مفردة - إضافية', 1, '[{\"added\": {}}]', 7, 1),
(2, '2025-04-15 22:07:32.338032', '1', 'غرفة قياسية مزدوجة - 10 rooms available on 2025-04-15', 1, '[{\"added\": {}}]', 9, 1),
(3, '2025-04-15 22:11:27.720396', '1', 'hello', 1, '[{\"added\": {}}]', 38, 1),
(4, '2025-04-16 09:54:37.761198', '2', 'غرفة قياسية مزدوجة - 5 rooms available on 2025-04-17', 2, '[{\"changed\": {\"fields\": [\"\\u0646\\u0648\\u0639 \\u0627\\u0644\\u063a\\u0631\\u0641\\u0629\"]}}]', 9, 1),
(5, '2025-04-16 10:00:04.644091', '1', 'غرفة قياسية مزدوجة - 10 rooms available on 2025-04-16', 2, '[{\"changed\": {\"fields\": [\"\\u062a\\u0627\\u0631\\u064a\\u062e \\u0627\\u0644\\u062a\\u0648\\u0641\\u0631\"]}}]', 9, 1),
(6, '2025-04-16 12:01:47.503558', '5', 'غرفة قياسية مفردة - 55000.00 (2025-04-16 إلى 2025-04-21)', 2, '[{\"changed\": {\"fields\": [\"\\u062a\\u0627\\u0631\\u064a\\u062e \\u0627\\u0644\\u0628\\u062f\\u0621\", \"\\u062a\\u0627\\u0631\\u064a\\u062e \\u0627\\u0644\\u0627\\u0646\\u062a\\u0647\\u0627\\u0621\"]}}]', 8, 1),
(7, '2025-04-16 12:03:31.293556', '5', 'غرفة قياسية مفردة - 55000.00 (2025-04-16 إلى 2025-05-21)', 2, '[{\"changed\": {\"fields\": [\"\\u062a\\u0627\\u0631\\u064a\\u062e \\u0627\\u0644\\u0627\\u0646\\u062a\\u0647\\u0627\\u0621\"]}}]', 8, 1),
(8, '2025-04-16 12:26:35.985171', '28', 'Ahmed Mohamed', 3, '', 2, 1),
(9, '2025-04-16 12:26:36.000813', '25', 'ahmed algarbani', 3, '', 2, 1),
(10, '2025-04-16 12:37:53.226444', '34', 'سكاي تو - SKY 2', 3, '', 2, 1),
(11, '2025-04-16 12:37:53.233469', '33', 'joker Games', 3, '', 2, 1),
(12, '2025-04-16 12:37:53.236472', '32', 'Ahmed Mohamed', 3, '', 2, 1),
(13, '2025-04-16 12:37:53.240409', '24', 'akshdkj askdj8888', 3, '', 2, 1),
(14, '2025-04-16 12:38:40.372802', '59', 'عملاء دائمون -  ', 3, '', 34, 1),
(15, '2025-04-16 12:38:40.377924', '58', 'عملاء دائمون -  ', 3, '', 34, 1),
(16, '2025-04-16 12:38:40.381953', '57', 'عملاء دائمون -  ', 3, '', 34, 1),
(17, '2025-04-16 12:38:40.388720', '56', 'عملاء دائمون -  ', 3, '', 34, 1),
(18, '2025-04-16 12:50:35.704598', '60', 'عملاء دائمون -  ', 3, '', 34, 1),
(19, '2025-04-16 12:50:45.145016', '36', 'صديق الطالب', 3, '', 2, 1),
(20, '2025-04-16 12:50:45.151863', '35', 'joker Games', 3, '', 2, 1),
(21, '2025-04-16 12:59:30.185341', '61', 'عملاء دائمون -  ', 3, '', 34, 1),
(22, '2025-04-16 12:59:38.250893', '38', 'ahmed algarbani', 3, '', 2, 1),
(23, '2025-04-16 13:26:41.814137', '43', 'joker Games', 3, '', 2, 1),
(24, '2025-04-16 13:26:41.818894', '42', 'صديق الطالب', 3, '', 2, 1),
(25, '2025-04-16 13:26:41.822379', '40', 'ahmed algarbani', 3, '', 2, 1),
(26, '2025-04-16 13:26:41.823421', '39', 'مارس - Mars', 3, '', 2, 1),
(27, '2025-04-16 13:39:02.973353', '45', 'سكاي تو - SKY 2', 3, '', 2, 1),
(28, '2025-04-16 13:39:02.982509', '44', 'مارس - Mars', 3, '', 2, 1),
(29, '2025-04-16 13:46:42.010746', '50', 'ahmed algarbani', 3, '', 2, 1),
(30, '2025-04-16 13:46:42.024335', '49', 'Ahmed Mohamed', 3, '', 2, 1),
(31, '2025-04-16 13:46:42.027580', '48', 'صديق الطالب', 3, '', 2, 1),
(32, '2025-04-16 13:46:42.031605', '46', 'joker Games', 3, '', 2, 1),
(33, '2025-04-16 14:25:09.447535', '52', 'joker Games', 3, '', 2, 1),
(34, '2025-04-16 14:25:09.452447', '51', 'مارس - Mars', 3, '', 2, 1),
(35, '2025-04-16 14:38:12.513845', '58', 'joker Games', 3, '', 2, 1),
(36, '2025-04-16 14:38:12.520342', '57', 'ahmed algarbani', 3, '', 2, 1),
(37, '2025-04-16 14:38:12.522339', '56', 'صديق الطالب', 3, '', 2, 1),
(38, '2025-04-16 14:38:12.527874', '54', 'سكاي تو - SKY 2', 3, '', 2, 1),
(39, '2025-04-16 14:40:16.486218', '72', 'عملاء دائمون - مارس - Mars ', 3, '', 34, 1),
(40, '2025-04-16 14:40:16.492487', '71', 'عملاء دائمون - joker Games ', 3, '', 34, 1),
(41, '2025-04-16 14:40:16.497293', '70', 'عملاء دائمون - ahmed algarbani', 3, '', 34, 1),
(42, '2025-04-16 14:40:16.500713', '69', 'عملاء دائمون -  ', 3, '', 34, 1),
(43, '2025-04-16 14:40:16.503888', '68', 'عملاء دائمون -  ', 3, '', 34, 1),
(44, '2025-04-16 14:40:16.510583', '67', 'عملاء دائمون -  ', 3, '', 34, 1),
(45, '2025-04-16 14:40:16.515303', '66', 'عملاء دائمون -  ', 3, '', 34, 1),
(46, '2025-04-16 14:40:16.518794', '65', 'عملاء دائمون -  ', 3, '', 34, 1),
(47, '2025-04-16 14:40:16.522253', '64', 'عملاء دائمون -  ', 3, '', 34, 1),
(48, '2025-04-16 14:40:16.525748', '63', 'عملاء دائمون -  ', 3, '', 34, 1),
(49, '2025-04-16 14:40:16.529304', '62', 'عملاء دائمون -  ', 3, '', 34, 1);

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
(34, 'accounts', 'chartofaccounts'),
(35, 'accounts', 'journalentry'),
(1, 'admin', 'logentry'),
(4, 'auth', 'group'),
(31, 'auth', 'permission'),
(3, 'auth', 'user'),
(66, 'authtoken', 'token'),
(67, 'authtoken', 'tokenproxy'),
(25, 'blog', 'category'),
(24, 'blog', 'comment'),
(23, 'blog', 'post'),
(26, 'blog', 'tag'),
(13, 'bookings', 'booking'),
(14, 'bookings', 'bookingdetail'),
(50, 'bookings', 'bookinghistory'),
(15, 'bookings', 'extensionmovement'),
(51, 'bookings', 'guest'),
(32, 'contenttypes', 'contenttype'),
(59, 'customer', 'favourites'),
(65, 'django_celery_beat', 'clockedschedule'),
(60, 'django_celery_beat', 'crontabschedule'),
(61, 'django_celery_beat', 'intervalschedule'),
(62, 'django_celery_beat', 'periodictask'),
(63, 'django_celery_beat', 'periodictasks'),
(64, 'django_celery_beat', 'solarschedule'),
(37, 'home', 'contactmessage'),
(38, 'home', 'heroslider'),
(39, 'home', 'infobox'),
(40, 'home', 'partner'),
(41, 'home', 'paymenpolicy'),
(42, 'home', 'pricingplan'),
(43, 'home', 'privacypolicy'),
(44, 'home', 'roomtypehome'),
(45, 'home', 'setting'),
(46, 'home', 'socialmedialink'),
(47, 'home', 'teammember'),
(48, 'home', 'termsconditions'),
(49, 'home', 'testimonial'),
(21, 'HotelManagement', 'city'),
(18, 'HotelManagement', 'hotel'),
(30, 'HotelManagement', 'hotelrequest'),
(19, 'HotelManagement', 'image'),
(22, 'HotelManagement', 'location'),
(20, 'HotelManagement', 'phone'),
(58, 'notifications', 'notifications'),
(74, 'oauth2_provider', 'accesstoken'),
(73, 'oauth2_provider', 'application'),
(75, 'oauth2_provider', 'grant'),
(77, 'oauth2_provider', 'idtoken'),
(76, 'oauth2_provider', 'refreshtoken'),
(27, 'payments', 'currency'),
(29, 'payments', 'hotelpaymentmethod'),
(52, 'payments', 'payment'),
(53, 'payments', 'paymenthistory'),
(28, 'payments', 'paymentoption'),
(17, 'reviews', 'hotelreview'),
(16, 'reviews', 'roomreview'),
(9, 'rooms', 'availability'),
(6, 'rooms', 'category'),
(7, 'rooms', 'roomimage'),
(8, 'rooms', 'roomprice'),
(10, 'rooms', 'roomstatus'),
(5, 'rooms', 'roomtype'),
(54, 'services', 'coupon'),
(12, 'services', 'hotelservice'),
(55, 'services', 'offer'),
(11, 'services', 'roomtypeservice'),
(33, 'sessions', 'session'),
(68, 'social_django', 'association'),
(69, 'social_django', 'code'),
(70, 'social_django', 'nonce'),
(72, 'social_django', 'partial'),
(71, 'social_django', 'usersocialauth'),
(56, 'token_blacklist', 'blacklistedtoken'),
(57, 'token_blacklist', 'outstandingtoken'),
(36, 'users', 'activitylog'),
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
(1, 'contenttypes', '0001_initial', '2025-04-15 20:32:15.632211'),
(2, 'contenttypes', '0002_remove_content_type_name', '2025-04-15 20:32:15.687538'),
(3, 'auth', '0001_initial', '2025-04-15 20:32:15.885211'),
(4, 'auth', '0002_alter_permission_name_max_length', '2025-04-15 20:32:15.941664'),
(5, 'auth', '0003_alter_user_email_max_length', '2025-04-15 20:32:15.943071'),
(6, 'auth', '0004_alter_user_username_opts', '2025-04-15 20:32:15.954008'),
(7, 'auth', '0005_alter_user_last_login_null', '2025-04-15 20:32:15.959591'),
(8, 'auth', '0006_require_contenttypes_0002', '2025-04-15 20:32:15.963581'),
(9, 'auth', '0007_alter_validators_add_error_messages', '2025-04-15 20:32:15.969301'),
(10, 'auth', '0008_alter_user_username_max_length', '2025-04-15 20:32:15.970521'),
(11, 'auth', '0009_alter_user_last_name_max_length', '2025-04-15 20:32:15.979280'),
(12, 'auth', '0010_alter_group_name_max_length', '2025-04-15 20:32:15.986684'),
(13, 'auth', '0011_update_proxy_permissions', '2025-04-15 20:32:15.995659'),
(14, 'auth', '0012_alter_user_first_name_max_length', '2025-04-15 20:32:16.000510'),
(15, 'auth', '0013_alter_permission_options', '2025-04-15 20:32:16.005742'),
(16, 'auth', '0014_alter_permission_options_alter_user_user_permissions', '2025-04-15 20:32:16.013445'),
(17, 'auth', '0015_alter_user_user_permissions', '2025-04-15 20:32:16.019135'),
(18, 'accounts', '0001_initial', '2025-04-15 20:32:16.043739'),
(19, 'users', '0001_initial', '2025-04-15 20:32:16.451265'),
(20, 'HotelManagement', '0001_initial', '2025-04-15 20:32:16.542838'),
(21, 'HotelManagement', '0002_initial', '2025-04-15 20:32:17.733352'),
(22, 'accounts', '0002_initial', '2025-04-15 20:32:18.082301'),
(23, 'admin', '0001_initial', '2025-04-15 20:32:18.195587'),
(24, 'admin', '0002_logentry_remove_auto_add', '2025-04-15 20:32:18.216783'),
(25, 'admin', '0003_logentry_add_action_flag_choices', '2025-04-15 20:32:18.237678'),
(26, 'authtoken', '0001_initial', '2025-04-15 20:32:18.321449'),
(27, 'authtoken', '0002_auto_20160226_1747', '2025-04-15 20:32:18.359866'),
(28, 'authtoken', '0003_tokenproxy', '2025-04-15 20:32:18.377762'),
(29, 'authtoken', '0004_alter_tokenproxy_options', '2025-04-15 20:32:18.383172'),
(30, 'blog', '0001_initial', '2025-04-15 20:32:18.449053'),
(31, 'blog', '0002_initial', '2025-04-15 20:32:19.392229'),
(32, 'services', '0001_initial', '2025-04-15 20:32:19.452981'),
(33, 'rooms', '0001_initial', '2025-04-15 20:32:19.559453'),
(34, 'payments', '0001_initial', '2025-04-15 20:32:19.628358'),
(35, 'bookings', '0001_initial', '2025-04-15 20:32:19.768278'),
(36, 'bookings', '0002_initial', '2025-04-15 20:32:21.422953'),
(37, 'customer', '0001_initial', '2025-04-15 20:32:21.427494'),
(38, 'customer', '0002_initial', '2025-04-15 20:32:21.742322'),
(39, 'django_celery_beat', '0001_initial', '2025-04-15 20:32:21.910261'),
(40, 'django_celery_beat', '0002_auto_20161118_0346', '2025-04-15 20:32:21.989147'),
(41, 'django_celery_beat', '0003_auto_20161209_0049', '2025-04-15 20:32:22.009463'),
(42, 'django_celery_beat', '0004_auto_20170221_0000', '2025-04-15 20:32:22.014334'),
(43, 'django_celery_beat', '0005_add_solarschedule_events_choices', '2025-04-15 20:32:22.022457'),
(44, 'django_celery_beat', '0006_auto_20180322_0932', '2025-04-15 20:32:22.078600'),
(45, 'django_celery_beat', '0007_auto_20180521_0826', '2025-04-15 20:32:22.111013'),
(46, 'django_celery_beat', '0008_auto_20180914_1922', '2025-04-15 20:32:22.143426'),
(47, 'django_celery_beat', '0006_auto_20180210_1226', '2025-04-15 20:32:22.165610'),
(48, 'django_celery_beat', '0006_periodictask_priority', '2025-04-15 20:32:22.186677'),
(49, 'django_celery_beat', '0009_periodictask_headers', '2025-04-15 20:32:22.212340'),
(50, 'django_celery_beat', '0010_auto_20190429_0326', '2025-04-15 20:32:22.395072'),
(51, 'django_celery_beat', '0011_auto_20190508_0153', '2025-04-15 20:32:22.483387'),
(52, 'django_celery_beat', '0012_periodictask_expire_seconds', '2025-04-15 20:32:22.492653'),
(53, 'django_celery_beat', '0013_auto_20200609_0727', '2025-04-15 20:32:22.513693'),
(54, 'django_celery_beat', '0014_remove_clockedschedule_enabled', '2025-04-15 20:32:22.529886'),
(55, 'django_celery_beat', '0015_edit_solarschedule_events_choices', '2025-04-15 20:32:22.601694'),
(56, 'django_celery_beat', '0016_alter_crontabschedule_timezone', '2025-04-15 20:32:22.641557'),
(57, 'django_celery_beat', '0017_alter_crontabschedule_month_of_year', '2025-04-15 20:32:22.729152'),
(58, 'django_celery_beat', '0018_improve_crontab_helptext', '2025-04-15 20:32:22.737617'),
(59, 'django_celery_beat', '0019_alter_periodictasks_options', '2025-04-15 20:32:22.745085'),
(60, 'home', '0001_initial', '2025-04-15 20:32:22.926102'),
(61, 'home', '0002_initial', '2025-04-15 20:32:23.347628'),
(62, 'notifications', '0001_initial', '2025-04-15 20:32:23.364739'),
(63, 'notifications', '0002_initial', '2025-04-15 20:32:23.645766'),
(64, 'oauth2_provider', '0001_initial', '2025-04-15 20:32:24.395517'),
(65, 'oauth2_provider', '0002_auto_20190406_1805', '2025-04-15 20:32:24.544924'),
(66, 'oauth2_provider', '0003_auto_20201211_1314', '2025-04-15 20:32:24.622214'),
(67, 'oauth2_provider', '0004_auto_20200902_2022', '2025-04-15 20:32:24.990916'),
(68, 'oauth2_provider', '0005_auto_20211222_2352', '2025-04-15 20:32:25.146478'),
(69, 'oauth2_provider', '0006_alter_application_client_secret', '2025-04-15 20:32:25.295882'),
(70, 'oauth2_provider', '0007_application_post_logout_redirect_uris', '2025-04-15 20:32:25.333579'),
(71, 'oauth2_provider', '0008_alter_accesstoken_token', '2025-04-15 20:32:25.366209'),
(72, 'oauth2_provider', '0009_add_hash_client_secret', '2025-04-15 20:32:25.410289'),
(73, 'oauth2_provider', '0010_application_allowed_origins', '2025-04-15 20:32:25.443867'),
(74, 'oauth2_provider', '0011_refreshtoken_token_family', '2025-04-15 20:32:25.480233'),
(75, 'oauth2_provider', '0012_add_token_checksum', '2025-04-15 20:32:25.881595'),
(76, 'payments', '0002_initial', '2025-04-15 20:32:27.634575'),
(77, 'reviews', '0001_initial', '2025-04-15 20:32:27.662336'),
(78, 'reviews', '0002_initial', '2025-04-15 20:32:28.716740'),
(79, 'rooms', '0002_initial', '2025-04-15 20:32:30.908060'),
(80, 'services', '0002_initial', '2025-04-15 20:32:32.108229'),
(81, 'sessions', '0001_initial', '2025-04-15 20:32:32.167731'),
(82, 'default', '0001_initial', '2025-04-15 20:32:32.412535'),
(83, 'social_auth', '0001_initial', '2025-04-15 20:32:32.412535'),
(84, 'default', '0002_add_related_name', '2025-04-15 20:32:32.535922'),
(85, 'social_auth', '0002_add_related_name', '2025-04-15 20:32:32.543428'),
(86, 'default', '0003_alter_email_max_length', '2025-04-15 20:32:32.543428'),
(87, 'social_auth', '0003_alter_email_max_length', '2025-04-15 20:32:32.561410'),
(88, 'default', '0004_auto_20160423_0400', '2025-04-15 20:32:32.599042'),
(89, 'social_auth', '0004_auto_20160423_0400', '2025-04-15 20:32:32.610843'),
(90, 'social_auth', '0005_auto_20160727_2333', '2025-04-15 20:32:32.629215'),
(91, 'social_django', '0006_partial', '2025-04-15 20:32:32.663218'),
(92, 'social_django', '0007_code_timestamp', '2025-04-15 20:32:32.682989'),
(93, 'social_django', '0008_partial_timestamp', '2025-04-15 20:32:32.715324'),
(94, 'social_django', '0009_auto_20191118_0520', '2025-04-15 20:32:32.810445'),
(95, 'social_django', '0010_uid_db_index', '2025-04-15 20:32:32.869536'),
(96, 'social_django', '0011_alter_id_fields', '2025-04-15 20:32:33.163219'),
(97, 'social_django', '0012_usersocialauth_extra_data_new', '2025-04-15 20:32:33.227502'),
(98, 'social_django', '0013_migrate_extra_data', '2025-04-15 20:32:33.290507'),
(99, 'social_django', '0014_remove_usersocialauth_extra_data', '2025-04-15 20:32:33.351815'),
(100, 'social_django', '0015_rename_extra_data_new_usersocialauth_extra_data', '2025-04-15 20:32:33.492150'),
(101, 'social_django', '0016_alter_usersocialauth_extra_data', '2025-04-15 20:32:33.610608'),
(102, 'token_blacklist', '0001_initial', '2025-04-15 20:32:33.824724'),
(103, 'token_blacklist', '0002_outstandingtoken_jti_hex', '2025-04-15 20:32:33.877519'),
(104, 'token_blacklist', '0003_auto_20171017_2007', '2025-04-15 20:32:33.956243'),
(105, 'token_blacklist', '0004_auto_20171017_2013', '2025-04-15 20:32:34.042462'),
(106, 'token_blacklist', '0005_remove_outstandingtoken_jti', '2025-04-15 20:32:34.097671'),
(107, 'token_blacklist', '0006_auto_20171017_2113', '2025-04-15 20:32:34.148847'),
(108, 'token_blacklist', '0007_auto_20171017_2214', '2025-04-15 20:32:34.612204'),
(109, 'token_blacklist', '0008_migrate_to_bigautofield', '2025-04-15 20:32:34.898937'),
(110, 'token_blacklist', '0010_fix_migrate_to_bigautofield', '2025-04-15 20:32:34.947058'),
(111, 'token_blacklist', '0011_linearizes_history', '2025-04-15 20:32:34.961479'),
(112, 'token_blacklist', '0012_alter_outstandingtoken_user', '2025-04-15 20:32:35.007176'),
(113, 'social_django', '0001_initial', '2025-04-15 20:32:35.015363'),
(114, 'social_django', '0004_auto_20160423_0400', '2025-04-15 20:32:35.019115'),
(115, 'social_django', '0003_alter_email_max_length', '2025-04-15 20:32:35.022454'),
(116, 'social_django', '0002_add_related_name', '2025-04-15 20:32:35.027528'),
(117, 'social_django', '0005_auto_20160727_2333', '2025-04-15 20:32:35.031723'),
(118, 'rooms', '0003_remove_availability_room_status_delete_roomstatus', '2025-04-15 21:51:17.159148'),
(119, 'payments', '0003_alter_payment_payment_discount_code', '2025-04-16 12:15:12.066768');

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
('ejkt477rw2a80094croirlqf5oo8udpr', '.eJxVjEEOwiAQAP_C2RAWqEs9evcNBHZBqgaS0p6MfzckPeh1ZjJv4cO-Fb_3tPqFxUWAOP2yGOiZ6hD8CPXeJLW6rUuUI5GH7fLWOL2uR_s3KKGXsVWsM2iasj2jw2zQGYcEhiNoO-eETMgzQtZogZXKbAEnUkYzRdLi8wXI_Tdw:1u523H:t5jmDlNtAdC-vzmRaQ3RwYYjHsZaPAQEg7gUQcSFTdE', '2025-04-30 12:39:39.712488'),
('mk9pc3p86zxwxogqxk49hhfylgvwsqcy', '.eJxVjEEOwiAQAP_C2RAWqEs9evcNBHZBqgaS0p6MfzckPeh1ZjJv4cO-Fb_3tPqFxUWAOP2yGOiZ6hD8CPXeJLW6rUuUI5GH7fLWOL2uR_s3KKGXsVWsM2iasj2jw2zQGYcEhiNoO-eETMgzQtZogZXKbAEnUkYzRdLi8wXI_Tdw:1u52mG:_Fpep5V-lOg7wEXYpP_HNLM7Ddqa7jXKYYQzxAJUzO0', '2025-04-30 13:26:08.212357'),
('nc6sa8c55x7l3qa2nkjc1feg119jwwqz', '.eJxVy0EOwiAQheG7sDYNxRlg3Lnq0iMQhg6lsZGk2JXx7lbjQlcv-V--hwpxu5ewNVnDPKqTQlKH38gxXeX2flpNc1xCqqt039q6qdZpkW74zOW8M_PvS2xlx1ZHYifZZmtFHCALWe0RKVH2FgyjIQBgzo6A89gDcT46jUwYfa-eL817N3E:1u53uT:oS5gGEM69jcfHQIXQAmHx40UhBqZqktKg9B-yNvNPzQ', '2025-04-30 14:38:41.919194');

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
(1, 'slider_images/balcony-cabin.jpg', 'slider_images/avatar.jpeg', 'slider_images/app-store.png', 'hello', 'hi', 1);

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
(1, '2025-04-16 12:13:49.917872', '2025-04-16 12:13:49.917872', NULL, 'payments/transfer/transfer_image/bg_aNUVRHR.jpg', 0, '2025-04-16 12:13:49.898226', 2640000.00, 2640000.00, '$', 'e_pay', 'تم التحويل بواسطة:  - ', 0.00, '', 1, NULL, 1, NULL, 1);

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
  `room_type_id` bigint(20) NOT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rooms_availability`
--

INSERT INTO `rooms_availability` (`id`, `created_at`, `updated_at`, `deleted_at`, `availability_date`, `available_rooms`, `notes`, `created_by_id`, `hotel_id`, `room_type_id`, `updated_by_id`) VALUES
(1, '2025-04-15 22:07:32.332146', '2025-04-16 10:00:04.644091', NULL, '2025-04-16', 10, 's', 1, 1, 3, 1),
(2, '2025-04-15 22:10:24.101174', '2025-04-16 09:54:37.757104', NULL, '2025-04-17', 5, '', NULL, 1, 3, 1),
(3, '2025-04-15 22:10:24.102351', '2025-04-15 22:10:24.102351', NULL, '2025-04-18', 5, NULL, NULL, 1, 2, NULL),
(4, '2025-04-15 22:10:24.102351', '2025-04-15 22:10:24.102351', NULL, '2025-04-19', 5, NULL, NULL, 1, 2, NULL),
(5, '2025-04-15 22:10:24.102351', '2025-04-15 22:10:24.102351', NULL, '2025-04-20', 5, NULL, NULL, 1, 2, NULL),
(6, '2025-04-15 22:10:24.102351', '2025-04-15 22:10:24.102351', NULL, '2025-04-21', 5, NULL, NULL, 1, 2, NULL),
(7, '2025-04-15 22:10:24.102351', '2025-04-15 22:10:24.102351', NULL, '2025-04-22', 5, NULL, NULL, 1, 2, NULL),
(8, '2025-04-15 22:10:24.102351', '2025-04-15 22:10:24.102351', NULL, '2025-04-23', 5, NULL, NULL, 1, 2, NULL),
(9, '2025-04-15 22:10:24.102351', '2025-04-15 22:10:24.102351', NULL, '2025-04-24', 5, NULL, NULL, 1, 2, NULL),
(10, '2025-04-15 22:10:24.103393', '2025-04-15 22:10:24.103393', NULL, '2025-04-25', 5, NULL, NULL, 1, 2, NULL),
(11, '2025-04-15 22:10:24.103393', '2025-04-15 22:10:24.103393', NULL, '2025-04-26', 5, NULL, NULL, 1, 2, NULL),
(12, '2025-04-15 22:10:24.103393', '2025-04-15 22:10:24.103393', NULL, '2025-04-27', 5, NULL, NULL, 1, 2, NULL),
(13, '2025-04-15 22:10:24.103393', '2025-04-15 22:10:24.103393', NULL, '2025-04-28', 5, NULL, NULL, 1, 2, NULL),
(14, '2025-04-15 22:10:24.103393', '2025-04-15 22:10:24.103393', NULL, '2025-04-29', 5, NULL, NULL, 1, 2, NULL),
(15, '2025-04-15 22:10:24.103393', '2025-04-15 22:10:24.103393', NULL, '2025-04-30', 5, NULL, NULL, 1, 2, NULL),
(16, '2025-04-16 12:13:49.898226', '2025-04-16 12:13:49.898226', NULL, '2025-04-16', 6, 'Updated due to booking #1', NULL, 1, 2, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `rooms_category`
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

--
-- Dumping data for table `rooms_category`
--

INSERT INTO `rooms_category` (`id`, `created_at`, `updated_at`, `deleted_at`, `status`, `name`, `description`, `created_by_id`, `updated_by_id`) VALUES
(1, '2025-03-01 19:18:19.935767', '2025-03-01 19:18:46.244395', NULL, 0, 'vip', 'شسيسشيش', NULL, NULL),
(2, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, 0, 'قياسي', 'غرف مريحة بمواصفات أساسية', 2, 2),
(3, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, 0, 'جناح', 'أجنحة واسعة مع منطقة جلوس منفصلة', 2, 2),
(4, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, 0, 'غرفة ديلوكس', 'غرف بمساحة أكبر وتجهيزات إضافية', 3, 3),
(5, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, 0, 'غرفة مطلة على البحر', 'غرف تتمتع بإطلالة مباشرة على البحر', 3, 3),
(6, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, 0, 'كوخ بيئي', 'أكواخ بسيطة وصديقة للبيئة', 6, 6),
(7, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, 0, 'قياسي2', 'غرف مريحة بمواصفات أساسية', 3, 3),
(8, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, 0, 'قياسي1', 'غرف مريحة بمواصفات أساسية', 6, 6);

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
(7, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, 'images/rooms/socotra_eco_hut_1.jpg', 1, 'كوخ بيئي مزدوج في نزل سقطرى', 6, 4, 6, 6),
(8, '2025-04-15 22:04:49.657032', '2025-04-15 22:04:49.657032', NULL, 'room_images/balcony-cabin.jpg', 0, 'sssss', 1, 1, 2, 1);

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
) ;

--
-- Dumping data for table `rooms_roomprice`
--

INSERT INTO `rooms_roomprice` (`id`, `created_at`, `updated_at`, `deleted_at`, `date_from`, `date_to`, `price`, `is_special_offer`, `created_by_id`, `hotel_id`, `room_type_id`, `updated_by_id`) VALUES
(1, '2025-04-01 23:57:21.633047', '2025-04-01 23:57:21.633047', NULL, '2025-04-01', '2025-04-11', 500.00, 0, 1, 1, 1, 1),
(2, '2025-04-04 21:50:12.631031', '2025-04-04 21:50:28.360614', NULL, '2025-04-04', '2025-04-05', 330.00, 0, 1, 2, 1, 1),
(3, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, '2025-04-15', '2025-12-31', 50000.00, 0, 2, 1, 2, 2),
(4, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, '2025-04-15', '2025-12-31', 75000.00, 0, 3, 2, 5, 3),
(5, '2025-04-15 01:56:01.000000', '2025-04-16 12:03:31.293556', NULL, '2025-04-16', '2025-05-21', 55000.00, 1, 2, 1, 2, 1),
(6, '2025-04-15 01:56:01.000000', '2025-04-15 01:56:01.000000', NULL, '2025-04-15', '2025-12-31', 40000.00, 0, 6, 4, 6, 6);

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
) ;

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
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`data`))
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
  `extra_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`extra_data`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `social_auth_usersocialauth`
--

INSERT INTO `social_auth_usersocialauth` (`id`, `provider`, `uid`, `user_id`, `created`, `modified`, `extra_data`) VALUES
(25, 'google-oauth2', 'telegram1imo@gmail.com', 59, '2025-04-16 14:38:41.676930', '2025-04-16 14:38:41.684862', '{\"auth_time\": 1744814321, \"expires\": 3598, \"token_type\": \"Bearer\", \"first_name\": \"\\u0645\\u0627\\u0631\\u0633 - Mars\", \"last_name\": \"\", \"gender\": null, \"birthday\": null, \"picture\": \"https://lh3.googleusercontent.com/a/ACg8ocKksxVfE_3RHUvFZftePpn2f01-HtmaEZQEyndPqpo7xHeo3SE=s96-c\", \"access_token\": \"ya29.a0AZYkNZjDhlTI39fEJmxJgHQuXI3YuzTD9vZpjbO-txDiviALf9hAG6ejAUZYkaYg4Mp7Lvo4x8X6pLQ4Fb3Oz5iqC46XPb2SbiSo_4XdeIRwQm9z5DdBP0bgOKdG-a4OrOe_MgNJ2Grz2qspwbfSuItAInAClCbN25fTWPj92AaCgYKAdMSARQSFQHGX2MiY3_m6iV9nOTk_oORZBk6aQ0177\"}');

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
  `otp_code` varchar(6) DEFAULT NULL,
  `otp_created_at` datetime(6) DEFAULT NULL,
  `chart_id` bigint(20) DEFAULT NULL,
  `chield_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users_customuser`
--

INSERT INTO `users_customuser` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `date_joined`, `created_at`, `updated_at`, `user_type`, `phone`, `image`, `gender`, `birth_date`, `is_active`, `otp_code`, `otp_created_at`, `chart_id`, `chield_id`) VALUES
(1, 'pbkdf2_sha256$600000$WiLeYKRGdIKtWxdmTAtOmU$KTRRkjHfaMrfsm0s9x9BjNoJSbF/vkwNCqNRJNelKoI=', '2025-04-16 13:26:08.204201', 1, 'a', '', '', 'a@a.com', 1, '2025-03-20 20:53:38.214703', '2025-03-20 20:53:39.041969', '2025-03-20 20:53:39.041969', '', '', '', NULL, NULL, 1, NULL, NULL, NULL, NULL),
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
(26, 'pbkdf2_sha256$600000$hZUmsvhJFisnXWaFeAlQf5$GrvGT1Zw0gbrfWXGcgwLaHwKg3+OXlwA1pGZC1rw478=', '2025-04-16 12:20:30.651886', 0, 'as888aua', 'ajkhdk', 'kajshdask', 'kjashd654@asd.com', 0, '2025-04-16 12:20:30.120259', '2025-04-16 12:20:30.638306', '2025-04-16 12:20:30.638306', 'customer', '7817171717', 'users/2025/04/16/balcony-cabin.jpg', 'Male', '2000-11-11', 1, NULL, NULL, 54, NULL),
(27, 'pbkdf2_sha256$600000$Y85SoKwjr8uGSY4BPSRNt0$KTvVe8q8lECZKcUDEXn6JFcPbH+xF4+ILIFGUllRs30=', '2025-04-16 12:21:28.848034', 0, 'test444', 'test', 'tset', 'testt44@gma.com', 0, '2025-04-16 12:21:28.296690', '2025-04-16 12:21:28.827509', '2025-04-16 12:21:28.827509', 'customer', '781717609', 'users/2025/04/16/airline-img7.png', 'Female', '2002-11-11', 1, NULL, NULL, 55, NULL),
(59, '!GtAs4iBJ35YjOL9uuD6KYz2vriON7450105XrMWn', '2025-04-16 14:38:41.714787', 0, 'telegram1imo', 'مارس - Mars', '', 'telegram1imo@gmail.com', 0, '2025-04-16 14:38:41.668958', '2025-04-16 14:38:41.669953', '2025-04-16 14:38:41.746499', 'customer', '', 'https://lh3.googleusercontent.com/a/ACg8ocKksxVfE_3RHUvFZftePpn2f01-HtmaEZQEyndPqpo7xHeo3SE=s96-c', NULL, NULL, 1, NULL, NULL, NULL, NULL);

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=96;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=307;

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=78;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=120;

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `payments_paymenthistory`
--
ALTER TABLE `payments_paymenthistory`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `payments_paymentoption`
--
ALTER TABLE `payments_paymentoption`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `rooms_category`
--
ALTER TABLE `rooms_category`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `rooms_roomimage`
--
ALTER TABLE `rooms_roomimage`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

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
  ADD CONSTRAINT `rooms_availability_room_type_id_ee87e18f_fk_rooms_roomtype_id` FOREIGN KEY (`room_type_id`) REFERENCES `rooms_roomtype` (`id`),
  ADD CONSTRAINT `rooms_availability_updated_by_id_f8d6a9d2_fk_users_customuser_id` FOREIGN KEY (`updated_by_id`) REFERENCES `users_customuser` (`id`);

--
-- Constraints for table `rooms_category`
--
ALTER TABLE `rooms_category`
  ADD CONSTRAINT `rooms_category_created_by_id_c539b61c_fk_users_customuser_id` FOREIGN KEY (`created_by_id`) REFERENCES `users_customuser` (`id`),
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
