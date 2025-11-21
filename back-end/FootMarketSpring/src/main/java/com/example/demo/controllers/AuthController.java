package com.example.demo.controllers;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.*;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

import com.example.demo.security.JwtUtils;

record LoginRequest(String username, String password) {}
record JwtResponse(String token, String username) {}

@RestController
@RequestMapping("/auth")
@CrossOrigin(origins = "http://localhost:4200")
public class AuthController {

    private final AuthenticationManager authManager;
    private final JwtUtils jwtUtils;

    public AuthController(AuthenticationManager authManager, JwtUtils jwtUtils) {
        this.authManager = authManager;
        this.jwtUtils = jwtUtils;
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody Map<String, String> body) {
        String username = body.get("username");
        String password = body.get("password");

        UsernamePasswordAuthenticationToken authReq =
                new UsernamePasswordAuthenticationToken(username, password);
        Authentication auth = authManager.authenticate(authReq);

        UserDetails principal = (UserDetails) auth.getPrincipal();
        String token = jwtUtils.generateToken(principal.getUsername(), principal.getAuthorities());
        Map<String, Object> resp = new HashMap<>();
        resp.put("token", token);
        resp.put("username", principal.getUsername());
        resp.put("roles", principal.getAuthorities().stream()
                .map(ga -> ga.getAuthority().replace("ROLE_", ""))
                .toList());
        return ResponseEntity.ok(resp);
    }

}
