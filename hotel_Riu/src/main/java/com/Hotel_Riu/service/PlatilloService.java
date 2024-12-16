package com.Hotel_Riu.service;

import com.Hotel_Riu.domain.Platillo;
import java.util.List;

/**
 *
 * @author dvela
 */
public interface PlatilloService {
    
    public List<Platillo>getPlatillos();
    
    public void agregarPlatillo(Platillo platillo);

}
