package com.Se2.CyberWebApp.repository;

import com.Se2.CyberWebApp.entity.Education;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface EducationRepository extends JpaRepository<Education, Integer> {
    List<Education> findByUserIdAndStatusOrderByStartYearDesc(Integer userId, Short status);
}
