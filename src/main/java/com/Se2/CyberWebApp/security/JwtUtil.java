package com.Se2.CyberWebApp.security; // Đảm bảo đúng tên thư mục của bạn

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import org.springframework.stereotype.Component;

import java.security.Key;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.function.Function;
import com.Se2.CyberWebApp.entity.User;
@Component
public class JwtUtil {

    // 1. MẬT KHẨU TỐI CAO (Secret Key)
    // Dùng để ký và giải mã Token. Chuỗi này phải dài ít nhất 256-bit.
    // (Lưu ý: Trong dự án thực tế, người ta sẽ giấu chuỗi này trong file application.properties)
    public static final String SECRET = "5367566B59703373367639792F423F4528482B4D6251655468576D5A71347437";

    // 2. THỜI GIAN SỐNG CỦA TOKEN
    // Cài đặt 24 giờ (tính bằng milliseconds: 1000ms * 60s * 60p * 24h)
    public static final long EXPIRATION_TIME = 1000 * 60 * 60 * 24;

    // Chuyển đổi Secret String thành Chìa khóa thuật toán
    private Key getSignKey() {
        byte[] keyBytes = Decoders.BASE64.decode(SECRET);
        return Keys.hmacShaKeyFor(keyBytes);
    }

    // =========================================================
    // TÍNH NĂNG 1: TẠO TOKEN MỚI (Khi user đăng nhập thành công)
    // =========================================================
    // Thay đổi tham số truyền vào từ String thành đối tượng User
    public String generateToken(User user) {
        Map<String, Object> claims = new HashMap<>();

        if (user.getRoleEntity() != null) {
            claims.put("role", user.getRoleEntity().getName());
        } else {
            claims.put("role", "MEMBER");
        }

        return createToken(claims, user.getUsername());
    }

    private String createToken(Map<String, Object> claims, String userName) {
        return Jwts.builder()
                .setClaims(claims)
                .setSubject(userName) // Nhét tên user vào lõi Token
                .setIssuedAt(new Date(System.currentTimeMillis())) // Ngày cấp
                .setExpiration(new Date(System.currentTimeMillis() + EXPIRATION_TIME)) // Ngày hết hạn
                .signWith(getSignKey(), SignatureAlgorithm.HS256) // Đóng mộc chữ ký điện tử
                .compact();
    }

    // =========================================================
    // TÍNH NĂNG 2: MỞ KHOÁ TOKEN ĐỂ ĐỌC DỮ LIỆU
    // =========================================================
    public String extractUsername(String token) {
        return extractClaim(token, Claims::getSubject);
    }

    public Date extractExpiration(String token) {
        return extractClaim(token, Claims::getExpiration);
    }

    public <T> T extractClaim(String token, Function<Claims, T> claimsResolver) {
        final Claims claims = extractAllClaims(token);
        return claimsResolver.apply(claims);
    }

    public Claims extractAllClaims(String token) {
        return Jwts.parserBuilder()
                .setSigningKey(getSignKey())
                .build()
                .parseClaimsJws(token)
                .getBody();
    }

    // =========================================================
    // TÍNH NĂNG 3: KIỂM TRA XEM TOKEN CÓ HỢP LỆ KHÔNG
    // =========================================================
    private Boolean isTokenExpired(String token) {
        return extractExpiration(token).before(new Date());
    }

    public Boolean validateToken(String token, String username) {
        final String extractedUsername = extractUsername(token);
        // Hợp lệ = Đúng tên người đó + Token chưa hết hạn
        return (extractedUsername.equals(username) && !isTokenExpired(token));
    }
}