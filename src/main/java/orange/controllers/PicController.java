package orange.controllers;

import orange.entities.OrangeItem;
import orange.services.OrangeItemService;
import orange.user.CustomUser;
import orange.user.UserService;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.activation.MimetypesFileTypeMap;
import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.UUID;

@Controller
public class PicController {
    @Autowired
    private OrangeItemService orangeItemService;
    @Autowired
    private UserService userService;

    private static final DecimalFormat format = new DecimalFormat("#.##");
    private static final long MiB = 1024 * 1024;
    private static final long KiB = 1024;

    @RequestMapping(value = "/add_photo", method = RequestMethod.POST)
    public String addPhoto(Model model, @RequestParam("photo") MultipartFile pic ) throws IOException {

        if(pic.isEmpty()) {
            model.addAttribute("emptyPic", true);
            return "redirect:/";
        }

        if(!isImageFile(pic)) {
            model.addAttribute("notSupported", true);
                return "redirect:/";
        }

        File file = new File(pic.getOriginalFilename());
        BufferedImage img = ImageIO.read(pic.getInputStream());

        OrangeItem item = new OrangeItem();
        item.setuId(getUUID());
        item.setName(file.getName());
        item.setSize(pic.getSize());
        if(pic.getSize() > 2097152) {
            model.addAttribute("sizeLimit", true);
            return "redirect:/";
        }
        item.setWidth(img.getWidth());
        item.setHeight(img.getHeight());
        item.setType(getFileExtension(file));
        item.setUser(null);
        item.setAlbum(null);
        item.setDescription("");
        item.setViews(0);
        item.setUploadDate(Calendar.getInstance().getTime());
        item.setRating(0);
        item.setImage(pic.getBytes());

        model.addAttribute("item", item);
        model.addAttribute("name", file.getName());
        model.addAttribute("type", pic.getContentType());
//        try {
            model.addAttribute("size", getFileSize(pic));
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
        model.addAttribute("dimension", img.getWidth() + "x" + img.getHeight());

        orangeItemService.addOrangeItem(item);

        return "single-pic-view";
    }

    /**
     * Getting image for thumbnail view anywhere it needed
     * @param uid item uid
     * @return image for placing
     */
    @RequestMapping("/view-item/{uid}")
    public ResponseEntity<byte[]> onPhoto(@PathVariable("uid") String uid) {
        return itemByUid(uid);
    }

//    @RequestMapping(value = "/view-fullsize/{uid}", method = RequestMethod.GET)
//    public ModelAndView onFullSizePhoto(@PathVariable("uid") String uid) {
//        return new ModelAndView("single-pic-view-fullsize", "img", itemByUid(uid));
//    }

    /**
     * Getting image as byte array
     * @param uid image uid
     * @return byte array
     */
    private ResponseEntity<byte[]> itemByUid(String uid) {
        OrangeItem item = orangeItemService.getByUid(uid);
//        byte[] bytes = orangeItemService.getByUid(uid);
//        if (bytes == null)
//            throw new PhotoNotFoundException();

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.IMAGE_PNG);

