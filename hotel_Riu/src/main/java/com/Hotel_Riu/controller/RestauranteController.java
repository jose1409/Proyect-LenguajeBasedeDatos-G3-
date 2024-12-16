package com.Hotel_Riu.controller;

import com.Hotel_Riu.domain.Restaurante;
import com.Hotel_Riu.service.RestauranteService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/restaurante")
public class RestauranteController {

    @Autowired
    private RestauranteService _RestauranteService;

    @GetMapping("/inicio")
    public String inicio(Model model) {
        List<Restaurante> result = _RestauranteService.getRestaurantes();
        model.addAttribute("Restaurantes", result);
        return "layout/Restaurante/ListaRestaurante :: ListaRestaurante";
    }
}
