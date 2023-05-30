package com.seba.waterbnb.repositories;

import com.seba.waterbnb.models.Review;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface ReviewRepository extends CrudRepository<Review,Long> {
    @Query(value = "SELECT AVG(rating) FROM reviews where place_id = :id", nativeQuery = true)
    Optional<Double> obtenerPromedioRatings(Long id);
}
