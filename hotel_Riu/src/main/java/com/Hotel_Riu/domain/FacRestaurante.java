package com.Hotel_Riu.domain;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import java.util.List;
import lombok.ToString;

@Entity
@Table(name = "FAC_RESTAURANTE_TB")
public class FacRestaurante {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_FACT_RESTAURANTE")
    private Long idFactRestaurante;

    @ManyToOne
    @JoinColumn(name = "ID_RESERVACION_RESTAURANTE")
    private ReservacionRestaurante reservacionRestaurante;

    @Column(name = "DESCUENTO")
    private int descuento;

    @Column(name = "TOTAL_PAGO")
    private int totalPago;

    @Column(name = "METODO_PAGO")
    private String metodoPago;

    @OneToMany(mappedBy = "facRestaurante", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @ToString.Exclude
    private List<PlatilloMultiple> platilloMultiple;

    public FacRestaurante() {
    }

    public FacRestaurante(Long idFactRestaurante, ReservacionRestaurante reservacionRestaurante, int descuento, int totalPago, String metodoPago, List<PlatilloMultiple> platilloMultiple) {
        this.idFactRestaurante = idFactRestaurante;
        this.reservacionRestaurante = reservacionRestaurante;
        this.descuento = descuento;
        this.totalPago = totalPago;
        this.metodoPago = metodoPago;
        this.platilloMultiple = platilloMultiple;
    }

    public FacRestaurante(Long idFactRestaurante, ReservacionRestaurante reservacionRestaurante, int descuento, int totalPago, String metodoPago) {
        this.idFactRestaurante = idFactRestaurante;
        this.reservacionRestaurante = reservacionRestaurante;
        this.descuento = descuento;
        this.totalPago = totalPago;
        this.metodoPago = metodoPago;
    }

    public Long getIdFactRestaurante() {
        return idFactRestaurante;
    }

    public void setIdFactRestaurante(Long idFactRestaurante) {
        this.idFactRestaurante = idFactRestaurante;
    }

    public ReservacionRestaurante getReservacionRestaurante() {
        return reservacionRestaurante;
    }

    public void setReservacionRestaurante(ReservacionRestaurante reservacionRestaurante) {
        this.reservacionRestaurante = reservacionRestaurante;
    }

    public int getDescuento() {
        return descuento;
    }

    public void setDescuento(int descuento) {
        this.descuento = descuento;
    }

    public int getTotalPago() {
        return totalPago;
    }

    public void setTotalPago(int totalPago) {
        this.totalPago = totalPago;
    }

    public String getMetodoPago() {
        return metodoPago;
    }

    public void setMetodoPago(String metodoPago) {
        this.metodoPago = metodoPago;
    }

    public List<PlatilloMultiple> getPlatilloMultiple() {
        return platilloMultiple;
    }

    public void setPlatilloMultiple(List<PlatilloMultiple> platilloMultiple) {
        this.platilloMultiple = platilloMultiple;
    }
    
    
}
