package com.example.demo.repository;

import model.Transfer;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface TransferRepository extends JpaRepository<Transfer, Long> {

	List<Transfer> findByPlayerId(Long playerId);

	List<Transfer> findByToClub_Id(Long clubId);

	List<Transfer> findByFromClub_Id(Long clubId);

    @Query("SELECT t FROM Transfer t WHERE t.transferDate BETWEEN :startDate AND :endDate")
    List<Transfer> findBySeason(Date startDate, Date endDate);
    
    @Query("SELECT t FROM Transfer t WHERE t.player.name = :playerName AND t.transferDate = :transferDate")
    Transfer findByPlayerNameAndDate(String playerName, Date transferDate);

    void deleteByPlayer_NameAndTransferDate(String playerName, Date transferDate);
}
