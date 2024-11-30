package com.Hotel_Riu.service.impl;
import com.Hotel_Riu.domain.Habitacion;
import com.Hotel_Riu.domain.Servicio;
import com.Hotel_Riu.service.HabitacionService;
import jakarta.persistence.EntityManager;
import jakarta.persistence.ParameterMode;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.StoredProcedureQuery;
import java.util.List;
import org.springframework.stereotype.Service;

@Service
public class HabitacionServiceImpl implements HabitacionService {

    @PersistenceContext
    private EntityManager em;

    @Override
    public List<Habitacion> getHabitaciones() {
        // Crear la consulta del procedimiento almacenado
        StoredProcedureQuery query = em.createStoredProcedureQuery("OBTENER_HABITACIONES", Habitacion.class);

        // Registrar el parámetro de salida (el cursor)
        query.registerStoredProcedureParameter(
                1, // posición del parámetro
                void.class, // tipo del parámetro
                ParameterMode.REF_CURSOR // modo del parámetro
        );

        // Ejecutar el procedimiento
        query.execute();

        List<Habitacion> resultado = query.getResultList();

        return resultado;
    }

    @Override
    public void agregarHabitacion(Habitacion habitacion) {
        // Crear la consulta del procedimiento almacenado
        StoredProcedureQuery query = em.createStoredProcedureQuery("AGREGAR_HABITACION");

        // Registrar los parámetros de entrada
        query.registerStoredProcedureParameter(1, Long.class, ParameterMode.IN);   // ID_HOTEL
        query.registerStoredProcedureParameter(2, Integer.class, ParameterMode.IN); // NUMERO_HABITACION
        query.registerStoredProcedureParameter(3, Integer.class, ParameterMode.IN); // PRECIO
        query.registerStoredProcedureParameter(4, String.class, ParameterMode.IN);  // DESCRIPCION
        query.registerStoredProcedureParameter(5, String.class, ParameterMode.IN);  // ESTADO_LIMPIEZA
        query.registerStoredProcedureParameter(6, Integer.class, ParameterMode.IN); // CAPACIDAD

        // Establecer los valores de los parámetros
        query.setParameter(1, 1); // Este campo establece por predeterminado el primer hotel
        query.setParameter(2, habitacion.getNumeroHabitacion());
        query.setParameter(3, habitacion.getPrecio());
        query.setParameter(4, habitacion.getDescripcion());
        query.setParameter(5, habitacion.getEstadoLimpieza());
        query.setParameter(6, habitacion.getCapacidad());

        // Ejecutar el procedimiento
        query.execute();
    }

    @Override
    public void actualizarHabitacion(Habitacion habitacion) {
        // Crear la consulta del procedimiento almacenado
        StoredProcedureQuery query = em.createStoredProcedureQuery("ACTUALIZAR_HABITACION");

        // Registrar los parámetros de entrada
        query.registerStoredProcedureParameter(1, Long.class, ParameterMode.IN);    // ID_HABITACION
        query.registerStoredProcedureParameter(2, Integer.class, ParameterMode.IN); // NUMERO_HABITACION
        query.registerStoredProcedureParameter(3, Integer.class, ParameterMode.IN); // PRECIO
        query.registerStoredProcedureParameter(4, String.class, ParameterMode.IN);  // DESCRIPCION
        query.registerStoredProcedureParameter(5, String.class, ParameterMode.IN);  // ESTADO_LIMPIEZA
        query.registerStoredProcedureParameter(6, Integer.class, ParameterMode.IN); // CAPACIDAD

        // Establecer los valores de los parámetros
        query.setParameter(1, habitacion.getIdHabitacion());
        query.setParameter(2, habitacion.getNumeroHabitacion());
        query.setParameter(3, habitacion.getPrecio());
        query.setParameter(4, habitacion.getDescripcion());
        query.setParameter(5, habitacion.getEstadoLimpieza());
        query.setParameter(6, habitacion.getCapacidad());

        // Ejecutar el procedimiento
        query.execute();
    }

    @Override
    public Habitacion ObtenerHabitacionID(Long id) {
        List<Habitacion> habitaciones = getHabitaciones();
        boolean estado = true;
        for (int i = 0; i < habitaciones.size(); i++) {
            if (habitaciones.get(i).getIdHabitacion() == id) {
                return habitaciones.get(i);
            }
        }
        return null;
    }

    @Override
    public void eliminarHabitacion(Long idHabitacion) {
        // Crear una consulta de procedimiento almacenado
        StoredProcedureQuery query = em.createStoredProcedureQuery("ELIMINAR_HABITACION");

        // Registrar el parámetro de entrada (ID de la habitación a eliminar)
        query.registerStoredProcedureParameter(1, Long.class, ParameterMode.IN);

        // Establecer el valor del parámetro de entrada
        query.setParameter(1, idHabitacion);

        // Ejecutar el procedimiento
        query.execute();
    }

    @Override
    public List<Servicio> getServicios(Long id) {
        // Crear la consulta del procedimiento almacenado
        StoredProcedureQuery query = em.createStoredProcedureQuery("OBTENER_SERVICIOS_POR_HABITACION", Servicio.class);

        // Registrar el parámetro de entrada (ID de la habitación)
        query.registerStoredProcedureParameter(
                1, // posición del parámetro
                Integer.class, // tipo del parámetro
                ParameterMode.IN // modo del parámetro (entrada)
        );
        query.setParameter(1, id);

        // Registrar el parámetro de salida (cursor)
        query.registerStoredProcedureParameter(
                2, // posición del parámetro de salida
                void.class, // tipo del parámetro de salida
                ParameterMode.REF_CURSOR // modo del parámetro
        );

        // Ejecutar el procedimiento
        query.execute();

        // Obtener los resultados
        List<Servicio> resultado = query.getResultList();

        return resultado;

    }
}
