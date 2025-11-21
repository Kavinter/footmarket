package model;

import java.io.Serializable;
import jakarta.persistence.*;
import java.util.List;


/**
 * The persistent class for the users database table.
 * 
 */
@Entity
@Table(name="users")
@NamedQuery(name="User.findAll", query="SELECT u FROM User u")
public class User implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private long id;

	private String email;

	private String password;

	private String username;

	//bi-directional many-to-one association to FavoritePlayer
	@OneToMany(mappedBy="user")
	private List<FavoritePlayer> favoritePlayers;

	//bi-directional many-to-one association to Watchlist
	@OneToMany(mappedBy="user")
	private List<Watchlist> watchlists;

	//bi-directional many-to-one association to Role
	@ManyToOne
	private Role role;

	public User() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getUsername() {
		return this.username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public List<FavoritePlayer> getFavoritePlayers() {
		return this.favoritePlayers;
	}

	public void setFavoritePlayers(List<FavoritePlayer> favoritePlayers) {
		this.favoritePlayers = favoritePlayers;
	}

	public FavoritePlayer addFavoritePlayer(FavoritePlayer favoritePlayer) {
		getFavoritePlayers().add(favoritePlayer);
		favoritePlayer.setUser(this);

		return favoritePlayer;
	}

	public FavoritePlayer removeFavoritePlayer(FavoritePlayer favoritePlayer) {
		getFavoritePlayers().remove(favoritePlayer);
		favoritePlayer.setUser(null);

		return favoritePlayer;
	}

	public List<Watchlist> getWatchlists() {
		return this.watchlists;
	}

	public void setWatchlists(List<Watchlist> watchlists) {
		this.watchlists = watchlists;
	}

	public Watchlist addWatchlist(Watchlist watchlist) {
		getWatchlists().add(watchlist);
		watchlist.setUser(this);

		return watchlist;
	}

	public Watchlist removeWatchlist(Watchlist watchlist) {
		getWatchlists().remove(watchlist);
		watchlist.setUser(null);

		return watchlist;
	}

	public Role getRole() {
		return this.role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

}