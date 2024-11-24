package com.hotel_riu.dao;

import com.hotel_riu.domain.FacRestaurante;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface FacRestauranteDAO extends JpaRepository<FacRestaurante, Long> {
    
}
