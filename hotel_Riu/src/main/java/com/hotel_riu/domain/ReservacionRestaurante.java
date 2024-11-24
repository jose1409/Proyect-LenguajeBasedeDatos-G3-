package com.hotel_riu.domain;

import jakarta.persistence.*;
import java.io.Serializable;
import java.sql.Date;
;
import lombok.Data;



@Data
@Entity
@Table(name = "RESERVACION_RESTAURANTE_TB")
public class ReservacionRestaurante implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "ID_RESERVACION_RESTAURANTE")
    private Long idReservacionRestaurante;

    @Column(name = "ID_CLIENTE", nullable = false)
    private Long idCliente;

    @Column(name = "HORA_ENTRADA", nullable = false)
    private String horaEntrada;

    @Column(name = "FECHA_RESRVACION", nullable = false)
    @Temporal(TemporalType.DATE)
    private Date fechaReservacion;
}
