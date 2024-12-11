package com.Hotel_Riu.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.sql.Date;
import lombok.Data;

@Entity
@Table(name="HOTEL_TB") 
public class Hotel implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_HOTEL")
    private Long id_hotel;
       
    @Column(name = "NOMBRE", nullable = false)
    private String nombre;

    @Column(name = "TELEFONO", nullable = false)
    private String telefono;

    @Column(name = "CORREO", nullable = false)
    private String correo;

    @OneToOne
    @JoinColumn(name = "ID_DIRECCION")
    private Direccion direccion;
    
    @ManyToOne
    @JoinColumn(name = "ID_HORARIO", nullable = false)
    private Horario horario; 
    
    public Hotel() {
    }

    public Hotel(Long id_hotel, String nombre, String telefono, String correo, Direccion direccion, Horario horario) {
        this.id_hotel = id_hotel;
        this.nombre = nombre;
        this.telefono = telefono;
        this.correo = correo;
        this.direccion = direccion;
        this.horario = horario;
    }

    public Long getId_hotel() {
        return id_hotel;
    }

    public void setId_hotel(Long id_hotel) {
        this.id_hotel = id_hotel;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public Direccion getDireccion() {
        return direccion;
    }

    public void setDireccion(Direccion direccion) {
        this.direccion = direccion;
    }

    public Horario getHorario() {
        return horario;
    }

    public void setHorario(Horario horario) {
        this.horario = horario;
    }


    
}
