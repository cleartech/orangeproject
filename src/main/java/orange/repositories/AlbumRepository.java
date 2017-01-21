package orange.repositories;

import orange.entities.Album;
import orange.user.CustomUser;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface AlbumRepository extends JpaRepository<Album, Integer> {
    @Query("SELECT a FROM Album a WHERE a.user =:user")
    List<Album> getUserAlbums(@Param("user") CustomUser user);

    @Query("SELECT a FROM Album a WHERE a.albumUID =:albumUID")
    Album getByUID(@Param("albumUID") String albumUID);

    @Query("SELECT a FROM Album a WHERE a.albumName =:albumName")
    Album getByName(@Param("albumName") String albumName);

    @Query("SELECT a FROM Album a WHERE a.user =:user")
    Page<Album> findUserAlbums(@Param("user") CustomUser user, Pageable pageable);

    @Query("SELECT a FROM Album a ORDER BY a.creationDate DESC")
    Page<Album> findAlbumsOrderByCreationDateDesc(Pageable pageable);

    @Query("SELECT a FROM Album a WHERE a.category.name =:name ORDER BY a.creationDate DESC")
    Page<Album> findAlbumsByCategory(@Param("name") String name, Pageable pageable);
}
