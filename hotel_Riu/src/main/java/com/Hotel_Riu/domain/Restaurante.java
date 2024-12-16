package com.Hotel_Riu.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import java.io.Serializable;

@Entity
@Table(name = "RESTAURANTE_TB")
public class Restaurante implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_RESTAURANTE")
    private Long idRestaurante;

    @Column(name = "NOMBRE")
    private String nombre;

    // Relación con la tabla Hotel
    @ManyToOne
    @JoinColumn(name = "ID_HOTEL")
    private Hotel hotel;

    public Restaurante() {
    }

    public Restaurante(Long idRestaurante, String nombre, Hotel hotel) {
        this.idRestaurante = idRestaurante;
        this.nombre = nombre;
        this.hotel = hotel;
    }

    public Long getIdRestaurante() {
        return idRestaurante;
    }

    public void setIdRestaurante(Long idRestaurante) {
        this.idRestaurante = idRestaurante;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public Hotel getHotel() {
        return hotel;
    }

    public void setHotel(Hotel hotel) {
        this.hotel = hotel;
    }
}
