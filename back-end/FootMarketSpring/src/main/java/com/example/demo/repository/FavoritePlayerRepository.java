package com.example.demo.repository;

import model.FavoritePlayer;
import model.User;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface FavoritePlayerRepository extends JpaRepository<FavoritePlayer, Long> {
	
	List<FavoritePlayer> findByUser(User user);
    FavoritePlayer findByUserId(Long userId);
    FavoritePlayer findByUserIdAndPlayerId(Long userId, Long playerId);
}
