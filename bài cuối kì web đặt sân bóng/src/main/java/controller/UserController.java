package controller;

import model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import jakarta.servlet.http.HttpSession;

import dao.UserDao;
import service.UserService;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private UserDao userDao; // Tiêm UserDao

    @GetMapping("/")
    public String root() {
        return "redirect:/login";
    }

    @GetMapping("/login")
    public String showLoginForm(Model model) {
        model.addAttribute("user", new User());
        model.addAttribute("pageTitle", "Login");
        return "login";
    }

    @PostMapping("/login")
    public String login(@ModelAttribute("user") User user, HttpSession session, Model model) {
        if (userService.login(user.getUsername(), user.getPassword())) {
            session.setAttribute("username", user.getUsername());
            User loggedInUser = userDao.findByUsername(user.getUsername()); // Gọi từ UserDao
            if (loggedInUser == null) {
                model.addAttribute("error", "User not found in database");
                model.addAttribute("pageTitle", "Login");
                return "login";
            }
            session.setAttribute("role", loggedInUser.getRole().toString());
            if (loggedInUser.getRole() == User.Role.ADMIN) {
                return "redirect:/admin";
            }
            return "redirect:/home";
        } else {
            model.addAttribute("error", "Invalid username or password");
            model.addAttribute("pageTitle", "Login");
            return "login";
        }
    }

    @GetMapping("/register")
    public String showRegisterForm(Model model) {
        model.addAttribute("user", new User());
        model.addAttribute("pageTitle", "Register");
        return "register";
    }

    @PostMapping("/register")
    public String register(@ModelAttribute("user") User user, Model model) {
        if (userService.register(user)) {
            return "redirect:/login";
        } else {
            model.addAttribute("error", "Username or email already exists");
            model.addAttribute("pageTitle", "Register");
            return "register";
        }
    }

    @GetMapping("/home")
    public String home(HttpSession session, Model model) {
        String username = (String) session.getAttribute("username");
        if (username == null) {
            return "redirect:/login";
        }
        model.addAttribute("username", username);
        model.addAttribute("pageTitle", "Home");
        model.addAttribute("contentPage", "home");
        return "layouts/user_layout";
    }

    @GetMapping("/admin")
    public String admin(HttpSession session, Model model) {
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");
        if (username == null || role == null || !role.equals(User.Role.ADMIN.toString())) {
            return "redirect:/login";
        }
        model.addAttribute("username", username);
        model.addAttribute("pageTitle", "Admin Dashboard");
        model.addAttribute("contentPage", "admin");
        return "layouts/admin_layout";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}