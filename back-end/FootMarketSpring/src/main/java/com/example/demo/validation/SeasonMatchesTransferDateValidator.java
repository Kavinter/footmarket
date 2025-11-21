package com.example.demo.validation;

import com.example.demo.DTO.TransferDTO;
import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;

import java.time.LocalDate;
import java.time.ZoneId;

public class SeasonMatchesTransferDateValidator implements ConstraintValidator<SeasonMatchesTransferDate, TransferDTO> {

    @Override
    public boolean isValid(TransferDTO dto, ConstraintValidatorContext context) {
        if (dto == null || dto.getSeason() == null || dto.getTransferDate() == null)
            return true;

        try {
            String[] parts = dto.getSeason().split("/");
            if (parts.length != 2) return false;

            int startYear = Integer.parseInt(parts[0]);
            int endYear = Integer.parseInt(parts[1]);

            startYear += 2000;
            endYear += 2000;

            LocalDate start = LocalDate.of(startYear, 8, 1);
            LocalDate end = LocalDate.of(endYear, 5, 30);

            LocalDate transferDate = dto.getTransferDate()
                    .toInstant()
                    .atZone(ZoneId.systemDefault())
                    .toLocalDate();

            boolean valid = !transferDate.isBefore(start) && !transferDate.isAfter(end);

            if (!valid) {
                context.disableDefaultConstraintViolation();
                context.buildConstraintViolationWithTemplate(
                        "Datum transfera mora biti između 1. avgusta " + startYear +
                        " i 30. maja " + endYear + ".")
                        .addPropertyNode("transferDate")
                        .addConstraintViolation();
            }

            return valid;
        } catch (Exception e) {
            return false;
        }
    }
}
