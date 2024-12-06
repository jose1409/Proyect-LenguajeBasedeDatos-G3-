package com.Hotel_Riu.service.impl;

import com.Hotel_Riu.domain.Platillo;
import com.Hotel_Riu.service.PlatilloService;
import jakarta.persistence.EntityManager;
import jakarta.persistence.ParameterMode;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.StoredProcedureQuery;
import jakarta.transaction.Transactional;
import java.util.List;
import org.springframework.stereotype.Service;

/**
 *
 * @author Alonso Muñoz Aguilar
 */
@Service
public class PlatilloServiceImpl implements PlatilloService {

    @PersistenceContext
    private EntityManager em;

    @Override
    public List<Platillo> getPlatillos() {
        StoredProcedureQuery query = em.createStoredProcedureQuery("OBTENER_PLATILLOS", Platillo.class);
        query.registerStoredProcedureParameter(
                1,
                void.class,
                ParameterMode.REF_CURSOR
        );

        query.execute();

        return query.getResultList();
    }

    @Override
    @Transactional
    public void agregarPlatillo(Platillo platillo) {
        StoredProcedureQuery query = em.createStoredProcedureQuery("AGREGAR_PLATILLO");

        query.registerStoredProcedureParameter(1, Long.class, ParameterMode.IN);   // ID_RESTAURANTE
        query.registerStoredProcedureParameter(2, String.class, ParameterMode.IN); // NOMBRE
        query.registerStoredProcedureParameter(3, Double.class, ParameterMode.IN); // PRECIO
        query.registerStoredProcedureParameter(4, Integer.class, ParameterMode.IN); // CANTIDAD

        query.setParameter(1, platillo.getIdRestaurante());
        query.setParameter(2, platillo.getNombre());
        query.setParameter(3, platillo.getPrecio());
        query.setParameter(4, platillo.getCantidad());

        query.execute();
    }

    @Override
    @Transactional
    public void actualizarPlatillo(Platillo platillo) {
        StoredProcedureQuery query = em.createStoredProcedureQuery("ACTUALIZAR_PLATILLO");

        query.registerStoredProcedureParameter(1, Long.class, ParameterMode.IN);   // ID_PLATILLO
        query.registerStoredProcedureParameter(2, Long.class, ParameterMode.IN);   // ID_RESTAURANTE
        query.registerStoredProcedureParameter(3, String.class, ParameterMode.IN); // NOMBRE
        query.registerStoredProcedureParameter(4, Double.class, ParameterMode.IN); // PRECIO
        query.registerStoredProcedureParameter(5, Integer.class, ParameterMode.IN); // CANTIDAD

        query.setParameter(1, platillo.getIdPlatillo());
        query.setParameter(2, platillo.getIdRestaurante());
        query.setParameter(3, platillo.getNombre());
        query.setParameter(4, platillo.getPrecio());
        query.setParameter(5, platillo.getCantidad());

        query.execute();
    }

    @Override
    @Transactional
    public void eliminarPlatillo(Long idPlatillo) {
        StoredProcedureQuery query = em.createStoredProcedureQuery("ELIMINAR_PLATILLO");

        query.registerStoredProcedureParameter(1, Long.class, ParameterMode.IN); // ID_PLATILLO
        query.setParameter(1, idPlatillo);

        query.execute();
    }

    @Override
    public Platillo obtenerPlatilloPorId(Long id) {

        List<Platillo> platillos = getPlatillos();
        return platillos.stream()
                .filter(platillo -> platillo.getIdPlatillo().equals(id))
                .findFirst()
                .orElse(null);
    }
}
