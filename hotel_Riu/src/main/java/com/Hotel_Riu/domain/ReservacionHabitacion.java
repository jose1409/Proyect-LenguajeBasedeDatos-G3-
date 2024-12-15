package com.Hotel_Riu.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.sql.Date;


@Entity
@Table(name = "RESERVACION_HABITACION_TB")
public class ReservacionHabitacion implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_RESERVACION_HABITACION")
    private Long idReservacionHabitacion;

    @Column(name = "METODO_PAGO")
    private String metodoPago;

    @Column(name = "DESCUENTO")
    private int descuento;

    @Column(name = "TOTAL_PAGAR")
    private int totalPagar;

    @Column(name = "FECHA_ENTREDA")
    private java.sql.Date fechaEntrada;

    @Column(name = "FECHA_SALIDA")
    private java.sql.Date fechaSalida;

    // Relación con la tabla Habitacion
    @ManyToOne
    @JoinColumn(name = "ID_HABITACION")
    private Habitacion habitacion;

    // Relación con la tabla Cliente
    @ManyToOne
    @JoinColumn(name = "ID_CLIENTE")
    private Cliente cliente;

    // Relación con la tabla Horario
    @ManyToOne
    @JoinColumn(name = "ID_HORARIO")
    private Horario horario;

    public ReservacionHabitacion() {
    }

    public ReservacionHabitacion(Long idReservacionHabitacion, String metodoPago, int descuento, int totalPagar, Date fechaEntrada, Date fechaSalida, Habitacion habitacion, Cliente cliente, Horario horario) {
        this.idReservacionHabitacion = idReservacionHabitacion;
        this.metodoPago = metodoPago;
        this.descuento = descuento;
        this.totalPagar = totalPagar;
        this.fechaEntrada = fechaEntrada;
        this.fechaSalida = fechaSalida;
        this.habitacion = habitacion;
        this.cliente = cliente;
        this.horario = horario;
    }

    public Long getIdReservacionHabitacion() {
        return idReservacionHabitacion;
    }

    public void setIdReservacionHabitacion(Long idReservacionHabitacion) {
        this.idReservacionHabitacion = idReservacionHabitacion;
    }

    public String getMetodoPago() {
        return metodoPago;
    }

    public void setMetodoPago(String metodoPago) {
        this.metodoPago = metodoPago;
    }

    public int getDescuento() {
        return descuento;
    }

    public void setDescuento(int descuento) {
        this.descuento = descuento;
    }

    public int getTotalPagar() {
        return totalPagar;
    }

    public void setTotalPagar(int totalPagar) {
        this.totalPagar = totalPagar;
    }

    public Date getFechaEntrada() {
        return fechaEntrada;
    }

    public void setFechaEntrada(Date fechaEntrada) {
        this.fechaEntrada = fechaEntrada;
    }

    public Date getFechaSalida() {
        return fechaSalida;
    }

    public void setFechaSalida(Date fechaSalida) {
        this.fechaSalida = fechaSalida;
    }

    public Habitacion getHabitacion() {
        return habitacion;
    }

    public void setHabitacion(Habitacion habitacion) {
        this.habitacion = habitacion;
    }

    public Cliente getCliente() {
        return cliente;
    }

    public void setCliente(Cliente cliente) {
        this.cliente = cliente;
    }

    public Horario getHorario() {
        return horario;
    }

    public void setHorario(Horario horario) {
        this.horario = horario;
    }
    
    
    
    
}

