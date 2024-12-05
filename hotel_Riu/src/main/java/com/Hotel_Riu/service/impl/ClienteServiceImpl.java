package com.Hotel_Riu.service.impl;

import com.Hotel_Riu.domain.Cliente;
import com.Hotel_Riu.domain.Persona;
import com.Hotel_Riu.service.ClienteService;
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
 * @autor dvela
 */
@Service
public class ClienteServiceImpl implements ClienteService {
    
    private static final Logger logger = LoggerFactory.getLogger(ClienteServiceImpl.class);

    @PersistenceContext
    private EntityManager em;

    @Autowired
    private PersonaService personaService;

    @Override
    public List<Cliente> getClientes() {
        StoredProcedureQuery query = em.createStoredProcedureQuery("OBTENER_CLIENTE", Cliente.class);

        query.registerStoredProcedureParameter(
                1, 
                void.class, 
                ParameterMode.REF_CURSOR 
        );

        query.execute();

        List<Cliente> resultado = query.getResultList();

        return resultado;
    }

    @Override
    public void agregarCliente(Cliente cliente) {
        StoredProcedureQuery query = em.createStoredProcedureQuery("AGREGAR_CLIENTE");

        query.registerStoredProcedureParameter(1, Long.class, ParameterMode.IN);   // ID_PERSONA
        query.setParameter(1, cliente.getPersona().getId_persona());  // Establecer el parámetro de entrada

        query.execute();
    }

    @Override
    @Transactional
    public void actualizarCliente(Cliente cliente) { 
        Persona persona = cliente.getPersona(); 
        logger.debug("Actualizando persona con ID: {}", persona.getId_persona());
        personaService.actualizarPersona(persona);

    }

    @Override
    public void eliminarCliente(Long id_cliente) {
        StoredProcedureQuery query = em.createStoredProcedureQuery("ELIMINAR_CLIENTE");
        query.registerStoredProcedureParameter(1, Long.class, ParameterMode.IN);
        query.setParameter(1, id_cliente);

        query.execute();
    }

    @Override
    public Cliente obtenerClientePorID(Long id) {
        List<Cliente> clientes = getClientes();
        for (Cliente cliente : clientes) {
            if (cliente.getId_cliente().equals(id)) {
                return cliente;
            }
        }
        return null;
    }
}
