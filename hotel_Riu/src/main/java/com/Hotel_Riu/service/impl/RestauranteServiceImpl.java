package com.Hotel_Riu.service.impl;

import com.Hotel_Riu.domain.Cliente;
import com.Hotel_Riu.domain.Persona;
import com.Hotel_Riu.domain.Restaurante;
import com.Hotel_Riu.service.ClienteService;
import com.Hotel_Riu.service.PersonaService;
import com.Hotel_Riu.service.RestauranteService;
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

/**
 *
 * @autor dvela
 */
@Service
public class RestauranteServiceImpl implements RestauranteService {

    @PersistenceContext
    private EntityManager em;

    @Override
    public List<Restaurante> getRestaurantes() {
        // Crear una consulta para el procedimiento almacenado
        StoredProcedureQuery query = em.createStoredProcedureQuery("OBTENER_RESTAURANTES", Restaurante.class);

        // Registrar el parámetro de salida del cursor
        query.registerStoredProcedureParameter(
                1,
                void.class,
                ParameterMode.REF_CURSOR
        );

        // Ejecutar el procedimiento
        query.execute();

        // Obtener y retornar los resultados como una lista de Restaurante
        List<Restaurante> resultado = query.getResultList();

        return resultado;
    }

}
