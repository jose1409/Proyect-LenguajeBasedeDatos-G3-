package com.Hotel_Riu.controller;

import com.Hotel_Riu.domain.Cliente;
import com.Hotel_Riu.domain.ReservacionRestaurante;
import com.Hotel_Riu.service.ClienteService;
import com.Hotel_Riu.service.ReservacionRestauranteService;
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
@RequestMapping("/reservacionRestaurante")
public class ReservacionRestauranteController {

    @Autowired
    private ReservacionRestauranteService _ReservacionRestauranteService;

    @Autowired
    private ClienteService _ClienteService;

    @GetMapping("/inicio")
    public String inicio(Model model) {
        List<ReservacionRestaurante> result = _ReservacionRestauranteService.getReservacionRestaurante();
        model.addAttribute("ReservacionRestaurante", result);
        return "layout/ReservacionRestaurante/ListaReservacionRestaurante :: ListaReservacionRestaurante";
    }

    //Utilizado para almacenar datos de ReservacionRestaurante
    @GetMapping("/crear")
    public String mostrarFormulario(Model model) {
        //Listado de Clientes
        List<Cliente> clientes = _ClienteService.getClientes();
        model.addAttribute("clientes", clientes);
        model.addAttribute("reservacionRestaurante", new ReservacionRestaurante());
        return "layout/ReservacionRestaurante/AgregarReservacionRestaurante :: AgregarReservacionRestaurante";
    }

    //Utilizado en Agregar Platillo
    @PostMapping("/guardar")
    public String guardarServicio(@ModelAttribute ReservacionRestaurante reservacionRestaurante) {
        _ReservacionRestauranteService.agregarReservacionRestaurante(reservacionRestaurante);
        return "redirect:/";
    }
}
