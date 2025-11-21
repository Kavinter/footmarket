package com.example.demo.repository;

import model.Player;
import model.User;
import model.Watchlist;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface WatchlistRepository extends JpaRepository<Watchlist, Long> {
	
	List<Watchlist> findByUserId(Long userId);
	List<Watchlist> findByUser(User user);
    boolean existsByUserAndPlayer(User user, Player player);
}
