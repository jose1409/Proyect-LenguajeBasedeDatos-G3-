package com.hotel_riu.controller;

import com.hotel_riu.domain.Restaurante;
import com.hotel_riu.services.RestauranteService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/restaurante")
public class RestauranteController {

    @Autowired
    private RestauranteService restauranteService;

    @GetMapping
    public List<Restaurante> getAllRestaurantes() {
        return restauranteService.getAllRestaurantes();
    }

    @GetMapping("/{id}")
    public Restaurante getRestauranteById(@PathVariable Long id) {
        return restauranteService.getRestauranteById(id);
    }

    @PostMapping
    public Restaurante saveRestaurante(@RequestBody Restaurante restaurante) {
        return restauranteService.saveRestaurante(restaurante);
    }

    @DeleteMapping("/{id}")
    public void deleteRestaurante(@PathVariable Long id) {
        restauranteService.deleteRestaurante(id);
    }
}
