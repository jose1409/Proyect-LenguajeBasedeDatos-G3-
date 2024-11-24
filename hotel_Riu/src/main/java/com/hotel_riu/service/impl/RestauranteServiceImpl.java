package com.hotel_riu.service.impl;

import com.hotel_riu.services.RestauranteService;
import com.hotel_riu.dao.RestauranteDAO;
import com.hotel_riu.domain.Restaurante;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RestauranteServiceImpl implements RestauranteService {

    @Autowired
    private RestauranteDAO restauranteDao;

    @Override
    public List<Restaurante> getAllRestaurantes() {
        return restauranteDao.findAll();
    }

    @Override
    public Restaurante getRestauranteById(Long idRestaurante) {
        return restauranteDao.findById(idRestaurante).orElse(null);
    }

    @Override
    public Restaurante saveRestaurante(Restaurante restaurante) {
        return restauranteDao.save(restaurante);
    }

    @Override
    public void deleteRestaurante(Long idRestaurante) {
        restauranteDao.deleteById(idRestaurante);
    }
}
