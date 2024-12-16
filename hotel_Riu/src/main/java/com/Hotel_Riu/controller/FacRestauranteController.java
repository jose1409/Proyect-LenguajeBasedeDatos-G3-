package com.Hotel_Riu.controller;

import com.Hotel_Riu.domain.FacRestaurante;
import com.Hotel_Riu.domain.Platillo;
import com.Hotel_Riu.domain.ReservacionRestaurante;
import com.Hotel_Riu.service.FacRestauranteService;
import com.Hotel_Riu.service.PersonaService;
import com.Hotel_Riu.service.PlatilloService;
import com.Hotel_Riu.service.ReservacionRestauranteService;
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
@RequestMapping("/facRestaurante")
public class FacRestauranteController {

    @Autowired
    FacRestauranteService _FacRestauranteService;

    @Autowired
    ReservacionRestauranteService _ReservacionRestauranteService;

    @Autowired
    PlatilloService _PlatilloService;

    @GetMapping("/inicio")
    public String inicio(Model model) {
        List<FacRestaurante> result = _FacRestauranteService.getFacRestaurante();
        model.addAttribute("facRestaurantes", result);
        return "layout/FacRestaurante/ListaFacRestaurante :: ListaFacRestaurante";
    }

    @GetMapping("/selecModal")
    public String mostrarFormulario(Model model) {
        List<ReservacionRestaurante> result = _ReservacionRestauranteService.getReservacionRestaurante();
        model.addAttribute("ReservacionRestaurante", result);
        return "layout/FacRestaurante/ModalCrearFactura :: ListaReservacionesRestaurante";
    }

    @GetMapping("/crear/{idReservacionRestaurante}")
    public String habitacionEliminar(@PathVariable("idReservacionRestaurante") Long idReservacionRestaurante, Model model) {
        ReservacionRestaurante result = _ReservacionRestauranteService.getReservacionRestaurantexID(idReservacionRestaurante);
        List<Platillo> platillos = _PlatilloService.getPlatillos();
        model.addAttribute("FacRestaurante", new FacRestaurante());
        model.addAttribute("reservacionHabitacion", result);
        model.addAttribute("platillos", platillos);
        return "layout/FacRestaurante/AgregarReservacionRestaurante :: AgregarReservacionRestaurante";
    }

//    //Utilizado para ver Servicios Vinculados a la habitacion
//    @GetMapping("/servicios/{idHabitacion}")
//    public String habitacionxServicios(@PathVariable("idHabitacion") Long idHabitacion, Model model) {
//        List<Servicio> resultado = _HabitacionService.getServicios(idHabitacion);
//        model.addAttribute("Servicios", resultado);
//        return "layout/habitacion/ServicioxHabitacion :: ServicioxHabitacion";
//    }

}
