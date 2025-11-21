package com.example.demo.security;

import java.nio.charset.StandardCharsets;
import java.security.Key;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.function.Function;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

import io.jsonwebtoken.*;
import io.jsonwebtoken.security.Keys;

@Component
public class JwtUtils {

    // Za demo: hardkodovan secret. U praksi koristi ENV/CONFIG.
    private final String jwtSecret = "super-secret-change-me-please-very-long-256-bit-key";
    private final long   jwtExpirationMs = 24 * 60 * 60 * 1000L; // 24h
    
    private final Key key = Keys.hmacShaKeyFor(jwtSecret.getBytes(StandardCharsets.UTF_8));

    public String extractUsername(String token) {
        return parseClaims(token).getSubject();
    }

    public <T> T extractClaim(String token, Function<Claims, T> claimsResolver) {
        final Claims claims = parseClaims(token);
        return claimsResolver.apply(claims);
    }

    public String generateToken(String username, Collection<? extends GrantedAuthority> authorities) {
        Date now = new Date();
        Date exp = new Date(now.getTime() + jwtExpirationMs);

        // u token stavi claim "roles": ["ADMIN","MANAGER",...]
        List<String> roles = authorities == null ? List.of()
                : authorities.stream()
                  .map(a -> a.getAuthority().replace("ROLE_", ""))
                  .collect(Collectors.toList());

        return Jwts.builder()
                .setSubject(username)
                .setIssuedAt(now)
                .setExpiration(exp)
                .claim("roles", roles)
                .signWith(key, SignatureAlgorithm.HS256)
                .compact();
    }
    
    public String generateToken(UserDetails userDetails) {
        return generateToken(userDetails.getUsername(), userDetails.getAuthorities());
    }

    public boolean isTokenValid(String token, org.springframework.security.core.userdetails.UserDetails user) {
        try {
            final Claims claims = parseClaims(token);
            String sub = claims.getSubject();
            Date exp = claims.getExpiration();
            return sub != null && sub.equals(user.getUsername()) && exp != null && exp.after(new Date());
        } catch (JwtException | IllegalArgumentException e) {
            return false;
        }
    }

    private Claims parseClaims(String token) {
        return Jwts.parserBuilder()
                .setSigningKey(key)
                .build()
                .parseClaimsJws(token)
                .getBody();
    }
}
