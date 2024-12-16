package com.Hotel_Riu.service.impl;

import com.Hotel_Riu.domain.ReservacionRestaurante;
import com.Hotel_Riu.service.ReservacionRestauranteService;
import jakarta.persistence.EntityManager;
import jakarta.persistence.ParameterMode;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.StoredProcedureQuery;
import java.sql.Date;
import java.util.List;
import org.springframework.stereotype.Service;

/**
 *
 * @autor dvela
 */
@Service
public class ReservacionRestauranteServiceImpl implements ReservacionRestauranteService {

    @PersistenceContext
    private EntityManager em;

    @Override
    public List<ReservacionRestaurante> getReservacionRestaurante() {
        StoredProcedureQuery query = em.createStoredProcedureQuery("obtener_reservaciones_restaurante", ReservacionRestaurante.class);
        query.registerStoredProcedureParameter(
                1,
                void.class,
                ParameterMode.REF_CURSOR
        );

        // Ejecutar el procedimiento
        query.execute();

        List<ReservacionRestaurante> resultado = query.getResultList();

        return resultado;
    }

    @Override
    public void agregarReservacionRestaurante(ReservacionRestaurante reservacionRestaurante) {
        // Crear la consulta del procedimiento almacenado
        StoredProcedureQuery query = em.createStoredProcedureQuery("AGREGAR_RESERVACION_RESTAURANTE");

        // Registrar los parámetros de entrada
        query.registerStoredProcedureParameter(1, Long.class, ParameterMode.IN);   // ID_CLIENTE
        query.registerStoredProcedureParameter(2, String.class, ParameterMode.IN);  // HORA_ENTRADA
        query.registerStoredProcedureParameter(3, java.sql.Date.class, ParameterMode.IN);  // FECHA_RESERVACION
        // Establecer los valores de los parámetros
        query.setParameter(1, reservacionRestaurante.getCliente().getId_cliente());
        query.setParameter(2, reservacionRestaurante.getHoraEntrada());
        query.setParameter(3, reservacionRestaurante.getFechaReservacion());

        // Ejecutar el procedimiento
        query.execute();
    }

    @Override
    public ReservacionRestaurante getReservacionRestaurantexID(Long id) {
        List<ReservacionRestaurante> result = getReservacionRestaurante();
        for (int i = 0; i < result.size(); i++) {
            if(result.get(i).getIdReservacionRestaurante() == id) {
                return result.get(i);
            }
        }
        return null;
    }
}
