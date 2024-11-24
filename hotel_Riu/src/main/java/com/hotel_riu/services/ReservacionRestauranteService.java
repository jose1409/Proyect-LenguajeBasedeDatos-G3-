package com.hotel_riu.services;

import com.hotel_riu.domain.ReservacionRestaurante;
import java.util.List;

public interface ReservacionRestauranteService {

    /**
     * Obtiene una lista de todas las reservaciones de restaurante almacenadas.
     *
     * @return una lista de objetos {@link ReservacionRestaurante}.
     */
    List<ReservacionRestaurante> getAllReservaciones();

    /**
     * Obtiene una reservación de restaurante específica por su identificador único.
     *
     * @param id el identificador único de la reservación.
     * @return un objeto {@link ReservacionRestaurante} si se encuentra; de lo contrario, {@code null}.
     */
    ReservacionRestaurante getReservacionById(Long id);

    /**
     * Guarda una nueva reservación o actualiza una existente.
     *
     * @param reservacion el objeto {@link ReservacionRestaurante} a guardar o actualizar.
     * @return el objeto {@link ReservacionRestaurante} guardado.
     */
    ReservacionRestaurante saveReservacion(ReservacionRestaurante reservacion);

    /**
     * Elimina una reservación de restaurante por su identificador único.
     *
     * @param id el identificador único de la reservación a eliminar.
     */
    void deleteReservacion(Long id);
}
