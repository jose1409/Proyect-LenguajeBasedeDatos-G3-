package com.Hotel_Riu.controller;

import com.Hotel_Riu.domain.Direccion;
import com.Hotel_Riu.domain.Horario;
import com.Hotel_Riu.service.HorarioService;
import com.Hotel_Riu.domain.Hotel;
import com.Hotel_Riu.service.DireccionService;
import com.Hotel_Riu.service.HotelService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/hotel")
public class HotelController {

    @Autowired
    private HotelService _HotelService;
    @Autowired
    private DireccionService _DireccionService;
    @Autowired
    private HorarioService _HorarioService;

    @GetMapping("/inicio")
    public String inicio(Model model) {
        List<Hotel> result = _HotelService.getHoteles();
        model.addAttribute("Hoteles", result);
        model.addAttribute("totalHoteles", result.size());
        return "layout/hotel/ListaHotel :: ListaHotel";
    }

    //Utilizado en ListaHoteles
    @GetMapping("/crear")
    public String mostrarFormulario(Model model) {
        model.addAttribute("hotel", new Hotel());
        return "layout/hotel/AgregarHotel :: AgregarHotel";
    }
    
    @PostMapping("/guardar")
    public String guardarHotel(@ModelAttribute Hotel hotel) {
        _DireccionService.spInsertDireccion(hotel.getDireccion());
        hotel.getDireccion().setId_direccion(hotel.getDireccion().getId_direccion());
        _HotelService.spInsertHotel(hotel);
        
        return "redirect:/";
    }

    @GetMapping("/modificar/{idHotel}")
    public String categoriaModificar(@PathVariable("idHotel") Long idHotel, Model model) {
        Hotel hotel = _HotelService.ObtenerHotel(idHotel);
        List<Direccion> result1 = _DireccionService.getDirecciones();
        model.addAttribute("direcciones", result1);
        
        List<Horario> result2 = _HorarioService.getHorarios();
        model.addAttribute("horarios", result2);
        
        model.addAttribute("hotel", hotel);
        return "layout/hotel/ModificarHotel :: ModificarHotel";
    }
    
    @PostMapping("/actualizar")
    public String hotelModificar(@ModelAttribute Hotel hotel) {
        _HotelService.spUpdateHotel(hotel);
        return "redirect:/";
    }
    
    @GetMapping("/eliminar/{idHotel}")
    public String hotelEliminar(@PathVariable("idHotel") Long idHotel) {
        _HotelService.spDeleteHotel(idHotel);

        return "redirect:/hotel/inicio";
    }
    
}
