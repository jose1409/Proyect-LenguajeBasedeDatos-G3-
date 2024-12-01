package com.Hotel_Riu.domain;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import java.io.Serializable;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Table(name="HABITACION_TB")
public class Habitacion implements Serializable{
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_HABITACION")
    private Long idHabitacion;


    @Column(name = "NUMERO_HABITACION", nullable = false)
    private int numeroHabitacion;

    @Column(name = "PRECIO", nullable = false)
    private int precio;

    @Column(name = "DESCRIPCION", nullable = false)
    private String descripcion;

    @Column(name = "ESTADO_LIMPIEZA", nullable = false)
    private String estadoLimpieza;

    @Column(name = "CAPACIDAD", nullable = false)
    private int capacidad;

    public Habitacion() {
    }

    public Habitacion(Long idHabitacion, int numeroHabitacion, int precio, String descripcion, String estadoLimpieza, int capacidad) {
        this.idHabitacion = idHabitacion;
        this.numeroHabitacion = numeroHabitacion;
        this.precio = precio;
        this.descripcion = descripcion;
        this.estadoLimpieza = estadoLimpieza;
        this.capacidad = capacidad;
    }

    public Long getIdHabitacion() {
        return idHabitacion;
    }

    public void setIdHabitacion(Long idHabitacion) {
        this.idHabitacion = idHabitacion;
    }

    public int getNumeroHabitacion() {
        return numeroHabitacion;
    }

    public void setNumeroHabitacion(int numeroHabitacion) {
        this.numeroHabitacion = numeroHabitacion;
    }

    public int getPrecio() {
        return precio;
    }

    public void setPrecio(int precio) {
        this.precio = precio;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getEstadoLimpieza() {
        return estadoLimpieza;
    }

    public void setEstadoLimpieza(String estadoLimpieza) {
        this.estadoLimpieza = estadoLimpieza;
    }

    public int getCapacidad() {
        return capacidad;
    }

    public void setCapacidad(int capacidad) {
        this.capacidad = capacidad;
    }
    
    
}
