package com.Se2.CyberWebApp.repository;
import java.util.Optional;
import com.Se2.CyberWebApp.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserRepository extends JpaRepository<User, Integer> {
    List<User> findTop10ByOrderByPointDesc();
    Optional<User> findByUsername(String username);
}
