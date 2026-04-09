package com.Se2.CyberWebApp.controller;

import com.Se2.CyberWebApp.entity.Project;
import com.Se2.CyberWebApp.entity.User;
import com.Se2.CyberWebApp.repository.ProjectRepository;
import com.Se2.CyberWebApp.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.*;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/v1")
public class ProjectController {

    @Autowired
    private ProjectRepository projectRepository;

    @Autowired
    private UserRepository userRepository;

    @GetMapping("/projects")
    public List<Map<String, Object>> getProjects() {
        List<Project> projects = projectRepository.findByStatusOrderByCreatedAtDesc((short) 1);
        return projects.stream().map(p -> toDto(p, false)).collect(Collectors.toList());
    }

    @GetMapping("/projects/{id}")
    public ResponseEntity<?> getProject(@PathVariable Integer id) {
        return projectRepository.findById(id)
                .map(p -> ResponseEntity.ok(toDto(p, true)))
                .orElse(ResponseEntity.notFound().build());
    }

    private Map<String, Object> toDto(Project p, boolean includeDetail) {
        Map<String, Object> dto = new LinkedHashMap<>();
        dto.put("id",          p.getId());
        dto.put("name",        p.getName());
        dto.put("description", p.getDescription());
        dto.put("image",       p.getImage());
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
