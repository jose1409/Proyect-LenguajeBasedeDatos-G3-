package com.Hotel_Riu.controller;
import com.Hotel_Riu.domain.Habitacion;
import com.Hotel_Riu.service.HabitacionService;
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
@RequestMapping("/habitacion")
public class HabitacionController {

    @Autowired
    private HabitacionService _HabitacionService;

    @GetMapping("/inicio")
    public String inicio(Model model) {
        List<Habitacion> result = _HabitacionService.getHabitaciones();
        model.addAttribute("Habitaciones", result);
        model.addAttribute("totalHabitaciones", result.size());
        return "layout/habitacion/ListaHabitacion :: ListaHabitacion";
    }

    //Utilizado en ListaHabitaciones
    @GetMapping("/crear")
    public String mostrarFormulario(Model model) {
        //Aun no existe ---List<Hotel> result = _HotelService.getHoteles(true);
        model.addAttribute("habitacion", new Habitacion());
        //Aun no existe ---model.addAttribute("hoteles", result);
        return "layout/habitacion/AgregarHabitacion :: AgregarHabitacion";
    }

    //Utilizado en AgregarHabitacion
    @PostMapping("/guardar")
    public String guardarHabitacion(@ModelAttribute Habitacion habitacion) {
        _HabitacionService.agregarHabitacion(habitacion);
        return "redirect:/";
    }

    //Utilizado para encontrar Habitacion para actualizar
    @GetMapping("/modificar/{idHabitacion}")
    public String habitacionModificar(@PathVariable("idHabitacion") Long idHabitacion, Model model) {
        Habitacion habitacion = _HabitacionService.ObtenerHabitacionID(idHabitacion);
        //Aun no exitse ---List<Hotel> result = _HotelService.getHoteles(true);
        // Aun no existe ---model.addAttribute("hoteles", result);
        model.addAttribute("habitacion", habitacion);
        return "layout/habitacion/ModificarHabitacion :: ModificarHabitacion";
    }

    //Utilizado para modificar Habitacion encontrada anteriormente
    @PostMapping("/actualizar")
    public String habitacionModificar(@ModelAttribute Habitacion habitacion) {
        _HabitacionService.actualizarHabitacion(habitacion);
        return "redirect:/";
    }

    //Utilizado para eliminar Habitacion
    @GetMapping("/eliminar/{idHabitacion}")
    public String habitacionEliminar(@PathVariable("idHabitacion") Long idHabitacion) {
        _HabitacionService.eliminarHabitacion(idHabitacion);
        return "redirect:/habitacion/inicio";
    }
}
