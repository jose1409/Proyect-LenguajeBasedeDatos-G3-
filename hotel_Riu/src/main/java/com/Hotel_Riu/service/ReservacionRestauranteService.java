
package com.Hotel_Riu.service;

import com.Hotel_Riu.domain.ReservacionRestaurante;
import java.util.List;

/**
 *
 * @author Alonso Muñoz Aguilar
 */
public interface ReservacionRestauranteService {

    // Obtener todas las reservaciones de restaurante
    public List<ReservacionRestaurante> obtenerReservaciones();

    // Agregar una nueva reservación de restaurante
    public void agregarReservacion(ReservacionRestaurante reservacion);

    // Actualizar una reservación existente
    public void actualizarReservacion(ReservacionRestaurante reservacion);

    // Obtener una reservación específica por su ID
    public ReservacionRestaurante obtenerReservacionPorID(Long idReservacionRestaurante);

    // Eliminar una reservación de restaurante
    public void eliminarReservacion(Long idReservacionRestaurante);
}
