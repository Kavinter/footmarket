package com.example.demo.repository;

import model.Club;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface ClubRepository extends JpaRepository<Club, Long> {
	
	Optional<Club> findByName(String name);
	
	@Query("SELECT c FROM Club c WHERE " +
	           "(:country IS NULL OR LOWER(c.country) = LOWER(:country)) AND " +
	           "(:foundedYear IS NULL OR c.foundedYear = :foundedYear)")
	List<Club> searchClubs(@Param("country") String country, @Param("foundedYear") Integer foundedYear);
	
	boolean existsByNameIgnoreCase(String name);
	
	Optional<Club> findByNameIgnoreCase(String name);
	
}