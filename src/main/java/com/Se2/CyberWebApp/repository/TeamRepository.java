package com.Se2.CyberWebApp.repository;

import com.Se2.CyberWebApp.entity.Team;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface TeamRepository extends JpaRepository<Team, Integer> {
    Optional<Team> findByUserId(Integer userId);
}
