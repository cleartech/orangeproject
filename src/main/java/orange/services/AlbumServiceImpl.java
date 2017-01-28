package orange.services;

import orange.entities.Album;
import orange.entities.AlbumCategory;
import orange.repositories.AlbumRepository;
import orange.user.CustomUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class AlbumServiceImpl implements AlbumService {

    private final static int ALBUMS_PAGE_SIZE = 12;
    private final static int ALBUMS_BROWSE_VIEW_PAGE_SIZE = 4;

    @Autowired
    private AlbumRepository albumRepository;

    @Override
    @Transactional
    public void addAlbum(Album album) {
        albumRepository.save(album);
    }

    @Override
    @Transactional
    public void updateAlbum(Album album) {
        albumRepository.save(album);
    }

    @Override
    @Transactional
    public void deleteAlbum(Album album) {
        albumRepository.delete(album);
    }


    @Override
    @Transactional(readOnly = true)
    public List<Album> getUserAlbums(CustomUser user) {
        return albumRepository.getUserAlbums(user);
    }

    @Override
    @Transactional
    public Album getByUid(String uid) {
        return albumRepository.getByUID(uid);
    }

    @Override
    @Transactional
    public Album getByName(String name) {
        return albumRepository.getByName(name);
    }

    @Override
    @Transactional
    public Page<Album> findUserAlbums(CustomUser user, int pageNumber) {
        PageRequest pageRequest = new PageRequest(pageNumber - 1, ALBUMS_PAGE_SIZE, Sort.Direction.DESC, "creationDate");

        return albumRepository.findUserAlbums(user, pageRequest);
    }

    @Override
    @Transactional(readOnly = true)
    public Page<Album> findAlbumsOrderByCreationDateDesc(int pageNumber) {
        PageRequest pageRequest = new PageRequest(pageNumber - 1, ALBUMS_BROWSE_VIEW_PAGE_SIZE);

        return albumRepository.findAlbumsOrderByCreationDateDesc(pageRequest);
    }

    @Override
    @Transactional(readOnly = true)
    public Page<Album> findAlbumsByCategory(AlbumCategory category, int pageNumber) {
        PageRequest pageRequest = new PageRequest(pageNumber - 1, ALBUMS_BROWSE_VIEW_PAGE_SIZE);

        return albumRepository.findAlbumsByCategory(category.getName(), pageRequest);
    }
}
