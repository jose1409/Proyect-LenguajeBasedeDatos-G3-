package com.hotel_riu.service.impl;

import com.hotel_riu.dao.PlatilloMultipleDAO;
import com.hotel_riu.domain.PlatilloMultiple;
import com.hotel_riu.services.PlatilloMultipleService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PlatilloMultipleServiceImpl implements PlatilloMultipleService {

    @Autowired
    private PlatilloMultipleDAO platilloMultipleDAO;

    @Override
    public List<PlatilloMultiple> getAllPlatillosMultiples() {
        return platilloMultipleDAO.findAll();
    }

    @Override
    public PlatilloMultiple getPlatilloMultipleById(Long id) {
        return platilloMultipleDAO.findById(id).orElse(null);
    }

    @Override
    public PlatilloMultiple savePlatilloMultiple(PlatilloMultiple platilloMultiple) {
        return platilloMultipleDAO.save(platilloMultiple);
    }

    @Override
    public void deletePlatilloMultiple(Long id) {
        platilloMultipleDAO.deleteById(id);
    }
}
