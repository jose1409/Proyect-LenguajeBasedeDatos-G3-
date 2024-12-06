package com.Hotel_Riu.service;

import com.Hotel_Riu.domain.Restaurante;
import java.util.List;

/**
 * @author Alonso
 */
public interface RestauranteService {

    List<Restaurante> obtenerRestaurantes();

    void agregarRestaurante(Restaurante restaurante);

    void actualizarRestaurante(Restaurante restaurante);

    Restaurante obtenerRestaurantePorId(Long idRestaurante);

    void eliminarRestaurante(Long idRestaurante);
}
