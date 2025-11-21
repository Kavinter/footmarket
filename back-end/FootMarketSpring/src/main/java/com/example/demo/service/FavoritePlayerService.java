package com.example.demo.service;

import model.FavoritePlayer;
import model.Player;
import model.User;

import com.example.demo.repository.FavoritePlayerRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class FavoritePlayerService {
	
	@Autowired
    private FavoritePlayerRepository favoritePlayerRepository;

	public List<FavoritePlayer> getAll() {
		return favoritePlayerRepository.findAll();
	}

	public FavoritePlayer getById(Long id) {
		return favoritePlayerRepository.findById(id).orElse(null);
	}

	public FavoritePlayer save(FavoritePlayer fp) {
		return favoritePlayerRepository.save(fp);
	}

	public void delete(Long id) {
		favoritePlayerRepository.deleteById(id);
	}
	
	public List<FavoritePlayer> getFavoritesByUser(User user) {
        return favoritePlayerRepository.findByUser(user);
    }

    public FavoritePlayer getByUserAndPlayer(User user, Player player) {
        return favoritePlayerRepository.findByUserIdAndPlayerId(user.getId(), player.getId());
    }

    public FavoritePlayer getByUser(User user) {
        return favoritePlayerRepository.findByUserId(user.getId());
    }

    public void addFavorite(User user, Player player) {
        FavoritePlayer favorite = new FavoritePlayer();
        favorite.setUser(user);
        favorite.setPlayer(player);
        favoritePlayerRepository.save(favorite);
    }

    public void removeFavorite(User user) {
        FavoritePlayer favorite = favoritePlayerRepository.findByUserId(user.getId());
        if (favorite != null) {
            favoritePlayerRepository.delete(favorite);
        }
    }
	
}

