package com.Hotel_Riu.service.impl;

import com.Hotel_Riu.domain.Direccion;
import com.Hotel_Riu.service.DireccionService;
import jakarta.persistence.EntityManager;
import jakarta.persistence.ParameterMode;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.StoredProcedureQuery;
import java.util.List;
import org.springframework.stereotype.Service;

@Service
public class DireccionServiceImpl implements DireccionService {

//    private static final Logger logger = LoggerFactory.getLogger(DireccionServiceImpl.class);

    @PersistenceContext
    private EntityManager em;

    
    @Override
    public Direccion obtenerDireccionID(Long id) {
         // Crear la consulta del procedimiento almacenado
        StoredProcedureQuery query = em.createStoredProcedureQuery("OBTENER_DIRECCION_POR_ID", Direccion.class);

        // Registrar el parámetro de entrada (ID del horario)
        query.registerStoredProcedureParameter(1, Long.class, ParameterMode.IN);

        // Registrar el parámetro de salida (cursor)
        query.registerStoredProcedureParameter(2, void.class, ParameterMode.REF_CURSOR);

        // Establecer el valor del parámetro de entrada Sera el id Direccion establecido en la reservacion
        query.setParameter(1, id);

        // Ejecutar el procedimiento
        query.execute();

        // Obtener el resultado como una lista (aunque esperamos solo un registro)
        Direccion direccion = (Direccion) query.getSingleResult();
        return direccion;
    }
    
    @Override
    public List<Direccion> getDirecciones() {
        StoredProcedureQuery query = em.createStoredProcedureQuery("OBTENER_DIRECCIONES", Direccion.class);
        query.registerStoredProcedureParameter(
                1,
                void.class,
                ParameterMode.REF_CURSOR
        );
        query.execute();
        List<Direccion> resultado = query.getResultList();
        return resultado;
    }
}
