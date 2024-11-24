package com.hotel_riu.domain;

import jakarta.persistence.*;

@Entity
@Table(name = "restaurante_TB")
public class Restaurante {

    @Id
    @Column(name = "ID_RESTAURANTE")
    private Long idRestaurante;

    @Column(name = "ID_HOTEL", nullable = false)
    private Long idHotel;

    @Column(name = "NOMBRE", nullable = false)
    private String nombre;
}
