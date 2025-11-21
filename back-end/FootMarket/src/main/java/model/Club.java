package model;

import java.io.Serializable;
import jakarta.persistence.*;
import java.util.List;


/**
 * The persistent class for the clubs database table.
 * 
 */
@Entity
@Table(name="clubs")
@NamedQuery(name="Club.findAll", query="SELECT c FROM Club c")
public class Club implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private long id;

	private String country;

	@Column(name="founded_year")
	private int foundedYear;

	private String name;

	//bi-directional many-to-one association to Player
	@OneToMany(mappedBy="club")
	private List<Player> players;

	//bi-directional many-to-one association to Transfer
	@OneToMany(mappedBy="fromClub")
	private List<Transfer> transfers1;

	//bi-directional many-to-one association to Transfer
	@OneToMany(mappedBy="toClub")
	private List<Transfer> transfers2;

	//bi-directional many-to-one association to Watchlist
	@OneToMany(mappedBy="club")
	private List<Watchlist> watchlists;

	public Club() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getCountry() {
		return this.country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public int getFoundedYear() {
		return this.foundedYear;
	}

	public void setFoundedYear(int foundedYear) {
		this.foundedYear = foundedYear;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<Player> getPlayers() {
		return this.players;
	}

	public void setPlayers(List<Player> players) {
		this.players = players;
	}

	public Player addPlayer(Player player) {
		getPlayers().add(player);
		player.setClub(this);

		return player;
	}

	public Player removePlayer(Player player) {
		getPlayers().remove(player);
		player.setClub(null);

		return player;
	}

	public List<Transfer> getTransfers1() {
		return this.transfers1;
	}

	public void setTransfers1(List<Transfer> transfers1) {
		this.transfers1 = transfers1;
	}

	public Transfer addTransfers1(Transfer transfers1) {
		getTransfers1().add(transfers1);
		transfers1.setFromClub(this);

		return transfers1;
	}

	public Transfer removeTransfers1(Transfer transfers1) {
		getTransfers1().remove(transfers1);
		transfers1.setFromClub(null);

		return transfers1;
	}

	public List<Transfer> getTransfers2() {
		return this.transfers2;
	}

	public void setTransfers2(List<Transfer> transfers2) {
		this.transfers2 = transfers2;
	}

	public Transfer addTransfers2(Transfer transfers2) {
		getTransfers2().add(transfers2);
		transfers2.setToClub(this);

		return transfers2;
	}

	public Transfer removeTransfers2(Transfer transfers2) {
		getTransfers2().remove(transfers2);
		transfers2.setToClub(null);

		return transfers2;
	}

	public List<Watchlist> getWatchlists() {
		return this.watchlists;
	}

	public void setWatchlists(List<Watchlist> watchlists) {
		this.watchlists = watchlists;
	}

	public Watchlist addWatchlist(Watchlist watchlist) {
		getWatchlists().add(watchlist);
		watchlist.setClub(this);

		return watchlist;
	}

	public Watchlist removeWatchlist(Watchlist watchlist) {
		getWatchlists().remove(watchlist);
		watchlist.setClub(null);

		return watchlist;
	}

}