package com.Hotel_Riu.service;

import com.Hotel_Riu.domain.Hotel;
import java.util.List;

public interface HotelService {

    public List<Hotel> getHoteles();
    
    public void spInsertHotel(Hotel hotel);
    
    public void spUpdateHotel(Hotel hotel);
    
    public Hotel ObtenerHotelID(Long id_hotel);
    
    public void spDeleteHotel(Long id_hotel);
    
}
