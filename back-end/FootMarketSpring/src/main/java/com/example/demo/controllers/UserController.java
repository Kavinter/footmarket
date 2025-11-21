package com.example.demo.controllers;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import com.example.demo.DTO.UserDTO;
import com.example.demo.service.RoleService;
import com.example.demo.service.UserService;

import jakarta.validation.Valid;
import model.Role;
import model.User;

@RestController
@RequestMapping("/auth")
@CrossOrigin(origins = "http://localhost:4200")
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private RoleService roleService;

    @PostMapping("/register")
    public ResponseEntity<?> register(@Valid @RequestBody UserDTO userDTO, BindingResult br) {

        if (br.hasErrors()) {
            return ResponseEntity.badRequest().body(fieldErrors(br));
        }

        if (userService.existsByUsername(userDTO.getUsername())) {
            return ResponseEntity.status(HttpStatus.CONFLICT)
                    .body(error("username", "Korisničko ime već postoji!"));
        }
        if (userService.existsByEmail(userDTO.getEmail())) {
            return ResponseEntity.status(HttpStatus.CONFLICT)
                    .body(error("email", "Email adresa već postoji!"));
        }

        Role role = roleService.getById(userDTO.getRoleId());
        if (role == null) {
            return ResponseEntity.badRequest()
                    .body(error("roleId", "Nepostojeća uloga."));
        }

        User user = new User();
        user.setUsername(userDTO.getUsername());
        user.setEmail(userDTO.getEmail());
        user.setPassword(userDTO.getPassword());
        user.setRole(role);

        boolean ok = userService.registerUser(user);
        if (!ok) {
            return ResponseEntity.status(HttpStatus.CONFLICT)
                    .body(error("username", "Korisničko ime ili email već postoji."));
        }

        Map<String, Object> resp = new HashMap<>();
        resp.put("message", "Uspešna registracija.");
        resp.put("username", user.getUsername());
        resp.put("role", role.getName());
        return ResponseEntity.status(HttpStatus.CREATED).body(resp);
    }

    @GetMapping("/check-username")
    public ResponseEntity<Map<String, Object>> checkUsername(@RequestParam("u") String username) {
        boolean taken = userService.existsByUsername(username);
        return ResponseEntity.ok(Map.of("username", username, "taken", taken));
    }

    @GetMapping("/check-email")
    public ResponseEntity<Map<String, Object>> checkEmail(@RequestParam("e") String email) {
        boolean taken = userService.existsByEmail(email);
        return ResponseEntity.ok(Map.of("email", email, "taken", taken));
    }

    @GetMapping("/roles")
    public ResponseEntity<?> roles() {
        return ResponseEntity.ok(
            roleService.getAll().stream()
                .map(r -> Map.of("id", r.getId(), "name", r.getName()))
                .toList()
        );
    }

    private Map<String, String> error(String field, String message) {
        Map<String, String> m = new HashMap<>();
        m.put(field, message);
        return m;
    }

    private Map<String, String> fieldErrors(BindingResult br) {
        Map<String, String> m = new HashMap<>();
        br.getFieldErrors().forEach(e -> m.put(e.getField(), e.getDefaultMessage()));
        return m;
    }
}
