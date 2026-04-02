package com.Se2.CyberWebApp.repository;

import com.Se2.CyberWebApp.entity.UserExperience;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface UserExperienceRepository extends JpaRepository<UserExperience, Integer> {
    List<UserExperience> findByUserIdOrderByStartDateDesc(Integer userId);
}