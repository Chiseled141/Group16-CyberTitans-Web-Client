-- MySQL dump 10.13  Distrib 9.6.0, for macos26.2 (arm64)
--
-- Host: localhost    Database: cyberweb
-- ------------------------------------------------------
-- Server version	9.6.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ 'fcd6de40-16ef-11f1-b96e-f083c037d37f:1-269';

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `parent_id` int DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` smallint NOT NULL DEFAULT '1' COMMENT '0 for inactive, 1 for active',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  KEY `idx-category-parent_id` (`parent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Web Development','web-development',0,'Project about website, web app, SaaS',1,'2026-03-12 03:03:31','2026-03-12 03:03:31'),(2,'Mobile App','mobile-app',0,'Applications for iOS, Android, or cross-platform',1,'2026-03-12 03:03:31','2026-03-12 03:03:31'),(3,'Desktop Software','desktop-software',0,'Software for Windows, macOS, Linux',1,'2026-03-12 03:03:31','2026-03-12 03:03:31'),(4,'AI','ai',0,'Projects related to AI, ML, or Data Science',1,'2026-03-12 03:03:31','2026-03-12 03:03:31'),(5,'IoT','iot',0,'Hardware, IoT devices, firmware, and embedded systems',1,'2026-03-12 03:03:31','2026-03-12 03:03:31'),(6,'Game Development','game-development',0,'PC, console, or mobile game projects',1,'2026-03-12 03:03:31','2026-03-12 03:03:31'),(7,'Automation Tools','automation-tools',0,'Scripts, automation tools, plugins, utilities',1,'2026-03-12 03:03:31','2026-03-12 03:03:31'),(8,'Blockchain','blockchain',0,'Blockchain, smart contracts, and crypto-related projects',1,'2026-03-12 03:03:31','2026-03-12 03:03:31'),(9,'AR VR Mixed Reality','ar-vr-mixed-reality',0,'Augmented reality, virtual reality, and mixed reality projects',1,'2026-03-12 03:03:31','2026-03-12 03:03:31'),(10,'Robotics','robotics',0,'Robotics, control systems, drones',1,'2026-03-12 03:03:31','2026-03-12 03:03:31'),(11,'Machine Learning','machine-learning',4,'Projects related to Machine Learning',1,'2026-03-12 03:03:31','2026-03-12 03:03:31'),(12,'Deep Learning','deep-learning',11,'Projects related to Deep Learning',1,'2026-03-12 03:03:31','2026-03-12 03:03:31'),(13,'Computer Vision','computer-vision',12,'Projects related to Computer Vision',1,'2026-03-12 03:03:31','2026-03-12 03:03:31');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `education`
--

