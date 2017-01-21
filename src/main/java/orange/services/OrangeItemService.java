package orange.services;


import orange.entities.Album;
import orange.entities.OrangeItem;
import orange.user.CustomUser;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface OrangeItemService {
    void addOrangeItem(OrangeItem item);

    void deleteOrangeItem(OrangeItem item);

    void deleteOrangeItem(long id);

    void updateOrangeItem(OrangeItem item);

    OrangeItem getByUid(String uid);

    List<OrangeItem> getAllForUser(CustomUser user);

    Page<OrangeItem> findAllByAlbumId(Album album, int pageNumber);

    Page<OrangeItem> getCommentsForUserItems(CustomUser user, int pageNumber);

    Page<OrangeItem> getUserFavorites(List<OrangeItem> favorites, int pageNumber);

    Page<OrangeItem> getFavorited(List<OrangeItem> favorited, int pageNumber);

    Page<OrangeItem> getMoreItemFromAlbum(Album album);

    Page<OrangeItem> getLatestPhoto(int pageNumber);

    Page<OrangeItem> getMostCommentedPhoto(int pageNumber);

    Page<OrangeItem> getMostFavoritesPhoto(int pageNumber);
}
