package com.example.demo.service;

import model.Club;

import com.example.demo.DTO.ClubDTO;
import com.example.demo.repository.ClubRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class ClubService {
	
	@Autowired
	ClubRepository clubRepository;

	public List<Club> getAll() {
		return clubRepository.findAll();
	}
	
	public List<Club> findAll() {
		return clubRepository.findAll();
	}

	public Club getById(Long id) {
		return clubRepository.findById(id).orElse(null);
	}

	public Club save(Club club) {
		return clubRepository.save(club);
	}

	public void delete(Long id) {
		clubRepository.deleteById(id);
	}
	
	public boolean existsByName(String name) {
        return clubRepository.existsByNameIgnoreCase(name);
    }
	
	public void addClub(ClubDTO dto) {
		
		if (existsByName(dto.getName())) {
            throw new IllegalArgumentException("Klub sa tim imenom već postoji!");
        }
		
        Club club = new Club();
        club.setName(dto.getName());
        club.setCountry(dto.getCountry());
        club.setFoundedYear(dto.getFoundedYear());
        clubRepository.save(club);
    }

    public List<Club> getAllClubs() {
        return clubRepository.findAll();
    }
    
    public List<Club> searchClubs(String country, Integer foundedYear) {
        if (country != null && country.isBlank()) {
            country = null;
        }
        return clubRepository.searchClubs(country, foundedYear);
    }
    
    public boolean deleteByName(String name) {
        Optional<Club> clubOpt = clubRepository.findByNameIgnoreCase(name);
        if (clubOpt.isPresent()) {
            clubRepository.delete(clubOpt.get());
            return true;
        } else {
            return false;
        }
    }
    
    public Optional<Club> findByName(String name) {
        return clubRepository.findByNameIgnoreCase(name);
    }

    public Optional<Club> findById(Long id) {
        return clubRepository.findById(id);
    }
}
