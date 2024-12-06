package com.Hotel_Riu.service.impl;

import com.Hotel_Riu.domain.FacRestaurante;
import com.Hotel_Riu.service.FacRestauranteService;
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
 * Alonso Muñoz Aguilar
 */
@Service
public class FacRestauranteServiceImpl implements FacRestauranteService {

    private static final Logger logger = LoggerFactory.getLogger(FacRestauranteServiceImpl.class);

    @PersistenceContext
    private EntityManager em;

    @Override
    public List<FacRestaurante> getFacturas() {
        // Ejecuta el procedimiento almacenado para obtener todas las facturas
        StoredProcedureQuery query = em.createStoredProcedureQuery("OBTENER_FACTURAS_RESTAURANTE", FacRestaurante.class);
        query.registerStoredProcedureParameter(1, void.class, ParameterMode.REF_CURSOR);
        query.execute();

        return query.getResultList();
    }

    @Override
    public void agregarFactura(FacRestaurante factura) {
        // Ejecuta el procedimiento almacenado para agregar una factura
        StoredProcedureQuery query = em.createStoredProcedureQuery("AGREGAR_FACTURA_RESTAURANTE");

        query.registerStoredProcedureParameter(1, Long.class, ParameterMode.IN);   // ID_RESERVACION_RESTAURANTE
        query.registerStoredProcedureParameter(2, Double.class, ParameterMode.IN);  // DESCUENTO
        query.registerStoredProcedureParameter(3, Double.class, ParameterMode.IN);  // TOTAL_PAGO
        query.registerStoredProcedureParameter(4, String.class, ParameterMode.IN);  // METODO_PAGO

        query.setParameter(1, factura.getId_reservacion_restaurante());
        query.setParameter(2, factura.getDescuento());
        query.setParameter(3, factura.getTotal_pago());
        query.setParameter(4, factura.getMetodo_pago());

        query.execute();
    }

    @Override
    @Transactional
    public void actualizarFactura(FacRestaurante factura) {
        // Ejecuta el procedimiento almacenado para actualizar una factura
        logger.debug("Ejecutando procedimiento almacenado para actualizar factura con ID: {}", factura.getId_fact_restaurante());

        StoredProcedureQuery query = em.createStoredProcedureQuery("ACTUALIZAR_FACTURA_RESTAURANTE");

        query.registerStoredProcedureParameter(1, Long.class, ParameterMode.IN);  // ID_FACT_RESTAURANTE
        query.registerStoredProcedureParameter(2, Long.class, ParameterMode.IN);  // ID_RESERVACION_RESTAURANTE
        query.registerStoredProcedureParameter(3, Double.class, ParameterMode.IN);  // DESCUENTO
        query.registerStoredProcedureParameter(4, Double.class, ParameterMode.IN);  // TOTAL_PAGO
        query.registerStoredProcedureParameter(5, String.class, ParameterMode.IN);  // METODO_PAGO

        query.setParameter(1, factura.getId_fact_restaurante());
        query.setParameter(2, factura.getId_reservacion_restaurante());
        query.setParameter(3, factura.getDescuento());
        query.setParameter(4, factura.getTotal_pago());
        query.setParameter(5, factura.getMetodo_pago());

        query.execute();
    }

    @Override
    public void eliminarFactura(Long idFactura) {
        // Ejecuta el procedimiento almacenado para eliminar una factura
        StoredProcedureQuery query = em.createStoredProcedureQuery("ELIMINAR_FACTURA_RESTAURANTE");
        query.registerStoredProcedureParameter(1, Long.class, ParameterMode.IN);
        query.setParameter(1, idFactura);

        query.execute();
    }

    @Override
    public FacRestaurante obtenerFacturaPorID(Long id) {
        // Busca la factura por su ID utilizando el procedimiento almacenado
        List<FacRestaurante> facturas = getFacturas();
        for (FacRestaurante factura : facturas)
        {
            if (factura.getId_fact_restaurante().equals(id))
            {
                return factura;
            }
        }
        return null;
    }
}
