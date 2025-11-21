package model;

import java.io.Serializable;
import jakarta.persistence.*;


/**
 * The persistent class for the favorite_players database table.
 * 
 */
@Entity
@Table(name="favorite_players")
@NamedQuery(name="FavoritePlayer.findAll", query="SELECT f FROM FavoritePlayer f")
public class FavoritePlayer implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private long id;

	//bi-directional many-to-one association to Player
	@ManyToOne
	private Player player;

	//bi-directional many-to-one association to User
	@ManyToOne
	private User user;

	public FavoritePlayer() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
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