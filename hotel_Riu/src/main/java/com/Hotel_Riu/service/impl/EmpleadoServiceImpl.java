/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.Hotel_Riu.service.impl;

import com.Hotel_Riu.domain.Empleado;
import com.Hotel_Riu.domain.Persona;
import com.Hotel_Riu.service.EmpleadoService;
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

/**
 *
 * @author dvela
 */
@Service
public class EmpleadoServiceImpl implements EmpleadoService {

    @PersistenceContext
    private EntityManager em;

    @Autowired
    private PersonaService personaService;

    private static final Logger logger = LoggerFactory.getLogger(PersonaServiceImpl.class);

    @Override
    public List<Empleado> getEmpleados() {
        StoredProcedureQuery query = em.createStoredProcedureQuery("OBTENER_EMPLEADOS", Empleado.class);
        query.registerStoredProcedureParameter(
                1,
                void.class,
                ParameterMode.REF_CURSOR
        );

        query.execute();

        List<Empleado> resultado = query.getResultList();

        return resultado;
    }

    @Override
    public void agregarEmpleado(Empleado empleado) {
        StoredProcedureQuery query = em.createStoredProcedureQuery("AGREGAR_EMPLEADO");

        query.registerStoredProcedureParameter(1, Long.class, ParameterMode.IN);   // ID_HOTEL
        query.registerStoredProcedureParameter(2, Long.class, ParameterMode.IN);   // ID_PERSONA
        query.registerStoredProcedureParameter(3, String.class, ParameterMode.IN); // ESTADO
        query.registerStoredProcedureParameter(4, String.class, ParameterMode.IN); // PUESTO
        query.registerStoredProcedureParameter(5, Double.class, ParameterMode.IN); // SALARIO
        query.registerStoredProcedureParameter(6, java.sql.Date.class, ParameterMode.IN); // FECHA_INGRESO

        query.setParameter(1, empleado.getId_hotel());
        query.setParameter(2, empleado.getPersona().getId_persona());
        query.setParameter(3, empleado.getEstado());
        query.setParameter(4, empleado.getPuesto());
        query.setParameter(5, empleado.getSalario());
        query.setParameter(6, new java.sql.Date(empleado.getFecha_ingreso().getTime()));

        query.execute();
    }

    @Override
    @Transactional
    public void actualizarEmpleado(Empleado empleado) {
        Persona persona = empleado.getPersona();
        personaService.actualizarPersona(persona);

        logger.debug("Ejecutando procedimiento almacenado para actualizar empleado con ID: {}", empleado.getId_empleado());

        StoredProcedureQuery query = em.createStoredProcedureQuery("ACTUALIZAR_EMPLEADO");

        query.registerStoredProcedureParameter(1, Long.class, ParameterMode.IN);    // ID_EMPLEADO
        query.registerStoredProcedureParameter(2, Long.class, ParameterMode.IN);    // ID_HOTEL
        query.registerStoredProcedureParameter(3, Long.class, ParameterMode.IN);    // ID_PERSONA
        query.registerStoredProcedureParameter(4, String.class, ParameterMode.IN);  // ESTADO
        query.registerStoredProcedureParameter(5, String.class, ParameterMode.IN);  // PUESTO
        query.registerStoredProcedureParameter(6, Double.class, ParameterMode.IN);  // SALARIO
        query.registerStoredProcedureParameter(7, java.sql.Date.class, ParameterMode.IN);  // FECHA_INGRESO

        query.setParameter(1, empleado.getId_empleado());
        query.setParameter(2, empleado.getId_hotel());
        query.setParameter(3, empleado.getPersona().getId_persona());  // Pasar el ID de Persona
        query.setParameter(4, empleado.getEstado());
        query.setParameter(5, empleado.getPuesto());
        query.setParameter(6, empleado.getSalario());
        query.setParameter(7, new java.sql.Date(empleado.getFecha_ingreso().getTime()));

        query.execute();
    }

    @Override
    public void eliminarEmpleado(Long id_Empleado) {
        StoredProcedureQuery query = em.createStoredProcedureQuery("ELIMINAR_EMPELADO");
        query.registerStoredProcedureParameter(1, Long.class, ParameterMode.IN);
        query.setParameter(1, id_Empleado);

        query.execute();
    }

    @Override
    public Empleado obtenerEmpleadoPorID(Long id) {
        List<Empleado> empleados = getEmpleados();
        for (Empleado empleado : empleados) {
            if (empleado.getId_empleado().equals(id)) {
                return empleado;
            }
        }
        return null;
    }
}
