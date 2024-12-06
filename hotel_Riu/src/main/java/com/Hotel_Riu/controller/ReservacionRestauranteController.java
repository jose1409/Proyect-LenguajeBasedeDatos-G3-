package com.Hotel_Riu.controller;

import com.Hotel_Riu.domain.ReservacionRestaurante;
import com.Hotel_Riu.service.ReservacionRestauranteService;
import com.Hotel_Riu.service.ClienteService;
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
 * @author Alonso Muñoz Aguilar
 */

@Controller
@RequestMapping("/reservacion")
public class ReservacionRestauranteController {

    @Autowired
    private ReservacionRestauranteService reservacionRestauranteService;

    @Autowired
    private ClienteService clienteService;

    // Método para mostrar el listado de reservaciones
    @GetMapping("/inicio")
    public String inicio(Model model) {
        // Usar el procedimiento almacenado para obtener todas las reservaciones
        List<ReservacionRestaurante> reservaciones = reservacionRestauranteService.obtenerReservaciones(); // Este servicio ejecutará el procedimiento almacenado OBTENER_RESERVACIONES_RESTAURANTE
        model.addAttribute("reservaciones", reservaciones);
        model.addAttribute("totalReservaciones", reservaciones.size());
        return "layout/reservacion/ListaReservacion :: ListaReservacion"; 
    }

    // Método para mostrar formulario de creación de nueva reservación
    @GetMapping("/crear")
    public String mostrarFormularioCrear(Model model) {
        model.addAttribute("reservacion", new ReservacionRestaurante());
        return "layout/reservacion/AgregarReservacion :: AgregarReservacion";
    }

    // Método para guardar nueva reservación
    @PostMapping("/guardar")
    public String guardarReservacion(@ModelAttribute ReservacionRestaurante reservacion) {
        clienteService.agregarCliente(reservacion.getCliente()); // Aquí también podemos invocar procedimientos almacenados para insertar clientes
        reservacion.getCliente().setId_cliente(reservacion.getCliente().getId_cliente());
        // Usamos el procedimiento AGREGAR_RESERVACION_RESTAURANTE para insertar la reservación
        reservacionRestauranteService.agregarReservacion(reservacion); // Este servicio ejecutará el procedimiento almacenado AGREGAR_RESERVACION_RESTAURANTE
        return "redirect:/reservacion/inicio";
    }

    // Método para mostrar formulario de modificación de una reservación existente
    @GetMapping("/modificar/{id_reservacion}")
    public String mostrarFormularioModificar(@PathVariable("id_reservacion") Long id_reservacion, Model model) {
        ReservacionRestaurante reservacion = reservacionRestauranteService.obtenerReservacionPorID(id_reservacion);
        model.addAttribute("reservacion", reservacion);
        return "layout/reservacion/ModificarReservacion :: ModificarReservacion";
    }

    // Método para actualizar una reservación
    @PostMapping("/actualizar")
    public String actualizarReservacion(@ModelAttribute ReservacionRestaurante reservacion) {
        clienteService.actualizarCliente(reservacion.getCliente());
        // Usamos el procedimiento ACTUALIZAR_RESERVACION_RESTAURANTE para actualizar la reservación
        reservacionRestauranteService.actualizarReservacion(reservacion); // Este servicio ejecutará el procedimiento almacenado ACTUALIZAR_RESERVACION_RESTAURANTE
        return "redirect:/reservacion/inicio";
    }

    // Método para eliminar una reservación
    @GetMapping("/eliminar/{id_reservacion}")
    public String eliminarReservacion(@PathVariable("id_reservacion") Long id_reservacion) {
        // Usamos el procedimiento ELIMINAR_RESERVACION_RESTAURANTE para eliminar la reservación
        reservacionRestauranteService.eliminarReservacion(id_reservacion); // Este servicio ejecutará el procedimiento almacenado ELIMINAR_RESERVACION_RESTAURANTE
        return "redirect:/reservacion/inicio";
    }
}

