package com.Hotel_Riu.service;

import com.Hotel_Riu.domain.Direccion;
import java.util.List;

public interface DireccionService {
    

//    public void spInsertDireccion(Direccion direccion);
//    
//    public void spUpdateDireccion(Direccion direccion);
    
    public Direccion obtenerDireccionID(Long id);
    
    public List<Direccion> getDirecciones();
//    public void spDeleteDireccion(Long id);
}
