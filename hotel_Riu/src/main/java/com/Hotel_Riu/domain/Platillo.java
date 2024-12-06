
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
import lombok.Data;

/**
 *
 * @author Alonso Muñoz Aguilar
 */
@Data
@Entity
@Table(name = "PLATILLO_TB")
public class Platillo implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_PLATILLO")
    private Long idPlatillo;

    @Column(name = "ID_RESTAURANTE")
    private Long idRestaurante;

    @Column(name = "NOMBRE", nullable = false, length = 100)
    private String nombre;

    @Column(name = "PRECIO")
    private Double precio;

    @Column(name = "CANTIDAD")
    private Integer cantidad;

    @ManyToOne
    @JoinColumn(name = "ID_RESTAURANTE", insertable = false, updatable = false)
    private Restaurante restaurante;

    public Platillo() {
    }

    public Platillo(Long idPlatillo, Long idRestaurante, String nombre, Double precio, Integer cantidad) {
        this.idPlatillo = idPlatillo;
        this.idRestaurante = idRestaurante;
        this.nombre = nombre;
        this.precio = precio;
        this.cantidad = cantidad;
    }

    // Getters y Setters
    public Long getIdPlatillo() {
        return idPlatillo;
    }

    public void setIdPlatillo(Long idPlatillo) {
        this.idPlatillo = idPlatillo;
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

    public Double getPrecio() {
        return precio;
    }

    public void setPrecio(Double precio) {
        this.precio = precio;
    }

    public Integer getCantidad() {
        return cantidad;
    }

    public void setCantidad(Integer cantidad) {
        this.cantidad = cantidad;
    }

    public Restaurante getRestaurante() {
        return restaurante;
    }

    public void setRestaurante(Restaurante restaurante) {
        this.restaurante = restaurante;
    }
}

