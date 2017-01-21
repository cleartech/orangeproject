package orange.services;

import orange.entities.Album;
import orange.entities.AlbumCategory;
import orange.user.CustomUser;
import org.springframework.data.domain.Page;

import java.util.List;

public interface AlbumService {
    void addAlbum(Album album);

    void updateAlbum(Album album);

    void deleteAlbum(Album album);

    List<Album> getUserAlbums(CustomUser user);

    Album getByUid(String uid);

    Album getByName(String name);

    Page<Album> findUserAlbums(CustomUser user, int pageNumber);

    Page<Album> findAlbumsOrderByCreationDateDesc(int pageNumber);

    Page<Album> findAlbumsByCategory(AlbumCategory category, int pageNumber);
}
