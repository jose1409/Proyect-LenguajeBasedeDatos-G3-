package com.Hotel_Riu.controller;

import com.Hotel_Riu.domain.Platillo;
import com.Hotel_Riu.service.PlatilloService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 
 *
 * @author Alonso
 */
@Controller
@RequestMapping("/platillo")
public class PlatilloController {

    @Autowired
    private PlatilloService platilloService;

    @GetMapping("/inicio")
    public String inicio(Model model) {
        List<Platillo> result = platilloService.getPlatillos();
        model.addAttribute("platillos", result);
        model.addAttribute("totalPlatillos", result.size());
        return "layout/platillo/ListaPlatillo :: ListaPlatillo";
    }

    @GetMapping("/crear")
    public String mostrarFormulario(Model model) {
        model.addAttribute("platillo", new Platillo());
        return "layout/platillo/AgregarPlatillo :: AgregarPlatillo";
    }

    @PostMapping("/guardar")
    public String guardarPlatillo(@ModelAttribute Platillo platillo) {
        platilloService.agregarPlatillo(platillo);
        return "redirect:/platillo/inicio";
    }

    @GetMapping("/modificar/{idPlatillo}")
    public String mostrarFormularioModificar(@PathVariable("idPlatillo") Long idPlatillo, Model model) {
        Platillo platillo = platilloService.obtenerPlatilloPorId(idPlatillo);
        model.addAttribute("platillo", platillo);
        return "layout/platillo/ModificarPlatillo :: ModificarPlatillo";
    }

    @PostMapping("/actualizar")
    public String actualizarPlatillo(@ModelAttribute Platillo platillo) {
        platilloService.actualizarPlatillo(platillo);
        return "redirect:/platillo/inicio";
    }

    @GetMapping("/eliminar/{idPlatillo}")
    public String eliminarPlatillo(@PathVariable("idPlatillo") Long idPlatillo) {
        platilloService.eliminarPlatillo(idPlatillo);
        return "redirect:/platillo/inicio";
    }
}

