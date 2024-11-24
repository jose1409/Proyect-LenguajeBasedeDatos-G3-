package com.hotel_riu.controller;

import com.hotel_riu.domain.PlatilloMultiple;
import com.hotel_riu.services.PlatilloMultipleService;
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
@RequestMapping("/platilloMultiple")
public class PlatilloMultipleController {

    @Autowired
    private PlatilloMultipleService platilloMultipleService;

    @GetMapping
    public List<PlatilloMultiple> getAllPlatillosMultiples() {
        return platilloMultipleService.getAllPlatillosMultiples();
    }

    @GetMapping("/{id}")
    public PlatilloMultiple getPlatilloMultipleById(@PathVariable Long id) {
        return platilloMultipleService.getPlatilloMultipleById(id);
    }

    @PostMapping
    public PlatilloMultiple savePlatilloMultiple(@RequestBody PlatilloMultiple platilloMultiple) {
        return platilloMultipleService.savePlatilloMultiple(platilloMultiple);
    }

    @DeleteMapping("/{id}")
    public void deletePlatilloMultiple(@PathVariable Long id) {
        platilloMultipleService.deletePlatilloMultiple(id);
    }
}
