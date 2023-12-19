package com.seba.waterbnb.controllers;

import com.seba.waterbnb.models.Place;
import com.seba.waterbnb.models.Rol;
import com.seba.waterbnb.models.User;
import com.seba.waterbnb.services.PlaceService;
import com.seba.waterbnb.services.UserService;
import com.seba.waterbnb.util.validator.UserValidator;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MainController {
    @Autowired
    private UserService userService;
    @Autowired
    private UserValidator userValidator;
    @Autowired
    private PlaceService placeService;

    @GetMapping("/")
    public String index(@RequestParam(defaultValue = "0") int page,
                        @RequestParam(defaultValue = "4") int size,
                        Model model, HttpSession session) {
        Page<Place> placePage = placeService.findAllPaginated(PageRequest.of(page, size));
        model.addAttribute("userLogeado", session.getAttribute("userId"));
        model.addAttribute("userHost", session.getAttribute("userRol"));
        model.addAttribute("placePage", placePage);
        return "index.jsp";
    }

    @GetMapping("/guest/signin")
    public String registerAndLogin(Model model){
        model.addAttribute("register", new User());
        model.addAttribute("login", new User());
        model.addAttribute("roles", Rol.roles);
        return "login.jsp";
    }

    @PostMapping("/login")
    public String loginUser(@Valid @ModelAttribute("login") User loginuser, BindingResult result, Model model, HttpSession session) {
        boolean isAuthenticated = userService.authenticateUser(loginuser.getEmail(), loginuser.getPassword());
        if (isAuthenticated) {
            User user = userService.findByEmail(loginuser.getEmail());
            session.setAttribute("userId", user.getId());
            session.setAttribute("userRol", user.getRol());
            model.addAttribute("roles", Rol.roles);
            if (user.getRol().equals("host")){
                return "redirect:/host/dashboard";
            }else {
                return "redirect:/";
            }

        } else {
            model.addAttribute("error", "Credenciales Invalidas!");
            model.addAttribute("register", new User());
            model.addAttribute("roles", Rol.roles);
            return "login.jsp";
        }
    }

    @PostMapping("/registration")
    public String register(@Valid @ModelAttribute("register") User user, BindingResult result, Model model, HttpSession session) {
        userValidator.validate(user, result);
        if (result.hasErrors()) {
            model.addAttribute("login", new User());
            model.addAttribute("roles", Rol.roles);
            return "login.jsp";
        }

        try {
            User user1 = userService.registerUser(user);
            session.setAttribute("userId", user1.getId());
            session.setAttribute("userRol", user1.getRol());
            model.addAttribute("roles", Rol.roles);
            if (user1.getRol().equals("host")){
                return "redirect:/host/dashboard";
            }else {
                return "redirect:/";
            }
        } catch (DataIntegrityViolationException e) {
            result.rejectValue("email", "error.email", "El email ingresado ya está en uso. Por favor, ingrese otro email.");
            model.addAttribute("login", new User());
            model.addAttribute("roles", Rol.roles);
            return "login.jsp";
        }

    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }


}