        return new ResponseEntity<>(item.getImage(), headers, HttpStatus.OK);
    }

    @RequestMapping("/download/{uid}")
    public ResponseEntity<byte[]> downloadSingle(@PathVariable("uid") String uid) {
        OrangeItem item = orangeItemService.getByUid(uid);
//        File temp = null;
//        FileUtils.writeByteArrayToFile(temp, item.getImage());

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.IMAGE_PNG);
        headers.setContentDispositionFormData("attachment", item.getName());
        return new ResponseEntity<>(item.getImage(), headers, HttpStatus.OK);
    }

    @RequestMapping("/full-size/{uid}")
    public ResponseEntity<byte[]> viewFullSize(@PathVariable("uid") String uid) {
        OrangeItem item = orangeItemService.getByUid(uid);
        item.setViews(item.getViews() - 1);
        orangeItemService.updateOrangeItem(item);

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.IMAGE_PNG);
        return new ResponseEntity<>(item.getImage(), headers, HttpStatus.OK);
    }

    @RequestMapping(value = "/add-to-favorite/{itemUid}/{currentIndex}", method = RequestMethod.GET)
    public String addToFavorite(
            @PathVariable("itemUid") String itemUid,
            @PathVariable("currentIndex") String currentIndex,
            Model model) {

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (!(auth instanceof AnonymousAuthenticationToken)) {
            OrangeItem item = orangeItemService.getByUid(itemUid);
            item.setViews(item.getViews() - 1);
            item.setRating(item.getRating() + 1);
            User user = (User) auth.getPrincipal();
            String login = user.getUsername();
            CustomUser dbUser = userService.getUserByLogin(login);
//            dbUser.addToFavorite(item);
            item.addUserToAddedList(dbUser);
//            item.addUserToFavoriteList(dbUser);
            userService.updateUser(dbUser);
//            orangeItemService.updateOrangeItem(item);
            model.addAttribute("item", item);
        }
            return "redirect:/view-album-item/" + itemUid + "/" + currentIndex;
    }

    @RequestMapping(value = "/remove-from-favorites/{itemUid}/{currentIndex}", method = RequestMethod.GET)
    public String removeFromFavorites(
            @PathVariable("itemUid") String itemUid,
            @PathVariable("currentIndex") String currentIndex,
            Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (!(auth instanceof AnonymousAuthenticationToken)) {
            OrangeItem item = orangeItemService.getByUid(itemUid);
            item.setViews(item.getViews() - 1);
            item.setRating(item.getRating() - 1);
            User user = (User) auth.getPrincipal();
            String login = user.getUsername();
            CustomUser dbUser = userService.getUserByLogin(login);
//            dbUser.removeFromFavorite(item);
            item.removeUserFromAddedList(dbUser);
//            item.removeUserFromFavoriteList(dbUser);
            userService.updateUser(dbUser);
//            orangeItemService.updateOrangeItem(item);
            model.addAttribute("item", item);
            model.addAttribute("currentIndex", currentIndex);
        }
        return "redirect:/view-album-item/" + itemUid + "/" + currentIndex;
    }

    /**
     * Remove item from Favorites list on Favorites page
     * @param currentIndex
     * @param itemUid
     * @return
     */
    @RequestMapping(value = "/manage-favorites/{currentIndex}/{itemUid}", method = RequestMethod.GET)
    public String manageFavorites(
            @PathVariable int currentIndex,
            @PathVariable String itemUid
    ) {
        OrangeItem item = orangeItemService.getByUid(itemUid);
        item.setRating(item.getRating() - 1);
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User user = (User) auth.getPrincipal();
        CustomUser dbUser = userService.getUserByLogin(user.getUsername());
//        dbUser.removeFromFavorite(item);
        item.removeUserFromAddedList(dbUser);
//        item.removeUserFromFavoriteList(dbUser);
        userService.updateUser(dbUser);
//        orangeItemService.updateOrangeItem(item);

        return "redirect:/favorites/page/" + currentIndex;
    }

    @RequestMapping(value = "/delete-photo/{itemUid}", method = RequestMethod.GET)
    public String deletePhoto(
            @PathVariable String itemUid
    ) {
        OrangeItem deleteItem = orangeItemService.getByUid(itemUid);
        /////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////
//        for(CustomUser user: deleteItem.getAddedUsers()) {
//            user.getFavoriteList().remove(deleteItem);
//        }
        /////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////
        orangeItemService.deleteOrangeItem(deleteItem);

        return "redirect:/";
    }

    private String getFileExtension(File file) {
        String fileName = file.getName();
        if(fileName.lastIndexOf(".") != -1 && fileName.lastIndexOf(".") != 0)
            return fileName.substring(fileName.lastIndexOf(".") + 1);
        else return "";
    }

    private boolean isImageFile(MultipartFile file) {
        if (file == null || file.isEmpty()) {
            return false;
        }
        String contentType = file.getContentType();
        return
//                contentType.equals("image/pjpeg") ||
                contentType.equals("image/jpeg") ||
                contentType.equals("image/png") ||
                contentType.equals("image/gif");/* ||
//                contentType.equals("image/bmp");/* ||
                contentType.equals("image/x-png");*/
    }

    private String getUUID() {
        return UUID.randomUUID().toString();
    }

    private String getFileSize(MultipartFile file){

        final double length = file.getSize();

        if (length > MiB) {
            return format.format(length / MiB) + "MB";
        }
        if (length > KiB) {
            return format.format(length / KiB) + "KB";
        }
        return format.format(length) + "B";
    }
}
