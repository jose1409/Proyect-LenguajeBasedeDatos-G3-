package com.Hotel_Riu.service;

import com.Hotel_Riu.domain.Direccion;
import java.util.List;

public interface DireccionService {
    
    public List<Direccion> getDirecciones();

    public void spInsertDireccion(Direccion direccion);
    
    public void spUpdateDireccion(Direccion direccion);
    
    public Direccion obtenerDireccionPorID(Long id);
    
    public void spDeleteDireccion(Long id);
}
