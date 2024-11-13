/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.Hotel_Riu.domain;

import java.io.Serializable;
import lombok.Data;

/**
 *
 * @author dvela
 */

@Data
public class Persona implements Serializable {
    
    private Long id_persona;           
    private String nombre;              
    private String primer_apellido;    
    private String segundo_apellido;    
    private String tipo_documento;      
    private String cedula;            
    private String telefono;            
    private String correo;              

    public Persona() {
    }

    public Persona(Long id_persona, String nombre, String primer_apellido, String segundo_apellido, String tipo_documento, String cedula, String telefono, String correo) {
        this.id_persona = id_persona;
        this.nombre = nombre;
        this.primer_apellido = primer_apellido;
        this.segundo_apellido = segundo_apellido;
        this.tipo_documento = tipo_documento;
        this.cedula = cedula;
        this.telefono = telefono;
        this.correo = correo;
    }
}
