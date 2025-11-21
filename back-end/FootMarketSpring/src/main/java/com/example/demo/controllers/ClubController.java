package com.example.demo.controllers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.example.demo.DTO.ClubDTO;
import com.example.demo.service.ClubService;

import jakarta.validation.Valid;
import model.Club;

@RestController
@RequestMapping("/clubs")
@CrossOrigin(origins = "http://localhost:4200", allowCredentials = "true")
public class ClubController {

    @Autowired
    private ClubService clubService;

    @GetMapping
    public List<ClubDTO> list(
            @RequestParam(required = false) String country,
            @RequestParam(required = false) Integer foundedYear) {

        List<Club> entities = (country != null || foundedYear != null)
                ? clubService.searchClubs(country, foundedYear)
                : clubService.getAllClubs();

        return entities.stream().map(this::toDto).collect(Collectors.toList());
    }

    @GetMapping("/{id}")
    public ResponseEntity<ClubDTO> one(@PathVariable Long id) {
        Optional<Club> opt = clubService.findById(id);
        return opt.map(c -> ResponseEntity.ok(toDto(c)))
                  .orElseGet(() -> ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<?> create(@Valid @RequestBody ClubDTO dto) {
        Optional<Club> existing = clubService.findByName(dto.getName());
        if (existing.isPresent()) {
            Map<String, String> err = new HashMap<>();
            err.put("error", "Klub sa tim imenom već postoji.");
            return ResponseEntity.badRequest().body(err);
        }

        clubService.addClub(dto);

        Optional<Club> saved = clubService.findByName(dto.getName());
        if (saved.isPresent()) {
            return ResponseEntity.ok(toDto(saved.get()));
        }

        return ResponseEntity.ok(dto);
    }

    @PutMapping("/{id}")
    public ResponseEntity<ClubDTO> update(@PathVariable Long id, @Valid @RequestBody ClubDTO dto) {
        Optional<Club> opt = clubService.findById(id);
        if (opt.isEmpty()) return ResponseEntity.notFound().build();

        Club c = opt.get();
        c.setCountry(dto.getCountry());
        c.setFoundedYear(dto.getFoundedYear());
        if (dto.getName() != null && !dto.getName().isBlank()) {
            c.setName(dto.getName());
        }

        clubService.save(c);

        return ResponseEntity.ok(toDto(c));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteById(@PathVariable Long id) {
        Optional<Club> opt = clubService.findById(id);
        if (opt.isEmpty()) return ResponseEntity.notFound().build();

        clubService.deleteByName(opt.get().getName());
        return ResponseEntity.noContent().build();
    }

    @DeleteMapping("/by-name")
    public ResponseEntity<Void> deleteByName(@RequestParam String name) {
        boolean ok = clubService.deleteByName(name);
        return ok ? ResponseEntity.noContent().build()
                  : ResponseEntity.notFound().build();
    }
    
    @GetMapping("/by-name")
    public ResponseEntity<ClubDTO> findByName(@RequestParam String name) {
        Optional<Club> opt = clubService.findByName(name);
        return opt
                .map(c -> ResponseEntity.ok(toDto(c)))
                .orElseGet(() -> ResponseEntity.notFound().build());
    }

    private ClubDTO toDto(Club c) {
        ClubDTO dto = new ClubDTO();
        dto.setId(c.getId());
        dto.setName(c.getName());
        dto.setCountry(c.getCountry());
        dto.setFoundedYear(c.getFoundedYear());
        return dto;
    }
}
