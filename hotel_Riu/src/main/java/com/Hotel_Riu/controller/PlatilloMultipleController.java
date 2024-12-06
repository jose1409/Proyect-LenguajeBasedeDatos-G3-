package com.Hotel_Riu.controller;

import com.Hotel_Riu.domain.PlatilloMultiple;
import com.Hotel_Riu.service.PlatilloMultipleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 *
 * @author Alonso Muñoz Aguilar
 */
@Controller
@RequestMapping("/platilloMultiple")
public class PlatilloMultipleController {

    @Autowired
    private PlatilloMultipleService platilloMultipleService;

    @GetMapping("/inicio")
    public String inicio(Model model) {
        List<PlatilloMultiple> result = platilloMultipleService.getPlatillosMultiples();
        model.addAttribute("platillosMultiples", result);
        model.addAttribute("totalPlatillos", result.size());
        return "layout/platilloMultiple/ListaPlatillosMultiples :: ListaPlatillosMultiples";
    }

    @GetMapping("/crear")
    public String mostrarFormulario(Model model) {
        model.addAttribute("platilloMultiple", new PlatilloMultiple());
        return "layout/platilloMultiple/AgregarPlatilloMultiple :: AgregarPlatilloMultiple";
    }

    @PostMapping("/guardar")
    public String guardarPlatilloMultiple(@ModelAttribute PlatilloMultiple platilloMultiple) {
        platilloMultipleService.agregarPlatilloMultiple(platilloMultiple);
        return "redirect:/platilloMultiple/inicio";
    }

    @GetMapping("/modificar/{idPlatilloMultiple}")
    public String mostrarFormularioModificar(@PathVariable("idPlatilloMultiple") Long idPlatilloMultiple, Model model) {
        PlatilloMultiple platilloMultiple = platilloMultipleService.obtenerPlatilloMultiplePorId(idPlatilloMultiple);
        model.addAttribute("platilloMultiple", platilloMultiple);
        return "layout/platilloMultiple/ModificarPlatilloMultiple :: ModificarPlatilloMultiple";
    }

    @PostMapping("/actualizar")
    public String actualizarPlatilloMultiple(@ModelAttribute PlatilloMultiple platilloMultiple) {
        platilloMultipleService.actualizarPlatilloMultiple(platilloMultiple);
        return "redirect:/platilloMultiple/inicio";
    }

    @GetMapping("/eliminar/{idPlatilloMultiple}")
    public String eliminarPlatilloMultiple(@PathVariable("idPlatilloMultiple") Long idPlatilloMultiple) {
        platilloMultipleService.eliminarPlatilloMultiple(idPlatilloMultiple);
        return "redirect:/platilloMultiple/inicio";
    }
}
