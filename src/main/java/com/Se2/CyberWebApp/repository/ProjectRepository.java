package com.Se2.CyberWebApp.repository;

import com.Se2.CyberWebApp.entity.Project;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProjectRepository extends JpaRepository<Project, Integer> {
    List<Project> findByStatusOrderByCreatedAtDesc(Short status);
}
