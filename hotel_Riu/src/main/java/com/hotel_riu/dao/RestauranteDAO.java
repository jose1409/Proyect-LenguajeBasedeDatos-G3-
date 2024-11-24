package com.hotel_riu.dao;

import com.hotel_riu.domain.Restaurante;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface RestauranteDAO extends JpaRepository<Restaurante, Long> {
    
}
