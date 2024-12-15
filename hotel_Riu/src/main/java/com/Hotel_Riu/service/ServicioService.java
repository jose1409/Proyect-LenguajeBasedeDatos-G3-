package com.Hotel_Riu.service;

import com.Hotel_Riu.domain.Habitacion;
import com.Hotel_Riu.domain.Servicio;
import java.util.List;

public interface ServicioService {
    
    // Se obtiene un listado de Servicios en un List
    public List<Servicio> getServicios();
    //Agrega un Servicio
    public void agregarServicio(Servicio servicio);
    
    //Editar Servicio
    public void actualizarServicio(Servicio servicio);
    
    //Obtener una Servicio del ID para modificarlo
    public Servicio ObtenerServicioID(Long id);
    
    //Eliminar Servicio
    public void eliminarServicio(Long id);
    
    //Funciones para asignacion y eliminacion de servicios de las habitaciones
    
    //Funcion para Agregar servicio a la Habitacon
    public void agregarServicioxHabitacion(Long idService, Long idHabitacion);
    
    //Funcion para Eliminar servicio a la Habitacon
    public void eliminarServicioxHabitacion(Long idService, Long idHabitacion);
}
