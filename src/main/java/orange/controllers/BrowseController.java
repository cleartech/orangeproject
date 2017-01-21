package orange.controllers;

import orange.entities.Album;
import orange.entities.AlbumCategory;
import orange.entities.OrangeItem;
import orange.services.AlbumService;
import orange.services.CategoryService;
import orange.services.OrangeItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.ArrayList;
import java.util.List;

@Controller
public class BrowseController {

    @Autowired
    AlbumService albumService;
    @Autowired
    CategoryService categoryService;
    @Autowired
    OrangeItemService itemService;
    private final List<String> categories = new ArrayList<>();

    public BrowseController() {
        categories.add("recent");
        categories.add("commented");
        categories.add("favorites");
    }

    /**
     * Browse uploaded albums
     *
     * @param model      holds pagination data and selected albums
     * @param category   selecting parameter which holds albums category to select
     * @param pageNumber pagination parameter
     * @return loaded albums view
     */
    @RequestMapping(value = "/browse/albums/{category}/{pageNumber}", method = RequestMethod.GET)
    public String browseAlbums(
            Model model,
            @PathVariable String category,
            @PathVariable int pageNumber
    ) {
        Page<Album> latestAlbums = null;
        if (category.equals("latest")) {
            latestAlbums = albumService.findAlbumsOrderByCreationDateDesc(pageNumber);
        } else {
            latestAlbums = albumService.findAlbumsByCategory(categoryService.getByName(category), pageNumber);
        }
        int current = latestAlbums.getNumber() + 1;
        int begin = Math.max(1, current - 5);
        int end = Math.min(begin + 10, latestAlbums.getTotalPages());
        model.addAttribute("beginIndex", begin);
        model.addAttribute("endIndex", end);
        model.addAttribute("currentIndex", current);
        model.addAttribute("latestAlbums", latestAlbums);
        List<AlbumCategory> categoryList = categoryService.getAll();
        categoryList.add(new AlbumCategory("latest"));
        model.addAttribute("categories", categoryList);
        model.addAttribute("currentCategory", category);

        return "/browse-albums";
    }

    /**
     * Browse uploaded photos
     *
     * @param model      holds pagination data and selected photos
     * @param category   selecting parameter which holds photos category to select
     * @param pageNumber pagination parameter
     * @return loaded photos view
     */
    @RequestMapping(value = "/browse/photos/{category}/{pageNumber}", method = RequestMethod.GET)
    public String browsePhotos(
            Model model,
            @PathVariable String category,
            @PathVariable int pageNumber
    ) {
        Page<OrangeItem> latestPhotos = null;

        switch (category.toLowerCase()) {
            case "recent": {
                latestPhotos = itemService.getLatestPhoto(pageNumber);
                break;
            }
            case "commented": {
                latestPhotos = itemService.getMostCommentedPhoto(pageNumber);
                break;
            }
            case "favorites": {
                latestPhotos = itemService.getMostFavoritesPhoto(pageNumber);
                break;
            }
        }

        int current = latestPhotos.getNumber() + 1;
        int begin = Math.max(1, current - 5);
        int end = Math.min(begin + 10, latestPhotos.getTotalPages());
        model.addAttribute("beginIndex", begin);
        model.addAttribute("endIndex", end);
        model.addAttribute("photosIndex", current);
        model.addAttribute("latestPhotos", latestPhotos);
        model.addAttribute("categories", categories);
        model.addAttribute("currentCategory", category);

        return "/browse-photos";
    }
}
