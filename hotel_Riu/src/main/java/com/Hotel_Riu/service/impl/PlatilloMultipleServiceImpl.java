package com.Hotel_Riu.service.impl;

import com.Hotel_Riu.domain.PlatilloMultiple;
import com.Hotel_Riu.service.PlatilloMultipleService;
import jakarta.persistence.EntityManager;
import jakarta.persistence.ParameterMode;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.StoredProcedureQuery;
import jakarta.transaction.Transactional;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

/**
 *
 *
 * @author Alonso Muñoz Aguilar
 */
@Service
public class PlatilloMultipleServiceImpl implements PlatilloMultipleService {

    @PersistenceContext
    private EntityManager entityManager;

    private static final Logger LOGGER = LoggerFactory.getLogger(PlatilloMultipleServiceImpl.class);

    @Override
    @SuppressWarnings("unchecked")
    public List<PlatilloMultiple> getPlatillosMultiples() {
        StoredProcedureQuery query = entityManager.createStoredProcedureQuery("OBTENER_PLATILLOS_MULTIPLES", PlatilloMultiple.class);
        query.registerStoredProcedureParameter(1, void.class, ParameterMode.REF_CURSOR);
        query.execute();
        List<PlatilloMultiple> result = query.getResultList();
        LOGGER.info("Platillos múltiples obtenidos: {}", result.size());
        return result;
    }

    @Override
    @Transactional
    public void agregarPlatilloMultiple(PlatilloMultiple platilloMultiple) {
        try
        {
            StoredProcedureQuery query = entityManager.createStoredProcedureQuery("AGREGAR_PLATILLO_MULTIPLE");

            // Registrar parámetros del procedimiento almacenado
            query.registerStoredProcedureParameter(1, Long.class, ParameterMode.IN);  // ID_PLATILLO
            query.registerStoredProcedureParameter(2, Long.class, ParameterMode.IN);  // ID_FACT_RESTAURANTE

            // Establecer los valores de los parámetros
            query.setParameter(1, platilloMultiple.getIdPlatillo());
            query.setParameter(2, platilloMultiple.getIdFactRestaurante());

            // Ejecutar el procedimiento
            query.execute();

            LOGGER.info("Platillo múltiple agregado correctamente: {}", platilloMultiple);
        } catch (Exception e)
        {
            LOGGER.error("Error al agregar el platillo múltiple", e);
            throw new RuntimeException("Error al agregar el platillo múltiple: " + e.getMessage());
        }
    }

    @Override
    @Transactional
    public void actualizarPlatilloMultiple(PlatilloMultiple platilloMultiple) {
        try
        {
            StoredProcedureQuery query = entityManager.createStoredProcedureQuery("ACTUALIZAR_PLATILLO_MULTIPLE");

            query.registerStoredProcedureParameter(1, Long.class, ParameterMode.IN);    // ID_PLATILLO_MULTIPLE
            query.registerStoredProcedureParameter(2, Long.class, ParameterMode.IN);    // ID_PLATILLO
            query.registerStoredProcedureParameter(3, Long.class, ParameterMode.IN);    // ID_FACT_RESTAURANTE

            query.setParameter(1, platilloMultiple.getIdPlatilloMultiple());
            query.setParameter(2, platilloMultiple.getIdPlatillo());
            query.setParameter(3, platilloMultiple.getIdFactRestaurante());

            query.execute();
            LOGGER.info("Platillo múltiple actualizado: {}", platilloMultiple);
        } catch (Exception e)
        {
            LOGGER.error("Error al actualizar el platillo múltiple", e);
            throw new RuntimeException("Error al actualizar el platillo múltiple: " + e.getMessage());
        }
    }

    @Override
    @Transactional
    public void eliminarPlatilloMultiple(Long idPlatilloMultiple) {
        StoredProcedureQuery query = entityManager.createStoredProcedureQuery("ELIMINAR_PLATILLO_MULTIPLE");

        query.registerStoredProcedureParameter(1, Long.class, ParameterMode.IN);
        query.setParameter(1, idPlatilloMultiple);

        query.execute();
        LOGGER.info("Platillo múltiple eliminado con ID: {}", idPlatilloMultiple);
    }

    @Override
    public PlatilloMultiple obtenerPlatilloMultiplePorId(Long id) {
        return getPlatillosMultiples().stream()
                .filter(platillo -> platillo.getIdPlatilloMultiple().equals(id))
                .findFirst()
                .orElse(null);
    }
}
