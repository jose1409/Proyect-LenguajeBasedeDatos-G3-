package com.Hotel_Riu.service.impl;

import com.Hotel_Riu.domain.Direccion;
import com.Hotel_Riu.service.DireccionService;
import jakarta.persistence.EntityManager;
import jakarta.persistence.ParameterMode;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.StoredProcedureQuery;
import jakarta.transaction.Transactional;
import java.math.BigDecimal;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

@Service
public class DireccionServiceImpl implements DireccionService {


    private static final Logger logger = LoggerFactory.getLogger(DireccionServiceImpl.class);

    @PersistenceContext
    private EntityManager em;

    @Override
    public List<Direccion> getDirecciones() {
        StoredProcedureQuery query = em.createStoredProcedureQuery("OBTENER_DIRECCION", Direccion.class);
        query.registerStoredProcedureParameter(
                1,
                void.class,
                ParameterMode.REF_CURSOR
        );
        query.execute();
        List<Direccion> resultado = query.getResultList();
        return resultado;
    }

    @Override
    public void spInsertDireccion(Direccion direccion) {
        StoredProcedureQuery query = em.createStoredProcedureQuery("SP_INSERT_DIRECCION");

        query.registerStoredProcedureParameter(1, String.class, ParameterMode.IN); //PROVINCIA
        query.registerStoredProcedureParameter(2, String.class, ParameterMode.IN); //CANTON
        query.registerStoredProcedureParameter(3, String.class, ParameterMode.IN); //DISTRITO
        query.registerStoredProcedureParameter(4, String.class, ParameterMode.IN); //DIRECCION_DETALLADA

        query.setParameter(1, direccion.getProvincia());
        query.setParameter(2, direccion.getCanton());
        query.setParameter(3, direccion.getDistrito());
        query.setParameter(4, direccion.getDireccion_detallada());

        query.execute();

        Long idDireccionGenerado = ((BigDecimal) em.createNativeQuery("SELECT ID_DIRECCION_SEQ.CURRVAL FROM DUAL").getSingleResult()).longValue();
        direccion.setId_direccion(idDireccionGenerado);
    }

    @Override
    @Transactional
    public void spUpdateDireccion(Direccion direccion) {
        logger.debug("Ejecutando procedimiento almacenado para actualizar direccion con ID: {}", direccion.getId_direccion());
        logger.debug("Datos de direccion: Provincia: {}, Canton: {}, Distrito: {}, Direccion Detallada: {}",
                direccion.getProvincia(), direccion.getCanton(), direccion.getDistrito(), direccion.getDireccion_detallada());

        StoredProcedureQuery query = em.createStoredProcedureQuery("SP_UPDATE_DIRECCION");

        query.registerStoredProcedureParameter(1, Long.class, ParameterMode.IN);    // ID_DIRECCION
        query.registerStoredProcedureParameter(2, String.class, ParameterMode.IN);  // Provincia
        query.registerStoredProcedureParameter(3, String.class, ParameterMode.IN);  // Canton
        query.registerStoredProcedureParameter(4, String.class, ParameterMode.IN);  // Distrito
        query.registerStoredProcedureParameter(5, String.class, ParameterMode.IN);  // direccion_detallada

        query.setParameter(1, direccion.getId_direccion());
        query.setParameter(2, direccion.getProvincia());
        query.setParameter(3, direccion.getCanton());
        query.setParameter(4, direccion.getDistrito());
        query.setParameter(5, direccion.getDireccion_detallada());

        query.execute();
    }

    @Override
    public void spDeleteDireccion(Long idDireccion) {
        StoredProcedureQuery query = em.createStoredProcedureQuery("SP_DELETE_DIRECCION");
        query.registerStoredProcedureParameter(1, Long.class, ParameterMode.IN);
        query.setParameter(1, idDireccion);

        query.execute();
    }

    @Override
    public Direccion obtenerDireccionPorID(Long id) {
        List<Direccion> direcciones = getDirecciones();
        for (Direccion direccion : direcciones) {
            if (direccion.getId_direccion().equals(id)) {
                return direccion;
            }
        }
        return null;
    }
}
