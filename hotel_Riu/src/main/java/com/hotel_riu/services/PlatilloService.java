package com.hotel_riu.services;

import com.hotel_riu.domain.Platillo;
import java.util.List;

public interface PlatilloService {

    /**
     * Obtiene una lista de todos los platillos almacenados en la base de datos.
     *
     * @return una lista de objetos {@link Platillo}.
     */
    List<Platillo> getAllPlatillos();

    /**
     * Obtiene un platillo específico basado en su identificador único.
     *
     * @param idPlatillo el identificador único del platillo.
     * @return un objeto {@link Platillo} si se encuentra; de lo contrario, {@code null}.
     */
    Platillo getPlatilloById(Long idPlatillo);

    /**
     * Guarda un nuevo platillo o actualiza uno existente en la base de datos.
     *
     * @param platillo el objeto {@link Platillo} a guardar o actualizar.
     * @return el objeto {@link Platillo} guardado con los cambios aplicados.
     */
    Platillo savePlatillo(Platillo platillo);

    /**
     * Elimina un platillo de la base de datos basado en su identificador único.
     *
     * @param idPlatillo el identificador único del platillo a eliminar.
     */
    void deletePlatillo(Long idPlatillo);
}
