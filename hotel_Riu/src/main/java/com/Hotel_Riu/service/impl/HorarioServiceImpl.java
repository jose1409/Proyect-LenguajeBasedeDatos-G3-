package com.Hotel_Riu.service.impl;

import com.Hotel_Riu.domain.Horario;
import com.Hotel_Riu.service.HorarioService;
import jakarta.persistence.EntityManager;
import jakarta.persistence.ParameterMode;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.StoredProcedureQuery;
import java.util.List;
import org.springframework.stereotype.Service;

@Service
public class HorarioServiceImpl implements HorarioService {

    @PersistenceContext
    private EntityManager em;

    @Override
    public Horario obtenerHorarioID(Long id) {
        // Crear la consulta del procedimiento almacenado
        StoredProcedureQuery query = em.createStoredProcedureQuery("OBTENER_HORARIO_POR_ID", Horario.class);

        // Registrar el parámetro de entrada (ID del horario)
        query.registerStoredProcedureParameter(1, Long.class, ParameterMode.IN);

        // Registrar el parámetro de salida (cursor)
        query.registerStoredProcedureParameter(2, void.class, ParameterMode.REF_CURSOR);

        // Establecer el valor del parámetro de entrada Sera el id horario establecido en la reservacion
        query.setParameter(1, id);

        // Ejecutar el procedimiento
        query.execute();

        // Obtener el resultado como una lista (aunque esperamos solo un registro)
        Horario horario = (Horario) query.getSingleResult();
        return horario;
    }

    @Override
    public List<Horario> getHorarios() {
        // Crear la consulta del procedimiento almacenado
        StoredProcedureQuery query = em.createStoredProcedureQuery("OBTENER_HORARIOS", Horario.class);

        // Registrar el parámetro de salida (el cursor)
        query.registerStoredProcedureParameter(
                1, // posición del parámetro en el procedimiento
                void.class, // tipo del parámetro
                ParameterMode.REF_CURSOR // modo del parámetro
        );

        // Ejecutar el procedimiento almacenado
        query.execute();

        // Obtener el resultado y mapearlo a la clase Horario
        List<Horario> resultado = query.getResultList();

        return resultado;
    }

}
