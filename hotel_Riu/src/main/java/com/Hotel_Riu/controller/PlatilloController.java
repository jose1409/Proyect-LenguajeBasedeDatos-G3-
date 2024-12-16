package com.Hotel_Riu.controller;

import com.Hotel_Riu.domain.Platillo;
import com.Hotel_Riu.domain.Restaurante;
import com.Hotel_Riu.service.PlatilloService;
import com.Hotel_Riu.service.RestauranteService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/platillo")
public class PlatilloController {

    @Autowired
    private PlatilloService _PlatilloService;

    @Autowired
    private RestauranteService _RestauranteService;

    @GetMapping("/inicio")
    public String inicio(Model model) {
        List<Platillo> result = _PlatilloService.getPlatillos();
        model.addAttribute("Platillos", result);
        return "layout/platillo/ListaPlatillo :: ListaPlatillo";
    }

    //Utilizado para almacenar datos de platillo
    @GetMapping("/crear")
    public String mostrarFormulario(Model model) {
        List<Restaurante> result = _RestauranteService.getRestaurantes();
        model.addAttribute("Restaurantes", result);
        model.addAttribute("platillo", new Platillo());
        return "layout/platillo/AgregarPlatillo :: AgregarPlatillo";
    }

    //Utilizado en Agregar Platillo
    @PostMapping("/guardar")
    public String guardarServicio(@ModelAttribute Platillo platillo) {
        _PlatilloService.agregarPlatillo(platillo);
        return "redirect:/";
    }
}