DROP TABLE IF EXISTS `education`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `education` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `institution` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'School name',
  `institution_logo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'School logo',
  `institution_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'School address',
  `institution_website` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Official school website',
  `specialization` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Specialization within the degree',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Degree title (e.g. Bachelor, Master)',
  `study_mode` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Full-time, Part-time, Online',
  `thesis_title` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `thesis_url` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `start_year` varchar(12) COLLATE utf8mb4_general_ci NOT NULL,
  `end_year` varchar(12) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `graduation_date` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Exact graduation date',
  `description_html` text COLLATE utf8mb4_general_ci,
  `document_proof_url` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `gpa` decimal(4,2) DEFAULT '0.00',
  `courses` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'CourseID@#CourseName@#Content1, Content 2;CourseID@#CourseName@#Content1, Content 2',
  `activity` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT 'ActivityID@#ActivityName@#Content1, Content 2;ActivityID@#ActivityName@#Content1, Content 2',
  `achievement` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT 'AchieveID@#AchieveName@#Content1, Content 2;AchieveID@#AchieveName@#Content1, Content 2',
  `reference` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Professor Nguyen Van A@#0987654321@#Dean of Fit, Hanh University;Professor Nguyen Van B@# 0987654321@#Vice Dean of Fit, Hanh University;',
  `alumni_network_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Link to alumni profile',
  `status` smallint NOT NULL DEFAULT '1' COMMENT '0 for inactive, 1 for active',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk-education-user_id` (`user_id`),
  CONSTRAINT `fk-education-user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `education_chk_1` CHECK (((`gpa` >= 0) and (`gpa` <= 10)))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `education`
--

LOCK TABLES `education` WRITE;
/*!40000 ALTER TABLE `education` DISABLE KEYS */;
INSERT INTO `education` VALUES (1,1,'Hanoi University (HanU)','media/images/experience/hanulogo.png','Km 9, Nguyen Trai street, Dai Mo ward, Hanoi city, Vietnam','https://www.hanu.vn/','Information Technology','Bachelor','Full-time',NULL,NULL,'01/09/2014','30/06/2018','15/06/2018','During my time at university, I was heavily involved in both my academic studies and my extracurricular activities. I took a wide range of courses in computer science and related fields that gave me a solid foundation of theoretical principles and practical expertise. These courses covered important areas such as Java programming, MySQL, network security, data structures and artificial intelligence and laid the foundation for my technical skills. In addition to the courses, I actively participated in numerous academic conferences and research activities. Of particular note is my participation in presenting topics such as Mobile Malware: Attacks and Defense and Game Theory: Multi-objective Optimization at the Hanu - Kosen conference. In addition, I had the privilege of participating in the Sakura Science Exchange Program, where I worked on robotic applications, gaining invaluable hands-on experience and a deeper understanding of the real-world applications of the technology. These experiences not only strengthened my technical skills, but also instilled a strong passion for research and development. They have motivated me to pursue an academic career in which I want to contribute to advances in computer science, particularly in the areas of artificial intelligence and software development.',NULL,6.70,'AIW425@#Advanced Internet & Web Services@#;EBZ324@#E-Business@#;ENG101@#English@#IELTS B2;FIT222@#Principles of Computing@#;FIT223@#Introduction to Programming@#Java core;FIT226@#Principles of Operating systems@#;FIT324@#Data Structure and Algorithms@#;FIT325@#Principles of Programming Languages@#Java OOP, MVC;FIT327@#Computer Network@#;FIT328@#Database Systems@#MySQL, SQL Server;FIT329@#System Analysis and Design@#;FIT330@#Software Engineering@#Java MVC, Swing;FIT332@#Information Systems@#;FIT333@#Human-Computer Interaction@#;FIT334@#Network Security@#;FIT431@#Artificial Intelligence@#Prolog, Mathlab;FIT436@#Project Management@#;FIT445@#Java Technology@#;ISD421@#Information Systems Design@#;MAT201@#Calculus@#;MAT204@#Probability and Statistics@#;MAT206@#Discrete Maths@#;MAT207@#Algebra@#','122015122016001@#Hanu - Kosen Conference@#Mobile malware: Attacks and defense; 122016122016002@#Hanu - Kosen Conference@#Game theory: Multi-objective optimization; 012017012017003@#Hanu - Kosen Conference@#Build Java application for Nash equilibrium problem; 062017062017004@#SCICT 2017@#Developing Caller Identifying Application for Android Phones; 062017062017005@#SCICT 2017@#Risk Management; 102017102017006@#Sakura Science Exchange Programme 2017@#Robot and Its Application',NULL,'Dr. Trinh Bao Ngoc@#0987355xxx@#Vice Dean of Faculty of Information Technology, Hanoi University',NULL,1,'2026-03-12 03:03:31','2026-03-12 03:03:31'),(2,1,'Japan Advanced Institute of Science and Technology (JAIST)','media/images/experience/jaistlogo.png','1 Chome-1 Asahidai, Nomi, Ishikawa 923-1211, Japan','https://www.jaist.ac.jp/english/','Computer Science','Master','Full-time','Hands-on Training for Mitigating Web Application Vulnerabilities','https://dspace.jaist.ac.jp/dspace/bitstream/10119/18734/5/paper.pdf','01/09/2022','30/09/2023','22/09/2023','In earning the master\'s degree, the focus was on developing a solid foundation in advanced computational theories, algorithms and cybersecurity principles. Key areas of expertise include optimization techniques, machine learning, game theory and coding theory, as well as a deep understanding of network security and software design methods. The practical application of these skills was demonstrated in the NEC Attack Scripting project, which involved analyzing and developing real-world security solutions. The final project focused on cybersecurity, specifically the <a href=\'https://dspace.jaist.ac.jp/dspace/bitstream/10119/18734/5/paper.pdf\' class=\'text-decoration-none\' target=\'_blank\'>Hands-on Training for Mitigating Web Application Vulnerabilities</a>, which not only deepened knowledge of security protocols, but also provided hands-on experience in remediating critical vulnerabilities in web applications. This academic journey provided comprehensive skills in both theoretical foundations and practical implementation, preparing for future contributions to the field of cybersecurity and beyond.','https://dspace.jaist.ac.jp/dspace/bitstream/10119/18734/5/paper.pdf',0.00,'G213@#Social Problems in Modern Japan@#;I116E@#Fundamentals of Programming@#Python Programming;I214E@#System Optimization@#Linear Programming, Network Optimization, Nonlinear Programming, Combinatorial Optimization, System Optimization;I219E@#Software Design Methodology@#Java OOP Design;I226E@#Computer Network@#;I232E@#Information Theory@#Entropy, Mutual Information and Divergence, Source Coding, Channel Coding, Gaussian Channel, Rate Distortion, Optimization;I235E@#Game Informatics@#Game History, Game Theory, Chips Challenging, Consensus in Games, Game Refinement, Motion in mind, Disruptive AI, Clustering, Single-Agent Search, Machine Learning, Procedural Content Generation;I239E@#Machine Learning@#;I437E@#Coding Theory@#Error Correcting Code, Abstract Algebra, Lattice, Quantization, Nested Lattice codes, Linear Block codes, Decoding Linear Block codes, Low-density Parity Check, Polar codes;I470@#Theory of Advanced Algorithms@#;S101@# Innovation Theory and Methodology for Social Competencies@#;S102@#Innovation Theory and Methodology for Creativity@#',NULL,NULL,'Assoc. Prof. Razvan Beuran@#https://www.jaist.ac.jp/~razvan/@#Japan Advanced Institute of Science and Technology (JAIST), in Ishikawa prefecture, Japan',NULL,1,'2026-03-12 03:03:31','2026-03-12 03:03:31'),(3,1,'Hanoi University (HanU)','media/images/experience/hanulogo.png','Km 9, Nguyen Trai street, Dai Mo ward, Hanoi City, Vietnam','https://www.hanu.vn','English Pedagogy','Bachelor','Part-time',NULL,NULL,'01/12/2024',NULL,NULL,NULL,'https://www.hanu.vn/a/162739/Ket-qua-tuyen-sinh-bang-dai-hoc-thu-hai-nganh-Ngon-ngu-Anh-va-Ngon-ngu-Trung-Quoc-dot-2-nam-2024',0.00,'63ENG3GR1@#English Grammar 1;63ENG3LEX@#English Lexicology;63ENG3PHP@#English Phonetics and Phonology;63ENG3TE1@#English Language Teaching Methodology 1;63ENG4PLT@#Psychology in Language Teaching;63ENG2C1@#Language skills C1;63ENG3RES@#Research Methods;63ENG3SLT@#Language Acquisition Theories;63VIP1INL@#Introduction to Linguistics;63VIP1IVC@#Fundamentals of Vietnamese Culture;63VIP2HWC@#History of World Civilization;63VIP2IVL@#Introductory Vietnamese Linguistics;63VIP2VIU@#Vietnamese in Use;63ENG1A2@#Language skills A2;63ENG1B1@#Language skills B1;63ENG1STS@#Study skills;63ENG2B2@#Language skills B2;63FIT1CSK@#Computer Skills;63NDE1NDS@#National Defence & Security Education;63PED1MDR@#Middle-Distance Running;63PED1PP1@#Pingpong 1;63PED1PP2@#Pingpong 2;63PML1PML@#Philosophy of Marxism-Leninism;63PML1POE@#Political Economics Marxism-Leninism;63PML2GEL@#General Law;63PML2HVC@#History of Vietnam Communist Party;63PML2SCS@#Scientific Socialism;63PML3HCM@#Ho Chi Minh Ideology',NULL,NULL,NULL,NULL,1,'2026-03-12 03:03:31','2026-03-12 03:03:31'),(4,1,'Posts and Telecommunications Institute of Technology (PTIT)','media/images/experience/ptitlogo.png','96A, Tran Phu street, Mo Lao ward, Hanoi city, Vietnam','https://www.ptit.edu.vn','Information System','Doctor','Full-time',NULL,NULL,'01/09/2025',NULL,NULL,NULL,NULL,0.00,'None',NULL,NULL,NULL,NULL,1,'2026-03-12 03:03:31','2026-03-12 03:03:31'),(5,2,'Hanoi University (HanU)','media/images/experience/hanulogo.png','Km 9, Nguyen Trai street, Dai Mo ward, Hanoi city, Vietnam','https://www.hanu.vn','Information Technology','Bachelor','Full-time',NULL,NULL,'01/09/2021','30/06/2025','05/06/2025','Studied core and advanced topics in Information Technology, including algorithms, data structures, software engineering, and artificial intelligence. Participated in multiple research projects and collaborative software development initiatives, gaining hands-on experience in problem-solving, coding, and technical documentation. Actively engaged in academic and extracurricular activities such as mentoring junior students in programming and algorithms, participating in the Sakura Science Club (JST), and volunteering in community events.','https://drive.google.com/drive/folders/14euNclzvZou5fOHyxLMblNR-zAYcRgLB',3.24,'61FIT2CAL@#Calculus@#;61FIT2PR1@#Programming 1@#Java Core;61FIT2PR2@#Programming 2@#Java Advanced;61FIT2AIN@#Artificial Intelligence@#Statistics and Probability, Natural Language Processing, Python;61FIT2POP@#Principle of Operation@#Operations, Linux Ubuntu, C++;61FIT2DSA@#Data Structures and Algorithms@# Stack, Queue, Graph, Tree, Search algorithms, Sort algorithms;61FIT2SE1@#Software Engineering 1@#Java Spring MVC, XAMPP;61FIT2SE2@#Software Engineering 2@#Java Spring and Test;61FIT2SAD@#System Analysis and Design@#Agile, Waterfall, UX/UI, Figma;61FIT2WPR@#Web Programming@#HTML5, CSS3, Javascript ES6, ReactJS, NodeJS, ExpressJS;61FIT2SS1@#Special Subject 1@#Game Theory, Stable Matching, Computer Vision;61FIT2SS2@#Special Subject 2@#Game Theory, Stable Matching, Computer Vision;','082023122026001@#Cyb3r T1tans Club@#IT Mentor;052024062025002@#Mentorship Program@#Mentor for junior students in programming and algorithms;062025062025003@#Sakura Science Club (JST)@#Participant in international exchange activities;072025072025004@#Volunteer Program@#Blood Donation Campaign Volunteer','Second Prize at the Faculty-level Scientific Research Conference','Dr. Trinh Bao Ngoc@#0987355xxx@#Vice Dean of Faculty of Information Technology, Hanoi University',NULL,1,'2026-03-12 03:03:31','2026-03-12 03:03:31');
/*!40000 ALTER TABLE `education` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `login_attempt`
--

DROP TABLE IF EXISTS `login_attempt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `login_attempt` (
  `id` int NOT NULL AUTO_INCREMENT,
  `key` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `amount` int DEFAULT '1',
  `reset_at` int DEFAULT NULL,
  `updated_at` int DEFAULT NULL,
  `created_at` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `login_attempt_key_index` (`key`),
  KEY `login_attempt_amount_index` (`amount`),
  KEY `login_attempt_reset_at_index` (`reset_at`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login_attempt`
--

LOCK TABLES `login_attempt` WRITE;
/*!40000 ALTER TABLE `login_attempt` DISABLE KEYS */;
INSERT INTO `login_attempt` VALUES (1,'b776506e5a54fba04cb2f02f14a9e95259a6e141',2,1773286081,1773285781,1773285690),(2,'32d03988aa7e104382eef0432cc59e34bb6e82d4',2,1773286590,1773286290,1773286280),(3,'0f8a22b3857847ce31dc25cf23a13fc456643f88',1,1773286625,1773286325,1773286325),(4,'f6c4ca7cb5a56b39465390cf019ab866fe3189e0',1,1773286778,1773286478,1773286478);
/*!40000 ALTER TABLE `login_attempt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mentorship_request`
--

DROP TABLE IF EXISTS `mentorship_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mentorship_request` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mentee_id` int NOT NULL,
  `team_id` int NOT NULL,
  `topic` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `mode` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Eg. online, offline, async, ...',
  `duration_minutes` int NOT NULL,
  `offering_fee` int DEFAULT NULL COMMENT 'mentee offers an amount to mentor',
  `agreed_fee` int DEFAULT NULL,
  `currency_unit` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `tracking` int NOT NULL DEFAULT '0',
  `payment_status` int NOT NULL DEFAULT '0',
  `scheduled_at` datetime NOT NULL,
  `note` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` smallint NOT NULL DEFAULT '1' COMMENT '0 for inactive, 1 for active',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_mentorship_request_team` (`team_id`),
  KEY `fk_mentorship_request_payment_status` (`tracking`),
  KEY `idx_unique_mentee_team_schedule` (`mentee_id`,`team_id`,`scheduled_at`),
  CONSTRAINT `fk_mentorship_request_mentee` FOREIGN KEY (`mentee_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_mentorship_request_payment_status` FOREIGN KEY (`tracking`) REFERENCES `order_status` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_mentorship_request_team` FOREIGN KEY (`team_id`) REFERENCES `team` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_mentorship_request_tracking` FOREIGN KEY (`tracking`) REFERENCES `order_status` (`id`) ON DELETE CASCADE,
  CONSTRAINT `mentorship_request_chk_1` CHECK ((`duration_minutes` > 0)),
  CONSTRAINT `mentorship_request_chk_2` CHECK ((`offering_fee` >= 0)),
  CONSTRAINT `mentorship_request_chk_3` CHECK ((`agreed_fee` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mentorship_request`
--

LOCK TABLES `mentorship_request` WRITE;
/*!40000 ALTER TABLE `mentorship_request` DISABLE KEYS */;
INSERT INTO `mentorship_request` VALUES (1,9,2,'asd','xa','online',50,NULL,NULL,'0',1,9,'2026-03-13 10:30:00',NULL,1,'2026-03-12 03:25:12','2026-03-12 03:25:12');
/*!40000 ALTER TABLE `mentorship_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migration`
--

DROP TABLE IF EXISTS `migration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migration` (
  `version` varchar(180) COLLATE utf8mb4_general_ci NOT NULL,
  `apply_time` int DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migration`
--

LOCK TABLES `migration` WRITE;
/*!40000 ALTER TABLE `migration` DISABLE KEYS */;
INSERT INTO `migration` VALUES ('m000000_000000_base',1773285332),('m130523_110633_create_role_table',1773285335),('m130524_201442_init',1773285335),('m130721_072944_create_order_status_table',1773285335),('m171222_093021_login_attempt',1773285335),('m250715_104705_create_publication_type_table',1773285335),('m250715_110023_create_publication_table',1773285335),('m250719_101256_create_team_table',1773285335),('m250719_103949_create_mentorship_request_table',1773285335),('m250730_110142_create_policy_faq_table',1773285335),('m250807_112706_create_education_table',1773286206),('m250809_051930_create_user_experience_table',1773286206),('m250814_121442_create_category_table',1773286206),('m250814_122216_create_project_table',1773286206);
/*!40000 ALTER TABLE `migration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_status`
--

DROP TABLE IF EXISTS `order_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `label` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `slug` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'group + code',
  `group` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'workflow, payment,... in system constants',
  `description` text COLLATE utf8mb4_general_ci,
  `status` smallint NOT NULL DEFAULT '1' COMMENT '0 for inactive, 1 for active',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_status`
--

LOCK TABLES `order_status` WRITE;
/*!40000 ALTER TABLE `order_status` DISABLE KEYS */;
INSERT INTO `order_status` VALUES (1,'pending','workflow pending','workflow','Waiting for approval or payment',1,'2026-03-12 03:03:46','2026-03-12 03:03:46'),(2,'accepted','workflow accepted','workflow','Request is accepted',1,'2026-03-12 03:03:46','2026-03-12 03:03:46'),(3,'rejected','workflow rejected','workflow','Request is declined',1,'2026-03-12 03:03:46','2026-03-12 03:03:46'),(4,'cancelled','workflow cancelled','workflow','Request was cancelled by user',1,'2026-03-12 03:03:46','2026-03-12 03:03:46'),(5,'in_progress','workflow in_progress','workflow','Mentoring session is currently happening',1,'2026-03-12 03:03:46','2026-03-12 03:03:46'),(6,'completed','workflow completed','workflow','Session completed successfully',1,'2026-03-12 03:03:46','2026-03-12 03:03:46'),(7,'no_show','workflow no_show','workflow','Mentee did not show up',1,'2026-03-12 03:03:46','2026-03-12 03:03:46'),(8,'expired','workflow expired','workflow','Request expired before confirmation',1,'2026-03-12 03:03:46','2026-03-12 03:03:46'),(9,'unpaid','payment unpaid','payment','No payment has been made',1,'2026-03-12 03:03:46','2026-03-12 03:03:46'),(10,'paid','payment paid','payment','Full payment received',1,'2026-03-12 03:03:46','2026-03-12 03:03:46'),(11,'partial','payment partial','payment','Partial payment received',1,'2026-03-12 03:03:46','2026-03-12 03:03:46'),(12,'refunded','payment refunded','payment','Payment has been refunded',1,'2026-03-12 03:03:46','2026-03-12 03:03:46'),(13,'failed','payment failed','payment','Payment could not be processed',1,'2026-03-12 03:03:46','2026-03-12 03:03:46'),(14,'pending_payment','payment pending_payment','payment','Awaiting payment completion',1,'2026-03-12 03:03:46','2026-03-12 03:03:46');
/*!40000 ALTER TABLE `order_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `policy`
--

DROP TABLE IF EXISTS `policy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `policy` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `content` text COLLATE utf8mb4_general_ci,
  `content_html` text COLLATE utf8mb4_general_ci,
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'policy or FAQ',
  `category` smallint DEFAULT NULL,
  `version` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` smallint NOT NULL DEFAULT '1' COMMENT '0 for inactive, 1 for active',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  CONSTRAINT `policy_chk_1` CHECK ((`category` >= 1))
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `policy`
--

LOCK TABLES `policy` WRITE;
/*!40000 ALTER TABLE `policy` DISABLE KEYS */;
INSERT INTO `policy` VALUES (1,'Information We Collect','information-we-collect',NULL,'<ul class=\"list-group list-group-flush\"><li class=\"list-group-item\"><i class=\"fab fa-odnoklassniki-square me-2\"></i>Name, email, and contact details <small>(if you sign up or submit a form)</small>.</li><li class=\"list-group-item\"><i class=\"fab fa-odnoklassniki-square me-2\"></i>IP address, browser type, pages visited, and time of access <small>(via Google Analytics or similar)</small>.</li><li class=\"list-group-item\"><i class=\"fab fa-odnoklassniki-square me-2\"></i>OAuth login data <small>(if you use Google, GitHub, or LinkedIn to sign in)</small>.</li></ul>','0',1,'v1.0',1,'2026-03-12 03:03:46','2026-03-12 03:03:46'),(2,'How We Use Your Information','how-we-use-your-information',NULL,'<ul class=\"list-group list-group-flush\"><li class=\"list-group-item\"><i class=\"fab fa-odnoklassniki-square me-2\"></i>To authenticate users and grant access.</li><li class=\"list-group-item\"><i class=\"fab fa-odnoklassniki-square me-2\"></i>To send notifications, technical support, and system updates.</li><li class=\"list-group-item\"><i class=\"fab fa-odnoklassniki-square me-2\"></i>To analyze user behavior for improving our platform and services.</li></ul>','0',1,'v1.0',1,'2026-03-12 03:03:46','2026-03-12 03:03:46'),(3,'Data Sharing','data-sharing',NULL,'We do <b>NOT</b> sell or share your personal data with third parties unless:<ul class=\"list-group list-group-flush\"><li class=\"list-group-item\"><i class=\"fab fa-odnoklassniki-square me-2\"></i>Required by law.</li><li class=\"list-group-item\"><i class=\"fab fa-odnoklassniki-square me-2\"></i>You have given explicit consent.</li><li class=\"list-group-item\"><i class=\"fab fa-odnoklassniki-square me-2\"></i>Necessary for providing essential services (e.g., OAuth login with Google/GitHub).</li></ul>','0',1,'v1.0',1,'2026-03-12 03:03:46','2026-03-12 03:03:46'),(4,'Data Security','data-security',NULL,'<ul class=\"list-group list-group-flush\"><li class=\"list-group-item\"><i class=\"fab fa-odnoklassniki-square me-2\"></i>All data is encrypted and stored securely.</li><li class=\"list-group-item\"><i class=\"fab fa-odnoklassniki-square me-2\"></i>We apply modern security measures against threats such as CSRF, XSS, and SQL Injection.</li></ul>','0',1,'v1.0',1,'2026-03-12 03:03:46','2026-03-12 03:03:46'),(5,'Your Rights','your-rights',NULL,'<ul class=\"list-group list-group-flush\"><li class=\"list-group-item\"><i class=\"fab fa-odnoklassniki-square me-2\"></i>You can request to view, edit, or delete your personal data at any time.</li><li class=\"list-group-item\"><i class=\"fab fa-odnoklassniki-square me-2\"></i>You may refuse to provide certain data, but this might limit access to some features.</li></ul>','0',1,'v1.0',1,'2026-03-12 03:03:46','2026-03-12 03:03:46'),(6,'Do I need an account to use Cyb3r Web?','do-i-need-an-account-to-use-cyb3r-web?','No, but signing in with Google, GitHub, or LinkedIn gives you access to personalized features and full functionality.',NULL,'1',1,'v1.0',1,'2026-03-12 03:03:46','2026-03-12 03:03:46'),(7,'Can I delete my account?','can-i-delete-my-account?','Yes. You can request account deletion by contacting our admins',NULL,'1',1,'v1.0',1,'2026-03-12 03:03:46','2026-03-12 03:03:46'),(8,'I’m having trouble logging in with Google/GitHub,... What should I do?','i’m-having-trouble-logging-in-with-google/github,...-what-should-i-do?','Please try again after a few minutes or check your browser settings. If the problem persists, contact our technical support team.',NULL,'1',1,'v1.0',1,'2026-03-12 03:03:46','2026-03-12 03:03:46');
/*!40000 ALTER TABLE `policy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project`
--

DROP TABLE IF EXISTS `project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `image` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `technologies` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Technologies by CSV',
  `price` decimal(15,2) NOT NULL DEFAULT '0.00',
  `coin_price` int NOT NULL DEFAULT '0',
  `currency_unit` varchar(10) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'USD',
  `category_id` int NOT NULL,
  `views` int NOT NULL DEFAULT '0',
  `rating_avg` decimal(3,2) NOT NULL DEFAULT '0.00',
  `rating_count` int NOT NULL DEFAULT '0',
  `code_file` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Path or URL to source code file',
  `report_file` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Path or URL to report file',
  `research_file` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Path or URL to research file',
  `file_package` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Path or URL to packaged ZIP',
  `demo_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Path or URL to demo video',
  `download_policy` smallint NOT NULL DEFAULT '0' COMMENT '0 = No download, 1 = Allow if coin >= coin_price, 2 = Admin approval required',
  `download_count` int NOT NULL DEFAULT '0',
  `team_id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `published_at` varchar(12) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user_id` int NOT NULL COMMENT 'admin create or update any fields',
  `status` smallint NOT NULL DEFAULT '1' COMMENT '0 for inactive, 1 for active',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  KEY `idx-project-category_id` (`category_id`),
  KEY `idx-project-team_id` (`team_id`),
  KEY `idx-project-user_id` (`user_id`),
  CONSTRAINT `fk-category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project`
--

LOCK TABLES `project` WRITE;
/*!40000 ALTER TABLE `project` DISABLE KEYS */;
INSERT INTO `project` VALUES (1,'I am a Developer','i-am-a-developer','An application built by React Native that simulates the life of a developer from his/her born to his/her death','media/images/projects/mobile-application.png','React Native, Firebase',800.00,5000,'2',1,9527,4.50,86,NULL,NULL,NULL,NULL,NULL,1,108,'1,2','19/08/2024',1,1,'2026-03-12 03:03:31','2026-03-12 03:03:31'),(2,'I am a Developer 2','i-am-a-developer-2','An application built by React Native that simulates the life of a developer from his/her born to his/her death','media/images/projects/mobile-application.png','Android, iOS',700.00,4500,'2',9,9528,4.90,86,NULL,NULL,NULL,NULL,NULL,1,108,'1,2','19/09/2024',1,1,'2026-03-12 03:03:31','2026-03-12 03:03:31'),(3,'I am a Developer 3','i-am-a-developer-3','An application built by React Native that simulates the life of a developer from his/her born to his/her death','media/images/projects/mobile-application.png','Yii2 Advanced',900.00,5500,'2',1,9500,4.40,86,NULL,NULL,NULL,NULL,NULL,1,108,'1,2','19/08/2025',1,1,'2026-03-12 03:03:31','2026-03-12 03:03:31'),(4,'I am a Developer 4','i-am-a-developer-4','An application built by React Native that simulates the life of a developer from his/her born to his/her death','media/images/projects/mobile-application.png','Spring Boot, Hibernate, NoSQL',900.00,5000,'2',1,9530,3.20,86,NULL,NULL,NULL,NULL,NULL,1,108,'1,2','18/08/2024',1,1,'2026-03-12 03:03:31','2026-03-12 03:03:31');
/*!40000 ALTER TABLE `project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publication`
--

DROP TABLE IF EXISTS `publication`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `publication` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `feature_image` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `authors` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `abstract` text COLLATE utf8mb4_general_ci NOT NULL,
  `keyword` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `type` smallint NOT NULL,
  `volume` int DEFAULT NULL,
  `number` smallint DEFAULT NULL,
  `pages` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `year` int NOT NULL,
  `team_abbr` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `journal` text COLLATE utf8mb4_general_ci,
  `publisher` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'publication venue',
  `editor` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Editor of the work (used in books, proceedings)',
  `book_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Title of the book or proceedings',
  `school` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'University for thesis entries',
  `institution` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Institution for tech reports',
  `note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Additional notes or remarks',
  `isbn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'ISBN for books/e-books',
  `issn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'ISSN for articles',
  `doi` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Digital Object Identifier',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'URL to the publication',
  `url_date` date DEFAULT NULL COMMENT 'Date the URL was accessed',
  `how_published` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Form of publication (used in misc or online)',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Publisher''s location',
  `edition` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Edition of the book',
  `series` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Series the book or proceedings belongs to',
  `team_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'IDs of active users, separated by comma',
  `status` smallint NOT NULL DEFAULT '1' COMMENT '0 for inactive, 1 for active',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publication`
--

LOCK TABLES `publication` WRITE;
/*!40000 ALTER TABLE `publication` DISABLE KEYS */;
INSERT INTO `publication` VALUES (1,'Hands-on Training for Mitigating Web Application Vulnerabilities.','hands-on-training-for-mitigating-web-application-vulnerabilities.','media/images/publications/cyber-theses-jaist.png','Ngo Van Quyen, Razvan Beuran','Web applications are becoming increasingly complex and interconnected, making them more vulnerable to attack. In 2022, web application attacks accounted for about 56% of all data breaches. This is due to the fact that web applications are often developed using frameworks that contain security vulnerabilities that are known to hackers. One of the most popular frameworks to build web applications is the Yii2 PHP Framework. Yii2 is a free and open-source framework that is used by millions of developers worldwide. It is also a very secure framework, and it has been penetration tested by a number of security experts. However, there are still some vulnerabilities, such as those caused accidentally or unknowingly by developers, that need to be mitigated. Mitigating web application vulnerabilities can be approached in several ways. One approach is to use automated tools to scan for vulnerabilities. However, these tools can only find known vulnerabilities, and they often miss new or zero-day vulnerabilities. Another approach is to use manual security testing. This involves having a security expert manually test the application for vulnerabilities. However, manual security testing is a time-consuming and expensive process. A third approach is to use hands-on training. This involves training developers on how to identify and fix vulnerabilities in web applications. Hands-on training should be used as a complement to automated tools or manual security testing, as it teaches developers secure development practices with an attacker perspective. CyPROM is a scenario progression management system for cybersecurity training that allows instructors to define training scenarios and provide target information. The management module of CyPROM uses a set of processes to drive the execution of those scenarios in the training environment. This enables conducting hands-on training in which trainees can actively engage in simulated cyberattacks, forensic investigations, and defensive measures. Thus, they can actively participate in realistic cyber exercises, gaining practical experience in dealing with cybersecurity challenges. By simulating attack scenarios, trainees can develop skills in identifying vulnerabilities, detecting and responding to threats, and implementing defensive measures. The research presented in this thesis is an endeavor focused on bolstering the security characteristics of web applications by conducting a meticulous analysis of the Yii2 framework while drawing upon the reputable OWASP Top Ten as a fundamental reference. The OWASP Top Ten, developed and maintained by the Open Web Application Security Project (OWASP) Foundation, plays a crucial role in promoting awareness about the most critical security risks faced by web applications. By attentively examining the 2021 updates and trends outlined in the OWASP Top Ten, our research ensured a comprehensive approach to addressing the most pressing threats to web application security. In particular, vulnerabilities within the Yii2 framework were identified and carefully evaluated for their potential impact on web applications, leveraging insights from the OWASP Top Ten. A significant contribution of our research lies in providing a thorough assessment of web applications built on Yii2, aligning the results with industry-accepted security standards, and offering effective strategies to enhance web application security. This was achieved by extending the functionality of CyPROM via a custom module specifically designed for analyzing web applications. Extending CyPROM required a careful understanding of the intricacies of the Yii2 framework and its underlying architecture. We conducted a thorough analysis of the framework’s source code, libraries, and dependencies to identify potential areas vulnerable to security threats. The process required reverse engineering and static code analysis to gain comprehensive insights into the framework’s security posture. After gaining a comprehensive understanding of the Yii2 framework, the CyPROM extension development commenced, entailing an in-depth investigation that surpassed mere vulnerability identification. The focus extended to crafting a specialized hands-on training program using CyPROM, tailored explicitly to address the identified vulnerabilities, accompanied by a strategic approach to tackling each security concern. The training program provided a set of systematically implemented actions and scenarios, empowering web developers with practical knowledge to proficiently secure their web applications. This included rules and heuristics inspired by the OWASP Top Ten, targeting prevalent security issues commonly encountered in web applications. Through the incorporation of this extension, CyPROM facilitated automated security assessments, bolstering the security not only of Yii2-based web applications but also laying the groundwork for enhancing the security posture of other frameworks. The extension of CyPROM was assessed comprehensively via functionality evaluation, comparative analysis of implemented actions and scenarios, and user evaluation. Overall the enhanced CyPROM demonstrated significant coverage in addressing specific vulnerabilities in web applications, with notable strengths in dealing with Broken Access Control (3.36 out of 5), Identification and Authentication Failures (3.27 out of 5), and Cryptographic Failures (3.18 out of 5). The evaluation result, determined based on 2 trainees’ feedback obtained during training sessions, estimates the capability of the enhanced CyPROM to handle these critical categories. In addition, the assessment also revealed areas that need further improvement to increase overall effectiveness in addressing other vulnerabilities. Even so, participants appreciated the clarity and conciseness of the training, which enabled them to apply their newly acquired knowledge in a real-life environment. The positive feedback from users underscored the practical value and real-world relevance of our research findings. Efforts to increase coverage in areas where CyPROM is currently less effective will help improve its capabilities. This research serves as a valuable resource for developers and security professionals, aiding them in fortifying the integrity of web applications by highlighting vulnerabilities, benchmarking against the OWASP Top Ten, and conducting a comprehensive evaluation of Yii2-based projects.','web application vulnerabilities, hands-on training, vulnerability mitigation, CyPROM, Yii2 PHP Framework, OWASP Top Ten',6,NULL,NULL,NULL,2023,'Ngo Van Quyen',NULL,NULL,NULL,NULL,'Japan Advanced Institute of Science and Technology (JAIST)',NULL,NULL,NULL,NULL,NULL,'https://dspace02.jaist.ac.jp/dspace/bitstream/10119/18734/5/paper.pdf',NULL,NULL,NULL,NULL,NULL,'1',1,'2026-03-12 03:03:46','2026-03-12 03:03:46'),(2,'Application of NASH equilibrium-based approach in solving the risk responses conflicts','application-of-nash-equilibrium-based-approach-in-solving-the-risk-responses-conflicts','media/images/publications/largepreview.png','Bao-Ngoc Trinh, Quyet-Thang Huynh, Xuan-Thang Nguyen, Van-Quyen Ngo, Thanh-Trung Vu','The responses to a given risk reflect the risk assessment and the organization\'s attitude to risk, response method to risk can cause a problem to the response method of another risk. Therefore, the project manager cannot decide which risk response will be used in case of conflicts happen. Until now, the amount of research which deals with risk responses is count-on-finger. This paper proposes a model and the algorithm to resolve this conflict. The problem-solving model introduced below will base on Project Network and Game Theory, in which players of the game are risks, and the solution of this game is a Nash Equilibrium. The input information of the game will be described in the Project Network model, which can be used later in a Genetic Algorithm. The chromosome model of Genetic Algorithm is a Nash Equilibrium of the game whereas providing the balance in selecting a response method to each risk.','Game theory, Project network, Risk response, Nash equilibrium, Genetic algorithm',1,193,NULL,'17-31',2018,'Van-Quyen Ngo','Journal of Science and Technology (JST)','Le Quy Don Technical University - Section on Information and Communication Technology (LQDTU-JICT)',NULL,NULL,NULL,NULL,NULL,NULL,'859-0209',NULL,'https://www.researchgate.net/publication/329962461_APPLICATION_OF_NASH_EQUILIBRIUM_BASED_APPROACH_IN_SOLVING_THE_RISK_RESPONSES_CONFLICTS',NULL,NULL,NULL,NULL,NULL,'1',1,'2026-03-12 03:03:46','2026-03-12 03:03:46'),(3,'My Journey to Japan','my-journey-to-japan','media/images/publications/20220222-1.jpg','Ngo Van Quyen','None','None',10,NULL,NULL,NULL,2023,'Ngo Van Quyen',NULL,'Japan Science and Technology Agency (JST)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'https://ssp.jst.go.jp/sns/abroad/mayway/20230222_1.html','2025-07-15',NULL,NULL,NULL,NULL,'1',1,'2026-03-12 03:03:46','2026-03-12 03:03:46'),(4,'Transforming machine translation for isolating languages with multi-source neural model','transforming-machine-translation-for-isolating-languages-with-multi-source-neural-model','media/images/publications/54920e.jpg','Nguyen Ngoc Lan, Trinh Bao Ngoc, Le Phuong Thao, Nguyen Thanh Cong, Le Manh Toan, Tran Dinh Dien, Bui Phan Tue Anh, Vuong Thi Van, Nguyen Nhat Trang, Nguyen Tien Thanh','Recent advancements in Artificial intelligence (AI) and Deep learning have facilitated the rapid development of machine translation technologies, among them, Neural machine translation (NMT) models have demonstrated impressive performance, especially in handling multiple language pairs. However, due to their complexity and lack of appropriate data, contemporary NMT models still have a lot of challenges when applied to isolated languages, despite their great accomplishments. This paper proposes a multi-source neural model that employs two different encoders to process both the source word sequence and the linguistic feature sequences of isolating languages. Unlike traditional NMT models, this approach improves the encoders’ input embeddings by incorporating a second encoder that integrates the linguistic elements, including part-of-speech (POS) tags and lemma. To enhance the source sentence\'s context representation, this article combines the encoders\' conditional data with the outputs of the decoders using a serial combination technique. In this way, different metrics such as METEOR and BLEU are examined to assess the suggested model\'s precision of translation. Experimental results indicate that our methodology works efficiently for isolating language translation, as evidenced by the improvement of +3.9 BLEU and +3.2 METEOR scores on translation tasks conventional NMT models perform. This highlights a significant advancement in integrating linguistic features to enhance translation accuracy for isolating languages.','Artificial Intelligence, Neural Machine Translation, Linguistic Features, Isolated Language, BLEU, METEOR',1,103,NULL,'835-847',2025,'Le Manh Toan','Journal of Theoretical and Applied Information Technology (JATIT)','Little Lion Scientific',NULL,NULL,NULL,NULL,NULL,NULL,'1992-8645',NULL,'https://www.jatit.org/volumes/Vol103No3/5Vol103No3.pdf','2025-08-08',NULL,NULL,NULL,NULL,'2',1,'2026-03-12 03:03:31','2026-03-12 03:03:31');
/*!40000 ALTER TABLE `publication` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publication_type`
--

DROP TABLE IF EXISTS `publication_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `publication_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `icon` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `note` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` smallint NOT NULL DEFAULT '1' COMMENT '0 for inactive, 1 for active',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publication_type`
--

LOCK TABLES `publication_type` WRITE;
/*!40000 ALTER TABLE `publication_type` DISABLE KEYS */;
INSERT INTO `publication_type` VALUES (1,'Journal Articles','article','fas fa-file-alt','Peer-reviewed papers published in academic journals. Typically include author(s), title, journal name, volume, number, pages, and year.',1,'2026-03-12 03:03:46','2026-03-12 03:03:46'),(2,'Books & Monographs','book','fas fa-book','Complete, published books authored by one or more individuals. Include publisher, year, and optionally ISBN.',1,'2026-03-12 03:03:46','2026-03-12 03:03:46'),(3,'Book Chapters','incollection','fas fa-book-open','Chapters within an edited book. Usually include author(s), chapter title, book title, editors, publisher, and page range.',1,'2026-03-12 03:03:46','2026-03-12 03:03:46'),(4,'Conference Papers','inproceedings','fas fa-chalkboard-teacher','Individual papers presented at conferences and published in proceedings. Common in computer science and engineering.',1,'2026-03-12 03:03:46','2026-03-12 03:03:46'),(5,'Proceedings','proceedings','fas fa-handshake','Full conference proceedings as a publication, often edited volumes compiling all accepted papers.',1,'2026-03-12 03:03:46','2026-03-12 03:03:46'),(6,'Master’s Theses','mastersthesis','fas fa-user-graduate','Graduate-level research works submitted to earn a Master’s degree. Include author, title, institution, and year.',1,'2026-03-12 03:03:46','2026-03-12 03:03:46'),(7,'PhD Theses','phdthesis','fas fa-user-ninja','Doctoral dissertations submitted for a PhD degree. Typically longer and more in-depth than Master’s theses.',1,'2026-03-12 03:03:46','2026-03-12 03:03:46'),(8,'Technical Reports','techreport','fas fa-tools','Research or project reports issued by institutions, labs, or companies. May be published internally or publicly.',1,'2026-03-12 03:03:46','2026-03-12 03:03:46'),(9,'Unpublished Works','unpublished','fas fa-question-circle','Works not formally published but possibly circulated informally, such as drafts, preprints, or working papers.',1,'2026-03-12 03:03:46','2026-03-12 03:03:46'),(10,'Online Resources','online','fas fa-globe','Web-based materials such as websites, online articles, datasets, blog posts, or videos. Typically include author, title, URL, and access date.',1,'2026-03-12 03:03:46','2026-03-12 03:03:46'),(11,'Miscellanea','misc','fas fa-ellipsis-h','A catch-all category for items that don’t fit standard types—includes websites, presentations, datasets, blog posts, online documents, etc.',1,'2026-03-12 03:03:46','2026-03-12 03:03:46');
/*!40000 ALTER TABLE `publication_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `level` int DEFAULT '1',
  `status` smallint NOT NULL DEFAULT '1' COMMENT '0 for inactive, 1 for active',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  UNIQUE KEY `level` (`level`),
  CONSTRAINT `role_chk_1` CHECK ((`level` >= 1))
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'Super Admin','super-admin',1,1,'2026-03-12 03:03:43','2026-03-12 03:03:43'),(2,'Admin','admin',2,1,'2026-03-12 03:03:43','2026-03-12 03:03:43'),(3,'Sale Manager','sale-manager',3,1,'2026-03-12 03:03:43','2026-03-12 03:03:43'),(4,'Editor Manager','editor-manager',4,1,'2026-03-12 03:03:43','2026-03-12 03:03:43'),(5,'Mentor Manager','mentor-manager',5,1,'2026-03-12 03:03:43','2026-03-12 03:03:43'),(6,'Sale','sale',11,1,'2026-03-12 03:03:43','2026-03-12 03:03:43'),(7,'Editor','editor',12,1,'2026-03-12 03:03:43','2026-03-12 03:03:43'),(8,'Mentor','mentor',13,1,'2026-03-12 03:03:43','2026-03-12 03:03:43'),(9,'Club Member','club-member',21,1,'2026-03-12 03:03:43','2026-03-12 03:03:43'),(10,'Student','student',22,1,'2026-03-12 03:03:43','2026-03-12 03:03:43'),(11,'Developer','developer',14,1,'2026-03-12 03:03:27','2026-03-12 03:03:27'),(12,'Researcher','researcher',15,1,'2026-03-12 03:03:27','2026-03-12 03:03:27');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `team`
--

DROP TABLE IF EXISTS `team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `team` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Mr. Ms.',
  `nickname` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `position` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Eg. Leader, Member,...',
  `joined_year` int NOT NULL,
  `left_year` int DEFAULT NULL,
  `mentor_mode` smallint DEFAULT '1',
  `bio` text COLLATE utf8mb4_general_ci,
  `social` text COLLATE utf8mb4_general_ci,
  `rate_per_hour` int DEFAULT NULL,
  `rate_per_project` int DEFAULT NULL,
  `currency_unit` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Eg. coin, VND, USD,...',
  `status` smallint NOT NULL DEFAULT '1' COMMENT '0 for inactive, 1 for active',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `fk_team_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `team_chk_1` CHECK ((`rate_per_hour` >= 1)),
  CONSTRAINT `team_chk_2` CHECK ((`rate_per_project` >= 1))
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team`
--

LOCK TABLES `team` WRITE;
/*!40000 ALTER TABLE `team` DISABLE KEYS */;
INSERT INTO `team` VALUES (1,'Nguyễn Khánh Sơn','MSc','Tấm',3,'Leader',2025,NULL,1,'This is a demo description about Khanh Son. (short)','facebook:fb.com/khanhson123;linkedin:linkedin.com/khanhson',100000,3000000,'VND',1,'2026-03-12 03:03:46','2026-03-12 03:03:46'),(2,'Phạm Tuân','Mr','Bàn Tử',4,'Member',2025,NULL,1,'This is a long demo description about <b>Pham Tuan</b>. Lorem ipsum dolor sit amet, consectetur \n				adipiscing elit. Donec at facilisis orci. Nunc iaculis, leo eget convallis ornare, felis metus luctus \n				nulla, eu egestas dolor erat a leo. Duis gravida massa vel odio laoreet, nec iaculis lorem hendrerit.  (long)','github:github',120000,3200000,'VND',1,'2026-03-12 03:03:46','2026-03-12 03:03:46'),(3,'Nguyễn Khánh Sơn','MSc','Tấm',5,'Leader',2025,NULL,1,'This is a demo description about Khanh Son. (short)','facebook:fb.com/khanhson123;linkedin:linkedin.com/khanhson',100000,3000000,'VND',1,'2026-03-12 03:03:46','2026-03-12 03:03:46'),(4,'Phạm Tuân','Mr','Bàn Tử',6,'Member',2025,NULL,1,'This is a long demo description about <b>Pham Tuan</b>. Lorem ipsum dolor sit amet, consectetur \n				adipiscing elit. Donec at facilisis orci. Nunc iaculis, leo eget convallis ornare, felis metus luctus \n				nulla, eu egestas dolor erat a leo. Duis gravida massa vel odio laoreet, nec iaculis lorem hendrerit.  (long)','github:github',120000,3200000,'VND',1,'2026-03-12 03:03:46','2026-03-12 03:03:46'),(5,'Nguyễn Khánh Sơn','MSc','Tấm',7,'Leader',2025,NULL,1,'This is a demo description about Khanh Son. (short)','facebook:fb.com/khanhson123;linkedin:linkedin.com/khanhson',100000,3000000,'VND',1,'2026-03-12 03:03:46','2026-03-12 03:03:46'),(6,'Ngô Văn Quyền','MSc','The Doctor',1,'Software Lecturer',2025,NULL,1,'I want to contribute to a dynamic academic and research environment that emphasizes innovation, interdisciplinary learning, and real-world impact. With my vast experience in software engineering, machine learning, and pedagogy, I aim to guide future developers while advancing meaningful research. I am looking for opportunities that allow me to integrate teaching and technology to solve complex challenges. As Doctor Who once said, “In the end, we’re all stories. Just make it a good one.”','facebook:https://www.facebook.com/thedoctor2404@#linkedin:https://www.linkedin.com/in/thedoctor2404/@#github:https://github.com/CtrlShiftN',1000,NULL,'coin',1,'2026-03-12 03:03:31','2026-03-12 03:03:31'),(7,'Lê Mạnh Toản','Mr','Tôm',2,'Mentor',2025,NULL,1,'Aspiring software developer with a strong passion for programming, eager to gain hands-on experience and deepen my understanding of real-world software development. Seeking an internship opportunity where I can learn from experienced engineers, participate in practical projects. I am dedicated to continuous learning, and contributing effectively to a dynamic team based on open mindset and communication.','facebook:https://www.facebook.com/toanlemanh2003@#linkedin:https://www.linkedin.com/in/m%E1%BA%A1nh-to%E1%BA%A3n-l%C3%AA-855a23355/@#youtube:https://www.youtube.com/@toanlemanh2003fithanu@#github:https://github.com/toanlemanh',800,2000,'coin',1,'2026-03-12 03:03:31','2026-03-12 03:03:31');
/*!40000 ALTER TABLE `team` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8mb3_unicode_ci NOT NULL,
  `avatar` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `birthday` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `gender` int DEFAULT '1' COMMENT ' 0 - female, 1 - male',
  `tel` varchar(12) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `auth_key` varchar(32) COLLATE utf8mb3_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `password_reset_token` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `verified_at` datetime DEFAULT NULL,
  `coin` int DEFAULT '0',
  `vip_level` smallint DEFAULT '0',
  `point` double DEFAULT '0',
  `verification_token` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `referral_code` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `status` smallint NOT NULL DEFAULT '1' COMMENT '0 for inactive, 1 for active',
  `role` int NOT NULL COMMENT 'from role table',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `login_session` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL COMMENT 'sessionid + ipaddress + user agancy ',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `referral_code` (`referral_code`),
  UNIQUE KEY `password_reset_token` (`password_reset_token`),
  UNIQUE KEY `login_session` (`login_session`),
  KEY `idx_user_verified` (`verified_at`),
  KEY `idx_user_role` (`role`),
  KEY `idx_user_coin` (`coin`),
  KEY `idx_user_vip_level` (`vip_level`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'superadmin1','Super Admin 1','media/images/male-avatar.png','01/01/1990',1,'0987654321','Gia Sinh, Gia Vien, Ninh Binh','mSwxWgFP9TSpo3Eau3w2gh0HyglQFHqK','$2y$13$Y.s0j22ILgp6eD32vHuK9edL7iS/R82uDa1bJCxWs/lTp.VgIrC0i','V-BPbfauzCUPEGhidXDVROwX5b9yC-3-_1773285343','superadmin1@gmail.com','2026-03-12 03:03:43',0,0,0,NULL,'superadmin1',1,1,'2026-03-12 03:03:43','2026-03-12 03:03:43',NULL),(2,'admin2','Admin 2','media/images/male-avatar.png','05/06/1992',1,'0987654123','Truong Vien, Hoa Lu, Ninh Binh','l3RP5F0VPbuErfOH7QjZCuu1UK924DMK','$2y$13$DwNrbLvFYgG3kpDy9ymJEukNs4A/GtzQtZNMpwDCG.AxCE9awQFta','0MGROOn45_Eok3huaLKlnCahOCskCLJn_1773285343','admin2@gmail.com','2026-03-12 03:03:43',0,0,0,NULL,'admin2',1,2,'2026-03-12 03:03:43','2026-03-12 03:03:43',NULL),(3,'sale.manager','Sale Manager','media/images/female-avatar.png','01/04/2003',0,'0987456321','Phat Diem, Kim Son, Ninh Binh','Sd2EhNM2afaz8LCERPlFdvDq5M-kbNYW','$2y$13$EOFvCgP4CxXib4ZV09EuFumTTVIwNqsnvnh.pfZo/HMpPIC.zrO3K','ULqxzJTTsrF_SHv5tMZPh2xJfPN8epHO_1773285344','sale.manager@gmail.com','2026-03-12 03:03:44',0,0,0,NULL,'sale.manager',1,3,'2026-03-12 03:03:44','2026-03-12 03:03:44',NULL),(4,'sale3','Editor Manager','media/images/female-avatar.png','16/05/2002',0,'0987456123','Ninh Xuan, Hoa Lu, Ninh Binh','HvmaTlxnmOkYLPpZSpdLq4WONmi6khwY','$2y$13$Iv/DLj4excsHPuOxVYwImucUSKISTd5CYK1E26Kx2kwhUFcuQ7eUi','dfgYvQ145CYePRKHrtpbx-C55CUHVx2S_1773285344','sale3@gmail.com','2026-03-12 03:03:44',0,0,0,NULL,'sale3',1,4,'2026-03-12 03:03:44','2026-03-12 03:03:44',NULL),(5,'mentor.manager','Mentor Manager','media/images/male-avatar.png','19/05/2005',1,'0987456246','Ninh Ha, Hoa Lu, Ninh Binh','5ceJi9m3dk2yUQ-y2TuJP_3dR6wEOx9_','$2y$13$2AfWkv0KUOHEa7f.vTb24uIpKto5wDWFCjSuPOzXjOuoPJRQfSHpq','pCifNIvmyRllG9eGEzPZwNAbP-NAF7Tx_1773285344','mentor.manager@gmail.com','2026-03-12 03:03:44',0,0,0,NULL,'mentor.manager',1,5,'2026-03-12 03:03:44','2026-03-12 03:03:44',NULL),(6,'sale1','Sale','media/images/male-avatar.png','21/09/2004',1,'0987456357','Nam Tu Liem, Ha Noi','U4vkuUH7Up4xZ3Bh1XFYTf-Stz4L6JN4','$2y$13$HWRFG7qjb2E6OtiA7OR7bOXZk7Bqr4gErDekjS5alaPIHU1CgL7e6','okZZyRVmVOUfDEO8qCwbi_2TWYK2x8CI_1773285345','sale1@gmail.com','2026-03-12 03:03:45',0,0,0,NULL,'sale1',1,11,'2026-03-12 03:03:45','2026-03-12 03:03:45',NULL),(7,'editor1','Editor','media/images/female-avatar.png','24/05/2001',0,'0987235246','Kim Giang, Thanh Xuan, Ha Noi','KLzt66m3SIrSuj9U5OOKBM_JCkDx7D1c','$2y$13$zT3PaKKIP9egjBKPJpXf9.oeYiffsMgwSA4hHPzqzAwFaHsKLsVwW','tl5VZSOpm2mEynjzL8bZLy-1EESE_9pZ_1773285345','editor1@gmail.com','2026-03-12 03:03:45',0,0,0,NULL,'editor1',1,12,'2026-03-12 03:03:45','2026-03-12 03:03:45',NULL),(8,'mentor1','Mentor','media/images/female-avatar.png','17/12/2005',0,'0987246357','Hai Ba Trung, Ha Dong, Ha Noi','DCFTT7c1XjXILZSPswDcbmOt5IlkDOhw','$2y$13$BWvqnJWy9i7s.4EbTFpgvOGYWYGuu7qoLc87nExKXTa4LeVzyLhh2','mOr3enH3vPkl_XAFsKue0szzc9z-EFxP_1773285345','mentor1@gmail.com','2026-03-12 03:03:45',0,0,0,NULL,'mentor1',1,13,'2026-03-12 03:03:45','2026-03-12 03:03:45','9b4190c890bb8c45d226a2936fe82f836bfc52411f92157dbc947e94478ed9a0'),(9,'student1','Student 1','media/images/male-avatar.png','11/03/2008',1,'0987123357','Do Ngoc Du, Thanh Binh, Hai Phong','SRfDuW2TQQtuB-GNUWgbC0bKjwvhS5ph','$2y$13$9EPvNS.qV77BTyo1chO09.zdN.fw0OtBSeCGsd7ga0EC.6VHgAgGK','AQmGdudIdU9zhIh6uvCJt7OVbIMafSwO_1773285346','student1@gmail.com','2026-03-12 03:03:46',0,0,0,NULL,'student1',1,22,'2026-03-12 03:03:46','2026-03-12 03:03:46','c2cfe9cf1c3f361de34cbac9fc0bb4a4dbb306eca26a5527fb82fc86161b9675'),(10,'nvquyen2404','Ngô Văn Quyền','media/images/avatar/08062022.png','24/04/1996',1,'0987654321','Thuy Son 2, Nguyen Uy ward, Ninh Binh province, Vietnam','H2eY6LPEgTy2piJo0s1P0twCHCPmBEoe','$2y$13$BQL9MHwZsZCJ8xICgQX4BOr5VlTsa.AZFz6DvDVXprFE9ABN.CL2G','VN9QzjZJ5vIqE2-r37K2dtD---rt5gfV_1773286888','nvquyen2404@gmail.com','2026-03-12 03:03:28',0,0,0,NULL,'nvquyen2404',1,1,'2026-03-12 03:03:28','2026-03-12 03:03:28',NULL),(11,'lemanhtoan2003','Lê Mạnh Toản','media/images/avatar/toan.png','01/01/2003',1,'0987654123','Truong Vien, Hoa Lu, Ninh Binh','w-NEXRdXz5WutJSPrecXTHZRt8934sFC','$2y$13$6lv85fH7uhwlYwaRJyoW2.r2Z78qdgB6oZEjmklhLIYr2iOP.QzSu','Ip9SRNldZP9de5ghyruj6XOfX23YsxJL_1773286888','lemanhtoan2003@gmail.com','2026-03-12 03:03:28',0,0,0,NULL,'lemanhtoan2003',1,2,'2026-03-12 03:03:28','2026-03-12 03:03:28',NULL),(12,'xuantae1030','Vũ Thị Xuân','media/images/avatar/xuantae-nobg.png','10/11/2005',0,'0987654123','Truong Vien, Hoa Lu, Ninh Binh','dApRM2zRhvbLwi7SI7zkr_W-Nmx8sFCp','$2y$13$9YpM0DpS/5AoAqo0X9cB8ewPyovZ2szmf2RJBobXhSONX2eKBEFP.','CxNHF_WwwvGpMk_uqEwi-b1fyAiDXP2N_1773286888','xuantae1030@gmail.com','2026-03-12 03:03:28',0,0,0,NULL,'xuantae1030',1,15,'2026-03-12 03:03:28','2026-03-12 03:03:28',NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_experience`
--

DROP TABLE IF EXISTS `user_experience`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_experience` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `organization_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Name of the organization or institution',
  `organization_logo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Logo URL',
  `organization_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Address of the organization or institution',
  `country` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Country where the experience took place',
  `discipline` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Field, subject area, or discipline',
  `position_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Title, role',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT 'Format: Code@#Title@#Content;...',
  `course_info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT 'Format for teaching: Code@#Title@#Content;...',
  `teaching_format` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'e.g. In-person, Online, Hybrid',
  `teaching_level` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'e.g. Undergraduate, Graduate, High School',
  `annual_teaching_hours` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT 'Course@#Number of teaching hours a year',
  `start_date` varchar(12) COLLATE utf8mb4_general_ci NOT NULL,
  `end_date` varchar(12) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT 'Free-form description of the experience',
  `document_proof_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'ProofName@#Link to proof document',
  `activities_info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT 'ActivityName@#Content1, Content2;...',
  `achievements_info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT 'AchievementName@#Content1, Content2;...',
  `materials_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Course@#url;Course@#url;...',
  `reference_info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT 'ReferenceName@#Phone|Website|Email@#Position;...',
  `type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'education' COMMENT 'Type: education, internship, job, volunteer, research, teaching, etc.',
  `tags` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` smallint NOT NULL DEFAULT '1' COMMENT '0 for inactive, 1 for active',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx-user_experience-user_id` (`user_id`),
  CONSTRAINT `fk-user_experience-user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_experience`
--

LOCK TABLES `user_experience` WRITE;
/*!40000 ALTER TABLE `user_experience` DISABLE KEYS */;
INSERT INTO `user_experience` VALUES (1,1,'FPT Telecom Ha Noi','media/images/experience/ftellogo.png','2nd floor, FPT Cau Giay building, 17 Duy Tan street, Dich Vong Hau ward, Cau Giay district, Hanoi City, Vietnam','Vietnam','Software Engineering','Intern',NULL,NULL,NULL,NULL,NULL,'01/07/2017','30/09/2017','Contributed to the development and maintenance of the SCC-C (Service Command Central), which supports key service management operations. Responsibilities included assisting with software development tasks, conducting code reviews, and participating in Scrum-based team activities. Applied basic knowledge of Java and PHP to implement minor functionality, troubleshoot bugs and support integration processes. I also researched the Scrum methodology and gave a presentation on its application within the SCC-C projects. This internship enhanced practical understanding of collaborative software development workflows and agile practices while contributing to incremental improvements in system functionality and performance.',NULL,NULL,NULL,NULL,NULL,'intership','Java, PHP, Scrum',1,'2026-03-12 03:03:31','2026-03-12 03:03:31'),(2,1,'FPT Software','media/images/experience/fsoftlogo.png','F-Ville Building, Technology Village No. 3 & 4, Software Area, Hoa Lac Hi-tech Park, Km29, Thanglong Freeway, Thach That District, Hanoi, Vietnam','Vietnam','Software Engineering','Intern','Java Web (Spring, Hibernate)@#SQL Server',NULL,NULL,NULL,NULL,'01/02/2018','30/03/2018',NULL,NULL,NULL,NULL,NULL,NULL,'intership','Java Web, Spring, Hibernate',1,'2026-03-12 03:03:31','2026-03-12 03:03:31'),(3,1,'E-Sing Viet Nam','media/images/experience/defaultlogo.png','Thanh Thuy, Phu Tho district, Vietnam','Vietnam','Software Engineering','IT Manager','www.esing.vn (Wordpress)@#Compose English songs lyric@#Other technical issues',NULL,NULL,NULL,NULL,'01/04/2018','02/03/2019',NULL,NULL,NULL,NULL,NULL,NULL,'manager','PHP, Wordpress',1,'2026-03-12 03:03:31','2026-03-12 03:03:31'),(4,1,'VIET NAM MANGOTECH TECHNOLOGY JOINT STOCK COMPANY (VietMango JSC)','media/images/experience/defaultlogo.png','19/9, Quynh Loi street, Quynh Mai district, Hai Ba Trung ward, Ha Noi city, Vietnam','Vietnam','Software Engineering','Business Analysis','Chinese Ordering Website@#POS System',NULL,NULL,NULL,NULL,'01/02/2019','30/04/2019',NULL,NULL,NULL,NULL,NULL,NULL,'manager','Business Analysis, Mockup',1,'2026-03-12 03:03:31','2026-03-12 03:03:31'),(5,1,'E-Sing Language','media/images/experience/defaultlogo.png','1 HUng Vuong street, Hoi Hop ward, Vinh Yen city, Vinh Phuc province, Vietnam','Vietnam','Language Education','Director','Supervision and Evaluation@#Strategy and Technique@#Administering the language requirement',NULL,NULL,NULL,NULL,'01/04/2019','30/07/2019',NULL,NULL,NULL,NULL,NULL,NULL,'manager','Foreign Language, Education, English',1,'2026-03-12 03:03:31','2026-03-12 03:03:31'),(6,1,'JobsGO JSC','media/images/experience/jobsgologo.png','Floor 3 Building G1, Five Star Garden, Thanh Xuan ward, Ha Noi city, Vietnam','Vietnam','Software Engineering','Backend Developer','Google Sheet sync (Google API)@#Firebase notifications and messages (Firebase SDK, PHP, VueJS)@#Candidate info scrapper from files, sites (PdfToText, DomXpath, Curl, TesseractOCR)@#Job scrapper from sites (Curl, DomXpath)@#Matching data after scrapping@#Stringee call and logs (Stringee API & webhooks)@#GoCV@#Avatar cropper (JavaScript)@#Firebase Authen@#Realtime Dashboard 3C call center (Curl;Linkedin, Facebook lead ads scrapper)@#QR-code-related features@#Extract candidate data (AWS, OCR)@#Text, Face detection (AWS)@#Mailing template (Swift mail)@#Other private tools (JavaScript, JQuery, Curl, PHP libraries)',NULL,NULL,NULL,NULL,'01/07/2019','30/09/2020',NULL,NULL,NULL,'Outstanding staff of the year@#Dec 2019',NULL,'https://www.jobsgo.vn','developer','PHP, Yii2 Advanced, JavaScript, AWS, Curl, Google API, Firebase, DomXPath, OCR, Swift Mail, Scrapper, Cropper, Stringee, VueJS',1,'2026-03-12 03:03:31','2026-03-12 03:03:31'),(7,1,'HC Vina','media/images/experience/defaultlogo.png','A36-TT10 Van Quan urban area, Van Quan ward, Ha Dong district, Ha Noi city, Vietnam','Vietnam','Language Education','Teacher',NULL,'English Grammar@#Maths',NULL,'Secondary School, High School','English@#270;Maths@#50','01/08/2020','30/10/2021',NULL,NULL,NULL,NULL,NULL,NULL,'teaching','English, Maths',1,'2026-03-12 03:03:31','2026-03-12 03:03:31'),(8,1,'T3H IT Institute','media/images/experience/t3hlogo.png','128a Ho Tung Mau street, Mai Dich ward, Cau Giay district, Ha Noi city, Vietnam','Vietnam','Software Engineering','Lecturer',NULL,'English in use (IELTS B1)@#Computer Skills (Office Word, Excel, PowerPoint, Presentation)@#Data Structure and Algorithms (Java)@#Software Development (PHP, Yii2 Advanced framework)@#Calculus@#Graph Theory','lecture','Graduate','English in use@#105;Computer Skills@#60;Data Structure and Algorithms@#45;Software Development@#120;Calculus@#45;Graph Theory@#45','01/09/2020','30/10/2021',NULL,NULL,NULL,NULL,NULL,NULL,'teaching','English, Maths, Calculus, PHP, Yii2 Advanced, Java, Office, Presentation, Graph',1,'2026-03-12 03:03:31','2026-03-12 03:03:31'),(9,1,'College of Science and Technology','media/images/experience/cstlogo.png','Ho Tung Mau street, Mai Dich ward, Cau Giay district, Ha Noi city, Vietnam','Vietnam','Software Engineering','Lecturer',NULL,'Web Development (PHP, Yii2 Advanced framework, Laravel framework)@#Java Web (Java core, Web fundamentals, Servlets and JSP, JDBC, MVC)@#Data Structure and Algorithms (C/C++)@#Calculus@#Graph Theory','lecture','Graduate','Web Development@#120;Java Web@#120;Data Structure and Algorithms@#60;Calculus@#45;Graph Theory@#45','01/04/2021','30/12/2024',NULL,NULL,NULL,NULL,NULL,NULL,'teaching','Maths, Calculus, PHP, Yii2 Advanced, Laravel, Java, Servlets, JSP, Graph',1,'2026-03-12 03:03:31','2026-03-12 03:03:31'),(10,1,'VTI Academy','media/images/experience/vtilogo.png','No. 19 Le Thanh Nghi street, Hai Ba Trung district, Ha Noi city, Vietnam','Vietnam','Software Engineering','Lecturer',NULL,'Web Development (HTML, CSS, Boostrap)@#Java Programming (Java core, MVC)@#Data Structure and Algorithms (Java)@#Graph Theory','lecture','Graduate','Web Development@#120;Java Programming@#120;Data Structure and Algorithms@#45;Graph Theory@#45','01/10/2021','30/09/2022',NULL,NULL,NULL,NULL,NULL,NULL,'teaching','Maths, Java, MVC, HTML, CSS, Bootstrap, Graph',1,'2026-03-12 03:03:31','2026-03-12 03:03:31'),(11,1,'Hanoi University (HanU)','media/images/experience/hanulogo.png','Km 9, Nguyen Trai street, Dai Mo ward, Ha Noi city, Vietnam','Vietnam','Software Engineering','Teaching Assistant',NULL,'WPR - Web Development (HTML, CSS, Boostrap)@#PR1 - Programming 01 (Java core, JavaFX)@#PR2 - Programming 02 (Java OOP, Swing, JavaFX)','lecture','Graduate','WPR@#Web Development@#30;PR1@#Programming 01@#45;PR2@#Programming 02@#45','01/10/2021','30/09/2022',NULL,NULL,NULL,NULL,NULL,NULL,'teaching','Java, OOP, MVC, HTML, CSS, Bootstrap, English',1,'2026-03-12 03:03:31','2026-03-12 03:03:31'),(12,1,'CodeGym Academy','media/images/experience/codegymlogo.png','No. TT01.23, Hai Dang city, My Dinh 2 ward, Nam Tu Liem district, Ha Noi city, Vietnam','Vietnam','Software Engineering','Lecturer',NULL,'PF2101R1 - Programming Fundamentals (JavaScript)@#RJ2203R1 - ReactJS (JSX, React, NextJS)@#BW2203R1 - Web Programming (HTML, CSS, Bootstrap)@#PYF2201R1 - Python Fundamentals (Jupiter Notebook, Matplotlib, Numpy, Pandas)','lecture','Graduate','PF2101R1@#Programming Fundamentals@#48;RJ2203R1@#ReactJS@#48;BW2203R1@#Web Programming@#48;PYF2201R1@#Python Fundamentals@#24','01/08/2021','30/12/2023',NULL,NULL,NULL,NULL,NULL,NULL,'teaching','JavaScript, OOP, MVC, HTML, CSS, Bootstrap, React, NextJS, Python',1,'2026-03-12 03:03:31','2026-03-12 03:03:31'),(13,1,'Japan Advanced Institute of Science and Technology (JAIST)','media/images/experience/jaistlogo.png','1 Chome-1 Asahidai, Nomi, Ishikawa 923-1211, Japan','Japan','Software Engineering','Developer','CyPROM Enhancedment (Python, OWASP Top Ten, Yii2 Advanced framework, National Vulnerability Database)@#Explainable NEC Script (PHP, Python, terminal scripts)',NULL,NULL,NULL,NULL,'01/10/2022','30/10/2023',NULL,'https://github.com/cyb3rlab/CyPROM',NULL,NULL,NULL,'Assoc. Prof. Razvan Beuran@#https://www.jaist.ac.jp/~razvan/@# Japan Advanced Institute of Science and Technology (JAIST), in Ishikawa prefecture, Japan','developer','JavaScript, PHP, Yii2 Advanced, Terminal Scripts, Python, Vulnerability, Cyber-security',1,'2026-03-12 03:03:31','2026-03-12 03:03:31'),(14,1,'Hanoi Architectural University (HaU)','media/images/experience/haulogo.png','Km 10 Nguyen Trai street, Thanh Xuan district, Hanoi city, Vietnam','Vietnam','Software Engineering','Visiting Lecturer',NULL,'TH4309 - Web Technology (HTML, Bootstrap, PHP, Yii2 Advanced, Laravel)@#TH4316 - Java Technology (Java core, OOP, MVC)@#TH4311 - Mobile Programming (ReactJS, React Native, Android, iOS)','lecture','Graduate','TH4309@#Web Technology@#60;TH4316@#Java Technology@#60;TH4311@#Mobile Programming@#60','01/09/2024',NULL,NULL,NULL,NULL,NULL,NULL,'MSc. Hoang Thi Thuy Dung@#0967xxxxxx@# Hanoi Architectural University (HaU), Hanoi, Vietnam','teaching','JavaScript, PHP, Yii2 Advanced, Laravel, React, React Native, Android, iOS',1,'2026-03-12 03:03:31','2026-03-12 03:03:31'),(15,1,'Hanoi University (HanU)','media/images/experience/hanulogo.png','Km 9, Nguyen Trai street, Dai Mo ward, Hanoi city, Vietnam','Vietnam','Software Engineering','Lecturer',NULL,'PR1 - Programming 01 (Java core, GUI, Swing, AWT, JavaFX)@#PR2 - Programming 02 (Java OOP, MVC, GUI, Swing, AWT, JavaFX)@#SE1 - Software Engineering 01 (Spring Boot, Hibernate, Git)@#SE2 - Software Engineering 02 (Spring Boot, Hibernate, Git)@#WPR - Web Programming (HTML, JavaScript, React, NodeJS)@#MPR - Mobile Programming (React, React Native)@#JSD - Java Software Development (Java GUI, Threading, Meta-programming, I/O, Networking, JDBC)','lecture','Graduate','PR1@#Programming 01@#255;PR2@#Programming 02@#255;SE1@#Software Engineering 01@#60;SE2@#Software Engineering 02@#60;WPR@#Web Programming@#30;MPR@#Mobile Programming@#105;JSD@#Java Software Development@#105','01/11/2023',NULL,NULL,'https://www.hanu.vn/a/75992/11-Khoa-Cong-nghe-thong-tin?c=8971','Undergraduate Thesis Reviewer@#2024;JST Alumni Meeting@#2024, 2025',NULL,NULL,'Dr. Trinh Bao Ngoc@#0987355xxx@#Vice Dean of Faculty of Information Technology, Hanoi University','teaching','Java, OOP, MVC, HTML, CSS, Bootstrap, PHP, Yii2 Advanced, React, React Native, Spring Boot, Hibernate, Swing, AWT, JavaFX, JavaScript, English, JST Alumni, Multi-threading, Meta-programming',1,'2026-03-12 03:03:31','2026-03-12 03:03:31'),(16,2,'MindX Technology School','media/images/experience/mindxlogo.png','505 Minh Khai Street, Vinh Tuy ward, Ha Noi','Vietnam','Software Engineering','Lecturer',NULL,'Web Development (HTML5, CSS3, Javascript ES6)@#Robotic Programming (VexGo, VexIQ)@#Scratch Programming@#Scratch','lecture','Secondary School, High School','Web Development@#80;Robotic@#100;Scratch@#80','01/08/2023','30/04/2024',NULL,NULL,NULL,NULL,NULL,NULL,'teaching','HTML5, CSS3, Javascript ES6, VexGo, VexIQ, Scratch',1,'2026-03-12 03:03:31','2026-03-12 03:03:31'),(17,2,'Hanoi University (HanU)','media/images/experience/hanulogo.png','Km 9, Nguyen Trai street, Dai Mo ward, Hanoi, Vietnam','Vietnam','Software Engineering','Lecturer',NULL,'SAD - System Analysis and Design (SDLC, Agile, Waterfall, UX/UI, Usecase diagram, Sequence diagram, Figma)@#SS1 - Special Subject 1 (Game Theory, Stable Matching)','lecture','Graduate','SAD@#System Analysis and Design@#180;SS1@#Special Subject 1@#90','01/09/2025',NULL,NULL,'https://www.hanu.vn/a/75992/11-Khoa-Cong-nghe-thong-tin?c=8971',NULL,NULL,NULL,'Dr. Trinh Bao Ngoc@#0987355xxx@#Vice Dean of Faculty of Information Technology, Hanoi University','teaching','Agile, Waterfall, UX/UI, Figma, Game Theory, Stable Matching',1,'2026-03-12 03:03:31','2026-03-12 03:03:31');
/*!40000 ALTER TABLE `user_experience` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-12 10:52:21
