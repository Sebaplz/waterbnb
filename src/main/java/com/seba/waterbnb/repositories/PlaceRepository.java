package com.seba.waterbnb.repositories;

import com.seba.waterbnb.models.Place;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PlaceRepository extends CrudRepository<Place,Long> {

    List<Place> findByUserPlaceId(Long id);

    List<Place> findAllByAddress(String address);
}
