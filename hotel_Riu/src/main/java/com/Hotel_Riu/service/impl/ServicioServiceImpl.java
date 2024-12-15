package com.Hotel_Riu.service.impl;

import com.Hotel_Riu.domain.Habitacion;
import com.Hotel_Riu.domain.Servicio;
import com.Hotel_Riu.service.ServicioService;
import jakarta.persistence.EntityManager;
import jakarta.persistence.ParameterMode;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.StoredProcedureQuery;
import java.util.List;
import org.springframework.stereotype.Service;

@Service
public class ServicioServiceImpl implements ServicioService {

    @PersistenceContext
    private EntityManager em;

    @Override
    public List<Servicio> getServicios() {
        // Crear la consulta del procedimiento almacenado
        StoredProcedureQuery query = em.createStoredProcedureQuery("OBTENER_SERVICIOS", Servicio.class);
        // Registrar el parámetro de salida
        query.registerStoredProcedureParameter(
                1, // posición del parámetro
                void.class, // tipo del parámetro
                ParameterMode.REF_CURSOR // modo del parámetro
        );
        // Ejecutar el procedimiento
        query.execute();

        // Obtener los resultados
        List<Servicio> resultado = query.getResultList();
        return resultado;
    }

    @Override
    public void agregarServicio(Servicio servicio) {
        // Crear la consulta del procedimiento almacenado
        StoredProcedureQuery query = em.createStoredProcedureQuery("AGREGAR_SERVICIO");
        // Registrar los parámetros de entrada
        query.registerStoredProcedureParameter(1, String.class, ParameterMode.IN); // NOMBRE
        // Establecer el valor de los parámetros
        query.setParameter(1, servicio.getNombre());
        // Ejecutar el procedimiento
        query.execute();
    }

    @Override
    public void actualizarServicio(Servicio servicio) {
        // Crear la consulta del procedimiento almacenado
        StoredProcedureQuery query = em.createStoredProcedureQuery("ACTUALIZAR_SERVICIO");

        // Registrar los parámetros de entrada
        query.registerStoredProcedureParameter(1, Long.class, ParameterMode.IN);
        query.registerStoredProcedureParameter(2, String.class, ParameterMode.IN);

        // Establecer los valores de los parámetros
        query.setParameter(1, servicio.getIdServicio());
        query.setParameter(2, servicio.getNombre());

        // Ejecutar el procedimiento
        query.execute();
    }

    @Override
    public Servicio ObtenerServicioID(Long id) {
        List<Servicio> servicios = getServicios();
        for (int i = 0; i < servicios.size(); i++) {
            if (servicios.get(i).getIdServicio() == id) {
                return servicios.get(i);
            }
        }
        return null;
    }

    @Override
    public void eliminarServicio(Long idServicio) {
        // Crear la consulta del procedimiento almacenado
        StoredProcedureQuery query = em.createStoredProcedureQuery("ELIMINAR_SERVICIO");

        // Registrar el parámetro de entrada (ID del servicio a eliminar)
        query.registerStoredProcedureParameter(1, Long.class, ParameterMode.IN);

        // Establecer el valor del parámetro de entrada
        query.setParameter(1, idServicio);

        // Ejecutar el procedimiento
        query.execute();
    }

    //Logica y Funciones para asignacion y eliminacion de servicios de las habitaciones
    @Override
    public void agregarServicioxHabitacion(Long idService, Long idHabitacion) {
        // Crear la consulta del procedimiento almacenado
        StoredProcedureQuery query = em.createStoredProcedureQuery("ASIGNAR_SERVICIO_A_HABITACION");

        // Registrar los parámetros de entrada
        query.registerStoredProcedureParameter("P_ID_HABITACION", Long.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("P_ID_SERVICIO", Long.class, ParameterMode.IN);

        // Establecer los valores de los parámetros
        query.setParameter("P_ID_HABITACION", idHabitacion);
        query.setParameter("P_ID_SERVICIO", idService);

        // Ejecutar el procedimiento
        query.execute();
    }

    @Override
    public void eliminarServicioxHabitacion(Long idService, Long idHabitacion) {
        // Crear la consulta del procedimiento almacenado
        StoredProcedureQuery query = em.createStoredProcedureQuery("ELIMINAR_SERVICIO_DE_HABITACION");

        // Registrar los parámetros de entrada
        query.registerStoredProcedureParameter("P_ID_HABITACION", Long.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("P_ID_SERVICIO", Long.class, ParameterMode.IN);

        // Establecer los valores de los parámetros
        query.setParameter("P_ID_HABITACION", idHabitacion);
        query.setParameter("P_ID_SERVICIO", idService);

        // Ejecutar el procedimiento
        query.execute();
    }

}
