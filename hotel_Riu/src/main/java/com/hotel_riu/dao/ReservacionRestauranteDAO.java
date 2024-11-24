package com.hotel_riu.dao;

import com.hotel_riu.domain.ReservacionRestaurante;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ReservacionRestauranteDAO extends JpaRepository<ReservacionRestaurante, Long> {

}
