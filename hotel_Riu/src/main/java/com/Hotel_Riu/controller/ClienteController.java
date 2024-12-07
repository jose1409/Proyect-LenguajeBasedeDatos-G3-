/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.Hotel_Riu.controller;

import com.Hotel_Riu.domain.Cliente;
import com.Hotel_Riu.service.ClienteService;
import com.Hotel_Riu.service.PersonaService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 *
 * @autor dvela
 */
@Controller
@RequestMapping("/cliente")
public class ClienteController {

    private static final Logger logger = LoggerFactory.getLogger(ClienteController.class);

    @Autowired
    private ClienteService _ClienteService;

    @Autowired
    private PersonaService _PersonaService;

    @GetMapping("/inicio")
    public String inicio(Model model) {
        List<Cliente> result = _ClienteService.getClientes();
        model.addAttribute("clientes", result);
        model.addAttribute("totalClientes", result.size());
        return "layout/cliente/ListaCliente :: ListaCliente";
    }

    @GetMapping("/crear")
    public String mostrarFormulario(Model model) {
        model.addAttribute("cliente", new Cliente());
        return "layout/cliente/AgregarCliente :: AgregarCliente";
    }

    @PostMapping("/guardar")
    public String guardarCliente(@ModelAttribute Cliente cliente) {
        _PersonaService.agregarPersona(cliente.getPersona());
        cliente.getPersona().setId_persona(cliente.getPersona().getId_persona());
        _ClienteService.agregarCliente(cliente);
        return "redirect:/";
    }

    @GetMapping("/modificar/{id_cliente}")
    public String mostrarFormularioModificar(@PathVariable("id_cliente") Long id_cliente, Model model) {
        Cliente cliente = _ClienteService.obtenerClientePorID(id_cliente);
        model.addAttribute("cliente", cliente);
        return "layout/cliente/ModificarCliente :: ModificarCliente";
    }

    @PostMapping("/actualizar")
    public String actualizarCliente(@ModelAttribute Cliente cliente) {
        logger.debug("Actualizando cliente con ID: {}", cliente.getId_cliente());
        logger.debug("Datos de cliente: Persona ID: {}, Nombre: {}, Primer Apellido: {}, Segundo Apellido: {}",
                cliente.getPersona().getId_persona(), cliente.getPersona().getNombre(), cliente.getPersona().getPrimer_apellido(), cliente.getPersona().getSegundo_apellido());
        _PersonaService.actualizarPersona(cliente.getPersona());
        _ClienteService.actualizarCliente(cliente);
        return "redirect:/";
    }

    @GetMapping("/eliminar/{id_cliente}")
    public String eliminarCliente(@PathVariable("id_cliente") Long id_cliente) {
        _ClienteService.eliminarCliente(id_cliente);
        return "redirect:/cliente/inicio";
    }
}
