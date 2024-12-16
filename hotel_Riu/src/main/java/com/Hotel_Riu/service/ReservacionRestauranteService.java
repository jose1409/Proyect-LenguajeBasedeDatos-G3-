package com.Hotel_Riu.service;

import com.Hotel_Riu.domain.ReservacionRestaurante;
import java.util.List;

/**
 *
 * @author dvela
 */
public interface ReservacionRestauranteService {

    public List<ReservacionRestaurante> getReservacionRestaurante();
    
    public void agregarReservacionRestaurante(ReservacionRestaurante reservacionrestaurante);
    
    public ReservacionRestaurante getReservacionRestaurantexID(Long id);

}
