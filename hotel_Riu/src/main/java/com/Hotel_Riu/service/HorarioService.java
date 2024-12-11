package com.Hotel_Riu.service;

import com.Hotel_Riu.domain.Horario;
import java.util.List;

public interface HorarioService {
    
    public List<Horario> getHorarios();

    public void spInsertHorario(Horario horario);
    
    public void spUpdateHorario(Horario horario);
    
    public Horario obtenerHorarioPorID(Long id);
    
    public void spDeleteHorario(Long id);
}
