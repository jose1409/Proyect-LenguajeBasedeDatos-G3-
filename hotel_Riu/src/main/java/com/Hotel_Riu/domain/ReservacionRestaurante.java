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
import java.sql.Date;

@Entity
@Table(name = "RESERVACION_RESTAURANTE_TB")
public class ReservacionRestaurante implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_RESERVACION_RESTAURANTE")
    private Long idReservacionRestaurante;

    @ManyToOne
    @JoinColumn(name = "ID_CLIENTE")
    private Cliente cliente;
    
    @Column(name = "HORA_ENTRADA")
    private String horaEntrada;

    @Column(name = "FECHA_RESRVACION")
    private java.sql.Date fechaReservacion;

    public ReservacionRestaurante() {
    }

    public ReservacionRestaurante(Long idReservacionRestaurante, Cliente cliente, String horaEntrada, Date fechaReservacion) {
        this.idReservacionRestaurante = idReservacionRestaurante;
        this.cliente = cliente;
        this.horaEntrada = horaEntrada;
        this.fechaReservacion = fechaReservacion;
    }

    public Long getIdReservacionRestaurante() {
        return idReservacionRestaurante;
    }

    public void setIdReservacionRestaurante(Long idReservacionRestaurante) {
        this.idReservacionRestaurante = idReservacionRestaurante;
    }

    public Cliente getCliente() {
        return cliente;
    }

    public void setCliente(Cliente cliente) {
        this.cliente = cliente;
    }

    public String getHoraEntrada() {
        return horaEntrada;
    }

    public void setHoraEntrada(String horaEntrada) {
        this.horaEntrada = horaEntrada;
    }

    public Date getFechaReservacion() {
        return fechaReservacion;
    }

    public void setFechaReservacion(Date fechaReservacion) {
        this.fechaReservacion = fechaReservacion;
    }
    
    
    
    
}
