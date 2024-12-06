package com.Hotel_Riu.service.impl;

import com.Hotel_Riu.domain.Restaurante;
import com.Hotel_Riu.service.RestauranteService;
import jakarta.persistence.EntityManager;
import jakarta.persistence.ParameterMode;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.StoredProcedureQuery;
import jakarta.transaction.Transactional;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @autor Alonso
 */
@Service
public class RestauranteServiceImpl implements RestauranteService {

    private static final Logger logger = LoggerFactory.getLogger(RestauranteServiceImpl.class);

    @PersistenceContext
    private EntityManager em;

    @Override
    public List<Restaurante> obtenerRestaurantes() {
        logger.info("Obteniendo lista de restaurantes...");
        StoredProcedureQuery query = em.createStoredProcedureQuery("OBTENER_RESTAURANTES");

        query.registerStoredProcedureParameter(1, void.class, ParameterMode.REF_CURSOR);
        query.execute();

        List<Object[]> results = query.getResultList();
        List<Restaurante> restaurantes = new ArrayList<>();

        for (Object[] row : results)
        {
            Restaurante restaurante = new Restaurante();
            restaurante.setIdRestaurante(((Number) row[0]).longValue());
            restaurante.setIdHotel(((Number) row[1]).longValue());
            restaurante.setNombre((String) row[2]);
            restaurantes.add(restaurante);
        }

        logger.info("Total de restaurantes obtenidos: {}", restaurantes.size());
        return restaurantes;
    }

    @Override
    @Transactional
    public void agregarRestaurante(Restaurante restaurante) {
        logger.info("Agregando nuevo restaurante: {}", restaurante.getNombre());
        StoredProcedureQuery query = em.createStoredProcedureQuery("AGREGAR_RESTAURANTE");

        query.registerStoredProcedureParameter(1, Long.class, ParameterMode.IN);   // ID_HOTEL
        query.registerStoredProcedureParameter(2, String.class, ParameterMode.IN); // NOMBRE

        query.setParameter(1, restaurante.getIdHotel());
        query.setParameter(2, restaurante.getNombre());

        query.execute();
        logger.info("Restaurante agregado exitosamente");
    }

    @Override
    @Transactional
    public void actualizarRestaurante(Restaurante restaurante) {
        logger.info("Actualizando restaurante con ID: {}", restaurante.getIdRestaurante());
        StoredProcedureQuery query = em.createStoredProcedureQuery("ACTUALIZAR_RESTAURANTE");

        query.registerStoredProcedureParameter(1, Long.class, ParameterMode.IN);   // ID_RESTAURANTE
        query.registerStoredProcedureParameter(2, Long.class, ParameterMode.IN);   // ID_HOTEL
        query.registerStoredProcedureParameter(3, String.class, ParameterMode.IN); // NOMBRE

        query.setParameter(1, restaurante.getIdRestaurante());
        query.setParameter(2, restaurante.getIdHotel());
        query.setParameter(3, restaurante.getNombre());

        query.execute();
        logger.info("Restaurante actualizado exitosamente");
    }

    @Override
    @Transactional
    public void eliminarRestaurante(Long idRestaurante) {
        logger.info("Eliminando restaurante con ID: {}", idRestaurante);
        StoredProcedureQuery query = em.createStoredProcedureQuery("ELIMINAR_RESTAURANTE");

        query.registerStoredProcedureParameter(1, Long.class, ParameterMode.IN); // ID_RESTAURANTE
        query.setParameter(1, idRestaurante);

        query.execute();
        logger.info("Restaurante eliminado exitosamente");
    }

    @Override
    public Restaurante obtenerRestaurantePorId(Long idRestaurante) {
        logger.info("Buscando restaurante con ID: {}", idRestaurante);
        List<Restaurante> restaurantes = obtenerRestaurantes();

        for (Restaurante restaurante : restaurantes)
        {
            if (restaurante.getIdRestaurante().equals(idRestaurante))
            {
                logger.info("Restaurante encontrado: {}", restaurante.getNombre());
                return restaurante;
            }
        }

        logger.warn("Restaurante con ID {} no encontrado", idRestaurante);
        return null;
    }
}
