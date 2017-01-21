package orange.repositories;


import orange.entities.Album;
import orange.entities.OrangeItem;
import orange.user.CustomUser;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface OrangeItemRepository extends JpaRepository<OrangeItem, Long> {

    @Query("SELECT i FROM OrangeItem i WHERE i.uId = :uid")
    OrangeItem findByUID(@Param("uid") String uid);

    @Query("SELECT i FROM OrangeItem i WHERE i.user =:user")
    List<OrangeItem> getAllForUser(@Param("user") CustomUser user);

    Page<OrangeItem> findByAlbumId(Integer albumId, Pageable pageable);

    @Query("SELECT i FROM OrangeItem i LEFT JOIN i.comments c WHERE i.user =:user AND i.comments IS NOT EMPTY GROUP BY i.name ORDER BY MAX(c.commentDate) DESC")
    Page<OrangeItem> getCommentsForUserItems(@Param("user") CustomUser user, Pageable pageable);

    @Query("SELECT i FROM OrangeItem i WHERE i IN :favorites")
    Page<OrangeItem> getUserFavorites(@Param("favorites") List<OrangeItem> favorites, Pageable pageable);

    @Query("SELECT i FROM OrangeItem i WHERE i.addedUsers IS NOT EMPTY AND i IN :favorited")
    Page<OrangeItem> getFavorited(@Param("favorited") List<OrangeItem> favorited, Pageable pageable);

    @Query("SELECT i FROM OrangeItem i WHERE i.album =:album")
    Page<OrangeItem> getMoreItemFromAlbum(@Param("album") Album album, Pageable pageable);

    Page<OrangeItem> findAllByOrderByUploadDateDesc(Pageable pageable);

    @Query("SELECT i FROM OrangeItem i WHERE i.comments IS NOT EMPTY")
    Page<OrangeItem> getMostCommented(Pageable pageable);

    @Query("SELECT i FROM OrangeItem i WHERE i.addedUsers IS NOT EMPTY")
    Page<OrangeItem> getMostFavorited(Pageable pageable);
}
