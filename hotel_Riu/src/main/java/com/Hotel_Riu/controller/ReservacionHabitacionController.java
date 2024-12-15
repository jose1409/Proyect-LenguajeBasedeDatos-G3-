package com.Hotel_Riu.controller;

import com.Hotel_Riu.domain.Cliente;
import com.Hotel_Riu.domain.Habitacion;
import com.Hotel_Riu.domain.Horario;
import com.Hotel_Riu.domain.ReservacionHabitacion;
import com.Hotel_Riu.service.ClienteService;
import com.Hotel_Riu.service.HabitacionService;
import com.Hotel_Riu.service.HorarioService;
import com.Hotel_Riu.service.ReservacionHabitacionService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/reservacionHabitacion")
public class ReservacionHabitacionController {

    @Autowired
    private ReservacionHabitacionService _ReservacionHabitacionService;

    @Autowired
    private HabitacionService _HabitacionService;

    @Autowired
    private ClienteService _ClienteService;

    @Autowired
    private HorarioService _HorarioService;

    @GetMapping("/inicio")
    public String inicio(Model model) {
        List<ReservacionHabitacion> result = _ReservacionHabitacionService.getReservacionHabitaciones();
        model.addAttribute("Reservaciones", result);
        model.addAttribute("totalHabitaciones", result.size());
        return "layout/reservacion_habitacion/ListaReservacionHabitacion :: ListaReservacionHabitacion";
    }

    //Utilizado para llenar la pestaña de Crear
    @GetMapping("/crear")
    public String mostrarFormulario(Model model) {
        //Listado de Habitaciones
        List<Habitacion> result = _HabitacionService.getHabitaciones();
        model.addAttribute("Habitaciones", result);
        //Listado de Clientes
        List<Cliente> clientes = _ClienteService.getClientes();
        model.addAttribute("clientes", clientes);
        //Listado de Horarios
        List<Horario> horarios = _HorarioService.getHorarios();
        model.addAttribute("horarios", horarios);
        //Creacion del objeto Reservacion
        model.addAttribute("reservacionHabitacion", new ReservacionHabitacion());
        return "layout/reservacion_habitacion/AgregarReservacionHabitacion :: AgregarReservacionHabitacion";
    }

    //Calcula el precio y muestra el formulario nuevamente
    @GetMapping("/precioTotal/{precio}/{descuento}/{fecha1}/{fecha2}")
    public ResponseEntity<Integer> precioTotal(@PathVariable("precio") int precio, @PathVariable("descuento") int descuento, @PathVariable("fecha1") java.sql.Date fecha1, @PathVariable("fecha2") java.sql.Date fecha2) {
        int precioReservacion;
        precioReservacion = _ReservacionHabitacionService.PrecioTotal(precio, descuento, fecha1, fecha2);
        return ResponseEntity.ok(precioReservacion);
    }

    //Utilizado en AgregarHabitacion
    @PostMapping("/guardar")
    public String guardarHabitacion(@ModelAttribute ReservacionHabitacion reservacionHabitacion) {
        _ReservacionHabitacionService.agregarReservacionHabitacion(reservacionHabitacion);
        return "redirect:/";
    }

    //Utilizado para ver Detalles de la Reservacion
    @GetMapping("/detalles/{idReservacionHabitacion}")
    public String habitacionxServicios(@PathVariable("idReservacionHabitacion") Long idReservacionHabitacion, Model model) {
        ReservacionHabitacion resultado = _ReservacionHabitacionService.ObtenerHabitacionID(idReservacionHabitacion);
        model.addAttribute("reservacion", resultado);
        return "layout/reservacion_habitacion/ModalxHabitacion :: DetallesReservacion";
    }

    //Utilizado para eliminar Habitacion
    @GetMapping("/eliminar/{idReservacionHabitacion}")
    public String habitacionEliminar(@PathVariable("idReservacionHabitacion") Long idReservacionHabitacion) {
        _ReservacionHabitacionService.eliminarReservacionHabitacion(idReservacionHabitacion);
        return "redirect:/reservacionHabitacion/inicio";
    }

    //Utilizado para encontrar Habitacion para actualizar
    @GetMapping("/modificar/{idReservacionHabitacion}")
    public String habitacionModificar(@PathVariable("idReservacionHabitacion") Long idReservacionHabitacion, Model model) {
        ReservacionHabitacion reservacionHabitacion = _ReservacionHabitacionService.ObtenerHabitacionID(idReservacionHabitacion);
        model.addAttribute("reservacionHabitacion", reservacionHabitacion);

        //Listado de Habitaciones
        List<Habitacion> result = _HabitacionService.getHabitaciones();
        model.addAttribute("Habitaciones", result);
        
        List<Cliente> clientes = _ClienteService.getClientes();
        model.addAttribute("clientes", clientes);
        return "layout/reservacion_habitacion/ModificarReservacionHabitacion :: ModificarReservacionHabitacion";
    }

    //Utilizado para modificar Habitacion encontrada anteriormente
    @PostMapping("/actualizar")
    public String habitacionModificar(@ModelAttribute ReservacionHabitacion ReservacionHabitacion) {
        _ReservacionHabitacionService.actualizarReservacion(ReservacionHabitacion);
        return "redirect:/";
    }

}
