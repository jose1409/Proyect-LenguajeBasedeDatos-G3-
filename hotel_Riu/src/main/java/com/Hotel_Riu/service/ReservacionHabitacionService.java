package com.Hotel_Riu.service;

import com.Hotel_Riu.domain.ReservacionHabitacion;
import java.util.List;

/**
 *
 * @author dvela
 */
public interface ReservacionHabitacionService {

    public List<ReservacionHabitacion> getReservacionHabitaciones();

    public void agregarReservacionHabitacion(ReservacionHabitacion reservacionHabitacion);

    public int PrecioTotal(int precio, int descuento, java.sql.Date fecha1, java.sql.Date fecha2);

    //Obtener una Habitacion del ID para modificarlo
    public ReservacionHabitacion ObtenerHabitacionID(Long id);

    //Eliminar reservacion
    public void eliminarReservacionHabitacion(Long id_reservacionHabitacion);

    //Editar reservacion
    public void actualizarReservacion(ReservacionHabitacion reservacionHabitacion);

}
