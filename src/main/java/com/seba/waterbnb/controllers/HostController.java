package com.seba.waterbnb.controllers;

import com.seba.waterbnb.models.Place;
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
public class HostController {

    @Autowired
    private UserService userService;
    @Autowired
    private PlaceService placeService;
    @Autowired
    private ReviewService reviewService;

    private boolean isNotAuthenticated(HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        return userId == null;
    }

    @GetMapping("/host/dashboard")
    public String dashboard(@ModelAttribute("place") Place place, BindingResult result, HttpSession session, Model model) {
        if (isNotAuthenticated(session)) {
            return "redirect:/";
        }
        if (session.getAttribute("userRol").equals("host")) {
            User user = userService.findUserById((Long) session.getAttribute("userId"));
            model.addAttribute("user", user);
            model.addAttribute("allPlaces", placeService.allPlacesById(user.getId()));
            return "/host/dashboard.jsp";
        }
        return "redirect:/";
    }

    @PostMapping("/host/dashboard")
    public String createPlace(@Valid @ModelAttribute("place") Place place, BindingResult result, Model model, HttpSession session) {
        if (result.hasErrors()) {
            User user = userService.findUserById((Long) session.getAttribute("userId"));
            model.addAttribute("user", user);
            model.addAttribute("allPlaces", placeService.allPlacesById(user.getId()));
            return "/host/dashboard.jsp";
        }
        placeService.createPlace(place);
        return "redirect:/host/dashboard";
    }

    @GetMapping("/host/pools/{id}")
    public String editPlace(@PathVariable("id") Long id, @ModelAttribute("place") Place place, BindingResult result, HttpSession session, Model model) {
        if (isNotAuthenticated(session)) {
            return "redirect:/";
        }
        if (session.getAttribute("userRol").equals("host")) {
            Place place1 = placeService.findById(id);
            User user = userService.findUserById((Long) session.getAttribute("userId"));
            if (place1 == null){
                return "redirect:/host/dashboard";
            }
            if (place1.getUserPlace().getId().equals(user.getId())){
                model.addAttribute("user", user);
                model.addAttribute("places", placeService.findById(id));
                return "/host/edit.jsp";
            }
            return "redirect:/host/dashboard";
        }
        return "redirect:/";
    }

    @PutMapping("/host/pools/{id}")
    public String putPlace(@Valid @ModelAttribute("place") Place place, BindingResult result, @PathVariable("id") Long id, HttpSession session, Model model) {
        if (isNotAuthenticated(session)) {
            return "redirect:/";
        }
        if (session.getAttribute("userRol").equals("host")) {
            if (result.hasErrors()) {
                User user = userService.findUserById((Long) session.getAttribute("userId"));
                model.addAttribute("user", user);
                model.addAttribute("places", placeService.findById(id));
            }
            User user = userService.findUserById((Long) session.getAttribute("userId"));
            model.addAttribute("allPlaces", placeService.allPlacesById(user.getId()));
            place.setRating(reviewService.obtenerPromedio(id));
            placeService.createPlace(place);
            return "/host/dashboard.jsp";
        }
        return "redirect:/";
    }
}
