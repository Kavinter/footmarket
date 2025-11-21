package com.example.demo.service;

import model.Player;
import model.Transfer;

import com.example.demo.repository.PlayerRepository;
import com.example.demo.repository.TransferRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class TransferService {
	@Autowired
	private TransferRepository transferRepository;

	@Autowired
	private PlayerRepository playerRepository;

	public List<Transfer> getAll() {
		return transferRepository.findAll();
	}

	public Transfer getById(Long id) {
		return transferRepository.findById(id).orElse(null);
	}

	public Transfer save(Transfer t) {
		return transferRepository.save(t);
	}

	public void delete(Long id) {
		transferRepository.deleteById(id);
	}

	public List<Transfer> findBySeason(Date startDate, Date endDate) {
		return transferRepository.findBySeason(startDate, endDate);
	}

	public void processTransfers() {
		Date now = new Date();
		List<Transfer> all = transferRepository.findAll();
		for (Transfer t : all) {
			Player player = t.getPlayer();
			if (t.getTransferDate() != null && t.getTransferDate().before(now)) {
				if (!player.getClub().equals(t.getToClub())) {
					player.setClub(t.getToClub());
					playerRepository.save(player);
				}
			}
		}
	}

	public List<Transfer> searchTransfers(String playerName, Long clubId, String season) {
		List<Transfer> all = transferRepository.findAll();
		List<Transfer> filtered = new ArrayList<>();

		for (Transfer t : all) {
			boolean matches = true;

			if (playerName != null && !playerName.isBlank()) {
				matches &= t.getPlayer().getName().toLowerCase().contains(playerName.toLowerCase());
			}

			if (clubId != null) {
				matches &= ((t.getToClub() != null && t.getToClub().getId() == clubId)
						|| (t.getFromClub() != null && t.getFromClub().getId() == clubId));
			}

			if (season != null && !season.isBlank() && season.matches("\\d{2}/\\d{2}")) {
				try {
					int startYear = Integer.parseInt(season.substring(0, 2)) + 2000;
					int endYear = Integer.parseInt(season.substring(3, 5)) + 2000;
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
					Date startDate = sdf.parse(startYear + "-08-01");
					Date endDate = sdf.parse(endYear + "-05-30");
					matches &= !(t.getTransferDate().before(startDate) || t.getTransferDate().after(endDate));
				} catch (Exception ignored) {
				}
			}

			if (matches)
				filtered.add(t);
		}

		filtered.sort((a, b) -> b.getTransferFee().compareTo(a.getTransferFee()));

		return filtered;
	}
	
	public boolean deleteByPlayerNameAndDate(String playerName, Date transferDate) {
	    Transfer transfer = transferRepository.findByPlayerNameAndDate(playerName, transferDate);
	    if (transfer != null) {
	        transferRepository.delete(transfer);
	        return true;
	    }
	    return false;
	}

}
