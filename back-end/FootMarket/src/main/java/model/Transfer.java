package model;

import java.io.Serializable;
import jakarta.persistence.*;
import java.math.BigDecimal;
import java.util.Date;


/**
 * The persistent class for the transfers database table.
 * 
 */
@Entity
@Table(name="transfers")
@NamedQuery(name="Transfer.findAll", query="SELECT t FROM Transfer t")
public class Transfer implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private long id;

	@Temporal(TemporalType.DATE)
	@Column(name="transfer_date")
	private Date transferDate;

	@Column(name="transfer_fee")
	private BigDecimal transferFee;

	//bi-directional many-to-one association to Club
	@ManyToOne
	@JoinColumn(name="from_club_id")
	private Club fromClub;

	//bi-directional many-to-one association to Club
	@ManyToOne
	@JoinColumn(name="to_club_id")
	private Club toClub;

	//bi-directional many-to-one association to Player
	@ManyToOne
	private Player player;

	public Transfer() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public Date getTransferDate() {
		return this.transferDate;
	}

	public void setTransferDate(Date transferDate) {
		this.transferDate = transferDate;
	}

	public BigDecimal getTransferFee() {
		return this.transferFee;
	}

	public void setTransferFee(BigDecimal transferFee) {
		this.transferFee = transferFee;
	}

	public Club getFromClub() {
        return fromClub;
    }

    public void setFromClub(Club fromClub) {
        this.fromClub = fromClub;
    }

    public Club getToClub() {
        return toClub;
    }

    public void setToClub(Club toClub) {
        this.toClub = toClub;
    }

	public Player getPlayer() {
		return this.player;
	}

	public void setPlayer(Player player) {
		this.player = player;
	}

}