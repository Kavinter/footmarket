package com.example.demo.DTO;

import java.math.BigDecimal;
import java.util.Date;
import jakarta.validation.constraints.*;
import org.springframework.format.annotation.DateTimeFormat;
import com.example.demo.validation.SeasonMatchesTransferDate;

@SeasonMatchesTransferDate
public class TransferDTO {

    @NotBlank(message = "Ime igrača je obavezno.")
    private String playerName;

    @NotBlank(message = "Sezona je obavezna. (npr. 24/25)")
    @Pattern(regexp = "\\d{2}/\\d{2}", message = "Sezona mora biti u formatu npr. 24/25")
    private String season;

    @NotNull(message = "Naziv kluba je obavezan.")
    private String toClubName;

    @NotNull(message = "Datum transfera je obavezan.")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date transferDate;

    @NotNull(message = "Cena transfera je obavezna.")
    @DecimalMin(value = "0.0", inclusive = true, message = "Cena transfera mora biti nula ili pozitivan broj.")
    private BigDecimal transferFee;
    
    @NotNull(message = "Izlazni klub je obavezan za transfere iz prošlosti.")
    private String fromClubName;

    public String getPlayerName() {
        return playerName;
    }
    public void setPlayerName(String playerName) {
        this.playerName = playerName;
    }
    
    public String getToClubName() {
        return toClubName;
    }

    public void setToClubName(String toClubName) {
        this.toClubName = toClubName;
    }
    
    public String getFromClubName() {
    	return fromClubName;
    }
    
    public void setFromClubName(String fromClubName) {
        this.fromClubName = fromClubName;
    }

    public String getSeason() {
        return season;
    }
    public void setSeason(String season) {
        this.season = season;
    }

    public Date getTransferDate() {
        return transferDate;
    }
    public void setTransferDate(Date transferDate) {
        this.transferDate = transferDate;
    }

    public BigDecimal getTransferFee() {
        return transferFee;
    }
    public void setTransferFee(BigDecimal transferFee) {
        this.transferFee = transferFee;
    }
}
