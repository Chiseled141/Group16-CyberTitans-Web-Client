package com.Se2.CyberWebApp.repository;

import com.Se2.CyberWebApp.entity.Policy;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PolicyRepository extends JpaRepository<Policy, Integer> {
    List<Policy> findByStatusOrderByIdAsc(Short status);
    List<Policy> findByTypeAndStatusOrderByIdAsc(String type, Short status);
}
