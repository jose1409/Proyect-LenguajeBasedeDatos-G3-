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
public class Cliente implements Serializable{
    
    private Long id_cliente;
    private Long id_persona;

    public Cliente() {
    }

    public Cliente(Long id_cliente, Long id_persona) {
        this.id_cliente = id_cliente;
        this.id_persona = id_persona;
    }
}
