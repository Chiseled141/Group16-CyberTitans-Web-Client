package com.Se2.CyberWebApp.repository;

import com.Se2.CyberWebApp.entity.MentorshipRequest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MentorshipRequestRepository extends JpaRepository<MentorshipRequest, Integer> {
    List<MentorshipRequest> findByTeamIdOrderByCreatedAtDesc(Integer teamId);
    List<MentorshipRequest> findByMenteeIdOrderByCreatedAtDesc(Integer menteeId);
}
