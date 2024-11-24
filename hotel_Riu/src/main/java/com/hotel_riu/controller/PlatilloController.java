package com.hotel_riu.controller;

import com.hotel_riu.domain.Platillo;
import com.hotel_riu.services.PlatilloService;
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
@RequestMapping("/platillo")
public class PlatilloController {

    @Autowired
    private PlatilloService platilloService;

    @GetMapping
    public List<Platillo> getAllPlatillos() {
        return platilloService.getAllPlatillos();
    }

    @GetMapping("/{id}")
    public Platillo getPlatilloById(@PathVariable Long id) {
        return platilloService.getPlatilloById(id);
    }

    @PostMapping
    public Platillo savePlatillo(@RequestBody Platillo platillo) {
        return platilloService.savePlatillo(platillo);
    }

    @DeleteMapping("/{id}")
    public void deletePlatillo(@PathVariable Long id) {
        platilloService.deletePlatillo(id);
    }
}
