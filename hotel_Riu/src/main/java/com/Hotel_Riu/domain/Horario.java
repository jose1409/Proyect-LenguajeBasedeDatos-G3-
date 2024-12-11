package com.Hotel_Riu.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.sql.Date;
import java.sql.Time;
import java.util.List;

@Entity
@Table(name = "HORARIO_TB")
public class Horario implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id_horario;

    @Column(name = "fecha_horario", nullable = false)
    private Date fecha_horario;

    @Column(name = "hora_apertura", nullable = false)
    private String hora_apertura;

    @Column(name = "hora_cierre", nullable = false)
    private String hora_cierre;

    @OneToMany(mappedBy = "horario") 
    private List<Hotel> hoteles;
    
    public Horario() {
    }

    public Horario(Long id_horario, Date fecha_horario, String hora_apertura, String hora_cierre) {
        this.id_horario = id_horario;
        this.fecha_horario = fecha_horario;
        this.hora_apertura = hora_apertura;
        this.hora_cierre = hora_cierre;
    }

    public void setId_horario(Long id_horario) {
        this.id_horario = id_horario;
    }

    public void setFecha_horario(Date fecha_horario) {
        this.fecha_horario = fecha_horario;
    }

    public void setHora_apertura(String hora_apertura) {
        this.hora_apertura = hora_apertura;
    }

    public void setHora_cierre(String hora_cierre) {
        this.hora_cierre = hora_cierre;
    }

    public Long getId_horario() {
        return id_horario;
    }

    public Date getFecha_horario() {
        return fecha_horario;
    }

    public String getHora_apertura() {
        return hora_apertura;
    }

    public String getHora_cierre() {
        return hora_cierre;
    }
    
}
