package com.example.demo.repository;

import model.Club;

import model.Player;
import model.Position;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;


@Repository
public interface PlayerRepository extends JpaRepository<Player, Long> {

	List<Player> findByNameContainingIgnoreCaseAndPosition(String name, Position position);

	List<Player> findByPosition(Position position);

	List<Player> findByClubId(Long clubId);

	@Query("SELECT p FROM Player p " 
			+ "WHERE (:name IS NULL OR LOWER(p.name) LIKE LOWER(CONCAT('%', :name, '%'))) "
			+ "AND (:position IS NULL OR p.position = :position) "
			+ "AND (:club IS NULL OR LOWER(p.club.name) = LOWER(:club))"
			+ "ORDER BY p.name ASC")
	List<Player> searchPlayers(@Param("name") String name, @Param("position") Position position,
			@Param("club") String club);
	
	@Query("SELECT p FROM Player p WHERE LOWER(p.name) = LOWER(:name) AND LOWER(p.club.name) = LOWER(:clubName)")
    Optional<Player> findByNameAndClub(@Param("name") String name, @Param("clubName") String clubName);
	
	Optional<Player> findByNameAndPositionAndClub(String name, Position position, Club club);

	Player findByName(String name);
	
	boolean existsByNameAndClub(String name, Club club);
}
