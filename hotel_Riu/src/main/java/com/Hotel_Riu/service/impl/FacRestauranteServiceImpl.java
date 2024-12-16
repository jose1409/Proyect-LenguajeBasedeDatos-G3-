package com.Hotel_Riu.service.impl;

import com.Hotel_Riu.domain.FacRestaurante;
import com.Hotel_Riu.service.FacRestauranteService;
import com.Hotel_Riu.service.PersonaService;
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
public class FacRestauranteServiceImpl implements FacRestauranteService {

    @PersistenceContext
    private EntityManager em;

    @Override
    public List<FacRestaurante> getFacRestaurante() {
        // Crear una consulta para el procedimiento almacenado
        StoredProcedureQuery query = em.createStoredProcedureQuery("obtener_fact_restaurante", FacRestaurante.class);
        query.registerStoredProcedureParameter(
                1,
                void.class,
                ParameterMode.REF_CURSOR
        );
        query.execute();

        // Obtener y retornar los resultados como una lista de FacRestaurante
        List<FacRestaurante> resultado = query.getResultList();

        return resultado;
    }

}
