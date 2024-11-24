package com.hotel_riu.service.impl;

import com.hotel_riu.dao.PlatilloDAO;
import com.hotel_riu.domain.Platillo;
import com.hotel_riu.services.PlatilloService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PlatilloServiceImpl implements PlatilloService {

    @Autowired
    private PlatilloDAO platilloDAO;

    @Override
    public List<Platillo> getAllPlatillos() {
        return platilloDAO.findAll();
    }

    @Override
    public Platillo getPlatilloById(Long idPlatillo) {
        return platilloDAO.findById(idPlatillo).orElse(null);
    }

    @Override
    public Platillo savePlatillo(Platillo platillo) {
        return platilloDAO.save(platillo);
    }

    @Override
    public void deletePlatillo(Long idPlatillo) {
        platilloDAO.deleteById(idPlatillo);
    }
}
