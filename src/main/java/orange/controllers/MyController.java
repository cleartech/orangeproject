package orange.controllers;

import orange.entities.Album;
import orange.entities.AlbumCategory;
import orange.entities.OrangeItem;
import orange.entities.OrangeMessage;
import orange.services.*;
import orange.user.CustomUser;
import orange.user.UserRole;
import orange.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Calendar;
import java.util.List;
import java.util.UUID;

@Controller
public class MyController {
    @Autowired
    private UserService userService;
    @Autowired
    private MessageService messageService;
    @Autowired
    private CategoryService categoryService;
    @Autowired
    private CommentService commentService;

    /**
     * User index page. Home page for registered and anonymous users
     *
     * @param model holds data for registered users (inbox, comments, favorites etc.)
     * @return index view
     */
    @RequestMapping("/")
    public String index(Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        for (GrantedAuthority authority : auth.getAuthorities()) {
            if (authority.getAuthority().equals("ROLE_USER") || authority.getAuthority().equals("ROLE_ADMIN")) {
                User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
                String login = user.getUsername();

                CustomUser dbUser = userService.getUserByLogin(login);

                int commentsTotal = commentService.getUserCommentsQty(dbUser);

                model.addAttribute("login", login);
                model.addAttribute("roles", user.getAuthorities());

                model.addAttribute("albums", dbUser.getUserAlbumsQty());
                model.addAttribute("inbox", messageService.getUserInboxSize(dbUser));
                model.addAttribute("inboxUnread", dbUser.getUnreadInbox());
                model.addAttribute("favorites", dbUser.getUserFavoritesQty());
                model.addAttribute("commentsTotal", commentsTotal);
            }
        }
        return "index";
    }

    /**
     * Registration form
     *
     * @param login    login
     * @param password password
     * @param model    holds user data
     * @return index view after registration
     */
    @RequestMapping(value = "/newuser", method = RequestMethod.POST)
    public String update(@RequestParam String login,
                         @RequestParam String password,
                         Model model) {
        if (userService.existsByLogin(login)) {
            model.addAttribute("exists", true);
            return "register";
        }

        if (login.equals("") || password.equals("")) {
            model.addAttribute("emptyForm", true);
            return "register";
        }

        ShaPasswordEncoder encoder = new ShaPasswordEncoder();
        String passHash = encoder.encodePassword(password, null);

        CustomUser dbUser = new CustomUser(login, passHash, UserRole.USER, Calendar.getInstance().getTime());
        /**/
        AlbumCategory category = categoryService.getByName("GENERAL");
        Album defaultAlbum = new Album(getUID(), dbUser, "First album", "First album",
                category, Calendar.getInstance().getTime());
        dbUser.addAlbum(defaultAlbum);
        /**/
        userService.addUser(dbUser);
        /**/
        CustomUser admin = userService.getUserByLogin("admin");
        OrangeMessage inMessage = new OrangeMessage(dbUser, admin, "Greetings!",
                "We are glad you here!", Calendar.getInstance().getTime(), false);
        inMessage.setMessageUID(getUID());
        inMessage.setMessageType("inbox");

        OrangeMessage outMessage = new OrangeMessage(dbUser, admin, "Greetings!",
                "We are glad you here!", Calendar.getInstance().getTime(), true);
        outMessage.setMessageUID(getUID());
        outMessage.setMessageType("outbox");

        messageService.addMessage(inMessage);
        messageService.addMessage(outMessage);
        /**/

        model.addAttribute("registered", true);
        return "redirect:/login";
    }

    /**
     * register url
     *
     * @return registration form view
     */
    @RequestMapping("/register")
    public String register() {
        return "register";
    }

    /**
     * admin url
     *
     * @return admin view
     */
    @RequestMapping("/admin")
    public String admin() {
        return "admin";
    }

    /**
     * Unauthorized url
     *
     * @param model model
     * @return unauthorized page view
     */
    @RequestMapping("/unauthorized")
    public String unauthorized(Model model) {
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        model.addAttribute("login", user.getUsername());
        return "unauthorized";
    }

    /**
     * Registered user profile page
     *
     * @param login user login
     * @param model holds user data
     * @return profile page view
     */
    @RequestMapping(value = "/user/{login}", method = RequestMethod.GET)
    public String getProfilePage(
            @PathVariable("login") String login,
            Model model) {

        CustomUser dbUser = userService.getUserByLogin(login);
        if (dbUser == null) {
            return "/user_not_found";
        }

        model.addAttribute("albums", dbUser.getUserAlbumsQty());
        model.addAttribute("items", dbUser.getUserPhotosQty());
        model.addAttribute("registrationDate", dbUser.getRegistrationDate());
        model.addAttribute("targetLogin", login);

        return "/user_page";
    }

    private String getUID() {
        return UUID.randomUUID().toString();
    }
}
