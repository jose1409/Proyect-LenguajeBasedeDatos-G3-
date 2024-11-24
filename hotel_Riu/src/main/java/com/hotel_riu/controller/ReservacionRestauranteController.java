package com.hotel_riu.controller;

import com.hotel_riu.domain.ReservacionRestaurante;
import com.hotel_riu.services.ReservacionRestauranteService;
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
@RequestMapping("/reservacionRestaurante")
public class ReservacionRestauranteController {

    @Autowired
    private ReservacionRestauranteService reservacionRestauranteService;

    @GetMapping
    public List<ReservacionRestaurante> getAllReservaciones() {
        return reservacionRestauranteService.getAllReservaciones();
    }

    @GetMapping("/{id}")
    public ReservacionRestaurante getReservacionById(@PathVariable Long id) {
        return reservacionRestauranteService.getReservacionById(id);
    }

    @PostMapping
    public ReservacionRestaurante saveReservacion(@RequestBody ReservacionRestaurante reservacion) {
        return reservacionRestauranteService.saveReservacion(reservacion);
    }

    @DeleteMapping("/{id}")
    public void deleteReservacion(@PathVariable Long id) {
        reservacionRestauranteService.deleteReservacion(id);
    }
}
