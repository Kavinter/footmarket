package model;

import java.io.Serializable;
import jakarta.persistence.*;
import java.math.BigDecimal;
import java.util.List;


/**
 * The persistent class for the players database table.
 * 
 */
@Entity
@Table(name="players")
@NamedQuery(name="Player.findAll", query="SELECT p FROM Player p")
public class Player implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private long id;

	private int age;

	@Column(name="market_value")
	private BigDecimal marketValue;

	private String name;

	@Enumerated(EnumType.STRING)
	@Column(name="position")
	private Position position;

	//bi-directional many-to-one association to FavoritePlayer
	@OneToMany(mappedBy="player")
	private List<FavoritePlayer> favoritePlayers;

	//bi-directional many-to-one association to Club
	@ManyToOne
	private Club club;

	//bi-directional many-to-one association to Transfer
	@OneToMany(mappedBy="player")
	private List<Transfer> transfers;

	//bi-directional many-to-one association to Watchlist
	@OneToMany(mappedBy="player")
	private List<Watchlist> watchlists;

	public Player() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public int getAge() {
		return this.age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public BigDecimal getMarketValue() {
		return this.marketValue;
	}

	public void setMarketValue(BigDecimal marketValue) {
		this.marketValue = marketValue;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Position getPosition() {
		return this.position;
	}

	public void setPosition(Position position) {
		this.position = position;
	}

	public List<FavoritePlayer> getFavoritePlayers() {
		return this.favoritePlayers;
	}

	public void setFavoritePlayers(List<FavoritePlayer> favoritePlayers) {
		this.favoritePlayers = favoritePlayers;
	}

	public FavoritePlayer addFavoritePlayer(FavoritePlayer favoritePlayer) {
		getFavoritePlayers().add(favoritePlayer);
		favoritePlayer.setPlayer(this);

		return favoritePlayer;
	}

	public FavoritePlayer removeFavoritePlayer(FavoritePlayer favoritePlayer) {
		getFavoritePlayers().remove(favoritePlayer);
		favoritePlayer.setPlayer(null);

		return favoritePlayer;
	}

	public Club getClub() {
		return this.club;
	}

	public void setClub(Club club) {
		this.club = club;
	}

	public List<Transfer> getTransfers() {
		return this.transfers;
	}

	public void setTransfers(List<Transfer> transfers) {
		this.transfers = transfers;
	}

	public Transfer addTransfer(Transfer transfer) {
		getTransfers().add(transfer);
		transfer.setPlayer(this);

		return transfer;
	}

	public Transfer removeTransfer(Transfer transfer) {
		getTransfers().remove(transfer);
		transfer.setPlayer(null);

		return transfer;
	}

	public List<Watchlist> getWatchlists() {
		return this.watchlists;
	}

	public void setWatchlists(List<Watchlist> watchlists) {
		this.watchlists = watchlists;
	}

	public Watchlist addWatchlist(Watchlist watchlist) {
		getWatchlists().add(watchlist);
		watchlist.setPlayer(this);

		return watchlist;
	}

	public Watchlist removeWatchlist(Watchlist watchlist) {
		getWatchlists().remove(watchlist);
		watchlist.setPlayer(null);

		return watchlist;
	}

}