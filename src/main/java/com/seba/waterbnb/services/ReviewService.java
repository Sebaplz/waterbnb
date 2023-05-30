package com.seba.waterbnb.services;

import com.seba.waterbnb.models.Place;
import com.seba.waterbnb.models.Review;
import com.seba.waterbnb.models.User;
import com.seba.waterbnb.repositories.ReviewRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class ReviewService {
    @Autowired
    private ReviewRepository reviewRepository;

    public void review(String review, User author, Place place, double rating){
        Review review1 = new Review(review, author, place, rating);
        reviewRepository.save(review1);
    }

    public Double obtenerPromedio(Long id){
         Optional<Double> promedio = reviewRepository.obtenerPromedioRatings(id);
        return promedio.orElse(0.0);
    }

}
