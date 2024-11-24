package com.hotel_riu.services;

import com.hotel_riu.domain.Restaurante;
import java.util.List;

public interface RestauranteService {

    /**
     * Obtiene una lista de todos los restaurantes almacenados en la base de datos.
     *
     * @return una lista de objetos {@link Restaurante}.
     */
    List<Restaurante> getAllRestaurantes();

    /**
     * Obtiene un restaurante específico basado en su identificador único.
     *
     * @param idRestaurante el identificador único del restaurante.
     * @return un objeto {@link Restaurante} si se encuentra; de lo contrario, {@code null}.
     */
    Restaurante getRestauranteById(Long idRestaurante);

    /**
     * Guarda un nuevo restaurante o actualiza uno existente en la base de datos.
     *
     * @param restaurante el objeto {@link Restaurante} a guardar o actualizar.
     * @return el objeto {@link Restaurante} guardado con los cambios aplicados.
     */
    Restaurante saveRestaurante(Restaurante restaurante);

    /**
     * Elimina un restaurante de la base de datos basado en su identificador único.
     *
     * @param idRestaurante el identificador único del restaurante a eliminar.
     */
    void deleteRestaurante(Long idRestaurante);
}
