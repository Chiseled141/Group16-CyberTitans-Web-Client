package com.Se2.CyberWebApp.controller;

import com.Se2.CyberWebApp.entity.Project;
import com.Se2.CyberWebApp.entity.User;
import com.Se2.CyberWebApp.repository.ProjectRepository;
import com.Se2.CyberWebApp.repository.UserRepository;
import com.Se2.CyberWebApp.security.JwtUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/v1")
public class ProjectController {

    @Autowired
    private ProjectRepository projectRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private JwtUtil jwtUtil;

    @GetMapping("/projects")
    public List<Map<String, Object>> getProjects() {
        List<Project> projects = projectRepository.findByStatusOrderByCreatedAtDesc((short) 1);
        return projects.stream().map(p -> toDto(p, false)).collect(Collectors.toList());
    }

    @PostMapping("/projects")
    public ResponseEntity<?> createProject(@RequestBody Map<String, Object> body,
                                           @RequestHeader("Authorization") String authHeader) {
        try {
            String token = authHeader.replace("Bearer ", "");
            String username = jwtUtil.extractUsername(token);
            User creator = userRepository.findByUsername(username).orElse(null);
            if (creator == null) return ResponseEntity.status(401).body(Map.of("message", "Unauthorized"));

            Project p = new Project();
            p.setName(body.getOrDefault("name", "Untitled").toString());
            p.setDescription(body.containsKey("description") ? body.get("description").toString() : "");
            p.setTechnologies(body.containsKey("techStack") ? String.join(",", (List<String>) body.get("techStack")) : "");
            p.setCategoryId(1);
            p.setTeamId(creator.getId().toString());
            p.setUserId(creator.getId());
            if (body.containsKey("githubUrl")) p.setDemoUrl(body.get("githubUrl").toString());
            p.setPrice(java.math.BigDecimal.ZERO);
            p.setCoinPrice(0);
            p.setCurrencyUnit("USD");
            p.setViews(0);
            p.setRatingAvg(java.math.BigDecimal.ZERO);
            p.setRatingCount(0);
            p.setDownloadCount(0);
            p.setStatus((short) 1);

            String rawName = p.getName().toLowerCase().replaceAll("[^a-z0-9]+", "-");
            p.setSlug(rawName + "-" + System.currentTimeMillis());
            p.setCreatedAt(LocalDateTime.now());
            p.setUpdatedAt(LocalDateTime.now());

            projectRepository.save(p);
            return ResponseEntity.ok(Map.of("message", "Project created", "id", p.getId()));
        } catch (Exception e) {
            return ResponseEntity.status(500).body(Map.of("message", "Failed to create project"));
        }
    }

    @GetMapping("/projects/{id}")
    public ResponseEntity<?> getProject(@PathVariable Integer id) {
        return projectRepository.findById(id)
                .map(p -> ResponseEntity.ok(toDto(p, true)))
                .orElse(ResponseEntity.notFound().build());
    }

    @PutMapping("/projects/{id}")
    public ResponseEntity<?> updateProject(@PathVariable Integer id,
                                           @RequestBody Map<String, Object> body,
                                           @RequestHeader("Authorization") String authHeader) {
        try {
            String token = authHeader.replace("Bearer ", "");
            String username = jwtUtil.extractUsername(token);
            User requester = userRepository.findByUsername(username).orElse(null);
            if (requester == null) return ResponseEntity.status(401).body(Map.of("message", "Unauthorized"));

            return projectRepository.findById(id).map(p -> {
                if (!p.getUserId().equals(requester.getId()))
                    return ResponseEntity.status(403).<Object>body(Map.of("message", "Forbidden"));

                if (body.containsKey("name"))        p.setName(body.get("name").toString());
                if (body.containsKey("description")) p.setDescription(body.get("description").toString());
                if (body.containsKey("techStack"))   p.setTechnologies(String.join(",", (List<String>) body.get("techStack")));
                if (body.containsKey("githubUrl"))   p.setDemoUrl(body.get("githubUrl").toString());
                p.setUpdatedAt(LocalDateTime.now());
                projectRepository.save(p);
                return ResponseEntity.ok(toDto(p, false));
            }).orElse(ResponseEntity.notFound().build());
        } catch (Exception e) {
            return ResponseEntity.status(500).body(Map.of("message", "Failed to update project"));
        }
    }

    @DeleteMapping("/projects/{id}")
    public ResponseEntity<?> deleteProject(@PathVariable Integer id,
                                           @RequestHeader("Authorization") String authHeader) {
        try {
            String token = authHeader.replace("Bearer ", "");
            String username = jwtUtil.extractUsername(token);
            User requester = userRepository.findByUsername(username).orElse(null);
            if (requester == null) return ResponseEntity.status(401).body(Map.of("message", "Unauthorized"));

            return projectRepository.findById(id).map(p -> {
                if (!p.getUserId().equals(requester.getId()))
                    return ResponseEntity.status(403).<Object>body(Map.of("message", "Forbidden"));
                p.setStatus((short) 0);
                p.setUpdatedAt(LocalDateTime.now());
                projectRepository.save(p);
                return ResponseEntity.ok(Map.of("message", "Project deleted"));
            }).orElse(ResponseEntity.notFound().build());
        } catch (Exception e) {
            return ResponseEntity.status(500).body(Map.of("message", "Failed to delete project"));
        }
    }

    private Map<String, Object> toDto(Project p, boolean includeDetail) {
        Map<String, Object> dto = new LinkedHashMap<>();
        dto.put("id",          p.getId());
        dto.put("userId",      p.getUserId());
        dto.put("name",        p.getName());
        dto.put("description", p.getDescription());
        dto.put("image",       p.getImage());
        dto.put("githubUrl",   p.getDemoUrl());
        dto.put("status",      p.getStatus() == 1 ? "ACTIVE" : "INACTIVE");
        dto.put("publishedAt", p.getPublishedAt());
        dto.put("coinPrice",   p.getCoinPrice());
        dto.put("ratingAvg",   p.getRatingAvg());
        dto.put("views",       p.getViews());

        // Split CSV technologies → array
        List<String> techStack = new ArrayList<>();
        if (p.getTechnologies() != null && !p.getTechnologies().isBlank()) {
            techStack = Arrays.stream(p.getTechnologies().split(","))
                    .map(String::trim).filter(s -> !s.isEmpty())
                    .collect(Collectors.toList());
        }
        dto.put("techStack", techStack);

        // Resolve team member names from CSV of user IDs
        List<Map<String, Object>> members = new ArrayList<>();
        if (p.getTeamId() != null && !p.getTeamId().isBlank()) {
            List<Integer> ids = Arrays.stream(p.getTeamId().split(","))
                    .map(String::trim).filter(s -> !s.isEmpty())
                    .map(s -> { try { return Integer.parseInt(s); } catch (Exception e) { return null; } })
                    .filter(Objects::nonNull)
                    .collect(Collectors.toList());
            for (Integer uid : ids) {
                userRepository.findById(uid).ifPresent(u -> {
                    Map<String, Object> m = new LinkedHashMap<>();
                    m.put("memberId",   u.getId());
                    m.put("memberName", u.getName());
                    m.put("role",       u.getRoleEntity() != null ? u.getRoleEntity().getName() : "MEMBER");
                    members.add(m);
                });
            }
        }
        dto.put("members", members);

        // Totals not in DB — default 0
        dto.put("totalTasks",     0);
        dto.put("completedTasks", 0);

        return dto;
    }
}
