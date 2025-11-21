package com.example.demo.service;

import model.Player;
import model.User;
import model.Watchlist;
import com.example.demo.repository.WatchlistRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class WatchlistService {
	
	@Autowired
    private WatchlistRepository watchlistRepository;

	public List<Watchlist> getAll() {
		return watchlistRepository.findAll();
	}

	public Watchlist getById(Long id) {
		return watchlistRepository.findById(id).orElse(null);
	}

	public Watchlist save(Watchlist w) {
		return watchlistRepository.save(w);
	}

	public void delete(Long id) {
		watchlistRepository.deleteById(id);
	}
	
	public List<Watchlist> getWatchlistByUser(User user) {
        return watchlistRepository.findByUser(user);
    }

    public boolean addToWatchlist(User user, Player player) {
        if (watchlistRepository.existsByUserAndPlayer(user, player)) {
            return false;
        }
        Watchlist w = new Watchlist();
        w.setUser(user);
        w.setPlayer(player);
        w.setClub(player.getClub());
        watchlistRepository.save(w);
        return true;
    }

    public void removeFromWatchlist(User user, Player player) {
        List<Watchlist> list = watchlistRepository.findByUser(user);
        list.stream()
            .filter(w -> w.getPlayer().equals(player))
            .findFirst()
            .ifPresent(w -> watchlistRepository.delete(w));
    }
	
    
}
