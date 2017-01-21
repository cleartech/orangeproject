package orange.controllers;

import orange.entities.OrangeItem;
import orange.entities.OrangeMessage;
import orange.services.MessageService;
import orange.user.CustomUser;
import orange.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Calendar;
import java.util.List;
import java.util.UUID;

@Controller
public class MessagesController {

    @Autowired
    private MessageService messageService;
    @Autowired
    private UserService userService;


    /**
     * View users messages
     *
     * @param model      holds messages
     * @param box        type of viewed messages (inbox or outbox)
     * @param pageNumber pagination parameter
     * @return messages view
     */
    @RequestMapping(value = "/messages/{box}/page/{pageNumber}", method = RequestMethod.GET)
    public String getInbox(
            Model model,
            @PathVariable("box") String box,
            @PathVariable int pageNumber) {

        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String login = user.getUsername();
        CustomUser dbUser = userService.getUserByLogin(login);

        Page<OrangeMessage> page = null;
        if (box.equals("inbox")) {
            page = messageService.getInboxMessages(dbUser, pageNumber);
            model.addAttribute("inbox", page);
        } else {
            page = messageService.getOutboxMessages(dbUser, pageNumber);
            model.addAttribute("outbox", page);
        }

        int current = page.getNumber() + 1;
        int begin = Math.max(1, current - 5);
        int end = Math.min(begin + 10, page.getTotalPages());
        model.addAttribute("page", page);
        model.addAttribute("beginIndex", begin);
        model.addAttribute("endIndex", end);
        model.addAttribute("currentIndex", current);

        model.addAttribute("box", box);
        model.addAttribute("total", page.getTotalElements());

        return "/messages";
    }

    /**
     * Single message view
     *
     * @param model       holds message
     * @param box         type of message (in or out)
     * @param messageUid  message uid
     * @param currentPage pagination parameter
     * @return single message view
     */
    @RequestMapping(value = "/messages/{box}/page/{currentPage}/{messageUid}", method = RequestMethod.GET)
    public String viewMessage(
            Model model,
            @PathVariable("box") String box,
            @PathVariable("messageUid") String messageUid,
            @PathVariable int currentPage) {

        OrangeMessage message = messageService.findByUid(messageUid);
        if (box.equals("inbox")) {
            message.setRead(true);
            messageService.updateMessage(message);
        }
        if (message == null) {
            return "/404";
        }
        model.addAttribute("box", box);
        model.addAttribute("message", message);
        model.addAttribute("currentPage", currentPage);

        return "/message-view";
    }

    /**
     * Message reply form
     *
     * @param model       holds message information
     * @param messageUid  message uid
     * @param currentPage pagination parameter
     * @return reply form
     */
    @RequestMapping(value = "/messages/reply/page/{currentPage}/{messageUid}", method = RequestMethod.GET)
    public String replyMessage(
            Model model,
            @PathVariable("messageUid") String messageUid,
            @PathVariable int currentPage
    ) {
        OrangeMessage reply = messageService.findByUid(messageUid);
        model.addAttribute("message", reply);
        model.addAttribute("type", "reply");
        model.addAttribute("currentPage", currentPage);

        return "/message-new";
    }

    /**
     * New message from user profile page
     *
     * @param model       holds message info
     * @param userToLogin message receiver's login
     * @return new message form
     */
    @RequestMapping(value = "/messages/new/{userToLogin}", method = RequestMethod.GET)
    public String newMessage(Model model, @PathVariable(value = "userToLogin") String userToLogin) {

        CustomUser userTo = userService.getUserByLogin(userToLogin);

        model.addAttribute("userTo", userTo);
        model.addAttribute("type", "new");
        model.addAttribute("targetLogin", userTo);
        return "/message-new-profile";
    }

