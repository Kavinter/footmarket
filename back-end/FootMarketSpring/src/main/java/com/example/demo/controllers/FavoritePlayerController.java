package com.example.demo.controllers;

import java.util.LinkedHashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

import com.example.demo.repository.UserRepository;
import com.example.demo.service.FavoritePlayerService;
import com.example.demo.service.PlayerService;

import model.FavoritePlayer;
import model.Player;
import model.User;

@RestController
@RequestMapping("/favorite")
@CrossOrigin(origins = "http://localhost:4200")
public class FavoritePlayerController {

    @Autowired
    private FavoritePlayerService favoritePlayerService;

    @Autowired
    private PlayerService playerService;

    @Autowired
    private UserRepository userRepository;

    private User currentUserOrThrow() {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = (principal instanceof UserDetails)
                ? ((UserDetails) principal).getUsername()
                : String.valueOf(principal);
        return userRepository.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("User not found: " + username));
    }

    private boolean isManager(User u) {
        return u != null && u.getRole()!=null && "MANAGER".equalsIgnoreCase(u.getRole().getName());
    }

    @GetMapping("/me")
    @PreAuthorize("hasRole('MANAGER')")
    public ResponseEntity<?> myFavorite() {
        User user = currentUserOrThrow();
        FavoritePlayer fp = favoritePlayerService.getByUser(user);
        if (fp == null) return ResponseEntity.noContent().build();

        Player p = fp.getPlayer();
        Map<String, Object> m = new LinkedHashMap<>();
        m.put("playerId", p!=null ? p.getId() : null);
        m.put("playerName", p!=null ? p.getName() : null);
        m.put("clubName", (p!=null && p.getClub()!=null) ? p.getClub().getName() : null);
        return ResponseEntity.ok(m);
    }

    @PostMapping
    @PreAuthorize("hasRole('MANAGER')")
    public ResponseEntity<?> setFavorite(@RequestBody Map<String, Long> body) {
        Long playerId = body.get("playerId");
        if (playerId == null) return ResponseEntity.badRequest().body("playerId is required");

        User user = currentUserOrThrow();
        if (!isManager(user)) return ResponseEntity.status(403).body("Samo menadžeri mogu postaviti omiljenog igrača.");

        Player player = playerService.getById(playerId);
        if (player == null) return ResponseEntity.badRequest().body("Igrač nije pronađen.");

        FavoritePlayer existing = favoritePlayerService.getByUser(user);
        if (existing != null) {
            if (existing.getPlayer()!=null && existing.getPlayer().getId() == playerId) {
                return ResponseEntity.status(208).body("Ovaj igrač je već vaš omiljeni.");
            }
            favoritePlayerService.removeFavorite(user);
        }

        favoritePlayerService.addFavorite(user, player);
        return ResponseEntity.ok().build();
    }

    @DeleteMapping
    @PreAuthorize("hasRole('MANAGER')")
    public ResponseEntity<?> removeFavorite() {
        User user = currentUserOrThrow();
        if (!isManager(user)) return ResponseEntity.status(403).body("Nemate dozvolu.");
        favoritePlayerService.removeFavorite(user);
        return ResponseEntity.noContent().build();
    }
}
