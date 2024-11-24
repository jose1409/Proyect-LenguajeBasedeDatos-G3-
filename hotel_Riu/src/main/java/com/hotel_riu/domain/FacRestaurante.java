package com.hotel_riu.domain;

import jakarta.persistence.*;
import lombok.Data;

import java.io.Serializable;

@Data
@Entity
@Table(name = "FAC_RESTAURANTE_TB")
public class FacRestaurante implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "ID_FACT_RESTAURANTE")
    private Long idFactRestaurante;

    @Column(name = "ID_RESERVACION_RESTAURANTE", nullable = false)
    private Long idReservacionRestaurante;

    @Column(name = "DESCUENTO", nullable = false)
    private Double descuento;

    @Column(name = "TOTAL_PAGO", nullable = false)
    private Double totalPago;

    @Column(name = "METODO_PAGO", nullable = false)
    private String metodoPago;
}
