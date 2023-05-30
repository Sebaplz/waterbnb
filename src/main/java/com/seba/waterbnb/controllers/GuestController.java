package com.seba.waterbnb.controllers;

import com.seba.waterbnb.models.Place;
import com.seba.waterbnb.models.Review;
import com.seba.waterbnb.models.User;
import com.seba.waterbnb.services.PlaceService;
import com.seba.waterbnb.services.ReviewService;
import com.seba.waterbnb.services.UserService;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;


@Controller
public class GuestController {

    @Autowired
    private PlaceService placeService;
    @Autowired
    private UserService userService;
    @Autowired
    private ReviewService reviewService;

    private boolean isNotAuthenticated(HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        return userId == null;
    }

    @GetMapping("/search")
    public String search(@RequestParam(value = "q") String searchQuery, Model model, HttpSession session) {
        model.addAttribute("q", searchQuery);
        model.addAttribute("placeList", placeService.allPlacesByAddress(searchQuery));
        model.addAttribute("userLogeado", session.getAttribute("userId"));
        return "/guest/search.jsp";
    }

    @GetMapping("/pools/{id}")
    public String showPlace(@PathVariable("id") Long id, HttpSession session, Model model) {
        model.addAttribute("userLogeado", session.getAttribute("userId"));
        model.addAttribute("userHost", session.getAttribute("userRol"));
        model.addAttribute("place", placeService.findById(id));
        return "/guest/show.jsp";
    }

    @GetMapping("/pools/{id}/review")
    public String newReview(@PathVariable("id") Long id, @ModelAttribute("review") Review review, BindingResult result, Model model, HttpSession session) {
        if (isNotAuthenticated(session)){
            return "redirect:/";
        }
        if (session.getAttribute("userRol").equals("host")){
            return "redirect:/";
        }
        model.addAttribute("place", placeService.findById(id));
        User user = userService.findUserById((Long) session.getAttribute("userId"));
        model.addAttribute("user", user);
        return "/guest/review.jsp";
    }

    @PostMapping("/pools/{id}/review")
    public String createReview(@Valid @ModelAttribute("review")Review review, BindingResult result, @PathVariable("id") Long id, Model model, HttpSession session){
        if (result.hasErrors()){
            model.addAttribute("place", placeService.findById(id));
            User user = userService.findUserById((Long) session.getAttribute("userId"));
            model.addAttribute("user", user);
            return "/guest/review.jsp";
        }
        Place place = placeService.findById(id);
        User user = userService.findUserById((Long) session.getAttribute("userId"));
        model.addAttribute("user", user);
        reviewService.review(review.getComment(),user,place, review.getRating());
        place.setRating(reviewService.obtenerPromedio(id));
        placeService.createPlace(place);
        return "redirect:/pools/" + id;
    }
}
