-- ============================================================
-- PATCH: Rename placeholder users + add varied mentor skills
-- Run this against your live cyberweb database
-- ============================================================

-- 1. Rename placeholder user names to real Vietnamese names
UPDATE `user` SET `name` = 'Nguyễn Thị Lan'   WHERE `id` = 3;
UPDATE `user` SET `name` = 'Trần Minh Đức'     WHERE `id` = 4;
UPDATE `user` SET `name` = 'Phạm Văn Hùng'     WHERE `id` = 5;
UPDATE `user` SET `name` = 'Hoàng Thị Mai'     WHERE `id` = 6;
UPDATE `user` SET `name` = 'Bùi Quang Trung'   WHERE `id` = 7;
UPDATE `user` SET `name` = 'Nguyễn Đức Thắng'  WHERE `id` = 8;

-- Sync team table names too
UPDATE `team` SET `name` = 'Nguyễn Thị Lan'   WHERE `user_id` = 3;
UPDATE `team` SET `name` = 'Trần Minh Đức'     WHERE `user_id` = 4;
UPDATE `team` SET `name` = 'Phạm Văn Hùng'     WHERE `user_id` = 5;
UPDATE `team` SET `name` = 'Hoàng Thị Mai'     WHERE `user_id` = 6;
UPDATE `team` SET `name` = 'Bùi Quang Trung'   WHERE `user_id` = 7;

-- 2. Rename any leftover test mentor accounts (update IDs if different)
UPDATE `user` SET `name` = 'Đinh Tuấn Kiệt'   WHERE `username` = 'testmentor';
UPDATE `user` SET `name` = 'Lưu Phương Thảo'  WHERE `username` LIKE '%mentor%' AND `id` NOT IN (1,2,5,7) AND `name` LIKE '%entor%';

-- ============================================================
-- 3. Clear any existing placeholder experiences for users 3–7
-- ============================================================
DELETE FROM `user_experience` WHERE `user_id` IN (3,4,5,6,7);

-- ============================================================
-- 4. Nguyễn Thị Lan (user 3) — Python, Machine Learning, Data Science
-- ============================================================
INSERT INTO `user_experience`
  (`user_id`,`organization_name`,`position_title`,`start_date`,`end_date`,`description`,`tags`,`type`,`status`,`created_at`,`updated_at`)
VALUES
(3,'VinAI Research','Machine Learning Engineer','01/06/2022',NULL,
 'Xây dựng và triển khai các mô hình học máy cho nhận dạng hình ảnh và xử lý ngôn ngữ tự nhiên bằng Python, TensorFlow và PyTorch.',
 'Python, Machine Learning, TensorFlow, PyTorch, NLP','developer',1,NOW(),NOW()),

(3,'FPT Software','Data Scientist','01/03/2020','31/05/2022',
 'Phân tích dữ liệu lớn, xây dựng mô hình dự đoán và dashboard bằng Python, pandas, scikit-learn cho các khách hàng doanh nghiệp.',
 'Python, Machine Learning, pandas, scikit-learn, Data Science','developer',1,NOW(),NOW()),

(3,'Đại học Bách Khoa Hà Nội','Trợ giảng AI','01/09/2019','28/02/2020',
 'Hỗ trợ giảng dạy các khóa học về học sâu, thị giác máy tính và lập trình Python cho sinh viên năm 3.',
 'Python, Machine Learning, Deep Learning, OpenCV','teaching',1,NOW(),NOW());

-- ============================================================
-- 5. Trần Minh Đức (user 4) — React, Docker, TypeScript
-- ============================================================
INSERT INTO `user_experience`
  (`user_id`,`organization_name`,`position_title`,`start_date`,`end_date`,`description`,`tags`,`type`,`status`,`created_at`,`updated_at`)
VALUES
(4,'Tiki Corporation','Frontend Engineer','01/04/2022',NULL,
 'Phát triển và tối ưu giao diện người dùng cho nền tảng thương mại điện tử với React, TypeScript và hệ thống CI/CD dựa trên Docker.',
 'React, TypeScript, Docker, CI/CD, Redux','developer',1,NOW(),NOW()),

(4,'Base.vn','React Developer','01/07/2020','31/03/2022',
 'Xây dựng SPA nội bộ bằng React và đóng gói microservices với Docker Compose cho môi trường staging và production.',
 'React, Docker, TypeScript, REST API, Microservices','developer',1,NOW(),NOW()),

