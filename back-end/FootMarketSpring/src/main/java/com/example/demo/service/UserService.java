package com.example.demo.service;

import model.Role;
import model.User;
import com.example.demo.repository.UserRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class UserService {
	
	@Autowired
    private UserRepository userRepository;
	
	@Autowired
    private PasswordEncoder passwordEncoder;

	public List<User> getAll() {
		return userRepository.findAll();
	}

	public User getById(Long id) {
		return userRepository.findById(id).orElse(null);
	}

	public User save(User user) {
		return userRepository.save(user);
	}

	public void delete(Long id) {
		userRepository.deleteById(id);
	}
	
	public List<User> getUsersByRole(Role role) {
	    return userRepository.findByRole(role);
	}
	
	public boolean existsByUsername(String username) {
	    return userRepository.existsByUsername(username);
	}

	public boolean existsByEmail(String email) {
	    return userRepository.existsByEmail(email);
	}
	
	public boolean registerUser(User user) {
        if (userRepository.existsByUsername(user.getUsername())) {
            return false; // korisnik vec postoji
        }
        
        if (userRepository.existsByEmail(user.getEmail())) {
            return false; // email vec postoji
        }
        
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        
        userRepository.save(user);
        return true;
    }

    public Optional<User> login(String username, String password) {
        Optional<User> userOpt = userRepository.findByUsername(username);
        if (userOpt.isPresent() && userOpt.get().getPassword().equals(password)) {
            return userOpt;
        }
        return Optional.empty();
    }
}
