package com.example.demo.service;

import org.springframework.stereotype.Service;
import javax.sql.DataSource;
import java.util.*;
import java.sql.Date;

import net.sf.jasperreports.engine.*;
import org.springframework.beans.factory.annotation.Autowired;

@Service
public class ReportService {

    @Autowired
    private DataSource dataSource;

    public byte[] generateTransfersBySeasonReport(String season) throws Exception {
        if (!season.matches("\\d{2}/\\d{2}")) {
            throw new IllegalArgumentException("Format sezone mora biti npr. 24/25");
        }

        int startYear = Integer.parseInt(season.substring(0, 2)) + 2000;
        int endYear = Integer.parseInt(season.substring(3, 5)) + 2000;

        Date startDate = Date.valueOf(startYear + "-08-01");
        Date endDate = Date.valueOf(endYear + "-05-30");

        Map<String, Object> parameters = new HashMap<>();
        parameters.put("season", season);
        parameters.put("startDate", startDate);
        parameters.put("endDate", endDate);

        JasperReport jasperReport = JasperCompileManager.compileReport(
                getClass().getResourceAsStream("/reports/TransfersBySeason.jrxml")
        );

        JasperPrint jasperPrint = JasperFillManager.fillReport(
                jasperReport, parameters, dataSource.getConnection()
        );

        return JasperExportManager.exportReportToPdf(jasperPrint);
    }
}
