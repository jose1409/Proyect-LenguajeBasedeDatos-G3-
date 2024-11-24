package com.hotel_riu.dao;

import com.hotel_riu.domain.PlatilloMultiple;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PlatilloMultipleDAO extends JpaRepository<PlatilloMultiple, Long> {
    
}
