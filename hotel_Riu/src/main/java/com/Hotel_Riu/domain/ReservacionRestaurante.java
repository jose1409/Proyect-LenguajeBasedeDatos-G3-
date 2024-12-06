package com.Hotel_Riu.domain;

import jakarta.persistence.*;
import java.io.Serializable;
import java.sql.Date;
import lombok.Data;

/**
 *
 * @author Alonso Muñoz Aguilar
 */
@Data
@Entity
@Table(name = "RESERVACION_RESTAURANTE_TB")
public class ReservacionRestaurante implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "reservacion_restaurante_seq")
    @SequenceGenerator(name = "reservacion_restaurante_seq", sequenceName = "ID_RESERVACION_RESTAURANTE_SEQ", allocationSize = 1)
    @Column(name = "ID_RESERVACION_RESTAURANTE")
    private Long idReservacionRestaurante;

    @Column(name = "ID_CLIENTE", nullable = false)
    private Long idCliente;

    @Column(name = "HORA_ENTRADA", nullable = false)
    private String horaEntrada;

    @Column(name = "FECHA_RESRVACION", nullable = false)
    private Date fechaReservacion;

    @ManyToOne
    @JoinColumn(name = "ID_CLIENTE", referencedColumnName = "ID_CLIENTE", insertable = false, updatable = false)
    private Cliente cliente;

    public ReservacionRestaurante() {
    }

    public ReservacionRestaurante(Long idReservacionRestaurante, Long idCliente, String horaEntrada, Date fechaReservacion, Cliente cliente) {
        this.idReservacionRestaurante = idReservacionRestaurante;
        this.idCliente = idCliente;
        this.horaEntrada = horaEntrada;
        this.fechaReservacion = fechaReservacion;
        this.cliente = cliente;
    }

    // Getters y Setters
    public Long getIdReservacionRestaurante() {
        return idReservacionRestaurante;
    }

    public void setIdReservacionRestaurante(Long idReservacionRestaurante) {
        this.idReservacionRestaurante = idReservacionRestaurante;
    }

    public Long getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(Long idCliente) {
        this.idCliente = idCliente;
    }

    public String getHoraEntrada() {
        return horaEntrada;
    }

    public void setHoraEntrada(String horaEntrada) {
        this.horaEntrada = horaEntrada;
    }

    public Date getFechaReservacion() {
        return fechaReservacion;
    }

    public void setFechaReservacion(Date fechaReservacion) {
        this.fechaReservacion = fechaReservacion;
    }

    public Cliente getCliente() {
        return cliente;
    }

    public void setCliente(Cliente cliente) {
        this.cliente = cliente;
    }
}
