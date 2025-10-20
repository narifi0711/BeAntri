-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Oct 17, 2025 at 09:37 AM
-- Server version: 8.0.30
-- PHP Version: 8.3.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `midone`
--

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(5, '2025_10_08_002242_create_permission_tables', 2),
(7, '2014_10_12_000000_create_users_table', 3),
(8, '2014_10_12_100000_create_password_resets_table', 3),
(9, '2019_08_19_000000_create_failed_jobs_table', 3),
(10, '2019_12_14_000001_create_personal_access_tokens_table', 3),
(11, '2025_10_08_005057_create_permission_tables', 3),
(12, '2025_10_08_012038_create_permission_tables', 4),
(13, '2025_10_08_040756_add_unit_to_users_table', 5),
(14, '2025_10_08_041644_create_permission_tables', 6),
(15, '2025_10_08_061758_create_permission_tables', 7),
(16, '2025_10_08_075122_create_permission_tables', 8),
(17, '2025_10_08_090244_create_permission_tables', 9),
(18, '2025_10_08_092350_create_permission_tables', 10),
(19, '2025_10_09_001415_create_permission_tables', 11),
(20, '2025_10_09_001223_add_unit_to_users_table', 12),
(21, '2025_10_17_160652_create_unit_table', 12);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Models\\User', 11),
(2, 'App\\Models\\User', 16);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'view dashboard', 'web', '2025-10-08 16:27:49', '2025-10-08 16:27:49'),
(2, 'manage users', 'web', '2025-10-08 16:27:49', '2025-10-08 16:27:49'),
(3, 'manage roles', 'web', '2025-10-08 16:27:49', '2025-10-08 16:27:49'),
(4, 'create articles', 'web', '2025-10-08 16:27:49', '2025-10-08 16:27:49'),
(5, 'edit articles', 'web', '2025-10-08 16:27:49', '2025-10-08 16:27:49'),
(6, 'delete articles', 'web', '2025-10-08 16:27:49', '2025-10-08 16:27:49'),
(7, 'view error logs', 'web', '2025-10-08 16:27:49', '2025-10-08 16:27:49');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'super-admin', 'web', '2025-10-08 16:27:49', '2025-10-08 16:27:49'),
(2, 'admin-unit', 'web', '2025-10-08 16:27:49', '2025-10-08 16:27:49'),
(3, 'user-unit', 'web', '2025-10-08 16:27:49', '2025-10-08 16:27:49');

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint UNSIGNED NOT NULL,
  `role_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(1, 2),
(2, 2),
(3, 2),
(1, 3),
(4, 3),
(5, 3);

-- --------------------------------------------------------

--
-- Table structure for table `unit`
--

CREATE TABLE `unit` (
  `kode` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alamat` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nomor_telepon` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nomor_fax` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `website` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `wa` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `facebook` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `instagram` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pimpinan_1_jabatan` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pimpinan_1_nama` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pimpinan_1_nip` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pimpinan_2_jabatan` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pimpinan_2_nama` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pimpinan_2_nip` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pimpinan_3_jabatan` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pimpinan_3_nama` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pimpinan_3_nip` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pimpinan_4_jabatan` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pimpinan_4_nama` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pimpinan_4_nip` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_create` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_date_create` timestamp NULL DEFAULT NULL,
  `user_change` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `app` tinyint NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `unit`
--

