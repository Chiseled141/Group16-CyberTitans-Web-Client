package com.Se2.CyberWebApp.security;

import io.jsonwebtoken.Claims;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.Collections;
import java.util.List;

@Component
public class JwtAuthFilter extends OncePerRequestFilter {

    @Autowired
    private JwtUtil jwtUtil;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {

        String authHeader = request.getHeader("Authorization");
        String token = null;
        String username = null;

        if (authHeader != null && authHeader.startsWith("Bearer ")) {
            token = authHeader.substring(7);
            try {
                username = jwtUtil.extractUsername(token);
            } catch (Exception e) {
                System.out.println("[SECURITY] Token không hợp lệ hoặc đã hết hạn.");
            }
        }

        if (username != null && SecurityContextHolder.getContext().getAuthentication() == null) {

            if (jwtUtil.validateToken(token, username)) {

                // --- PHẦN SỬA ĐỔI CHÍNH: TRÍCH XUẤT ROLE TỪ TOKEN ---
                // Chúng ta lấy toàn bộ "Claims" (dữ liệu đính kèm) trong Token ra
                Claims claims = jwtUtil.extractAllClaims(token);

                // Lấy giá trị của key "role" (Ví dụ: "ADMIN", "MENTOR"...)
                // Lưu ý: Bạn cần đảm bảo trong JwtUtil.java khi tạo Token đã put("role", ...) vào.
                String role = claims.get("role", String.class);
                if (role == null) role = "MEMBER"; // Mặc định nếu không có role

                // Chuyển đổi chuỗi String thành đối tượng Quyền (Authority) mà Spring Security hiểu
                List<GrantedAuthority> authorities = Collections.singletonList(new SimpleGrantedAuthority(role));

                // Nạp danh sách quyền (authorities) vào chứng chỉ xác thực
                UsernamePasswordAuthenticationToken authToken = new UsernamePasswordAuthenticationToken(
                        username,
                        null,
                        authorities // Cấp quyền thực tế cho đặc vụ tại đây
                );

                authToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
                SecurityContextHolder.getContext().setAuthentication(authToken);

                System.out.println("[SECURITY] Đặc vụ " + username + " truy cập với quyền: " + role);
            }
        }

        filterChain.doFilter(request, response);
    }
}