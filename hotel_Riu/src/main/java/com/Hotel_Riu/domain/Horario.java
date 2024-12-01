package com.Hotel_Riu.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import java.io.Serializable;
import jakarta.persistence.Table;
import java.time.LocalTime;
import java.util.Date;

@Entity
@Table(name = "HORARIO_TB")
public class Horario implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_HORARIO")
    private Long idHorario;

    @Column(name = "FECHA_HORARIO", nullable = false)
    private Date fechaHorario;

    @Column(name = "HORA_APERTURA", nullable = false)
    private java.time.LocalTime horaApertura;

    @Column(name = "HORA_CIERRE", nullable = false)
    private java.time.LocalTime horaCierre;

    public Horario(Long idHorario, Date fechaHorario, LocalTime horaApertura, LocalTime horaCierre) {
        this.idHorario = idHorario;
        this.fechaHorario = fechaHorario;
        this.horaApertura = horaApertura;
        this.horaCierre = horaCierre;
    }

    public Horario() {
    }

    public Long getIdHorario() {
        return idHorario;
    }

    public void setIdHorario(Long idHorario) {
        this.idHorario = idHorario;
    }

    public Date getFechaHorario() {
        return fechaHorario;
    }

    public void setFechaHorario(Date fechaHorario) {
        this.fechaHorario = fechaHorario;
    }

    public LocalTime getHoraApertura() {
        return horaApertura;
    }

    public void setHoraApertura(LocalTime horaApertura) {
        this.horaApertura = horaApertura;
    }

    public LocalTime getHoraCierre() {
        return horaCierre;
    }

    public void setHoraCierre(LocalTime horaCierre) {
        this.horaCierre = horaCierre;
    }
    
    
    
    
}
