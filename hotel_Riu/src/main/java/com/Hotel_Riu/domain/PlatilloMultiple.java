package com.Hotel_Riu.domain;

import jakarta.persistence.*;
import java.io.Serializable;
import lombok.Data;

/**
 *
 * @author Alonso Muñoz Aguilar
 */

@Data
@Entity
@Table(name = "PLATILLO_MULTIPLE_TB")
public class PlatilloMultiple implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "platillo_multiple_seq")
    @SequenceGenerator(name = "platillo_multiple_seq", sequenceName = "ID_PLATILLO_MULTIPLE_SEQ", allocationSize = 1)
    @Column(name = "ID_PLATILLO_MULTIPLE")
    private Long idPlatilloMultiple;

    @Column(name = "ID_PLATILLO", nullable = false)
    private Long idPlatillo;

    @Column(name = "ID_FACT_RESTAURANTE", nullable = false)
    private Long idFactRestaurante;

    @ManyToOne
    @JoinColumn(name = "ID_PLATILLO", referencedColumnName = "ID_PLATILLO", insertable = false, updatable = false)
    private Platillo platillo;

    @ManyToOne
    @JoinColumn(name = "ID_FACT_RESTAURANTE", referencedColumnName = "ID_FACT_RESTAURANTE", insertable = false, updatable = false)
    private FacRestaurante factRestaurante;

    public PlatilloMultiple() {
    }

    public PlatilloMultiple(Long idPlatilloMultiple, Long idPlatillo, Long idFactRestaurante) {
        this.idPlatilloMultiple = idPlatilloMultiple;
        this.idPlatillo = idPlatillo;
        this.idFactRestaurante = idFactRestaurante;
    }
}
