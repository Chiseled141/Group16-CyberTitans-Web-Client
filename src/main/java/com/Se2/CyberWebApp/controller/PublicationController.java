package com.Se2.CyberWebApp.controller;

import com.Se2.CyberWebApp.entity.Publication;
import com.Se2.CyberWebApp.entity.PublicationType;
import com.Se2.CyberWebApp.repository.PublicationRepository;
import com.Se2.CyberWebApp.repository.PublicationTypeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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
