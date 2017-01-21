package orange.controllers;

import orange.entities.OrangeItem;
import orange.services.CommentService;
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

@Controller
public class CommentsController {

    @Autowired
    private OrangeItemService itemService;
    @Autowired
    private UserService userService;
    @Autowired
    private CommentService commentService;

    /**
     * View comment for user photos
     *
     * @param model      holds data about commented photos
     * @param pageNumber pagination parameter
     * @return comments view
     */
    @RequestMapping(value = "/comments/{pageNumber}", method = RequestMethod.GET)
    public String showComments(
            Model model,
            @PathVariable Integer pageNumber) {

        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String login = user.getUsername();
        CustomUser dbUser = userService.getUserByLogin(login);

        Page<OrangeItem> commentedItems = itemService.getCommentsForUserItems(dbUser, pageNumber);

        int comments = commentService.getUserCommentsQty(dbUser);

        int current = commentedItems.getNumber() + 1;
        int begin = Math.max(1, current - 5);
        int end = Math.min(begin + 10, commentedItems.getTotalPages());
        model.addAttribute("page", commentedItems);
        model.addAttribute("beginIndex", begin);
        model.addAttribute("endIndex", end);
        model.addAttribute("currentIndex", current);

        model.addAttribute("totalRecords", commentedItems.getTotalElements());
        model.addAttribute("totalComments", comments);
        model.addAttribute("commentedItems", commentedItems);

        return "/comments";
    }
}
