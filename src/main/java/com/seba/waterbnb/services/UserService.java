package com.seba.waterbnb.services;

import com.seba.waterbnb.models.User;
import com.seba.waterbnb.repositories.UserRepository;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class UserService {
    @Autowired
    private UserRepository userRepository;

    // registrar el usuario y hacer Hash a su password
    public User registerUser(User user) {
        String hashed = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
        user.setPassword(hashed);
        return userRepository.save(user);
    }

    // encontrar un usuario por su email
    public User findByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    // encontrar un usuario por su id
    public User findUserById(Long id) {
        Optional<User> u = userRepository.findById(id);
        return u.orElse(null);
    }

    // autenticar usuario
    public boolean authenticateUser(String email, String password) {
        User user = userRepository.findByEmail(email);
        if (user == null) {
            return false;
        } else {
            return BCrypt.checkpw(password, user.getPassword());
        }
    }
}
