/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.Hotel_Riu.service;

import com.Hotel_Riu.domain.Cliente;
import java.util.List;

/**
 *
 * @author dvela
 */
public interface ClienteService {
    
    public List<Cliente>getClientes();
    
    public void agregarCliente(Cliente cliente);
    
    public void actualizarCliente(Cliente cliente);
    
    public Cliente obtenerClientePorID(Long id);
    
    public void eliminarCliente(Long id_cliente);
    
}
