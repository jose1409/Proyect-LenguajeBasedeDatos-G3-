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

    @Column(name = "FECHA_HORARIO")
    private java.sql.Date fechaHorario;

    @Column(name = "HORA_APERTURA_TEMP")
    private String horaApertura;

    @Column(name = "HORA_CIERRE_TEMP")
    private String horaCierre;

    public Horario() {
    }

    public Horario(Long idHorario, java.sql.Date fechaHorario, String horaApertura, String horaCierre) {
        this.idHorario = idHorario;
        this.fechaHorario = fechaHorario;
        this.horaApertura = horaApertura;
        this.horaCierre = horaCierre;
    }

    public Long getIdHorario() {
        return idHorario;
    }

    public void setIdHorario(Long idHorario) {
        this.idHorario = idHorario;
    }

    public java.sql.Date getFechaHorario() {
        return fechaHorario;
    }

    public void setFechaHorario(java.sql.Date fechaHorario) {
        this.fechaHorario = fechaHorario;
    }

    public String getHoraApertura() {
        return horaApertura;
    }

    public void setHoraApertura(String horaApertura) {
        this.horaApertura = horaApertura;
    }

    public String getHoraCierre() {
        return horaCierre;
    }

    public void setHoraCierre(String horaCierre) {
        this.horaCierre = horaCierre;
    }
    
    
    
    
    
    
    
    
}
