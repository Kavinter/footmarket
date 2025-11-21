package model;

import java.io.Serializable;
import jakarta.persistence.*;


/**
 * The persistent class for the watchlist database table.
 * 
 */
@Entity
@NamedQuery(name="Watchlist.findAll", query="SELECT w FROM Watchlist w")
public class Watchlist implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private long id;

	//bi-directional many-to-one association to Club
	@ManyToOne
	private Club club;

	//bi-directional many-to-one association to Player
	@ManyToOne
	private Player player;

	//bi-directional many-to-one association to User
	@ManyToOne
	private User user;

	public Watchlist() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public Club getClub() {
		return this.club;
	}

	public void setClub(Club club) {
		this.club = club;
	}

	public Player getPlayer() {
		return this.player;
	}

	public void setPlayer(Player player) {
		this.player = player;
	}

	public User getUser() {
		return this.user;
	}

	public void setUser(User user) {
		this.user = user;
	}

}