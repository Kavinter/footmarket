package com.example.demo.DTO;

import jakarta.validation.constraints.NotBlank;

public class ClubSearchDTO {

    @NotBlank(message = "Ime kluba je obavezno.")
    private String name;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
