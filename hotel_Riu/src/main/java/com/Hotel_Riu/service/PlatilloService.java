package com.Hotel_Riu.service;

import com.Hotel_Riu.domain.Platillo;
import java.util.List;

/**
 *
 *
 * @author Alonso
 */
public interface PlatilloService {

    List<Platillo> getPlatillos();

    void agregarPlatillo(Platillo platillo);

    void actualizarPlatillo(Platillo platillo);

    Platillo obtenerPlatilloPorId(Long idPlatillo);

    void eliminarPlatillo(Long idPlatillo);
}
