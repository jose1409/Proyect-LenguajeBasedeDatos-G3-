package com.Hotel_Riu.service;

import com.Hotel_Riu.domain.FacRestaurante;
import java.util.List;

/**
 * Alonso Muñoz Aguilar
 */
public interface FacRestauranteService {

    List<FacRestaurante> getFacturas();

    void agregarFactura(FacRestaurante factura);

    void actualizarFactura(FacRestaurante factura);

    FacRestaurante obtenerFacturaPorID(Long id);

    void eliminarFactura(Long idFactura);
}

