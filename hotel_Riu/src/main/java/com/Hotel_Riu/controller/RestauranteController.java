package com.Hotel_Riu.controller;

import com.Hotel_Riu.domain.Restaurante;
import com.Hotel_Riu.service.RestauranteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 *
 * @author Alonso
 */
@Controller
@RequestMapping("/restaurante")
public class RestauranteController {

    private static final Logger logger = LoggerFactory.getLogger(RestauranteController.class);

    @Autowired
    private RestauranteService restauranteService;

    // Mostrar lista de restaurantes
    @GetMapping("/inicio")
    public String inicio(Model model) {
        List<Restaurante> restaurantes = restauranteService.obtenerRestaurantes();
        model.addAttribute("restaurantes", restaurantes);
        model.addAttribute("totalRestaurantes", restaurantes.size());
        return "layout/restaurante/ListaRestaurantes :: ListaRestaurantes";
    }

    // Mostrar formulario para agregar un restaurante
    @GetMapping("/crear")
    public String mostrarFormularioCrear(Model model) {
        model.addAttribute("restaurante", new Restaurante());
        return "layout/restaurante/AgregarRestaurante :: AgregarRestaurante";
    }

    // Guardar un nuevo restaurante
    @PostMapping("/guardar")
    public String guardarRestaurante(@ModelAttribute Restaurante restaurante) {
        restauranteService.agregarRestaurante(restaurante);
        return "redirect:/restaurante/inicio";
    }

    // Mostrar formulario para editar un restaurante existente
    @GetMapping("/modificar/{idRestaurante}")
    public String mostrarFormularioModificar(@PathVariable("idRestaurante") Long idRestaurante, Model model) {
        Restaurante restaurante = restauranteService.obtenerRestaurantePorId(idRestaurante);
        model.addAttribute("restaurante", restaurante);
        return "layout/restaurante/ModificarRestaurante :: ModificarRestaurante";
    }

    // Actualizar un restaurante
    @PostMapping("/actualizar")
    public String actualizarRestaurante(@ModelAttribute Restaurante restaurante) {
        logger.debug("Actualizando restaurante con ID: {}", restaurante.getIdRestaurante());
        restauranteService.actualizarRestaurante(restaurante);
        return "redirect:/restaurante/inicio";
    }

    // Eliminar un restaurante
    @GetMapping("/eliminar/{idRestaurante}")
    public String eliminarRestaurante(@PathVariable("idRestaurante") Long idRestaurante) {
        restauranteService.eliminarRestaurante(idRestaurante);
        return "redirect:/restaurante/inicio";
    }
}
