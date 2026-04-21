package com.Se2.CyberWebApp.controller;

import com.Se2.CyberWebApp.entity.ProjectTask;
import com.Se2.CyberWebApp.entity.User;
import com.Se2.CyberWebApp.repository.ProjectRepository;
import com.Se2.CyberWebApp.repository.ProjectTaskRepository;
import com.Se2.CyberWebApp.repository.UserRepository;
import com.Se2.CyberWebApp.security.JwtUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/v1/projects/{projectId}/tasks")
public class ProjectTaskController {

    @Autowired private ProjectTaskRepository taskRepository;
    @Autowired private ProjectRepository projectRepository;
    @Autowired private UserRepository userRepository;
    @Autowired private JwtUtil jwtUtil;

    @GetMapping
    public ResponseEntity<?> getTasks(@PathVariable Integer projectId) {
        List<Map<String, Object>> tasks = taskRepository
                .findByProjectIdOrderByCreatedAtAsc(projectId)
                .stream().map(this::toDto).collect(Collectors.toList());
        return ResponseEntity.ok(tasks);
    }

    @PostMapping
    public ResponseEntity<?> addTask(@PathVariable Integer projectId,
                                     @RequestBody Map<String, Object> body,
                                     @RequestHeader("Authorization") String authHeader) {
        User user = resolveUser(authHeader);
        if (user == null) return ResponseEntity.status(401).body(Map.of("message", "Unauthorized"));

        String title = body.getOrDefault("title", "").toString().trim();
        if (title.isEmpty()) return ResponseEntity.badRequest().body(Map.of("message", "Title is required"));

        ProjectTask task = new ProjectTask();
        task.setProjectId(projectId);
        task.setTitle(title);
        task.setDone(false);
        task.setCreatedAt(LocalDateTime.now());
        taskRepository.save(task);
        return ResponseEntity.ok(toDto(task));
    }

    @PatchMapping("/{taskId}")
    public ResponseEntity<?> toggleTask(@PathVariable Integer projectId,
                                        @PathVariable Integer taskId,
                                        @RequestBody Map<String, Object> body,
                                        @RequestHeader("Authorization") String authHeader) {
        User user = resolveUser(authHeader);
        if (user == null) return ResponseEntity.status(401).body(Map.of("message", "Unauthorized"));

        return taskRepository.findById(taskId).map(task -> {
            if (!task.getProjectId().equals(projectId))
                return ResponseEntity.status(403).<Object>body(Map.of("message", "Forbidden"));
            task.setDone(Boolean.parseBoolean(body.getOrDefault("done", "false").toString()));
            taskRepository.save(task);
            return ResponseEntity.ok(toDto(task));
        }).orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{taskId}")
    public ResponseEntity<?> deleteTask(@PathVariable Integer projectId,
                                        @PathVariable Integer taskId,
                                        @RequestHeader("Authorization") String authHeader) {
        User user = resolveUser(authHeader);
        if (user == null) return ResponseEntity.status(401).body(Map.of("message", "Unauthorized"));

        return taskRepository.findById(taskId).map(task -> {
            if (!task.getProjectId().equals(projectId))
                return ResponseEntity.status(403).<Object>body(Map.of("message", "Forbidden"));
            taskRepository.delete(task);
            return ResponseEntity.ok(Map.of("message", "Task deleted"));
        }).orElse(ResponseEntity.notFound().build());
    }

    private Map<String, Object> toDto(ProjectTask t) {
        Map<String, Object> dto = new LinkedHashMap<>();
        dto.put("id",        t.getId());
        dto.put("projectId", t.getProjectId());
        dto.put("title",     t.getTitle());
        dto.put("done",      t.getDone());
        dto.put("createdAt", t.getCreatedAt());
        return dto;
    }

    private User resolveUser(String authHeader) {
        try {
            String token = authHeader.replace("Bearer ", "");
            String username = jwtUtil.extractUsername(token);
            return userRepository.findByUsername(username).orElse(null);
        } catch (Exception e) { return null; }
    }
}
