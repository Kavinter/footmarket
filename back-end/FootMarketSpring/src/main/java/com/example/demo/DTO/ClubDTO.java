package com.example.demo.DTO;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Positive;

public class ClubDTO {
	
	private long id;
	
	@NotBlank(message = "Ime kluba je obavezno.")
    private String name;

    @NotBlank(message = "Država je obavezna.")
    @Pattern(regexp = "^[^0-9]*$", message = "Država ne sme sadržati brojeve.")
    private String country;

    @Positive(message = "Godina mora biti pozitivan broj.")
    private int foundedYear;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public int getFoundedYear() {
		return foundedYear;
	}

	public void setFoundedYear(int foundedYear) {
		this.foundedYear = foundedYear;
	}
    
    
}
