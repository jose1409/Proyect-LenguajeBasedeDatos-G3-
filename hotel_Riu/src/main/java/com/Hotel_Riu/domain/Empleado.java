/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.Hotel_Riu.domain;

import java.io.Serializable;
import java.sql.Date;
import lombok.Data;

/**
 *
 * @author dvela
 */

@Data
public class Empleado implements Serializable{
    
    private Long id_empleado;        
    private Long id_persona;         
    private String estado;            
    private String puesto;           
    private Double salario;           
    private Date fecha_ingreso; 

    public Empleado() {
    }

    public Empleado(Long id_empleado, Long id_persona, String estado, String puesto, Double salario, Date fecha_ingreso) {
        this.id_empleado = id_empleado;
        this.id_persona = id_persona;
        this.estado = estado;
        this.puesto = puesto;
        this.salario = salario;
        this.fecha_ingreso = fecha_ingreso;
    }    
}
