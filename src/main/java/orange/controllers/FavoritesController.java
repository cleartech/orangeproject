package orange.controllers;

import orange.entities.OrangeItem;
import orange.services.OrangeItemService;
import orange.user.CustomUser;
import orange.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.List;

@Controller
public class FavoritesController {

    @Autowired
    private UserService userService;
    @Autowired
    private OrangeItemService itemService;

    /**
     * View user's favorites photos list
     *
     * @param model      holds favorites photo
     * @param pageNumber pagination parameter
     * @return favorites photos view
     */
    @RequestMapping(value = "/favorites/page/{pageNumber}", method = RequestMethod.GET)
    public String showFavorites(
            Model model,
            @PathVariable int pageNumber) {

        model.addAttribute("currentCase", "myFavorites");

        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String login = user.getUsername();
        CustomUser dbUser = userService.getUserByLogin(login);

        List<OrangeItem> userFavorites = dbUser.getFavoriteList();
        if (userFavorites.size() == 0) {
            model.addAttribute("emptyFavorites", true);

            return "/favorites";
        }

        Page<OrangeItem> page = itemService.getUserFavorites(dbUser.getFavoriteList(), pageNumber);

        int current = page.getNumber() + 1;
        int begin = Math.max(1, current - 5);
        int end = Math.min(begin + 10, page.getTotalPages());
        model.addAttribute("favoriteList", page);
        model.addAttribute("beginIndex", begin);
        model.addAttribute("endIndex", end);
        model.addAttribute("currentIndex", current);

        model.addAttribute("currentIndex", pageNumber);
        model.addAttribute("totalPages", page.getTotalElements());

        return "/favorites";
    }

    /**
     * View of users photo which was added by others users to their favorite lists
     *
     * @param model      holds photos
     * @param pageNumber pagination parameter
     * @return photos view
     */
    @RequestMapping(value = "/favorited/page/{pageNumber}", method = RequestMethod.GET)
    public String showFavorited(
            Model model,
            @PathVariable int pageNumber
    ) {
        model.addAttribute("currentCase", "othersFavorited");

        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String login = user.getUsername();
        CustomUser dbUser = userService.getUserByLogin(login);

        List<OrangeItem> favoritedList = dbUser.getOrangeItems();
        if (favoritedList.size() == 0) {
            model.addAttribute("emptyFavorited", true);
            return "/favorites";
        }

        Page<OrangeItem> favorited = itemService.getFavorited(favoritedList, pageNumber);
        int current = favorited.getNumber() + 1;
        int begin = Math.max(1, current - 5);
        int end = Math.min(begin + 10, favorited.getTotalPages());
        model.addAttribute("favoritedList", favorited);
        model.addAttribute("beginIndex", begin);
        model.addAttribute("endIndex", end);
        model.addAttribute("currentIndex", current);

        model.addAttribute("currentIndex", pageNumber);
        model.addAttribute("totalPages", favorited.getTotalElements());

        return "/favorites";
    }
}
