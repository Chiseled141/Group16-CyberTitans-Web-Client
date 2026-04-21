package com.Se2.CyberWebApp.repository;

import com.Se2.CyberWebApp.entity.ProjectTask;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProjectTaskRepository extends JpaRepository<ProjectTask, Integer> {
    List<ProjectTask> findByProjectIdOrderByCreatedAtAsc(Integer projectId);
    long countByProjectId(Integer projectId);
    long countByProjectIdAndDone(Integer projectId, Boolean done);
}
