package com.example.demo.DTO;

import java.math.BigDecimal;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import model.Position;

public class PlayerDTO {

    @NotBlank(message = "Ime je obavezno")
    private String name;

    @NotNull(message = "Pozicija je obavezna")
    private Position position;

    @NotNull(message = "Klub je obavezan")
    private Long clubId;

    @NotNull(message = "Market vrednost je obavezna")
    @Positive(message = "Market vrednost mora biti pozitivan broj")
    private BigDecimal marketValue;
    
    @NotNull(message = "Godine su obavezne")
    @Positive(message = "Godine moraju biti pozitivan broj")
    private Integer age;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Long getClubId() {
		return clubId;
	}

	public void setClubId(Long clubId) {
		this.clubId = clubId;
	}

	public BigDecimal getMarketValue() {
		return marketValue;
	}

	public void setMarketValue(BigDecimal marketValue) {
		this.marketValue = marketValue;
	}

	public Position getPosition() {
		return position;
	}

	public void setPosition(Position position) {
		this.position = position;
	}
	
	public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }
	
    
}
