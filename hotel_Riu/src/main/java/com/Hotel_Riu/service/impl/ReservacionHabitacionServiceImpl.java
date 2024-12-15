package com.Hotel_Riu.service.impl;

import com.Hotel_Riu.domain.ReservacionHabitacion;
import com.Hotel_Riu.domain.Servicio;
import com.Hotel_Riu.service.ReservacionHabitacionService;
import jakarta.persistence.EntityManager;
import jakarta.persistence.ParameterMode;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;
import jakarta.persistence.StoredProcedureQuery;
import java.math.BigDecimal;
import java.util.List;
import org.springframework.stereotype.Service;

@Service
public class ReservacionHabitacionServiceImpl implements ReservacionHabitacionService {

    @PersistenceContext
    private EntityManager em;

    @Override
    public List<ReservacionHabitacion> getReservacionHabitaciones() {
        // Crear la consulta del procedimiento almacenado
        StoredProcedureQuery query = em.createStoredProcedureQuery("OBTENER_RESERVACIONES", ReservacionHabitacion.class);

        // Registrar el parámetro de salida (el cursor)
        query.registerStoredProcedureParameter(
                1, // posición del parámetro
                void.class, // tipo del parámetro
                ParameterMode.REF_CURSOR // modo del parámetro (cursor de salida)
        );

        // Ejecutar el procedimiento
        query.execute();

        // Obtener los resultados como una lista de objetos ReservacionHabitacion
        List<ReservacionHabitacion> resultado = query.getResultList();

        return resultado;
    }

    @Override
    public void agregarReservacionHabitacion(ReservacionHabitacion reservacionHabitacion) {
        // Crear la consulta del procedimiento almacenado
        StoredProcedureQuery query = em.createStoredProcedureQuery("CREAR_RESERVACION");

        // Registrar los parámetros de entrada
        query.registerStoredProcedureParameter(1, Long.class, ParameterMode.IN);       // P_ID_HABITACION
        query.registerStoredProcedureParameter(2, Long.class, ParameterMode.IN);       // P_ID_CLIENTE
        query.registerStoredProcedureParameter(3, Long.class, ParameterMode.IN);       // P_ID_HORARIO
        query.registerStoredProcedureParameter(4, String.class, ParameterMode.IN);     // P_METODO_PAGO
        query.registerStoredProcedureParameter(5, Double.class, ParameterMode.IN);     // P_DESCUENTO
        query.registerStoredProcedureParameter(6, Double.class, ParameterMode.IN);     // P_TOTAL_PAGAR
        query.registerStoredProcedureParameter(7, java.sql.Date.class, ParameterMode.IN); // P_FECHA_ENTRADA
        query.registerStoredProcedureParameter(8, java.sql.Date.class, ParameterMode.IN); // P_FECHA_SALIDA

        // Establecer los valores de los parámetros
        query.setParameter(1, reservacionHabitacion.getHabitacion().getIdHabitacion());
        query.setParameter(2, reservacionHabitacion.getCliente().getId_cliente());
        query.setParameter(3, 1);
        query.setParameter(4, reservacionHabitacion.getMetodoPago());
        query.setParameter(5, reservacionHabitacion.getDescuento());
        query.setParameter(6, reservacionHabitacion.getTotalPagar());
        query.setParameter(7, reservacionHabitacion.getFechaEntrada());
        query.setParameter(8, reservacionHabitacion.getFechaSalida());

        // Ejecutar el procedimiento
        query.execute();
    }

    @Override
    public int PrecioTotal(int precio, int descuento, java.sql.Date fecha1, java.sql.Date fecha2) {
        // Crear una consulta para llamar la función en la base de datos
        String sql = "SELECT CALCULAR_PRECIO_TOTAL_RESERVACION(:P_PRECIO_NOCHE, :P_FECHA_ENTRADA, :P_FECHA_SALIDA, :P_DESCUENTO) FROM DUAL";
        Query query = em.createNativeQuery(sql);
        query.setParameter("P_PRECIO_NOCHE", precio);
        query.setParameter("P_FECHA_ENTRADA", fecha1);
        query.setParameter("P_FECHA_SALIDA", fecha2);
        query.setParameter("P_DESCUENTO", descuento);

        // Ejecutar la consulta y obtener el resultado
        BigDecimal precioTotal = (BigDecimal) query.getSingleResult();
        return precioTotal.intValue();
    }

    @Override
    public ReservacionHabitacion ObtenerHabitacionID(Long id) {
        List<ReservacionHabitacion> resultado = getReservacionHabitaciones();
        for (int i = 0; i < resultado.size(); i++) {
            if (resultado.get(i).getIdReservacionHabitacion() == id) {
                return resultado.get(i);
            }
        }
        return null;
    }

    @Override
    public void eliminarReservacionHabitacion(Long idReservacionHabitacion) {
        // Crear una consulta de procedimiento almacenado
        StoredProcedureQuery query = em.createStoredProcedureQuery("ELIMINAR_RESERVACION_HABITACION");

        // Registrar el parámetro de entrada (ID de la reservación a eliminar)
        query.registerStoredProcedureParameter(1, Long.class, ParameterMode.IN);

        // Establecer el valor del parámetro de entrada
        query.setParameter(1, idReservacionHabitacion);

        // Ejecutar el procedimiento
        query.execute();
    }

    @Override
    public void actualizarReservacion(ReservacionHabitacion reservacionHabitacion) {
        // Crear la consulta para el procedimiento almacenado
        StoredProcedureQuery query = em.createStoredProcedureQuery("ACTUALIZAR_RESERVACION_HABITACION");

        // Registrar los parámetros del procedimiento
        query.registerStoredProcedureParameter(1, Long.class, ParameterMode.IN); // ID de la reservación
        query.registerStoredProcedureParameter(2, Long.class, ParameterMode.IN); // ID de la habitación
        query.registerStoredProcedureParameter(3, Long.class, ParameterMode.IN); // ID del cliente
        query.registerStoredProcedureParameter(4, Long.class, ParameterMode.IN); // ID del horario
        query.registerStoredProcedureParameter(5, String.class, ParameterMode.IN); // Método de pago
        query.registerStoredProcedureParameter(6, Integer.class, ParameterMode.IN); // Descuento
        query.registerStoredProcedureParameter(7, Integer.class, ParameterMode.IN); // Total a pagar
        query.registerStoredProcedureParameter(8, java.sql.Date.class, ParameterMode.IN); // Fecha de entrada
        query.registerStoredProcedureParameter(9, java.sql.Date.class, ParameterMode.IN); // Fecha de salida

        // Establecer los valores de los parámetros
        query.setParameter(1, reservacionHabitacion.getIdReservacionHabitacion());
        query.setParameter(2, reservacionHabitacion.getHabitacion().getIdHabitacion());
        query.setParameter(3, reservacionHabitacion.getCliente().getId_cliente());
        query.setParameter(4, 1);
        query.setParameter(5, reservacionHabitacion.getMetodoPago());
        query.setParameter(6, reservacionHabitacion.getDescuento());
        query.setParameter(7, reservacionHabitacion.getTotalPagar());
        query.setParameter(8, reservacionHabitacion.getFechaEntrada());
        query.setParameter(9, reservacionHabitacion.getFechaSalida());

        // Ejecutar el procedimiento almacenado
        query.execute();
    }

}
