package com.hotel_riu.services;

import com.hotel_riu.domain.PlatilloMultiple;
import java.util.List;

public interface PlatilloMultipleService {

    /**
     * Obtiene una lista de todos los registros de platillos múltiples.
     *
     * @return una lista de objetos {@link PlatilloMultiple}.
     */
    List<PlatilloMultiple> getAllPlatillosMultiples();

    /**
     * Obtiene un registro específico por su identificador único.
     *
     * @param id el identificador único.
     * @return un objeto {@link PlatilloMultiple} si se encuentra; de lo contrario, {@code null}.
     */
    PlatilloMultiple getPlatilloMultipleById(Long id);

    /**
     * Guarda o actualiza un registro de platillo múltiple.
     *
     * @param platilloMultiple el objeto {@link PlatilloMultiple} a guardar o actualizar.
     * @return el objeto {@link PlatilloMultiple} guardado.
     */
    PlatilloMultiple savePlatilloMultiple(PlatilloMultiple platilloMultiple);

    /**
     * Elimina un registro de platillo múltiple por su identificador único.
     *
     * @param id el identificador único a eliminar.
     */
    void deletePlatilloMultiple(Long id);
}
