package com.Se2.CyberWebApp.controller;

import com.Se2.CyberWebApp.entity.Education;
import com.Se2.CyberWebApp.entity.MentorshipRequest;
import com.Se2.CyberWebApp.entity.User;
import com.Se2.CyberWebApp.entity.UserExperience;
import com.Se2.CyberWebApp.repository.EducationRepository;
import com.Se2.CyberWebApp.repository.MentorshipRequestRepository;
import com.Se2.CyberWebApp.repository.UserRepository;
import com.Se2.CyberWebApp.repository.UserExperienceRepository;
import java.time.LocalDateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/v1/team")
public class TeamController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private UserExperienceRepository experienceRepository;

    @Autowired
    private EducationRepository educationRepository;

    @Autowired
    private MentorshipRequestRepository mentorshipRequestRepository;

    // --- API 1: Take list of all Mem ---
    @GetMapping("/members")
    public ResponseEntity<?> getTeamMembers() {
        List<User> users = userRepository.findAll();
        List<Map<String, Object>> teamList = new ArrayList<>();

        for (User user : users) {
            Map<String, Object> map = new HashMap<>();
            map.put("id", user.getId());
            map.put("name", user.getName());
            map.put("avatar", user.getAvatar());
            map.put("role", (user.getRoleEntity() != null) ? user.getRoleEntity().getName() : "MEMBER");

            teamList.add(map);
        }

        return ResponseEntity.ok(teamList);
    }

    // --- API 2: Detail of 1 Member ---
    @GetMapping("/members/{id}")
    public ResponseEntity<?> getMemberDetail(@PathVariable Integer id) {
        User user = userRepository.findById(id).orElse(null);
        if (user == null) {
            return ResponseEntity.notFound().build();
        }

        List<UserExperience> experiences = experienceRepository.findByUserIdOrderByStartDateDesc(id);

        Map<String, Object> response = new HashMap<>();
        response.put("id", user.getId());
        response.put("name", user.getName());
        response.put("avatar", user.getAvatar());
        response.put("role", (user.getRoleEntity() != null) ? user.getRoleEntity().getName() : "MEMBER");
        response.put("experiences", experiences);
        response.put("phone", user.getPhone() != null ? user.getPhone() : "CLASSIFIED");
        response.put("address", user.getAddress() != null ? user.getAddress() : "UNKNOWN LOCATION");
        response.put("email", user.getEmail() != null ? user.getEmail() : "ENCRYPTED");
        response.put("coin", user.getCoin() != null ? user.getCoin() : 0);

        return ResponseEntity.ok(response);
    }

    // --- API 3: Update info and coin ---
    @PutMapping("/members/{id}")
    public ResponseEntity<?> updateMemberProfile(@PathVariable Integer id, @RequestBody Map<String, Object> updateData) {
        User user = userRepository.findById(id).orElse(null);
        if (user == null) {
            return ResponseEntity.notFound().build();
        }

        if (updateData.containsKey("name")) {
            user.setName(updateData.get("name").toString());
        }
        if (updateData.containsKey("phone")) {
            user.setPhone(updateData.get("phone").toString());
        }
        if (updateData.containsKey("address")) {
            user.setAddress(updateData.get("address").toString());
        }
        if (updateData.containsKey("email")) {
            user.setEmail(updateData.get("email").toString());
        }

        if (updateData.containsKey("coin")) {
            try {
                Integer newCoinBalance = Integer.parseInt(updateData.get("coin").toString());
                user.setCoin(newCoinBalance);
            } catch (NumberFormatException e) {
                System.out.println("[SYSTEM] Lỗi định dạng số Coin: " + e.getMessage());
            }
        }

        userRepository.save(user);

        Map<String, String> response = new HashMap<>();
        response.put("message", "Tactical Data & Economy updated successfully.");
        return ResponseEntity.ok(response);
    }
    @PostMapping("/members/{mentorId}/request-mentor")
    public ResponseEntity<?> requestMentor(@PathVariable Integer mentorId, @RequestBody Map<String, Integer> requestData) {
        Integer menteeId = requestData.get("menteeId");
        int MENTOR_COST = 500; // Đặt giá thuê Mentor là 500 Coins

        // 1. Transfer coin
        User mentee = userRepository.findById(menteeId).orElse(null);
        User mentor = userRepository.findById(mentorId).orElse(null);

        if (mentee == null || mentor == null) {
            return ResponseEntity.badRequest().body(Map.of("message", "Target not found."));
        }

        // 2. Check if the sender is self-employed
        if (mentee.getId().equals(mentor.getId())) {
            return ResponseEntity.badRequest().body(Map.of("message", "Bạn không thể tự thuê chính mình!"));
        }

        // 3. Check if coin is enough
        if (mentee.getCoin() == null || mentee.getCoin() < MENTOR_COST) {
            return ResponseEntity.badRequest().body(Map.of("message", "INSUFFICIENT FUNDS: Không đủ Coin."));
        }

        // 4. Minus coin
        mentee.setCoin(mentee.getCoin() - MENTOR_COST);
        userRepository.save(mentee);

        // 5. Persist mentorship request to DB
        MentorshipRequest req = new MentorshipRequest();
        req.setMenteeId(menteeId);
        req.setTeamId(mentorId);
        req.setTopic("Mentorship Request");
        req.setMode("online");
        req.setDurationMinutes(60);
        req.setCurrencyUnit("COIN");
        req.setOfferingFee(MENTOR_COST);
        req.setTracking(0);
        req.setPaymentStatus(0);
        req.setScheduledAt(LocalDateTime.now().plusDays(7));
        req.setStatus((short) 1);
        req.setCreatedAt(LocalDateTime.now());
        req.setUpdatedAt(LocalDateTime.now());
        mentorshipRequestRepository.save(req);

        Map<String, Object> response = new HashMap<>();
        response.put("message", "Request sent successfully!");
        response.put("remainingCoins", mentee.getCoin());

        return ResponseEntity.ok(response);
    }
    // --- API: Education for a member ---
    @GetMapping("/members/{id}/education")
    public ResponseEntity<?> getMemberEducation(@PathVariable Integer id) {
        List<Education> edu = educationRepository.findByUserIdAndStatusOrderByStartYearDesc(id, (short) 1);
        List<Map<String, Object>> result = new ArrayList<>();
        for (Education e : edu) {
            Map<String, Object> m = new HashMap<>();
            m.put("id",                 e.getId());
            m.put("institution",        e.getInstitution());
            m.put("institutionLogo",    e.getInstitutionLogo());
            m.put("institutionWebsite", e.getInstitutionWebsite());
            m.put("specialization",     e.getSpecialization());
            m.put("title",              e.getTitle());
            m.put("studyMode",          e.getStudyMode());
            m.put("thesisTitle",        e.getThesisTitle());
            m.put("thesisUrl",          e.getThesisUrl());
            m.put("startYear",          e.getStartYear());
            m.put("endYear",            e.getEndYear());
            m.put("gpa",                e.getGpa());
            result.add(m);
        }
        return ResponseEntity.ok(result);
    }

    @DeleteMapping("/members/{id}")
    public ResponseEntity<?> deleteMember(@PathVariable Integer id) {
        // 1. Tìm user
        return userRepository.findById(id).map(user -> {
            // 2. Thực hiện xóa
            userRepository.delete(user);
            return ResponseEntity.ok(Map.of("message", "Operative terminated successfully."));
        }).orElse(ResponseEntity.notFound().build());
    }
}