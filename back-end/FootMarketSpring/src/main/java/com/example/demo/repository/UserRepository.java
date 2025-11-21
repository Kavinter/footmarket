package com.example.demo.repository;

import model.Role;
import model.User;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


@Repository
public interface UserRepository extends JpaRepository<User, Long> {

	Optional<User> findByUsername(String username);

	List<User> findByRole(Role role);
	
	boolean existsByUsername(String username);
	
	boolean existsByEmail(String email);
}