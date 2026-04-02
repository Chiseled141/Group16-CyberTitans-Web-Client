package com.Se2.CyberWebApp.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PageController {

    @GetMapping("/")
    public String index() {
        return "index";
    }

    @GetMapping("/pages/home")
    public String home() {
        return "pages/home";
    }

    @GetMapping("/pages/admin")
    public String admin() {
        return "pages/admin";
    }

    @GetMapping("/pages/faq")
    public String faq() {
        return "pages/faq";
    }

    @GetMapping("/pages/projects")
    public String projects() {
        return "pages/projects";
    }

    @GetMapping("/pages/services")
    public String services() {
        return "pages/services";
    }

    @GetMapping("/pages/community/team")
    public String team() {
        return "pages/community/team";
    }

    @GetMapping("/pages/community/contact")
    public String contact() {
        return "pages/community/contact";
    }

    @GetMapping("/pages/community/ranking")
    public String ranking() {
        return "pages/community/ranking";
    }

    @GetMapping("/pages/community/announcements")
    public String announcements() {
        return "pages/community/announcements";
    }

    @GetMapping("/pages/community/events")
    public String events() {
        return "pages/community/events";
    }

    @GetMapping("/pages/community/publications")
    public String publications() {
        return "pages/community/publications";
    }

    @GetMapping("/pages/legal/terms")
    public String terms() {
        return "pages/legal/terms";
    }

    @GetMapping("/pages/legal/privacy")
    public String privacy() {
        return "pages/legal/privacy";
    }

    @GetMapping("/pages/services/mentor")
    public String serviceMentor() {
        return "pages/services/mentor";
    }

    @GetMapping("/pages/services/workshops")
    public String serviceWorkshops() {
        return "pages/services/workshops";
    }

    @GetMapping("/pages/services/cybersec")
    public String serviceCybersec() {
        return "pages/services/cybersec";
    }

    @GetMapping("/pages/services/competitive")
    public String serviceCompetitive() {
        return "pages/services/competitive";
    }

    @GetMapping("/pages/services/webdev")
    public String serviceWebdev() {
        return "pages/services/webdev";
    }

    @GetMapping("/pages/services/incubator")
    public String serviceIncubator() {
        return "pages/services/incubator";
    }

    @GetMapping("/pages/user/profile")
    public String userProfile() {
        return "pages/user/profile";
    }

    @GetMapping("/pages/user/mentor-hub")
    public String userMentorHub() {
        return "pages/user/mentor-hub";
    }

    @GetMapping("/pages/user/permissions")
    public String userPermissions() {
        return "pages/user/permissions";
    }
}
