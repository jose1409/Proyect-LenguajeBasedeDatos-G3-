package com.Hotel_Riu.service.impl;

import com.Hotel_Riu.domain.Horario;
import com.Hotel_Riu.service.HorarioService;
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

@Service
public class HorarioServiceImpl implements HorarioService {
    
    private static final Logger logger = LoggerFactory.getLogger(HorarioServiceImpl.class);

    @PersistenceContext
    private EntityManager em;

    @Override
    public List<Horario> getHorarios() {
        StoredProcedureQuery query = em.createStoredProcedureQuery("OBTENER_HORARIO", Horario.class);
        query.registerStoredProcedureParameter(
                1,
                void.class,
                ParameterMode.REF_CURSOR
        );
        query.execute();
        List<Horario> resultado = query.getResultList();
        return resultado;
    }

    @Override
    public void spInsertHorario(Horario horario) {
        StoredProcedureQuery query = em.createStoredProcedureQuery("SP_INSERT_HORARIO");

        query.registerStoredProcedureParameter(1, String.class, ParameterMode.IN); //FECHA_HORARIO
        query.registerStoredProcedureParameter(2, String.class, ParameterMode.IN); //HORA_APERTURA
        query.registerStoredProcedureParameter(3, String.class, ParameterMode.IN); //HORA_CIERRE

        query.setParameter(1, horario.getFecha_horario());
        query.setParameter(2, horario.getHora_apertura());
        query.setParameter(3, horario.getHora_cierre());

        query.execute();

        Long idHorarioGenerado = ((BigDecimal) em.createNativeQuery("SELECT ID_HORARIO_SEQ.CURRVAL FROM DUAL").getSingleResult()).longValue();
        horario.setId_horario(idHorarioGenerado);
    }

    @Override
    @Transactional
    public void spUpdateHorario(Horario horario) {

        StoredProcedureQuery query = em.createStoredProcedureQuery("SP_UPDATE_HORARIO");

        query.registerStoredProcedureParameter(1, Long.class, ParameterMode.IN);    // ID_HORARIO
        query.registerStoredProcedureParameter(2, String.class, ParameterMode.IN);  // FECHA_HORARIO
        query.registerStoredProcedureParameter(3, String.class, ParameterMode.IN);  // HORA_APERTURA
        query.registerStoredProcedureParameter(4, String.class, ParameterMode.IN);  // HORA_CIERRE

        query.setParameter(1, horario.getId_horario());
        query.setParameter(2, new java.sql.Date(horario.getFecha_horario().getTime()));
        query.setParameter(3, horario.getHora_apertura());
        query.setParameter(4, horario.getHora_cierre());

        query.execute();
    }

    @Override
    public void spDeleteHorario(Long idHorario) {
        StoredProcedureQuery query = em.createStoredProcedureQuery("SP_DELETE_HORARIO");
        query.registerStoredProcedureParameter(1, Long.class, ParameterMode.IN);
        query.setParameter(1, idHorario);

        query.execute();
    }

    @Override
    public Horario obtenerHorarioPorID(Long id) {
        List<Horario> horarios = getHorarios();
        for (Horario horario : horarios) {
            if (horario.getId_horario().equals(id)) {
                return horario;
            }
        }
        return null;
    }
}
