package com.Se2.CyberWebApp.repository;

import com.Se2.CyberWebApp.entity.Publication;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PublicationRepository extends JpaRepository<Publication, Integer> {
    List<Publication> findByStatusOrderByYearDesc(Short status);
}
