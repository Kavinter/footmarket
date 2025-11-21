package com.example.demo.controllers;

import java.util.*;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

import com.example.demo.repository.UserRepository;
import com.example.demo.service.PlayerService;
import com.example.demo.service.WatchlistService;

import model.Player;
import model.User;
import model.Watchlist;

@RestController
@RequestMapping("/watchlist")
@CrossOrigin(origins = "http://localhost:4200")
public class WatchlistController {

    @Autowired
    private WatchlistService watchlistService;

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
    public ResponseEntity<?> myWatchlist() {
        User user = currentUserOrThrow();
        List<Watchlist> list = watchlistService.getWatchlistByUser(user);

        List<Map<String, Object>> out = list.stream().map(w -> {
            Map<String, Object> m = new LinkedHashMap<>();
            m.put("playerId", w.getPlayer()!=null ? w.getPlayer().getId() : null);
            m.put("playerName", w.getPlayer()!=null ? w.getPlayer().getName() : null);
            m.put("clubName", w.getClub()!=null ? w.getClub().getName() : null);
            return m;
        }).collect(Collectors.toList());

        return ResponseEntity.ok(out);
    }

    @PostMapping
    @PreAuthorize("hasRole('MANAGER')")
    public ResponseEntity<?> addToWatchlist(@RequestBody Map<String, Long> body) {
        Long playerId = body.get("playerId");
        if (playerId == null) return ResponseEntity.badRequest().body("playerId is required");

        User user = currentUserOrThrow();
        if (!isManager(user)) return ResponseEntity.status(403).body("Samo menadžeri mogu dodavati na watchlistu.");

        Player player = playerService.getById(playerId);
        if (player == null) return ResponseEntity.badRequest().body("Igrač nije pronađen.");

        String clubName = player.getClub()!=null ? player.getClub().getName() : null;
        if ("Slobodan Igrac".equalsIgnoreCase(clubName) || "Penzionisan".equalsIgnoreCase(clubName)) {
            return ResponseEntity.badRequest().body("Ovaj igrač se ne može dodati na watchlistu.");
        }

        boolean added = watchlistService.addToWatchlist(user, player);
        if (added) return ResponseEntity.ok().build();
        return ResponseEntity.status(208).body("Igrač je već na watchlisti.");
    }

    @DeleteMapping("/{playerId}")
    @PreAuthorize("hasRole('MANAGER')")
    public ResponseEntity<?> removeFromWatchlist(@PathVariable Long playerId) {
        User user = currentUserOrThrow();
        if (!isManager(user)) return ResponseEntity.status(403).body("Nemate dozvolu.");

        Player player = playerService.getById(playerId);
        if (player == null) return ResponseEntity.badRequest().body("Igrač nije pronađen.");

        watchlistService.removeFromWatchlist(user, player);
        return ResponseEntity.noContent().build();
    }
}