    /**
     * Send new message from user profile page
     *
     * @param model       holds message info
     * @param toUser      message receiver
     * @param title       message title
     * @param messageText message text
     * @return user page view after sending message
     */
    @RequestMapping(value = "/message/send/profile", method = RequestMethod.POST)
    public String sendMessageFromProfilePage(
            Model model,
            @RequestParam String toUser,
            @RequestParam String title,
            @RequestParam String messageText
    ) {

        CustomUser receiver = userService.getUserByLogin(toUser);

        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String login = user.getUsername();
        CustomUser sender = userService.getUserByLogin(login);

        if (messageText.equals("")) {
            model.addAttribute("emptyMessage", true);
            return "redirect:/user/" + receiver.getLogin();
        }

        OrangeMessage outMessage = new OrangeMessage(
                receiver, sender, title, messageText,
                Calendar.getInstance().getTime(), true
        );
        outMessage.setMessageUID(getUUID());
        outMessage.setMessageType("outbox");

        OrangeMessage inMessage = new OrangeMessage(
                receiver, sender, title, messageText,
                Calendar.getInstance().getTime(), false
        );
        inMessage.setMessageUID(getUUID());
        inMessage.setMessageType("inbox");

        sender.addMessageToOutBox(outMessage);
        receiver.addMessageToInbox(inMessage);

        messageService.addMessage(outMessage);
        messageService.addMessage(inMessage);

        model.addAttribute("sent", true);

        return "redirect:/user/" + receiver.getLogin();
    }

    /**
     * Send new message from reply form
     *
     * @param model       holds message info
     * @param toUser      message receiver
     * @param title       message title
     * @param messageText message text
     * @param currentPage pagination parameter
     * @return
     */
    @RequestMapping(value = "/message/send/{currentPage}", method = RequestMethod.POST)
    public String sendMessage(
            Model model,
            @RequestParam String toUser,
            @RequestParam String title,
            @RequestParam String messageText,
            @PathVariable int currentPage) {

        if (messageText.equals("")) {
            model.addAttribute("emptyMessage", true);
            return "redirect:/messages/inbox/page/" + currentPage;
        }

        CustomUser receiver = userService.getUserByLogin(toUser);
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String login = user.getUsername();
        CustomUser sender = userService.getUserByLogin(login);

        OrangeMessage outMessage = new OrangeMessage(
                receiver, sender, title, messageText,
                Calendar.getInstance().getTime(), true
        );
        outMessage.setMessageUID(getUUID());
        outMessage.setMessageType("outbox");

        OrangeMessage inMessage = new OrangeMessage(
                receiver, sender, title, messageText,
                Calendar.getInstance().getTime(), false
        );
        inMessage.setMessageUID(getUUID());
        inMessage.setMessageType("inbox");

        sender.addMessageToOutBox(outMessage);
        receiver.addMessageToInbox(inMessage);

        messageService.addMessage(outMessage);
        messageService.addMessage(inMessage);

        model.addAttribute("sent", true);

        return "redirect:/messages/inbox/page/" + currentPage;
    }

    /**
     * Deleting inbox messages
     *
     * @param toDelete array with messages id's to delete
     * @return inbox view after deleting
     */
    @RequestMapping(value = "/inbox-delete", method = RequestMethod.POST)
    public ResponseEntity<Void> deleteInboxMessages(
            @RequestParam(value = "toDelete[]", required = false) String[] toDelete
    ) {

        if (toDelete != null) {
            CustomUser receiver = null;
            for (String uid : toDelete) {
                OrangeMessage message = messageService.findByUid(uid);
                receiver = message.getUserTo();
                receiver.removeMessageFromInbox(message);
            }
            userService.updateUser(receiver);
        }
        return new ResponseEntity<>(HttpStatus.OK);
    }

    /**
     * Deleting outbox messages
     *
     * @param toDelete array with messages id's to delete
     * @return outbox view after deleting
     */
    @RequestMapping(value = "/outbox-delete", method = RequestMethod.POST)
    public ResponseEntity<Void> deleteOutboxMessages(
            @RequestParam(value = "toDelete[]", required = false) String[] toDelete
    ) {
        if (toDelete != null) {
            CustomUser sender = null;

            for (String uid : toDelete) {
                OrangeMessage message = messageService.findByUid(uid);
                sender = message.getUserFrom();
                sender.removeMessageFromOutBox(message);
            }
            userService.updateUser(sender);
        }
        return new ResponseEntity<>(HttpStatus.OK);
    }

    private String getUUID() {
        return UUID.randomUUID().toString();
    }
}
