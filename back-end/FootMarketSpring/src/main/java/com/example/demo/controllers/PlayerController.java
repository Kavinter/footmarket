package com.example.demo.controllers;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import model.Club;
import model.Player;
import model.Position;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.web.bind.annotation.*;

import com.example.demo.DTO.PlayerDTO;
import com.example.demo.service.ClubService;
import com.example.demo.service.PlayerService;

@RestController
@RequestMapping("/players")
@CrossOrigin(origins = "http://localhost:4200", allowCredentials = "true")
public class PlayerController {

    @Autowired
    private PlayerService playerService;

    @Autowired
    private ClubService clubService;

    @GetMapping
    public List<PlayerResponse> list(
            @RequestParam(required = false) String name,
            @RequestParam(required = false) String position,
            @RequestParam(required = false) String club) {

        List<Player> players;
        if ((name != null && !name.isBlank()) ||
            (position != null && !position.isBlank()) ||
            (club != null && !club.isBlank())) {

            Position posEnum = null;
            if (position != null && !position.isBlank()) {
                try { posEnum = Position.valueOf(position.toUpperCase()); } catch (IllegalArgumentException ex) { posEnum = null; }
            }
            players = playerService.searchPlayers(
                    (name != null && !name.isBlank()) ? name.trim() : null,
                    posEnum,
                    (club != null && !club.isBlank()) ? club.trim() : null
            );
        } else {
            players = playerService.getAllPlayers();
        }
        return players.stream().map(this::toResponse).collect(Collectors.toList());
    }

    @GetMapping("/{id}")
    public ResponseEntity<PlayerResponse> one(@PathVariable Long id) {
        Player p = playerService.getById(id);
        if (p == null) return ResponseEntity.notFound().build();
        return ResponseEntity.ok(toResponse(p));
    }

    @PostMapping
    public ResponseEntity<?> create(@RequestBody PlayerDTO dto) {

        if (dto.getName() == null || dto.getName().isBlank()) {
            Map<String, String> err = new HashMap<>();
            err.put("error", "Ime igrača je obavezno.");
            return ResponseEntity.badRequest().body(err);
        }
        if (dto.getClubId() == null) {
            Map<String, String> err = new HashMap<>();
            err.put("error", "Klub je obavezan.");
            return ResponseEntity.badRequest().body(err);
        }

        boolean exists = playerService.existsByNameAndClub(dto.getName(), dto.getClubId());
        if (exists) {
            Map<String, String> err = new HashMap<>();
            err.put("error", "Igrač sa tim imenom već postoji u izabranom klubu.");
            return ResponseEntity.badRequest().body(err);
        }

        playerService.addPlayer(dto);

        Club club = clubService.getById(dto.getClubId());
        Player created = null;

        if (club != null && dto.getPosition() != null) {
            created = playerService
                    .findByNameAndPositionAndClub(dto.getName(), dto.getPosition(), club)
                    .orElse(null);
        }

        if (created == null) {
            created = playerService.findByName(dto.getName());
        }

        if (created == null) {
            return ResponseEntity.ok(
                new PlayerResponse(
                    null,
                    dto.getName(),
                    dto.getPosition(),
                    dto.getClubId(),
                    (club != null ? club.getName() : null),
                    dto.getMarketValue(),
                    dto.getAge()
                )
            );
        }

        return ResponseEntity.ok(toResponse(created));
    }


    @PutMapping("/{id}")
    public ResponseEntity<PlayerResponse> update(@PathVariable Long id, @RequestBody PlayerDTO dto, Authentication auth) {
        Player existing = playerService.getById(id);
        if (existing == null) return ResponseEntity.notFound().build();

        if (dto.getName() != null) existing.setName(dto.getName());
        if (dto.getPosition() != null) existing.setPosition(dto.getPosition());
        if (dto.getClubId() != null) {
            Club club = clubService.getById(dto.getClubId());
            if (club != null) existing.setClub(club);
        }
        if (dto.getMarketValue() != null) existing.setMarketValue(dto.getMarketValue());
        if (dto.getAge() != null) existing.setAge(dto.getAge());

        Player saved;
        boolean isAdmin = auth != null && auth.getAuthorities().stream().map(GrantedAuthority::getAuthority).anyMatch(r -> r.equals("ROLE_ADMIN"));
        boolean isManager = auth != null && auth.getAuthorities().stream().map(GrantedAuthority::getAuthority).anyMatch(r -> r.equals("ROLE_MANAGER"));

        if (isAdmin) {
            saved = playerService.updatePlayerAsAdmin(existing, existing);
        } else if (isManager) {
            saved = playerService.updatePlayerAsManager(existing, existing);
        } else {
            saved = playerService.updatePlayer(existing);
        }
        return ResponseEntity.ok(toResponse(saved));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        Player p = playerService.getById(id);
        if (p == null) return ResponseEntity.notFound().build();
        playerService.deletePlayer(id);
        return ResponseEntity.noContent().build();
    }

    @DeleteMapping("/by-name")
    public ResponseEntity<Void> deleteByNameAndClub(@RequestParam String name, @RequestParam String club) {
        boolean removed = playerService.deleteByNameAndClub(name, club);
        return removed ? ResponseEntity.noContent().build() : ResponseEntity.notFound().build();
    }

    private PlayerResponse toResponse(Player p) {
        Long clubId = (p.getClub() != null ? p.getClub().getId() : null);
        String clubName = (p.getClub() != null ? p.getClub().getName() : null);
        return new PlayerResponse(
                p.getId(),
                p.getName(),
                p.getPosition(),
                clubId,
                clubName,
                p.getMarketValue(),
                p.getAge()
        );
    }

    public static class PlayerResponse {
        private Long id;
        private String name;
        private Position position;
        private Long clubId;
        private String clubName;
        private BigDecimal marketValue;
        private Integer age;

        public PlayerResponse() {}

        public PlayerResponse(Long id, String name, Position position, Long clubId, String clubName, BigDecimal marketValue, Integer age) {
            this.id = id;
            this.name = name;
            this.position = position;
            this.clubId = clubId;
            this.clubName = clubName;
            this.marketValue = marketValue;
            this.age = age;
        }

        public Long getId() { return id; }
        public void setId(Long id) { this.id = id; }

        public String getName() { return name; }
        public void setName(String name) { this.name = name; }

        public Position getPosition() { return position; }
        public void setPosition(Position position) { this.position = position; }

        public Long getClubId() { return clubId; }
        public void setClubId(Long clubId) { this.clubId = clubId; }

        public String getClubName() { return clubName; }
        public void setClubName(String clubName) { this.clubName = clubName; }

        public BigDecimal getMarketValue() { return marketValue; }
        public void setMarketValue(BigDecimal marketValue) { this.marketValue = marketValue; }

        public Integer getAge() { return age; }
        public void setAge(Integer age) { this.age = age; }
    }
}
