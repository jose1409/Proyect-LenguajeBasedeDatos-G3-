package com.hotel_riu.controller;

import com.hotel_riu.domain.FacRestaurante;
import com.hotel_riu.services.FacRestauranteService;
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
@RequestMapping("/facRestaurante")
public class FacRestauranteController {

    @Autowired
    private FacRestauranteService facRestauranteService;

    @GetMapping
    public List<FacRestaurante> getAllFacturas() {
        return facRestauranteService.getAllFacturas();
    }

    @GetMapping("/{id}")
    public FacRestaurante getFacturaById(@PathVariable Long id) {
        return facRestauranteService.getFacturaById(id);
    }

    @PostMapping
    public FacRestaurante saveFactura(@RequestBody FacRestaurante factura) {
        return facRestauranteService.saveFactura(factura);
    }

    @DeleteMapping("/{id}")
    public void deleteFactura(@PathVariable Long id) {
        facRestauranteService.deleteFactura(id);
    }
}
