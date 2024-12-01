package com.Hotel_Riu.service;

import com.Hotel_Riu.domain.Horario;

public interface HorarioService {
    
    // Se filtra y obtiene el horario de entrada y salida de una reservacion
    public Horario obtenerHorarioID(Long id);

}
