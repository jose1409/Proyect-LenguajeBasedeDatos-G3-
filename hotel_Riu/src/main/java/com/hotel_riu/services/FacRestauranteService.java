package com.hotel_riu.services;

import com.hotel_riu.domain.FacRestaurante;
import java.util.List;

public interface FacRestauranteService {

    /**
     * Obtiene una lista de todas las facturas de restaurante almacenadas.
     *
     * @return una lista de objetos {@link FacRestaurante}.
     */
    List<FacRestaurante> getAllFacturas();

    /**
     * Obtiene una factura de restaurante específica por su identificador único.
     *
     * @param id el identificador único de la factura.
     * @return un objeto {@link FacRestaurante} si se encuentra; de lo contrario, {@code null}.
     */
    FacRestaurante getFacturaById(Long id);

    /**
     * Guarda una nueva factura o actualiza una existente.
     *
     * @param factura el objeto {@link FacRestaurante} a guardar o actualizar.
     * @return el objeto {@link FacRestaurante} guardado.
     */
    FacRestaurante saveFactura(FacRestaurante factura);

    /**
     * Elimina una factura de restaurante por su identificador único.
     *
     * @param id el identificador único de la factura a eliminar.
     */
    void deleteFactura(Long id);
}
