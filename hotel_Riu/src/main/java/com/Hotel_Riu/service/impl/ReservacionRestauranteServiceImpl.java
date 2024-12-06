package com.Hotel_Riu.service.impl;

import com.Hotel_Riu.domain.ReservacionRestaurante;
import com.Hotel_Riu.service.ReservacionRestauranteService;
import jakarta.persistence.EntityManager;
import jakarta.persistence.ParameterMode;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.StoredProcedureQuery;
import jakarta.transaction.Transactional;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 *
 * @author Alonso Muñoz Aguilar
 */
@Service
public class ReservacionRestauranteServiceImpl implements ReservacionRestauranteService {

    @PersistenceContext
    private EntityManager em;

    private static final Logger logger = LoggerFactory.getLogger(ReservacionRestauranteServiceImpl.class);

    @Override
    public List<ReservacionRestaurante> obtenerReservaciones() {
        // Ejecutar el procedimiento almacenado para obtener las reservaciones de restaurante
        StoredProcedureQuery query = em.createStoredProcedureQuery("OBTENER_RESERVACIONES_RESTAURANTE", ReservacionRestaurante.class);
        query.registerStoredProcedureParameter(1, void.class, ParameterMode.REF_CURSOR);

        query.execute();

        // Obtener y devolver el resultado
        List<ReservacionRestaurante> resultado = query.getResultList();
        return resultado;
    }

    @Override
    public void agregarReservacion(ReservacionRestaurante reservacion) {
        // Ejecutar el procedimiento almacenado para agregar una reservación
        StoredProcedureQuery query = em.createStoredProcedureQuery("AGREGAR_RESERVACION_RESTAURANTE");

        query.registerStoredProcedureParameter(1, Long.class, ParameterMode.IN);  // ID_CLIENTE
        query.registerStoredProcedureParameter(2, String.class, ParameterMode.IN); // HORA_ENTRADA
        query.registerStoredProcedureParameter(3, java.sql.Date.class, ParameterMode.IN); // FECHA_RESERVACION

        query.setParameter(1, reservacion.getIdCliente());
        query.setParameter(2, reservacion.getHoraEntrada());
        query.setParameter(3, new java.sql.Date(reservacion.getFechaReservacion().getTime()));

        query.execute();
    }

    @Override
    @Transactional
    public void actualizarReservacion(ReservacionRestaurante reservacion) {
        logger.debug("Ejecutando procedimiento almacenado para actualizar reservación con ID: {}", reservacion.getIdReservacionRestaurante());

        // Ejecutar el procedimiento almacenado para actualizar la reservación
        StoredProcedureQuery query = em.createStoredProcedureQuery("ACTUALIZAR_RESERVACION_RESTAURANTE");

        query.registerStoredProcedureParameter(1, Long.class, ParameterMode.IN);    // ID_RESERVACION_RESTAURANTE
        query.registerStoredProcedureParameter(2, Long.class, ParameterMode.IN);    // ID_CLIENTE
        query.registerStoredProcedureParameter(3, String.class, ParameterMode.IN);  // HORA_ENTRADA
        query.registerStoredProcedureParameter(4, java.sql.Date.class, ParameterMode.IN);  // FECHA_RESERVACION

        query.setParameter(1, reservacion.getIdReservacionRestaurante());
        query.setParameter(2, reservacion.getIdCliente());
        query.setParameter(3, reservacion.getHoraEntrada());
        query.setParameter(4, new java.sql.Date(reservacion.getFechaReservacion().getTime()));

        query.execute();
    }

    @Override
    public void eliminarReservacion(Long idReservacionRestaurante) {
        // Ejecutar el procedimiento almacenado para eliminar la reservación
        StoredProcedureQuery query = em.createStoredProcedureQuery("ELIMINAR_RESERVACION_RESTAURANTE");

        query.registerStoredProcedureParameter(1, Long.class, ParameterMode.IN);  // ID_RESERVACION_RESTAURANTE
        query.setParameter(1, idReservacionRestaurante);

        query.execute();
    }

    @Override
    public ReservacionRestaurante obtenerReservacionPorID(Long idReservacionRestaurante) {
        List<ReservacionRestaurante> reservaciones = obtenerReservaciones();
        for (ReservacionRestaurante reservacion : reservaciones) {
            if (reservacion.getIdReservacionRestaurante().equals(idReservacionRestaurante)) {
                return reservacion;
            }
        }
        return null;
    }
}

