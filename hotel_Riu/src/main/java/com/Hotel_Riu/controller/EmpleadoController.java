/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.Hotel_Riu.controller;

import com.Hotel_Riu.domain.Empleado;
import com.Hotel_Riu.service.EmpleadoService;
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

/**
 *
 * @author dvela
 */

@Controller
@RequestMapping("/empleado")
public class EmpleadoController {
    
    @Autowired
    private EmpleadoService _EmpleadoService;
    
    @Autowired
    private PersonaService _PersonaService;
    
    @GetMapping("/inicio")
    public String inicio (Model model){
        List<Empleado> result = _EmpleadoService.getEmpleados();
        model.addAttribute("empleados",result);
        model.addAttribute("totalEmpleados", result.size());
        return "layout/empleado/ListaEmpleado :: ListaEmpleado"; 
    } 
    
    @GetMapping("/crear")
    public String mostrarFormulario(Model model) {
        model.addAttribute("empleado", new Empleado());
        return "layout/empleado/AgregarEmpleado :: AgregarEmpleado";
    }
    
    @PostMapping("/guardar")
    public String guardarEmpleado(@ModelAttribute Empleado empleado) {
        _PersonaService.agregarPersona(empleado.getPersona());
        empleado.getPersona().setId_persona(empleado.getPersona().getId_persona());
        _EmpleadoService.agregarEmpleado(empleado);
        return "redirect:/";
    }
    
    @GetMapping("/modificar/{id_empleado}")
    public String mostrarFormularioModificar(@PathVariable("id_empleado") Long id_empleado, Model model) {
        Empleado empleado = _EmpleadoService.obtenerEmpleadoPorID(id_empleado);
        model.addAttribute("empleado", empleado);
        return "layout/empleado/ModificarEmpleados :: ModificarEmpleados";
    }
    
    @PostMapping("/actualizar")
    public String ActualizarEmpleado(@ModelAttribute Empleado empleado) {
        _PersonaService.actualizarPersona(empleado.getPersona());
        _EmpleadoService.actualizarEmpleado(empleado);
        return "redirect:/";
    }
    
    @GetMapping("/eliminar/{id_empleado}")
    public String habitacionEliminar(@PathVariable("id_empleado") Long id_empleado) {
        _EmpleadoService.eliminarEmpleado(id_empleado);
        return "redirect:/empleado/inicio";
    }   
}
