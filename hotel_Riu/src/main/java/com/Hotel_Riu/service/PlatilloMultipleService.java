package com.Hotel_Riu.service;

import com.Hotel_Riu.domain.PlatilloMultiple;
import java.util.List;

/**
 *
 * @author Alonso Muñoz Aguilar
 */
public interface PlatilloMultipleService {

    List<PlatilloMultiple> getPlatillosMultiples();

    void agregarPlatilloMultiple(PlatilloMultiple platilloMultiple);

    void actualizarPlatilloMultiple(PlatilloMultiple platilloMultiple);

    PlatilloMultiple obtenerPlatilloMultiplePorId(Long id);

    void eliminarPlatilloMultiple(Long idPlatilloMultiple);
}
