package com.seba.waterbnb.services;

import com.seba.waterbnb.models.Place;
import com.seba.waterbnb.repositories.PlaceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PlaceService {
    @Autowired
    private PlaceRepository placeRepository;

    public Place createPlace(Place place){
        return placeRepository.save(place);
    }
    public List<Place> allPlacesById(Long id){
        return placeRepository.findByUserPlaceId(id);
    }

    public List<Place> allPlacesByAddress(String address){
        return placeRepository.findAllByAddress(address);
    }

    public Place findById(Long id){
        return placeRepository.findById(id).orElse(null);
    }

    public Page<Place> findAllPaginated(Pageable pageable) {
        return placeRepository.findAll(pageable);
    }

    public void deletePlace(Long id) {
        placeRepository.deleteById(id);
    }
}
