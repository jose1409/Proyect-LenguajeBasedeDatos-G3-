/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.Hotel_Riu.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.sql.Date;
import lombok.Data;

/**
 *
 * @author dvela
 */
@Data
@Entity
@Table(name = "EMPLEADO_TB")
public class Empleado implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_EMPLEADO")
    private Long id_empleado;

    @Column(name = "ID_HOTEL")
    private Long id_hotel;

    @Column(name = "ESTADO")
    private String estado;

    @Column(name = "PUESTO")
    private String puesto;

    @Column(name = "SALARIO")
    private Double salario;

    @Column(name = "FECHA_INGRESO")
    private Date fecha_ingreso;

    @OneToOne
    @JoinColumn(name = "ID_PERSONA")
    Persona persona;

    public Empleado() {
    }

    public Empleado(Long id_empleado, Long id_hotel, String estado, String puesto, Double salario, Date fecha_ingreso, Persona persona) {
        this.id_empleado = id_empleado;
        this.id_hotel = id_hotel;
        this.estado = estado;
        this.puesto = puesto;
        this.salario = salario;
        this.fecha_ingreso = fecha_ingreso;
        this.persona = persona;
    }

    // Getters y Setters
    public Long getId_empleado() {
        return id_empleado;
    }

    public void setId_empleado(Long id_empleado) {
        this.id_empleado = id_empleado;
    }

    public Long getId_hotel() {
        return id_hotel;
    }

    public void setId_hotel(Long id_hotel) {
        this.id_hotel = id_hotel;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getPuesto() {
        return puesto;
    }

    public void setPuesto(String puesto) {
        this.puesto = puesto;
    }

    public Double getSalario() {
        return salario;
    }

    public void setSalario(Double salario) {
        this.salario = salario;
    }

    public Date getFecha_ingreso() {
        return fecha_ingreso;
    }

    public void setFecha_ingreso(Date fecha_ingreso) {
        this.fecha_ingreso = fecha_ingreso;
    }

    public Persona getPersona() {
        return persona;
    }

    public void setPersona(Persona persona) {
        this.persona = persona;
    }
}
