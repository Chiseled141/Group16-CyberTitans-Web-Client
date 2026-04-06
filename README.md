# CyberTitans Web Platform

Hệ thống quản lý câu lạc bộ an ninh mạng — Spring Boot + Thymeleaf + Vanilla JS + MySQL.

---

## Yêu cầu hệ thống

- Java 21+
- Maven (hoặc dùng `./mvnw` đi kèm)
- MySQL 8+

---

## Bước 1: Khởi tạo Cơ sở dữ liệu

1. Mở **MySQL Workbench** (hoặc client MySQL bất kỳ).
2. Kết nối với thông tin:
   - Host: `127.0.0.1` · Port: `3306`
   - Username: `root` · Password: *(để trống)*
3. Import file SQL của dự án để tạo schema `cyberweb` và các bảng dữ liệu.

---

## Bước 2: Cấu hình kết nối Database

Mở file `src/main/resources/application.properties` và kiểm tra thông tin kết nối:

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/cyberweb?useSSL=false&allowPublicKeyRetrieval=true
spring.datasource.username=root
spring.datasource.password=
```

Nếu MySQL của bạn dùng password khác, cập nhật dòng `spring.datasource.password` cho phù hợp.

---

## Bước 3: Khởi chạy ứng dụng

```bash
./mvnw spring-boot:run
```

Ứng dụng sẽ chạy tại: [http://localhost:8080](http://localhost:8080)

> **Lưu ý:** Nếu port 8080 đang bận, tìm và tắt process cũ:
> ```bash
> # macOS / Linux
> lsof -ti :8080 | xargs kill -9
> ```

---

## Cấu trúc dự án

```
src/
├── main/
│   ├── java/com/Se2/CyberWebApp/
│   │   ├── controller/      # REST & page controllers
│   │   ├── entity/          # JPA entities
│   │   ├── repository/      # Spring Data repositories
│   │   ├── security/        # JWT & Spring Security config
│   │   └── dto/             # Data Transfer Objects
│   └── resources/
│       ├── templates/       # Thymeleaf HTML templates
│       ├── static/
│       │   ├── css/         # Styles (Tailwind + custom)
│       │   └── js/          # Vanilla JS (auth, pages, utils)
│       └── application.properties
```

---

## Tech Stack

| Layer     | Technology                        |
|-----------|-----------------------------------|
| Backend   | Spring Boot 4 · Java 21           |
| Database  | MySQL 8 · Spring Data JPA         |
| Security  | Spring Security · JWT (jjwt 0.11) |
| Frontend  | Thymeleaf · Tailwind CSS · Vanilla JS |
| Build     | Maven                             |
