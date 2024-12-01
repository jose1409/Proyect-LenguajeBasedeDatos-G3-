package com.Hotel_Riu.service;

import com.Hotel_Riu.domain.Habitacion;
import com.Hotel_Riu.domain.Servicio;
import java.util.List;

public interface HabitacionService {
    
    // Se obtiene un listado de Habitaciones en un List
    public List<Habitacion> getHabitaciones();
    
    //Agrega una Habitacion
    public void agregarHabitacion(Habitacion habitacion);
    
    //Editar Habitacion
    public void actualizarHabitacion(Habitacion habitacion);
    
    //Obtener una Habitacion del ID para modificarlo
    public Habitacion ObtenerHabitacionID(Long id);
    
    //Eliminar Habitacion
    public void eliminarHabitacion(Long id);
    
    //Ver Servicio asignados a la Habitacion Asignada
    public List<Servicio> getServicios(Long id);
}
