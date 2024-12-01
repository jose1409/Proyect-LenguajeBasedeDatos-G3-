package com.Hotel_Riu.controller;

import com.Hotel_Riu.domain.Habitacion;
import com.Hotel_Riu.domain.Servicio;
import com.Hotel_Riu.service.HabitacionService;
import com.Hotel_Riu.service.ServicioService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/servicio")
public class ServicioController {

    @Autowired
    private ServicioService _ServicioService;

    @Autowired
    private HabitacionService _HabitacionService;

    @GetMapping("/inicio")
    public String inicio(Model model) {
        List<Servicio> result = _ServicioService.getServicios();
        model.addAttribute("Servicios", result);
        model.addAttribute("totalServicios", result.size());
        return "layout/servicio/ListaServicios :: ListaServicios";
    }

    //Utilizado en ListaServicioes
    @GetMapping("/crear")
    public String mostrarFormulario(Model model) {
        model.addAttribute("servicio", new Servicio());
        return "layout/servicio/AgregarServicios :: AgregarServicios";
    }

    //Utilizado en AgregarServicio
    @PostMapping("/guardar")
    public String guardarServicio(@ModelAttribute Servicio servicio) {
        _ServicioService.agregarServicio(servicio);
        return "redirect:/";
    }

    //Utilizado para encontrar Servicio para actualizar
    @GetMapping("/modificar/{idServicio}")
    public String servicioModificar(@PathVariable("idServicio") Long idServicio, Model model) {
        Servicio servicio = _ServicioService.ObtenerServicioID(idServicio);
        model.addAttribute("servicio", servicio);
        return "layout/servicio/ModificarServicios :: ModificarServicios";
    }

    //Utilizado para modificar Servicio encontrada anteriormente
    @PostMapping("/actualizar")
    public String servicioModificar(@ModelAttribute Servicio servicio) {
        _ServicioService.actualizarServicio(servicio);
        return "redirect:/";
    }

    //Utilizado para eliminar Servicio
    @GetMapping("/eliminar/{idServicio}")
    public String servicioEliminar(@PathVariable("idServicio") Long idServicio) {
        _ServicioService.eliminarServicio(idServicio);
        return "redirect:/servicio/inicio";
    }
    
    //Controller que siguen son para Asignar Servicios a la Habitacion
    
    
    //Utilizado para Ver las Habitaciones
    @GetMapping("/AsignarServicios")
    public String obtenerHabitaciones(Model model) {
        List<Habitacion> result = _HabitacionService.getHabitaciones();
        model.addAttribute("Habitaciones", result);
        model.addAttribute("totalHabitaciones", result.size());
        return "layout/servicio/ListaAsignarServicios :: ListaAsignarServicios";
    }

    //Utilizado para Listar Habitacion por id y empezar a asignar y eliminar servicios
    @GetMapping("/asignar/{idHabitacion}")
    public String servicioAsignar(@PathVariable("idHabitacion") Long idHabitacion, Model model) {
        Habitacion habitacion = _HabitacionService.ObtenerHabitacionID(idHabitacion); //Habitacion elegida
        List<Servicio> servicios = _ServicioService.getServicios(); // Todos los servicios
        List<Servicio> serviciosxHabitacion = _HabitacionService.getServicios(idHabitacion); // Servicios asignados a la habitación

        // Todo lo necesario para la asignacion de servicios
        model.addAttribute("servicio", servicios);
        model.addAttribute("habitacion", habitacion);
        model.addAttribute("serviciosxHabitacion", serviciosxHabitacion);
        return "layout/servicio/EditarServiciosxHabitacion :: EditarServiciosxHabitacion";
    }
    
    //Utilizado para Agregar Nuevo servicio y actualizar
    @GetMapping("/guardarxHabitacion/{idServicio}/{idHabitacion}")
    public String guardarServicioxHabitacion(@PathVariable("idServicio") Long idServicio, @PathVariable("idHabitacion") Long idHabitacion) {
        _ServicioService.agregarServicioxHabitacion(idServicio, idHabitacion);
        return "redirect:/servicio/asignar/{idHabitacion}";
    }
    
    //Utilizado para Eliminar servicios y actualizar
    @GetMapping("/eliminarxHabitacion/{idServicio}/{idHabitacion}")
    public String eliminarServicioxHabitacion(@PathVariable("idServicio") Long idServicio, @PathVariable("idHabitacion") Long idHabitacion) {
        _ServicioService.eliminarServicioxHabitacion(idServicio, idHabitacion);
        return "redirect:/servicio/asignar/{idHabitacion}";
    }

}
