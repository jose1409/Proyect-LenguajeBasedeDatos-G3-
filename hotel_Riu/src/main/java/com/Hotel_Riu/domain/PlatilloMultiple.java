package com.Hotel_Riu.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;


@Entity
@Table(name = "PLATILLO_MULTIPLE_TB")
public class PlatilloMultiple {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_PLATILLO_MULTIPLE")
    private Long idPlatilloMultiple;

    @ManyToOne
    @JoinColumn(name = "ID_PLATILLO")
    private Platillo platillo;

    @ManyToOne
    @JoinColumn(name = "ID_FACT_RESTAURANTE")
    private FacRestaurante facRestaurante;

}
