/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.Hotel_Riu.service;

import com.Hotel_Riu.domain.Persona;
import java.util.List;

/**
 *
 * @author dvela
 */
public interface PersonaService {
    
    public List<Persona>getPersonas();
    
    public void agregarPersona(Persona persona);
    
    public void actualizarPersona(Persona persona);
    
    public Persona obtenerPersonaPorID(Long id);
    
    public void eliminarPersona(Long id);
    
}
