package com.example.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.repository.RoleRepository;

import model.Role;

@Service
public class RoleService {
	
	@Autowired
	private RoleRepository roleRepository;
	
	
    public List<Role> getAll() {
        return roleRepository.findAll();
    }

    public Role getById(Long id) {
        return roleRepository.findById(id).orElse(null);
    }

    public Role getByName(String name) {
        return roleRepository.findByName(name);
    }
}
