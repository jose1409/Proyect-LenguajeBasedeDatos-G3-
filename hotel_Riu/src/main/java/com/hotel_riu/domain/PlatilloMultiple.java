package com.hotel_riu.domain;


import jakarta.persistence.*;
import lombok.Data;

import java.io.Serializable;

@Data
@Entity
@Table(name = "PLATILLO_MULTIPLE_TB")
public class PlatilloMultiple implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "ID_PLATILLO_MULTIPLE")
    private Long idPlatilloMultiple;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ID_PLATILLO", referencedColumnName = "ID_PLATILLO", nullable = false)
    private Platillo platillo;  // Relación con la tabla PLATILLO_TB

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ID_FACT_RESTAURANTE", referencedColumnName = "ID_FACT_RESTAURANTE", nullable = false)
    private FacRestaurante facRestaurante;  // Relación con la tabla FAC_RESTAURANTE_TB
}
