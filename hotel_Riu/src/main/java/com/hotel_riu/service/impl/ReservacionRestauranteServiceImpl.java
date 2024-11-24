package com.hotel_riu.service.impl;

import com.hotel_riu.dao.ReservacionRestauranteDAO;
import com.hotel_riu.domain.ReservacionRestaurante;
import com.hotel_riu.services.ReservacionRestauranteService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReservacionRestauranteServiceImpl implements ReservacionRestauranteService {

    @Autowired
    private ReservacionRestauranteDAO reservacionRestauranteDAO;

    @Override
    public List<ReservacionRestaurante> getAllReservaciones() {
        return reservacionRestauranteDAO.findAll();
    }

    @Override
    public ReservacionRestaurante getReservacionById(Long id) {
        return reservacionRestauranteDAO.findById(id).orElse(null);
    }

    @Override
    public ReservacionRestaurante saveReservacion(ReservacionRestaurante reservacion) {
        return reservacionRestauranteDAO.save(reservacion);
    }

    @Override
    public void deleteReservacion(Long id) {
        reservacionRestauranteDAO.deleteById(id);

    }
}
