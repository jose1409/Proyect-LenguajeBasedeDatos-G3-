package com.Hotel_Riu.domain;

import jakarta.persistence.*;
import lombok.Data;

import java.io.Serializable;

/**
 *
 * @author Alonso Muñoz Aguilar
 */
@Data
@Entity
@Table(name = "FAC_RESTAURANTE_TB")
public class FacRestaurante implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "factura_restaurante_seq")
    @SequenceGenerator(name = "factura_restaurante_seq", sequenceName = "ID_FACT_RESTAURANTE_SEQ", allocationSize = 1)
    @Column(name = "ID_FACT_RESTAURANTE")
    private Long id_fact_restaurante;

    @Column(name = "ID_RESERVACION_RESTAURANTE")
    private Long id_reservacion_restaurante;

    @Column(name = "DESCUENTO")
    private Double descuento;

    @Column(name = "TOTAL_PAGO")
    private Double total_pago;

    @Column(name = "METODO_PAGO")
    private String metodo_pago;

    @ManyToOne
    @JoinColumn(name = "ID_RESERVACION_RESTAURANTE", insertable = false, updatable = false)
    private ReservacionRestaurante reservacionRestaurante;

    // Constructor vacío
    public FacRestaurante() {
    }

    // Constructor con parámetros
    public FacRestaurante(Long id_reservacion_restaurante, Double descuento, Double total_pago, String metodo_pago) {
        this.id_reservacion_restaurante = id_reservacion_restaurante;
        this.descuento = descuento;
        this.total_pago = total_pago;
        this.metodo_pago = metodo_pago;
    }
}
