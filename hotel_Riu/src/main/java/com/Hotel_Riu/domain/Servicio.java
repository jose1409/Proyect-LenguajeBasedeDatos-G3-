package com.Hotel_Riu.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Data
@Entity
@Table(name = "SERVICIO_TB")
public class Servicio {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_SERVICIO")
    private Long idServicio;
    
    @Column(name = "NOMBRE", nullable = false)
    private String nombre;

    public Servicio(Long idServicio, String nombre) {
        this.idServicio = idServicio;
        this.nombre = nombre;
    }

    public Servicio() {
    }

    public Long getIdServicio() {
        return idServicio;
    }

    public void setIdServicio(Long idServicio) {
        this.idServicio = idServicio;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    
    
    
}
