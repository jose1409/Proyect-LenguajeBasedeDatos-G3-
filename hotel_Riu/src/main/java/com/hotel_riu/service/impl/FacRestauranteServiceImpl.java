package com.hotel_riu.service.impl;

import java.util.List;
import com.hotel_riu.dao.FacRestauranteDAO;
import com.hotel_riu.domain.FacRestaurante;
import com.hotel_riu.services.FacRestauranteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FacRestauranteServiceImpl implements FacRestauranteService {

    @Autowired
    private FacRestauranteDAO facRestauranteDAO;

    @Override
    public List<FacRestaurante> getAllFacturas() {
        return facRestauranteDAO.findAll();
    }

    @Override
    public FacRestaurante getFacturaById(Long id) {
        return facRestauranteDAO.findById(id).orElse(null);
    }

    @Override
    public FacRestaurante saveFactura(FacRestaurante factura) {
        return facRestauranteDAO.save(factura);
    }

    @Override
    public void deleteFactura(Long id) {
        facRestauranteDAO.deleteById(id);
    }
}
