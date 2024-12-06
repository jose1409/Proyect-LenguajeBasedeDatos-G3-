package com.Hotel_Riu.controller;

import com.Hotel_Riu.domain.FacRestaurante;
import com.Hotel_Riu.domain.FacRestaurante;
import com.Hotel_Riu.service.FacRestauranteService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

/**
 * Alonso Muñoz Aguilar
 */
@Controller
@RequestMapping("/facturaRestaurante")
public class FacRestauranteController {
    
    @Autowired
    private FacRestauranteService facturaRestauranteService;
    

    @GetMapping("/inicio")
    public String inicio(Model model) {
        List<FacRestaurante> facturas = facturaRestauranteService.getFacturas();
        model.addAttribute("facturas", facturas);
        model.addAttribute("totalFacturas", facturas.size());
        return "layout/facturaRestaurante/ListaFacturas :: ListaFacturas"; 
    }
    

    @GetMapping("/crear")
    public String mostrarFormularioCrear(Model model) {
        model.addAttribute("facturaRestaurante", new FacRestaurante());
        return "layout/facturaRestaurante/AgregarFactura :: AgregarFactura";
    }
    
 
    @PostMapping("/guardar")
    public String guardarFactura(@ModelAttribute FacRestaurante facturaRestaurante) {
        facturaRestauranteService.agregarFactura(facturaRestaurante);
        return "redirect:/facturaRestaurante/inicio";
    }
    

    @GetMapping("/modificar/{id_factura}")
    public String mostrarFormularioModificar(@PathVariable("id_factura") Long id_factura, Model model) {
        FacRestaurante facturaRestaurante = facturaRestauranteService.obtenerFacturaPorID(id_factura);
        model.addAttribute("facturaRestaurante", facturaRestaurante);
        return "layout/facturaRestaurante/ModificarFactura :: ModificarFactura";
    }
    

    @PostMapping("/actualizar")
    public String actualizarFactura(@ModelAttribute FacRestaurante facturaRestaurante) {
        facturaRestauranteService.actualizarFactura(facturaRestaurante);
        return "redirect:/facturaRestaurante/inicio";
    }
    

    @GetMapping("/eliminar/{id_factura}")
    public String eliminarFactura(@PathVariable("id_factura") Long id_factura) {
        facturaRestauranteService.eliminarFactura(id_factura);
        return "redirect:/facturaRestaurante/inicio";
    }   
}