(4,'CodeGym Academy','Giảng viên Frontend','01/01/2019','30/06/2020',
 'Giảng dạy lập trình web hiện đại: HTML/CSS, JavaScript ES6+, React và quy trình DevOps cơ bản.',
 'React, JavaScript, HTML, CSS, Docker','teaching',1,NOW(),NOW());

-- ============================================================
-- 6. Phạm Văn Hùng (user 5) — Spring Boot, Java, MySQL
-- ============================================================
INSERT INTO `user_experience`
  (`user_id`,`organization_name`,`position_title`,`start_date`,`end_date`,`description`,`tags`,`type`,`status`,`created_at`,`updated_at`)
VALUES
(5,'Viettel Digital Services','Backend Developer','01/09/2021',NULL,
 'Thiết kế và phát triển các REST API quy mô lớn sử dụng Spring Boot, Hibernate và MySQL. Tối ưu truy vấn database cho hơn 10 triệu bản ghi.',
 'Spring Boot, Java, MySQL, Hibernate, REST API','developer',1,NOW(),NOW()),

(5,'VNG Corporation','Java Developer','01/01/2019','31/08/2021',
 'Phát triển module backend cho hệ thống thanh toán trực tuyến với Java 11, Spring Framework và MySQL Cluster.',
 'Java, Spring Boot, MySQL, Microservices, Kafka','developer',1,NOW(),NOW()),

(5,'Đại học FPT','Giảng viên Java','01/09/2018','31/12/2018',
 'Hướng dẫn sinh viên lập trình Java hướng đối tượng, Spring MVC và thiết kế cơ sở dữ liệu MySQL.',
 'Java, Spring Boot, MySQL, OOP, MVC','teaching',1,NOW(),NOW());

-- ============================================================
-- 7. Hoàng Thị Mai (user 6) — C++, CTF, Cybersecurity
-- ============================================================
INSERT INTO `user_experience`
  (`user_id`,`organization_name`,`position_title`,`start_date`,`end_date`,`description`,`tags`,`type`,`status`,`created_at`,`updated_at`)
VALUES
(6,'VSEC Vietnam','Security Researcher','01/06/2021',NULL,
 'Nghiên cứu lỗ hổng bảo mật, tham gia CTF quốc tế và phát triển các công cụ khai thác bằng C++ và Python. Top 50 CTFtime toàn cầu 2023.',
 'CTF, C++, Cybersecurity, Reverse Engineering, Exploit Development','developer',1,NOW(),NOW()),

(6,'Bkav Corporation','Security Engineer','01/03/2019','31/05/2021',
 'Phân tích mã độc, nghiên cứu lỗ hổng phần mềm và phát triển engine diệt virus bằng C++.',
 'C++, CTF, Malware Analysis, Cybersecurity, Assembly','developer',1,NOW(),NOW()),

(6,'Học viện Kỹ thuật Mật mã','Trợ giảng An toàn thông tin','01/09/2018','28/02/2019',
 'Hỗ trợ giảng dạy các module về mã hóa, bảo mật mạng và lập trình C++ hệ thống.',
 'C++, CTF, Cryptography, Network Security','teaching',1,NOW(),NOW());

-- ============================================================
-- 8. Bùi Quang Trung (user 7) — Java, MySQL, Spring Boot
-- ============================================================
INSERT INTO `user_experience`
  (`user_id`,`organization_name`,`position_title`,`start_date`,`end_date`,`description`,`tags`,`type`,`status`,`created_at`,`updated_at`)
VALUES
(7,'Techcombank','Java Backend Engineer','01/11/2020',NULL,
 'Xây dựng hệ thống core banking với Java 17, Spring Boot và MySQL. Thiết kế schema tối ưu cho hàng triệu giao dịch mỗi ngày.',
 'Java, Spring Boot, MySQL, Hibernate, JPA','developer',1,NOW(),NOW()),

(7,'MoMo','Software Engineer','01/04/2018','31/10/2020',
 'Phát triển API thanh toán di động bằng Spring Boot và MySQL. Triển khai cơ chế phân vùng database cho hiệu suất cao.',
 'Java, MySQL, Spring Boot, REST API, Performance Tuning','developer',1,NOW(),NOW()),

(7,'T3H IT Institute','Giảng viên lập trình Java','01/09/2017','31/03/2018',
 'Giảng dạy Java Core, lập trình hướng đối tượng và thiết kế cơ sở dữ liệu MySQL cho học viên.',
 'Java, MySQL, OOP, MVC, JDBC','teaching',1,NOW(),NOW());
