package com.Hotel_Riu.domain;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.SequenceGenerator;
import jakarta.persistence.Table;
import java.io.Serializable;
import lombok.Data;

/**
 *
 * @author Alonso Muñoz Aguilar
 */
@Data
@Entity
@Table(name = "RESTAURANTE_TB")
public class Restaurante implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "restaurante_seq")
    @SequenceGenerator(name = "restaurante_seq", sequenceName = "ID_RESTAURANTE_SEQ", allocationSize = 1)
    @JoinColumn(name = "ID_RESTAURANTE")
    private Long idRestaurante;

    @JoinColumn(name = "ID_HOTEL", nullable = false)
    private Long idHotel;

    @JoinColumn(name = "NOMBRE", nullable = false)
    private String nombre;

    public Restaurante() {
    }

    public Restaurante(Long idRestaurante, Long idHotel, String nombre) {
        this.idRestaurante = idRestaurante;
        this.idHotel = idHotel;
        this.nombre = nombre;
    }

    public Long getIdRestaurante() {
        return idRestaurante;
    }

    public void setIdRestaurante(Long idRestaurante) {
        this.idRestaurante = idRestaurante;
    }

    public Long getIdHotel() {
        return idHotel;
    }

    public void setIdHotel(Long idHotel) {
        this.idHotel = idHotel;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
}
