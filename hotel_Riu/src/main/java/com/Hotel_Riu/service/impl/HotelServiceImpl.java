package com.Hotel_Riu.service.impl;

import com.Hotel_Riu.domain.Direccion;
import com.Hotel_Riu.domain.Horario;
import com.Hotel_Riu.domain.Hotel;
import com.Hotel_Riu.service.DireccionService;
import com.Hotel_Riu.service.HorarioService;
import com.Hotel_Riu.service.HotelService;
import jakarta.persistence.EntityManager;
import jakarta.persistence.ParameterMode;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.StoredProcedureQuery;
import jakarta.transaction.Transactional;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class HotelServiceImpl implements HotelService{
    
    @PersistenceContext
    private EntityManager em;
//    
//    @Autowired
//    private HorarioService horarioService;
//    
//    @Autowired
//    private DireccionService direccionService;
//    
//    private static final Logger logger = LoggerFactory.getLogger(DireccionServiceImpl.class);
//    
    @Override
    public List<Hotel> getHoteles() {
        StoredProcedureQuery query = em.createStoredProcedureQuery("OBTENER_HOTELES", Hotel.class);
        
        query.registerStoredProcedureParameter(
                1,
                void.class,
                ParameterMode.REF_CURSOR
        );

        query.execute();

        List<Hotel> resultado = query.getResultList();

        return resultado;
    }

    @Override
    public void spInsertHotel(Hotel hotel) {
        StoredProcedureQuery query = em.createStoredProcedureQuery("SP_INSERT_HOTEL");

        query.registerStoredProcedureParameter(1, Long.class, ParameterMode.IN);   // ID_DIRECCION
        query.registerStoredProcedureParameter(2, Long.class, ParameterMode.IN);   // ID_HORARIO
        query.registerStoredProcedureParameter(3, String.class, ParameterMode.IN); // NOMBRE
        query.registerStoredProcedureParameter(4, String.class, ParameterMode.IN); // TELEFONO
        query.registerStoredProcedureParameter(5, String.class, ParameterMode.IN); // CORREO

        
        query.setParameter(1, 1);
        query.setParameter(2, 1);
        query.setParameter(3, hotel.getNombre());
        query.setParameter(4, hotel.getTelefono());
        query.setParameter(5, hotel.getCorreo());

        query.execute();
    }
  
    @Override
    public Hotel ObtenerHotelID(Long id) {
        List<Hotel> hoteles = getHoteles();

        for (int i = 0; i < hoteles.size(); i++) {
            if (hoteles.get(i).getId_hotel() == id) {
                return hoteles.get(i);
            }
        }
        return null;
    }
    
    @Override
    public void spDeleteHotel(Long id_hotel) {
        StoredProcedureQuery query = em.createStoredProcedureQuery("SP_DELETE_HOTEL");
        
        query.registerStoredProcedureParameter(1, Long.class, ParameterMode.IN);
        
        query.setParameter(1, id_hotel);

        query.execute();
    }

    @Override
    @Transactional
    public void spUpdateHotel(Hotel hotel) {
        
        StoredProcedureQuery query = em.createStoredProcedureQuery("SP_UPDATE_HOTEL");

        query.registerStoredProcedureParameter(1, Long.class, ParameterMode.IN);   // ID_hotel
        query.registerStoredProcedureParameter(2, Long.class, ParameterMode.IN);   // ID_DIRECCION
        query.registerStoredProcedureParameter(3, Long.class, ParameterMode.IN);   // ID_HORARIO
        query.registerStoredProcedureParameter(4, String.class, ParameterMode.IN); // NOMBRE
        query.registerStoredProcedureParameter(5, String.class, ParameterMode.IN); // TELEFONO
        query.registerStoredProcedureParameter(6, String.class, ParameterMode.IN); // CORREO

        query.setParameter(1, hotel.getId_hotel());
        query.setParameter(2, 1);
        query.setParameter(3, 1);
        query.setParameter(4, hotel.getNombre());
        query.setParameter(5, hotel.getTelefono());
        query.setParameter(6, hotel.getCorreo());

        query.execute();
    }
    
}
