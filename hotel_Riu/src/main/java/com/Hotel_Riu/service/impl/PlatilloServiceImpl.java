package com.Hotel_Riu.service.impl;

import com.Hotel_Riu.domain.Cliente;
import com.Hotel_Riu.domain.Persona;
import com.Hotel_Riu.domain.Platillo;
import com.Hotel_Riu.service.ClienteService;
import com.Hotel_Riu.service.PersonaService;
import com.Hotel_Riu.service.PlatilloService;
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
public class PlatilloServiceImpl implements PlatilloService {

    @PersistenceContext
    private EntityManager em;

    @Override
    public List<Platillo> getPlatillos() {
        // Crear el query para ejecutar el procedimiento almacenado
        StoredProcedureQuery query = em.createStoredProcedureQuery("OBTENER_PLATILLOS", Platillo.class);

        // Registrar el parámetro de salida como un REF_CURSOR
        query.registerStoredProcedureParameter(
                1,
                void.class,
                ParameterMode.REF_CURSOR
        );

        // Ejecutar el procedimiento
        query.execute();

        // Obtener el resultado del cursor y mapearlo a una lista de Platillo
        List<Platillo> resultado = query.getResultList();

        return resultado;
    }
    
    @Override
    public void agregarPlatillo(Platillo platillo) {
        StoredProcedureQuery query = em.createStoredProcedureQuery("CREAR_PLATILLO");

        // Registrar los parámetros de entrada
        query.registerStoredProcedureParameter(1, String.class, ParameterMode.IN);  // P_NOMBRE
        query.registerStoredProcedureParameter(2, Double.class, ParameterMode.IN);  // P_PRECIO
        query.registerStoredProcedureParameter(3, Integer.class, ParameterMode.IN);  // P_CANTIDAD
        query.registerStoredProcedureParameter(4, Long.class, ParameterMode.IN);  // P_ID_RESTAURANTE

        // Establecer los valores de los parámetros
        query.setParameter(1, platillo.getNombre());
        query.setParameter(2, platillo.getPrecio());
        query.setParameter(3, platillo.getCantidad());
        query.setParameter(4, platillo.getRestaurante().getIdRestaurante());

        // Ejecutar el procedimiento
        query.execute();
    }


}
