package com.Se2.CyberWebApp.controller;

import com.Se2.CyberWebApp.entity.MentorshipRequest;
import com.Se2.CyberWebApp.entity.Team;
import com.Se2.CyberWebApp.entity.User;
import com.Se2.CyberWebApp.repository.MentorshipRequestRepository;
import com.Se2.CyberWebApp.repository.TeamRepository;
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

    @Autowired private MentorshipRequestRepository requestRepository;
    @Autowired private UserRepository userRepository;
    @Autowired private TeamRepository teamRepository;
    @Autowired private JwtUtil jwtUtil;

    // Mentee: create a new mentorship request
    @PostMapping("/requests")
    public ResponseEntity<?> createRequest(@RequestBody Map<String, Object> body,
                                           @RequestHeader("Authorization") String authHeader) {
        Integer menteeUserId = extractUserId(authHeader);
        if (menteeUserId == null) return ResponseEntity.status(401).body(Map.of("message", "Unauthorized"));

        Object mentorIdObj = body.get("mentorId");
        if (mentorIdObj == null) return ResponseEntity.badRequest().body(Map.of("message", "mentorId is required"));

        Integer mentorUserId;
        try { mentorUserId = Integer.parseInt(mentorIdObj.toString()); }
        catch (NumberFormatException e) { return ResponseEntity.badRequest().body(Map.of("message", "Invalid mentorId")); }

        // Resolve mentor's team.id from their user.id
        Optional<Team> teamOpt = teamRepository.findByUserId(mentorUserId);
        if (teamOpt.isEmpty()) return ResponseEntity.badRequest().body(Map.of("message", "Mentor has no team profile"));
        Integer teamId = teamOpt.get().getId();

        String message = body.getOrDefault("message", "").toString().trim();

        MentorshipRequest req = new MentorshipRequest();
        req.setMenteeId(menteeUserId);
        req.setTeamId(teamId);
        req.setTopic("Mentorship Session");
        req.setDescription(message.isEmpty() ? null : message);
        req.setMode("ONLINE");
        req.setDurationMinutes(60);
        req.setOfferingFee(500);
        req.setCurrencyUnit("COINS");
        req.setScheduledAt(LocalDateTime.now().plusDays(7));
        req.setTracking(1);
        req.setPaymentStatus(9);
        req.setStatus((short) 1);
        req.setCreatedAt(LocalDateTime.now());
        req.setUpdatedAt(LocalDateTime.now());

        MentorshipRequest saved = requestRepository.save(req);
        return ResponseEntity.ok(toDto(saved));
    }

    // Mentor: get all requests sent to me
    @GetMapping("/requests")
    public List<Map<String, Object>> getMyRequests(@RequestHeader("Authorization") String authHeader) {
        Integer userId = extractUserId(authHeader);
        if (userId == null) return Collections.emptyList();

        // Resolve user.id → team.id
        Optional<Team> teamOpt = teamRepository.findByUserId(userId);
        if (teamOpt.isEmpty()) return Collections.emptyList();
        Integer teamId = teamOpt.get().getId();

        return requestRepository.findByTeamIdOrderByCreatedAtDesc(teamId).stream()
                .map(this::toDto)
                .collect(Collectors.toList());
    }

    // Mentee: get my outgoing requests
    @GetMapping("/my-requests")
    public List<Map<String, Object>> getMyOutgoingRequests(@RequestHeader("Authorization") String authHeader) {
        Integer menteeId = extractUserId(authHeader);
        if (menteeId == null) return Collections.emptyList();

        return requestRepository.findByMenteeIdOrderByCreatedAtDesc(menteeId).stream()
                .map(this::toDto)
                .collect(Collectors.toList());
    }

    // Accept request (tracking=2)
    @PostMapping("/requests/{id}/accept")
    public ResponseEntity<?> acceptRequest(@PathVariable Integer id,
                                           @RequestHeader("Authorization") String authHeader) {
        Integer userId = extractUserId(authHeader);
        Optional<Team> teamOpt = userId != null ? teamRepository.findByUserId(userId) : Optional.empty();

        return requestRepository.findById(id).map(r -> {
            if (teamOpt.isEmpty() || !r.getTeamId().equals(teamOpt.get().getId()))
                return ResponseEntity.status(403).<Map<String,Object>>body(Map.of("message", "Forbidden"));
            r.setTracking(2);
            r.setUpdatedAt(LocalDateTime.now());
            requestRepository.save(r);
            return ResponseEntity.ok(Map.of("message", "Request accepted"));
        }).orElse(ResponseEntity.notFound().build());
    }

    // Decline request (tracking=3)
    @PostMapping("/requests/{id}/decline")
    public ResponseEntity<?> declineRequest(@PathVariable Integer id,
                                            @RequestHeader("Authorization") String authHeader) {
        Integer userId = extractUserId(authHeader);
        Optional<Team> teamOpt = userId != null ? teamRepository.findByUserId(userId) : Optional.empty();

        return requestRepository.findById(id).map(r -> {
            if (teamOpt.isEmpty() || !r.getTeamId().equals(teamOpt.get().getId()))
                return ResponseEntity.status(403).<Map<String,Object>>body(Map.of("message", "Forbidden"));
            r.setTracking(3);
            r.setUpdatedAt(LocalDateTime.now());
            requestRepository.save(r);
            return ResponseEntity.ok(Map.of("message", "Request declined"));
        }).orElse(ResponseEntity.notFound().build());
    }

    // Cancel request (mentee cancels, tracking=4)
    @PostMapping("/requests/{id}/cancel")
    public ResponseEntity<?> cancelRequest(@PathVariable Integer id,
                                           @RequestHeader("Authorization") String authHeader) {
        Integer menteeId = extractUserId(authHeader);
        return requestRepository.findById(id).map(r -> {
            if (!r.getMenteeId().equals(menteeId))
                return ResponseEntity.status(403).<Map<String,Object>>body(Map.of("message", "Forbidden"));
            r.setTracking(4);
            r.setUpdatedAt(LocalDateTime.now());
            requestRepository.save(r);
            return ResponseEntity.ok(Map.of("message", "Request cancelled"));
        }).orElse(ResponseEntity.notFound().build());
    }

    private Map<String, Object> toDto(MentorshipRequest r) {
        Map<String, Object> dto = new LinkedHashMap<>();
        dto.put("id",          r.getId());
        dto.put("menteeId",    r.getMenteeId());
        dto.put("teamId",      r.getTeamId());
        dto.put("topic",       r.getTopic());
        dto.put("description", r.getDescription());
        dto.put("mode",        r.getMode());
        dto.put("duration",    r.getDurationMinutes());
        dto.put("tracking",    r.getTracking());
        dto.put("scheduledAt", r.getScheduledAt());
        dto.put("createdAt",   r.getCreatedAt());

        // Resolve mentee name from user table
        userRepository.findById(r.getMenteeId()).ifPresent(u -> dto.put("menteeName", u.getName()));

        // Resolve mentor userId and name via team → user
        // mentorId = mentor's USER id (matches what frontend uses from /api/v1/team/members)
        teamRepository.findById(r.getTeamId()).ifPresent(t -> {
            dto.put("mentorId", t.getUserId());
            if (t.getUserId() != null) {
                userRepository.findById(t.getUserId())
                    .ifPresent(u -> dto.put("mentorName", u.getName()));
            }
        });

        Map<Integer, String> labels = Map.of(
            1, "PENDING",  2, "ACCEPTED",    3, "REJECTED",
            4, "CANCELLED", 5, "IN_PROGRESS", 6, "COMPLETED",
            7, "NO_SHOW",  8, "EXPIRED"
        );
        dto.put("status", labels.getOrDefault(r.getTracking(), "PENDING"));
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
