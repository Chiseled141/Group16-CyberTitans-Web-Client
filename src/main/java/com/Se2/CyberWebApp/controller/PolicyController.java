package com.Se2.CyberWebApp.controller;

import com.Se2.CyberWebApp.entity.Policy;
import com.Se2.CyberWebApp.repository.PolicyRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/v1")
public class PolicyController {

    @Autowired
    private PolicyRepository policyRepository;

    @GetMapping("/policies")
    public List<Map<String, Object>> getPolicies(@RequestParam(required = false) String type) {
        List<Policy> policies = (type != null)
                ? policyRepository.findByTypeAndStatusOrderByIdAsc(type, (short) 1)
                : policyRepository.findByStatusOrderByIdAsc((short) 1);

        return policies.stream().map(p -> {
            Map<String, Object> dto = new LinkedHashMap<>();
            dto.put("id",          p.getId());
            dto.put("title",       p.getTitle());
            dto.put("slug",        p.getSlug());
            dto.put("content",     p.getContent());
            dto.put("contentHtml", p.getContentHtml());
            dto.put("type",        p.getType());
            dto.put("category",    p.getCategory());
            dto.put("version",     p.getVersion());
            return dto;
        }).collect(Collectors.toList());
    }
}
