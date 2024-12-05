/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.Hotel_Riu.service.impl;

import com.Hotel_Riu.domain.Persona;
import com.Hotel_Riu.service.PersonaService;
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

/**
 *
 * @author dvela
 */
@Service
public class PersonaServiceImpl implements PersonaService {

    private static final Logger logger = LoggerFactory.getLogger(PersonaServiceImpl.class);

    @PersistenceContext
    private EntityManager em;

    @Override
    public List<Persona> getPersonas() {
        StoredProcedureQuery query = em.createStoredProcedureQuery("OBTENER_PERSONAS", Persona.class);
        query.registerStoredProcedureParameter(
                1,
                void.class,
                ParameterMode.REF_CURSOR
        );
        query.execute();
        List<Persona> resultado = query.getResultList();
        return resultado;
    }

    @Override
    public void agregarPersona(Persona persona) {
        StoredProcedureQuery query = em.createStoredProcedureQuery("AGREGAR_PERSONA");

        query.registerStoredProcedureParameter(1, String.class, ParameterMode.IN);
        query.registerStoredProcedureParameter(2, String.class, ParameterMode.IN);
        query.registerStoredProcedureParameter(3, String.class, ParameterMode.IN);
        query.registerStoredProcedureParameter(4, String.class, ParameterMode.IN);
        query.registerStoredProcedureParameter(5, String.class, ParameterMode.IN);
        query.registerStoredProcedureParameter(6, String.class, ParameterMode.IN);
        query.registerStoredProcedureParameter(7, String.class, ParameterMode.IN);

        query.setParameter(1, persona.getTipo_documento());
        query.setParameter(2, persona.getCedula());
        query.setParameter(3, persona.getTelefono());
        query.setParameter(4, persona.getCorreo());
        query.setParameter(5, persona.getNombre());
        query.setParameter(6, persona.getPrimer_apellido());
        query.setParameter(7, persona.getSegundo_apellido());

        query.execute();

        Long idPersonaGenerado = ((BigDecimal) em.createNativeQuery("SELECT ID_PERSONA_SEQ.CURRVAL FROM DUAL").getSingleResult()).longValue();
        persona.setId_persona(idPersonaGenerado);
    }

    @Override
    @Transactional
    public void actualizarPersona(Persona persona) {
        logger.debug("Ejecutando procedimiento almacenado para actualizar persona con ID: {}", persona.getId_persona());
        logger.debug("Datos de persona: Tipo Documento: {}, Cedula: {}, Telefono: {}, Correo: {}, Nombre: {}, Primer Apellido: {}, Segundo Apellido: {}",
                persona.getTipo_documento(), persona.getCedula(), persona.getTelefono(), persona.getCorreo(), persona.getNombre(), persona.getPrimer_apellido(), persona.getSegundo_apellido());

        StoredProcedureQuery query = em.createStoredProcedureQuery("ACTUALIZAR_PERSONA");

        query.registerStoredProcedureParameter(1, Long.class, ParameterMode.IN);    // ID_PERSONA
        query.registerStoredProcedureParameter(2, String.class, ParameterMode.IN);  // TIPO_DOCUMENTO
        query.registerStoredProcedureParameter(3, String.class, ParameterMode.IN);  // CEDULA
        query.registerStoredProcedureParameter(4, String.class, ParameterMode.IN);  // TELEFONO
        query.registerStoredProcedureParameter(5, String.class, ParameterMode.IN);  // CORREO
        query.registerStoredProcedureParameter(6, String.class, ParameterMode.IN);  // NOMBRE
        query.registerStoredProcedureParameter(7, String.class, ParameterMode.IN);  // PRIMER_APELLIDO
        query.registerStoredProcedureParameter(8, String.class, ParameterMode.IN);  // SEGUNDO_APELLIDO

        query.setParameter(1, persona.getId_persona());
        query.setParameter(2, persona.getTipo_documento());
        query.setParameter(3, persona.getCedula());
        query.setParameter(4, persona.getTelefono());
        query.setParameter(5, persona.getCorreo());
        query.setParameter(6, persona.getNombre());
        query.setParameter(7, persona.getPrimer_apellido());
        query.setParameter(8, persona.getSegundo_apellido());

        query.execute();
    }

    @Override
    public void eliminarPersona(Long idPersona) {
        StoredProcedureQuery query = em.createStoredProcedureQuery("ELIMINAR_PERSONA");
        query.registerStoredProcedureParameter(1, Long.class, ParameterMode.IN);
        query.setParameter(1, idPersona);

        query.execute();
    }

    @Override
    public Persona obtenerPersonaPorID(Long id) {
        List<Persona> personas = getPersonas();
        for (Persona persona : personas) {
            if (persona.getId_persona().equals(id)) {
                return persona;
            }
        }
        return null;
    }
}
