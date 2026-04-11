package com.Se2.CyberWebApp.controller;

import com.Se2.CyberWebApp.entity.Publication;
import com.Se2.CyberWebApp.entity.PublicationType;
import com.Se2.CyberWebApp.entity.User;
import com.Se2.CyberWebApp.repository.PublicationRepository;
import com.Se2.CyberWebApp.repository.PublicationTypeRepository;
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
@RequestMapping("/api/v1")
public class PublicationController {

    @Autowired
    private PublicationRepository publicationRepository;

    @Autowired
    private PublicationTypeRepository publicationTypeRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private JwtUtil jwtUtil;

    @PostMapping("/publications")
    public ResponseEntity<?> createPublication(@RequestBody Map<String, Object> body,
                                               @RequestHeader("Authorization") String authHeader) {
        try {
            String token = authHeader.replace("Bearer ", "");
            String username = jwtUtil.extractUsername(token);
            User creator = userRepository.findByUsername(username).orElse(null);
            if (creator == null) return ResponseEntity.status(401).body(Map.of("message", "Unauthorized"));

            Publication p = new Publication();
            p.setTitle(body.getOrDefault("title", "Untitled").toString());
            p.setAuthors(body.getOrDefault("authors", creator.getName()).toString());
            p.setAbstractText(body.containsKey("abstractText") ? body.get("abstractText").toString() : "");
            p.setKeyword(body.containsKey("keyword") ? body.get("keyword").toString() : "");
            p.setYear(body.containsKey("year") ? Integer.parseInt(body.get("year").toString()) : LocalDateTime.now().getYear());
            p.setType(body.containsKey("type") ? Short.parseShort(body.get("type").toString()) : (short) 1);
            p.setJournal(body.containsKey("journal") ? body.get("journal").toString() : null);
            p.setPublisher(body.containsKey("publisher") ? body.get("publisher").toString() : null);
            p.setUrl(body.containsKey("url") ? body.get("url").toString() : null);
            p.setTeamAbbr(creator.getName());
            p.setStatus((short) 1);

            String rawSlug = p.getTitle().toLowerCase().replaceAll("[^a-z0-9]+", "-");
            p.setSlug(rawSlug + "-" + System.currentTimeMillis());
            p.setCreatedAt(LocalDateTime.now());
            p.setUpdatedAt(LocalDateTime.now());

            publicationRepository.save(p);
            return ResponseEntity.ok(Map.of("message", "Publication submitted", "id", p.getId()));
        } catch (Exception e) {
            return ResponseEntity.status(500).body(Map.of("message", "Failed to submit publication"));
        }
    }

    @GetMapping("/publications")
    public List<Map<String, Object>> getPublications() {
        // Build type lookup from DB
        Map<Integer, String> typeNames = publicationTypeRepository.findByStatusOrderByIdAsc((short) 1)
                .stream().collect(Collectors.toMap(
                        t -> t.getId(),
                        t -> t.getName(),
                        (a, b) -> a,
                        LinkedHashMap::new
                ));

        List<Publication> publications = publicationRepository.findByStatusOrderByYearDesc((short) 1);

        return publications.stream().map(p -> {
            Map<String, Object> dto = new LinkedHashMap<>();
            dto.put("id",           p.getId());
            dto.put("title",        p.getTitle());
            dto.put("authors",      p.getAuthors());
            dto.put("year",         p.getYear());
            dto.put("type",         p.getType());
            dto.put("typeName",     typeNames.getOrDefault(p.getType() != null ? p.getType().intValue() : 0, "Other"));
            dto.put("journal",      p.getJournal());
            dto.put("publisher",    p.getPublisher());
            dto.put("school",       p.getSchool());
            dto.put("institution",  p.getInstitution());
            dto.put("volume",       p.getVolume());
            dto.put("number",       p.getNumber());
            dto.put("pages",        p.getPages());
            dto.put("issn",         p.getIssn());
            dto.put("doi",          p.getDoi());
            dto.put("url",          p.getUrl());
            dto.put("featureImage", p.getFeatureImage());
            dto.put("abstractText", p.getAbstractText());
            dto.put("keyword",      p.getKeyword());
            dto.put("teamAbbr",     p.getTeamAbbr());
            return dto;
        }).collect(Collectors.toList());
    }
}