INSERT INTO `unit` (`kode`, `nama`, `alamat`, `nomor_telepon`, `nomor_fax`, `email`, `website`, `wa`, `facebook`, `instagram`, `pimpinan_1_jabatan`, `pimpinan_1_nama`, `pimpinan_1_nip`, `pimpinan_2_jabatan`, `pimpinan_2_nama`, `pimpinan_2_nip`, `pimpinan_3_jabatan`, `pimpinan_3_nama`, `pimpinan_3_nip`, `pimpinan_4_jabatan`, `pimpinan_4_nama`, `pimpinan_4_nip`, `user_create`, `user_date_create`, `user_change`, `app`) VALUES
('10', 'Sorong', 'Jl. Basuki Rahmat, KM 11,5 Sorong, Papua Barat TEST UPDATE', '0951 - 321107, 321056, 321054', NULL, 'ut-sorong@ecampus.ut.ac.id', 'kumar', '4649849494', 'https://facebook.com', 'mar kumar taye', 'Direktur', 'test EDIT PIMPINAN', '12331', 'Manajer Tata Usaha', 'test pejabat2', '3232', 'Manajer Marketing dan Registrasi', 'test pejabat3', '5453', 'Manajer Pembelajaran dan Ujian', 'test pejabat4', '32131', NULL, '2025-03-07 17:05:04', NULL, 1),
('11', 'Banda Aceh ', 'Jl. Pendidikan/Bahagia, Punge Blang Cut,\\nKecamatan Jaya Baru,\\nKota Banda Aceh 23234', '0651-44749, 44750', '0651-44757', ' ut-bandaaceh@ecampus.ut.ac.id', NULL, NULL, NULL, NULL, 'Direktur', NULL, NULL, 'Manajer Tata Usaha', NULL, NULL, 'Manajer Marketing dan Registrasi', NULL, NULL, 'Manajer Pembelajaran dan Ujian', NULL, NULL, NULL, '2025-03-07 17:05:04', NULL, 0),
('12', 'Medan', 'Jl. Bromo No. 29 Medan, Kelurahan BinjaiKecamatan Medan Denai 20228', '061-7323795, 7326261', '061-7326260', 'ut-medan@ecampus.ut.ac.id', 'http://www.medan.ut.ac.id', NULL, 'Upbjj Medan', '@utmedan', 'Direktur', 'Yasir Riady, S.S., M.Hum.', '198410032009121002', 'Manajer Tata Usaha', 'Salman Saleh Hasibuan, S.E.', '197710062005011004', 'Manajer Marketing dan Registrasi', 'Husni Mubarak, S.P.', '119831101202312101', 'Manajer Pembelajaran dan Ujian', 'Nisha Marina, S.E., M.Si.', '198112312008122002', NULL, '2025-03-07 17:05:04', NULL, 0),
('13', 'Batam', 'Jl. Dr. Sutomo No. 3 Sekupang,\\nBatam 29422', '0778-323478', '0778-323479', 'ut-batam@ecampus.ut.ac.id', NULL, NULL, NULL, NULL, 'Direktur', NULL, NULL, 'Manajer Tata Usaha', NULL, NULL, 'Manajer Marketing dan Registrasi', NULL, NULL, 'Manajer Pembelajaran dan Ujian', NULL, NULL, NULL, '2025-03-07 17:05:04', NULL, 0),
('14', 'Padang', 'Jl. Raya By Pass Km.13\\nSungai Sapih, Padang 25159', '0811 660 1414', ' 0751-496630', 'ut-padang@ecampus.ut.ac.id', NULL, NULL, NULL, NULL, 'Direktur', NULL, NULL, 'Manajer Tata Usaha', NULL, NULL, 'Manajer Marketing dan Registrasi', NULL, NULL, 'Manajer Pembelajaran dan Ujian', NULL, NULL, NULL, '2025-03-07 17:05:04', NULL, 1),
('15', 'Pangkal Pinang', 'Jl. Pulau Bangka, Komplek Perkantoran\\ndan Pemukiman Terpadu,\\nPemerintah Prov. Kep Bangka Belitung\\nAir Hitam, Pangkal Pinang', '0717-424986, 437949', '0717-436140, 431315', 'ut-pangkalpinang@ecampus.ut.ac.id', NULL, NULL, NULL, NULL, 'Direktur', NULL, NULL, 'Manajer Tata Usaha', NULL, NULL, 'Manajer Marketing dan Registrasi', NULL, NULL, 'Manajer Pembelajaran dan Ujian', NULL, NULL, NULL, '2025-03-07 17:05:04', NULL, 0),
('16', 'Pekanbaru', 'Jl. Arifin Ahmad No. 111,\\nPekanbaru 28294', '0761-589261', '0761-589259', 'ut-pekanbaru@ecampus.ut.ac.id', NULL, NULL, NULL, NULL, 'Direktur', NULL, NULL, 'Manajer Tata Usaha', NULL, NULL, 'Manajer Marketing dan Registrasi', NULL, NULL, 'Manajer Pembelajaran dan Ujian', NULL, NULL, NULL, '2025-03-07 17:05:04', NULL, 1),
('17', 'Jambi', 'Jl. Gajah Mada No.51, Lebak Bandung,\\nJelutung, Jambi 36135', '0741-25753', '0741-755 5572', 'jambi@ecampus.ut.ac.id', NULL, NULL, NULL, NULL, 'Direktur', NULL, NULL, 'Manajer Tata Usaha', NULL, NULL, 'Manajer Marketing dan Registrasi', NULL, NULL, 'Manajer Pembelajaran dan Ujian', NULL, NULL, NULL, '2025-03-07 17:05:04', NULL, 0),
('18', 'Palembang', 'Jln Kol. H. Burlian KM.10 Karya Baru, Alang-Alang Lebar, Palembang 30154', '0711-5724000', '0711-443992', 'ut-palembang@ecampus.ut.ac.id', 'palembang.ut.ac.id', '0811-7858-875', 'utpalembang', 'utpalembang', 'Direktur', 'Drs. Muhammad Tair A. M.M.', '196510291986031001', 'Manajer Tata Usaha', 'Imam Dwinusa Harun S.E.', '197012172005011001', 'Manajer Marketing dan Registrasi', 'Wisnu Firdiansah Haris S.Pd. M.M.', '198206022010121005', 'Manajer Pembelajaran dan Ujian', 'Triana Sri Gunarti S.E. M.Si.', '197405132008122001', NULL, '2025-03-07 17:05:04', NULL, 0),
('19', 'Bengkulu', 'Jl. Sadang Raya, Kelurahan Lingkar Barat,\\nKota Bengkulu 38225', '0736-26294', '0736-346177', 'ut-bengkulu@ecampus.ut.ac.id', NULL, NULL, NULL, NULL, 'Direktur', NULL, NULL, 'Manajer Tata Usaha', NULL, NULL, 'Manajer Marketing dan Registrasi', NULL, NULL, 'Manajer Pembelajaran dan Ujian', NULL, NULL, NULL, '2025-03-07 17:05:04', NULL, 0),
('20', 'Bandar Lampung', 'Jl. Soekarno-Hatta No. 108B Rajabasa,Bandar Lampung 35144', '0721-704772', '0721-773736', 'ut-bandarlampung@ecampus.ut.ac.id', 'lampung.ut.ac.id', '08117223030', 'ut bandarlampung', '@utlampung.official', 'Direktur', 'Dra. Sri Ismulyaty, M.Si.', '196305071989102001', 'Manajer Tata Usaha', 'Firman Yusuf Abdurachman, S.T.', '197503162006041001', 'Manajer Marketing dan Registrasi', 'Sugianto, S.IP.', '196709282002121001', 'Manajer Pembelajaran dan Ujian', 'Dr. Welli Yuliatmoko, S.TP., M.Si.', '197307292001121001', NULL, '2025-03-07 17:05:04', NULL, 1),
('21', 'Jakarta', 'Jl. Ahmad Yani No. 43 (By pass) Kel. Utan Kayu, Kec. Matraman, Jakarta Timur', '021-29613751, 29613753, 29622059', '021-29613752', 'ut-jakarta@ecampus.ut.ac.id', NULL, NULL, NULL, NULL, 'Direktur', NULL, NULL, 'Manajer Tata Usaha', NULL, NULL, 'Manajer Marketing dan Registrasi', NULL, NULL, 'Manajer Pembelajaran dan Ujian', NULL, NULL, NULL, '2025-03-07 17:05:04', NULL, 0),
('22', 'Serang', 'Jl. Raya Jakarta Km. 7 Pakupatan,\\nSerang, Banten 42122', '0254-282728, 282721', '0254-282719', 'ut-serang@ecampus.ut.ac.id', NULL, NULL, NULL, NULL, 'Direktur', NULL, NULL, 'Manajer Tata Usaha', NULL, NULL, 'Manajer Marketing dan Registrasi', NULL, NULL, 'Manajer Pembelajaran dan Ujian', NULL, NULL, NULL, '2025-03-07 17:05:04', NULL, 0),
('23', 'Bogor', 'Jl. KH. Soleh Iskandar No. 234,\\nTanah Sareal, Bogor 16164', '0251-7559237', '0251-7559238', 'ut-bogor@ecampus.ut.ac.id', NULL, NULL, NULL, NULL, 'Direktur', 'Drs. Enang Rusyana, M.Pd', '196309087087540', 'Manajer Tata Usaha', 'Ono Sugiono, S.E', '0', 'Manajer Marketing dan Registrasi', 'Esa Fauzan, S.Kom', '0', 'Manajer Pembelajaran dan Ujian', 'Arina Rubiasih, M.Pd', '0', NULL, '2025-03-07 17:05:04', NULL, 1),
('24', 'Bandung', 'Jl. Panyileukan Raya No. 1 A,\\nSoekarno-Hatta, Bandung 40614', '022-7801791, 7801792, 87820554', '022-87820556', 'bandung@ecampus.ut.ac.id', NULL, NULL, NULL, NULL, 'Direktur', NULL, NULL, 'Manajer Tata Usaha', NULL, NULL, 'Manajer Marketing dan Registrasi', NULL, NULL, 'Manajer Pembelajaran dan Ujian', NULL, NULL, NULL, '2025-03-07 17:05:04', NULL, 0),
('41', 'Purwokerto', 'Jl. Kampus No. 54 Grendeng,\\nPurwokerto 53122', '0281-624317', '0281-624318', 'ut-purwokerto@ecampus.ut.ac.id', NULL, NULL, NULL, NULL, 'Direktur', 'Dr. Prasetyarti Utami, S.Si, M.Si', NULL, 'Manajer Tata Usaha', NULL, NULL, 'Manajer Marketing dan Registrasi', 'Ismiantoro Aziis Shahrani, S.Kom', '198001282005011001', 'Manajer Pembelajaran dan Ujian', NULL, NULL, NULL, '2025-03-07 17:05:04', NULL, 0),
('42', 'Semarang', 'Jl. Raya Semarang-Kendal Km. 14,5,Mangkang Wetan,Semarang', '024-8666044', '024-8666045', 'ut-semarang@ecampus.ut.ac.id', 'semarang.ut.ac.id', '085601100042', 'universitas terbuka semarang', 'universitas terbuka semarang @utsemarang_official', 'Direktur', 'Drs. Moh. Muzammil, M.M.', '196109171987031002', 'Manajer Tata Usaha', 'Hendra Budiman, S.E.', '198102212005011002', 'Manajer Marketing dan Registrasi', 'Bambang Yulianto, S.T., M.Si.', '197407182003121001', 'Manajer Pembelajaran dan Ujian', 'Dra. Sri Sumiyati, M.M.', '196207011987032001', NULL, '2025-03-07 17:05:04', NULL, 1),
('44', 'Surakarta', 'Jl. Raya Solo-Tawangmangu Km 9,5 Mojolaban, Sukoharjo 57554', '0271-822629, 822632', '0271-822632', 'ut-surakarta@ecampus.ut.ac.id', 'https://surakarta.ut.ac.id', '081586862727', 'https://www.facebook.com/univterbukasurakarta', 'https://www.instagram.com/utsurakarta/', 'Direktur', 'Dra. Yulia Budiwati, M.Si.', '196307161991032002', 'Manajer Tata Usaha', 'Andreas Sang Aji Purbokusumo, S.E., M.Si.', '197802192006041003', 'Manajer Marketing dan Registrasi', 'Danar Kristiana Dewi, S.I.Kom., M.I.Kom.', '199102272019032020', 'Manajer Pembelajaran dan Ujian', 'Drs. Kamari, M.Pd.', '196203271987031002', NULL, '2025-03-07 17:05:04', NULL, 1),
('45', 'Yogyakarta', 'Jl. Bantul No. 81Kel. Gedongkiwo, Kec. MantrijeronYogyakarta', '0274-411463, 411464', '0274-411464', 'ut-yogyakarta@ecampus.ut.ac.id', 'yogyakarta.ut.ac.id', '081328884500', 'ut.yogyakarta', 'ut.yogyakarta', 'Direktur', 'Prof. Dr. Agus Santoso, M.Si.', '196402171993031001', 'Manajer Tata Usaha', NULL, '11986051 520230 7 101', 'Manajer Marketing dan Registrasi', 'Dhimas Setyo Nugroho, S.Par., M.M.', '19921221 201903 1 015', 'Manajer Pembelajaran dan Ujian', 'Suyatno, S.IP., M.Si.', '19740326 200812 1 003', NULL, '2025-03-07 17:05:04', NULL, 1),
('47', 'Pontianak', 'Jl. Karya Bakti,Pontianak 78121', '0561-736107, 730291, 760791', '0561-736107', 'ut-pontianak@ecampus.ut.ac.id', 'https://www.pontianak.ut.ac.id', '081345476440', 'https://www.facebook.com/UTPontianak', 'https://www.instagram.com/ut.pontianak', 'Direktur', 'Dr. Romi Siswanto, S.Sos., M.Si.', '197205022005011001', 'Manajer Tata Usaha', 'Rasiman, S.Sos., M.A.P.', '197711072005011001', 'Manajer Marketing dan Registrasi', 'Fahriansyah, S.E., M.M.', '198212042006041002', 'Manajer Pembelajaran dan Ujian', 'Dr. Einstivina Nuryandani, S.Si., M.Si.', '198303122008122004', NULL, '2025-03-07 17:05:04', NULL, 1),
('48', 'Palangka Raya', 'Jl. G. Obos Km. 3,5 No. 177,\\nPalangka Raya,\\nKalimantan Tengah 73112', '0536-3221084, 3306440', '0536-3221086', 'ut-palangkaraya@ecampus.ut.ac.id', NULL, NULL, NULL, NULL, 'Direktur', NULL, NULL, 'Manajer Tata Usaha', NULL, NULL, 'Manajer Marketing dan Registrasi', NULL, NULL, 'Manajer Pembelajaran dan Ujian', NULL, NULL, NULL, '2025-03-07 17:05:04', NULL, 0),
('49', 'Banjarmasin', 'Jl. Sultan Adam No. 128 RT 26,Banjarmasin 70122', '0511-4315675', '0511-4315671', 'banjarmasin@ecampus.ut.ac.id', 'https://banjarmasin.ut.ac.id', NULL, NULL, NULL, 'Direktur', 'Ir. Mochamad Priono, M.Si', '196404151991031003', 'Manajer Tata Usaha', 'Yudiansyah, S.H.', '197606072005011003', 'Manajer Marketing dan Registrasi', 'Yuli Triana, S.E., M.M.', '198303082006042001', 'Manajer Pembelajaran dan Ujian', 'Jumriadi, S.Sos., M.A.P.', '197704162006041002', NULL, '2025-03-07 17:05:04', NULL, 1),
('50', 'Samarinda', 'Jl. H.A.M.M. Rifaddin,\\nSamarinda Seberang 75131', '0541-7269108', '0541-7269109', 'samarinda@ecampus.ut.ac.id', NULL, NULL, NULL, NULL, 'Direktur', NULL, NULL, 'Manajer Tata Usaha', NULL, NULL, 'Manajer Marketing dan Registrasi', NULL, NULL, 'Manajer Pembelajaran dan Ujian', NULL, NULL, NULL, '2025-03-07 17:05:04', NULL, 0),
('51', 'Tarakan', 'Jl. Mulawarman No 234 Karang Anyar, Tarakan, Kalimantan Utara', '0551 - 3802846, 3802847', NULL, 'ut-tarakan@ecampus.ut.ac.id', 'tarakan.ut.ac.id', '0282210000905', 'https://www.facebook.com/univterbukatarakan/', 'https://www.instagram.com/ut_tarakan', 'Direktur', 'Jeji Muhamad Najib, S.Kom.', '197606112005011002', 'Manajer Tata Usaha', 'Fajar Adiyanti, S.E.', '119920817202307201', 'Manajer Marketing dan Registrasi', 'Achmad Sophian, S.Kom.', '198102182009121001', 'Manajer Pembelajaran dan Ujian', 'Efraim Bavo Priyana, S.Tr.Par., M.Par.', '199305072019031009', NULL, '2025-03-07 17:05:04', NULL, 1),
('71', 'Surabaya', 'Jl. Dr. Ir. H. Soekarno, No. 567, MERR Rungkut, Surabaya', NULL, NULL, 'ut-surabaya@ecampus.ut.ac.id', 'surabaya.ut.ac.id', '+628999997971', NULL, '@ut.surabaya', 'Direktur', 'Dr. Suparti, M.Pd', '196106151986032001', 'Manajer Tata Usaha', 'Drs. Agus Prabowo, S.E.', NULL, 'Manajer Marketing dan Registrasi', 'Dwianto Asmara, S.Kom.', NULL, 'Manajer Pembelajaran dan Ujian', 'Dr. Pismia Sylvi, S.Si., M.Si.', '196912281998022001', NULL, '2025-03-07 17:05:04', NULL, 0),
('74', 'Malang', 'Jl. Mayjen, Sungkono No. 9,Malang 65135', '0341-751600, 751608', '0341-751717', 'malang@ecampus.ut.ac.id', 'malang.ut.ac.id', '0813336666924', NULL, NULL, 'Direktur', NULL, NULL, 'Manajer Tata Usaha', NULL, NULL, 'Manajer Marketing dan Registrasi', NULL, NULL, 'Manajer Pembelajaran dan Ujian', NULL, NULL, NULL, '2025-03-07 17:05:04', NULL, 1),
('76', 'Jember', 'Jl. Kaliurang No. 2-A,\\nJember 68121', '0331-326444', '0331-336444', 'jember@ecampus.ut.ac.id', NULL, NULL, NULL, NULL, 'Direktur', NULL, NULL, 'Manajer Tata Usaha', NULL, NULL, 'Manajer Marketing dan Registrasi', NULL, NULL, 'Manajer Pembelajaran dan Ujian', NULL, NULL, NULL, '2025-03-07 17:05:04', NULL, 0),
('77', 'Denpasar', 'Jl. Gurita No. 11 Sesetan,\\nDenpasar 80223', '0361-720720', '0361-710606', 'ut-denpasar@ecampus.ut.ac.id', NULL, NULL, NULL, NULL, 'Direktur', NULL, NULL, 'Manajer Tata Usaha', NULL, NULL, 'Manajer Marketing dan Registrasi', NULL, NULL, 'Manajer Pembelajaran dan Ujian', NULL, NULL, NULL, '2025-03-07 17:05:04', NULL, 0),
('78', 'Mataram', 'Jl. Neuningan, Sandubaya,\\nLombok, NTB 83236', '0370-671007', '0370-671006', 'ut-mataram@ecampus.ut.ac.id', NULL, NULL, NULL, NULL, 'Direktur', NULL, NULL, 'Manajer Tata Usaha', NULL, NULL, 'Manajer Marketing dan Registrasi', NULL, NULL, 'Manajer Pembelajaran dan Ujian', NULL, NULL, NULL, '2025-03-07 17:05:04', NULL, 0),
('79', 'Kupang', 'Jl. Pulau Indah No. 6, Oesapa Barat,\\nKupang 85228', '0380-8553825', '0380-8553813', 'ut-kupang@ecampus.ut.ac.id', NULL, NULL, NULL, NULL, 'Direktur', NULL, NULL, 'Manajer Tata Usaha', NULL, NULL, 'Manajer Marketing dan Registrasi', NULL, NULL, 'Manajer Pembelajaran dan Ujian', NULL, NULL, NULL, '2025-03-07 17:05:04', NULL, 0),
('80', 'Makassar', 'Jl. Monginsidi Baru No. 7,\\nMakassar 90142', '0411-441444', '0411-466483', 'ut-makassar@ecampus.ut.ac.id', NULL, NULL, NULL, NULL, 'Direktur', NULL, NULL, 'Manajer Tata Usaha', NULL, NULL, 'Manajer Marketing dan Registrasi', NULL, NULL, 'Manajer Pembelajaran dan Ujian', NULL, NULL, NULL, '2025-03-07 17:05:04', NULL, 0),
('81', 'Majene', 'Jl. Sultan Hasanuddin No. 2 Majene', '0422-22224, 22229', '0422-22227', 'ut-majene@ecampus.ut.ac.id', NULL, NULL, NULL, NULL, 'Direktur', NULL, NULL, 'Manajer Tata Usaha', NULL, NULL, 'Manajer Marketing dan Registrasi', NULL, NULL, 'Manajer Pembelajaran dan Ujian', NULL, NULL, NULL, '2025-03-07 17:05:04', NULL, 0),
('82', 'Palu', 'Jl. Pendidikan, Jalur 2 Untad\\nTondo, Palu 94118', '0451-452228', ' 0451-452826', 'ut-palu@ecampus.ut.ac.id', NULL, NULL, NULL, NULL, 'Direktur', NULL, NULL, 'Manajer Tata Usaha', NULL, NULL, 'Manajer Marketing dan Registrasi', NULL, NULL, 'Manajer Pembelajaran dan Ujian', NULL, NULL, NULL, '2025-03-07 17:05:04', NULL, 0),
('83', 'Kendari', 'Jl. A.H. Nasution, Kelurahan Kambu\\nBundaran Anduonohu, Kendari 93232', ' 0401-3136035', '0401-3136033', 'ut-kendari@ecampus.ut.ac.id', NULL, NULL, NULL, NULL, 'Direktur', NULL, NULL, 'Manajer Tata Usaha', NULL, NULL, 'Manajer Marketing dan Registrasi', NULL, NULL, 'Manajer Pembelajaran dan Ujian', NULL, NULL, NULL, '2025-03-07 17:05:04', NULL, 0),
('84', 'Manado', 'Jl. Sam Ratulangi Raya Manado-Tomohon,\\nKec. Winangun (depan gereja GPDI Winangun)\\nManado - SULUT 95261', '0431-822292', '0431-822229', 'ut-manado@ecampus.ut.ac.id', NULL, NULL, NULL, NULL, 'Direktur', NULL, NULL, 'Manajer Tata Usaha', NULL, NULL, 'Manajer Marketing dan Registrasi', NULL, NULL, 'Manajer Pembelajaran dan Ujian', NULL, NULL, NULL, '2025-03-07 17:05:04', NULL, 0),
('85', 'Gorontalo', 'Jl. Achmad Nadjamudin No. 27,\\nKel. Dulalowo Timur, Kec. Kota Tengah,\\nKota Gorontalo 96115', '0435-831965', '0435-831964', 'ut-gorontalo@ecampus.ut.ac.id', NULL, NULL, NULL, NULL, 'Direktur', NULL, NULL, 'Manajer Tata Usaha', NULL, NULL, 'Manajer Marketing dan Registrasi', NULL, NULL, 'Manajer Pembelajaran dan Ujian', NULL, NULL, NULL, '2025-03-07 17:05:04', NULL, 0),
('86', 'Ambon', 'Jl. Woltermonginsidi Lateri,\\nAmbon 97231', '0911-361303', '0911-361304', 'ut-ambon@ecampus.ut.ac.id', NULL, NULL, NULL, NULL, 'Direktur', NULL, NULL, 'Manajer Tata Usaha', NULL, NULL, 'Manajer Marketing dan Registrasi', NULL, NULL, 'Manajer Pembelajaran dan Ujian', NULL, NULL, NULL, '2025-03-07 17:05:04', NULL, 0),
('87', 'Jayapura', 'Jl. SPG Teruna Bhakti Waena,\\nKotak pos 204 Abepura\\nJayapura Papua 99358', '0967-571447', '0967-571090', 'ut-jayapura@ecampus.ut.ac.id', NULL, NULL, NULL, NULL, 'Direktur', NULL, NULL, 'Manajer Tata Usaha', NULL, NULL, 'Manajer Marketing dan Registrasi', NULL, NULL, 'Manajer Pembelajaran dan Ujian', NULL, NULL, NULL, '2025-03-07 17:05:04', NULL, 0),
('89', 'Ternate', 'Jl. Raya Mangga Dua, Kota Ternate,\\nProv. Maluku Utara 97710', '0921-3128352', '0921-3128442', 'ut-ternate@ecampus.ut.ac.id', NULL, NULL, NULL, NULL, 'Direktur', NULL, NULL, 'Manajer Tata Usaha', NULL, NULL, 'Manajer Marketing dan Registrasi', NULL, NULL, 'Manajer Pembelajaran dan Ujian', NULL, NULL, NULL, '2025-03-07 17:05:04', NULL, 0),
('90', 'LAYANAN LUAR NEGERI ', 'Universitas Terbuka, Gedung Pelayanan Publik Lantai 2,\\nJalan Cabe Raya, Pondok Cabe, Pamulang, Tangerang Selatan 15418', '+6221-7490941 (Hunting)', '+6221-74712237', 'luarnegeri@ecampus.ut.ac.id', NULL, NULL, NULL, NULL, 'Direktur', NULL, NULL, 'Manajer Tata Usaha', NULL, NULL, 'Manajer Marketing dan Registrasi', NULL, NULL, 'Manajer Pembelajaran dan Ujian', NULL, NULL, NULL, '2025-03-07 17:05:04', NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `unit` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` int NOT NULL DEFAULT '1',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `unit`, `email_verified_at`, `password`, `active`, `deleted_at`, `remember_token`, `created_at`, `updated_at`) VALUES
(11, 'Super Admin', 'superadmin@app.com', 'Core Team', NULL, '$2y$10$mlZztQ/eR.s4Dbj754YXh.1WDFa1qDj07BPwzzH2K.KX0DjkMB4rW', 1, NULL, NULL, '2025-10-08 16:27:49', '2025-10-08 16:27:49'),
(16, 'Noormiati Z, M.A.P', 'noormiatiz@ecampus.ut.ac.id', 'UT Banjarmasin', NULL, '$2y$10$OKqV81sKljKCJvybP98.0eqIjHOn8.8UvGv6hJdAkAyDH.v5CpIeC', 1, NULL, NULL, '2025-10-17 09:33:44', '2025-10-17 09:33:44');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indexes for table `unit`
--
ALTER TABLE `unit`
  ADD PRIMARY KEY (`kode`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
