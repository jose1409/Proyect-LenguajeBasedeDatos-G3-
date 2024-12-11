package com.Hotel_Riu.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.io.Serializable;

@Entity 
@Table(name= "DIRECCION_TB") //Con cual tabla mapeara el objeto
public class Direccion implements Serializable {
        
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    
    @Column(name = "ID_DIRECCION")
    private Long id_direccion;
    
    @Column(name = "PROVINCIA")
    private String provincia;
    
    @Column(name = "CANTON")
    private String canton;
    
    @Column(name = "DISTRITO")
    private String distrito;
    
    @Column(name = "DIRECCION_DETALLADA")
    private String direccion_detallada;
    
        
    public Direccion() {
    }

    public Direccion(Long id_direccion, String provincia, String canton, String distrito, String direccion_detallada) {
        this.id_direccion = id_direccion;
        this.provincia = provincia;
        this.canton = canton;
        this.distrito = distrito;
        this.direccion_detallada = direccion_detallada;
    }

    public Long getId_direccion() {
        return id_direccion;
    }

    public void setId_direccion(Long id_direccion) {
        this.id_direccion = id_direccion;
    }

    public String getProvincia() {
        return provincia;
    }

    public void setProvincia(String provincia) {
        this.provincia = provincia;
    }

    public String getCanton() {
        return canton;
    }

    public void setCanton(String canton) {
        this.canton = canton;
    }

    public String getDistrito() {
        return distrito;
    }

    public void setDistrito(String distrito) {
        this.distrito = distrito;
    }

    public String getDireccion_detallada() {
        return direccion_detallada;
    }

    public void setDireccion_detallada(String direccion_detallada) {
        this.direccion_detallada = direccion_detallada;
    }
    
}