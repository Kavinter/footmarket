package com.example.demo.config;

import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import com.example.demo.service.TransferService;
import org.springframework.beans.factory.annotation.Autowired;

@Component
@EnableScheduling
public class TransferScheduler {

    @Autowired
    private TransferService transferService;

    // svaki dan u 00:00
    @Scheduled(cron = "0 0 0 * * ?")
    public void checkTransfersDaily() {
        transferService.processTransfers();
    }
}
