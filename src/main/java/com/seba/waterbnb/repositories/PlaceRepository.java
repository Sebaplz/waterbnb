package com.seba.waterbnb.repositories;

import com.seba.waterbnb.models.Place;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PlaceRepository extends JpaRepository<Place,Long> {

    List<Place> findByUserPlaceId(Long id);

    List<Place> findAllByAddress(String address);

    Page<Place> findAll(Pageable pageable);
}
