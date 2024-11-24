package com.hotel_riu.domain;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "PLATILLO_TB")
public class Platillo {

    @Id
    @Column(name = "ID_PLATILLO")
    private Long idPlatillo;

    @Column(name = "ID_RESTAURANTE")
    private Long idRestaurante;

    @Column(name = "NOMBRE", nullable = false)
    private String nombre;

    @Column(name = "PRECIO")
    private Double precio;

    @Column(name = "CANTIDAD")
    private Integer cantidad;
    
}
