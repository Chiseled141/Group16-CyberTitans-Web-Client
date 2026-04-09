package com.Se2.CyberWebApp.controller;

import com.Se2.CyberWebApp.entity.MentorshipRequest;
import com.Se2.CyberWebApp.entity.User;
import com.Se2.CyberWebApp.repository.MentorshipRequestRepository;
import com.Se2.CyberWebApp.repository.UserRepository;
import com.Se2.CyberWebApp.security.JwtUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/v1/mentor")
public class MentorshipController {

    @Autowired
    private MentorshipRequestRepository requestRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private JwtUtil jwtUtil;

    // Mentor: get all requests sent to me
    @GetMapping("/requests")
    public List<Map<String, Object>> getMyRequests(@RequestHeader("Authorization") String authHeader) {
        Integer mentorId = extractUserId(authHeader);
        if (mentorId == null) return Collections.emptyList();

        return requestRepository.findByTeamIdOrderByCreatedAtDesc(mentorId).stream()
                .map(r -> toDto(r))
                .collect(Collectors.toList());
    }

    // Mentee: get my outgoing requests
    @GetMapping("/my-requests")
    public List<Map<String, Object>> getMyOutgoingRequests(@RequestHeader("Authorization") String authHeader) {
        Integer menteeId = extractUserId(authHeader);
        if (menteeId == null) return Collections.emptyList();

        return requestRepository.findByMenteeIdOrderByCreatedAtDesc(menteeId).stream()
                .map(r -> toDto(r))
                .collect(Collectors.toList());
    }

    // Accept request (tracking=2 = accepted)
    @PostMapping("/requests/{id}/accept")
    public ResponseEntity<?> acceptRequest(@PathVariable Integer id,
                                           @RequestHeader("Authorization") String authHeader) {
        Integer mentorId = extractUserId(authHeader);
        return requestRepository.findById(id).map(r -> {
            if (!r.getTeamId().equals(mentorId)) return ResponseEntity.status(403).<Map<String,Object>>body(Map.of("message", "Forbidden"));
            r.setTracking(2);
            r.setUpdatedAt(LocalDateTime.now());
            requestRepository.save(r);
            return ResponseEntity.ok(Map.of("message", "Request accepted"));
        }).orElse(ResponseEntity.notFound().build());
    }

    // Decline request (tracking=3 = rejected)
    @PostMapping("/requests/{id}/decline")
    public ResponseEntity<?> declineRequest(@PathVariable Integer id,
                                            @RequestHeader("Authorization") String authHeader) {
        Integer mentorId = extractUserId(authHeader);
        return requestRepository.findById(id).map(r -> {
            if (!r.getTeamId().equals(mentorId)) return ResponseEntity.status(403).<Map<String,Object>>body(Map.of("message", "Forbidden"));
            r.setTracking(3);
            r.setUpdatedAt(LocalDateTime.now());
            requestRepository.save(r);
            return ResponseEntity.ok(Map.of("message", "Request declined"));
        }).orElse(ResponseEntity.notFound().build());
    }

    private Map<String, Object> toDto(MentorshipRequest r) {
        Map<String, Object> dto = new LinkedHashMap<>();
        dto.put("id",          r.getId());
        dto.put("menteeId",    r.getMenteeId());
        dto.put("mentorId",    r.getTeamId());
        dto.put("topic",       r.getTopic());
        dto.put("description", r.getDescription());
        dto.put("mode",        r.getMode());
        dto.put("duration",    r.getDurationMinutes());
        dto.put("tracking",    r.getTracking());
        dto.put("scheduledAt", r.getScheduledAt());
        dto.put("createdAt",   r.getCreatedAt());

        // Resolve mentee name
        userRepository.findById(r.getMenteeId()).ifPresent(u -> dto.put("menteeName", u.getName()));
        // Resolve mentor name
        userRepository.findById(r.getTeamId()).ifPresent(u -> dto.put("mentorName", u.getName()));

        // Map tracking to status label
        Map<Integer, String> trackingLabels = Map.of(
            0, "PENDING", 1, "PENDING", 2, "ACCEPTED", 3, "REJECTED",
            4, "CANCELLED", 5, "IN_PROGRESS", 6, "COMPLETED"
        );
        dto.put("status", trackingLabels.getOrDefault(r.getTracking(), "PENDING"));
        return dto;
    }

    private Integer extractUserId(String authHeader) {
        try {
            String token = authHeader.replace("Bearer ", "");
            String username = jwtUtil.extractUsername(token);
            return userRepository.findByUsername(username).map(User::getId).orElse(null);
        } catch (Exception e) {
            return null;
        }
    }
}
