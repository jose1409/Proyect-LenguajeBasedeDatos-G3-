/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.Hotel_Riu.service;

import com.Hotel_Riu.domain.Empleado;
import java.util.List;

/**
 *
 * @author dvela
 */
public interface EmpleadoService {
    
    public List<Empleado>getEmpleados();
    
    public void agregarEmpleado(Empleado empleado);
    
    public void actualizarEmpleado(Empleado empleado);
    
    public Empleado obtenerEmpleadoPorID(Long id);
    
    public void eliminarEmpleado(Long idEmpleado);
    
}
