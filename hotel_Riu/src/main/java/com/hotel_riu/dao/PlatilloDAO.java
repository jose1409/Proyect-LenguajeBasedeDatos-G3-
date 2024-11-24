package com.hotel_riu.dao;

import com.hotel_riu.domain.Platillo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PlatilloDAO extends JpaRepository<Platillo, Long> {

}
