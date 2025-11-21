package com.example.demo.DTO;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import jakarta.validation.constraints.NotNull;

public class UserDTO {

	@NotBlank(message = "Korisničko ime je obavezno.")
	@Size(min = 3, max = 20, message = "Korisničko ime mora imati između 3 i 20 karaktera.")
	private String username;

	@NotBlank(message = "Email je obavezan.")
	@Email(message = "Unesite validan email format.")
	private String email;

	@NotBlank(message = "Lozinka je obavezna.")
	@Size(min = 6, message = "Lozinka mora imati najmanje 6 karaktera.")
	private String password;

	@NotNull(message = "Uloga je obavezna.")
	private Long roleId;

	// Getteri i setteri
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Long getRoleId() {
		return roleId;
	}

	public void setRoleId(Long roleId) {
		this.roleId = roleId;
	}
}
