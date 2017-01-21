package orange.services;

import orange.entities.Album;
import orange.entities.OrangeItem;
import orange.repositories.OrangeItemRepository;
import orange.user.CustomUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class OrangeItemServiceImpl implements OrangeItemService {

    @Autowired
    OrangeItemRepository orangeItemRepository;

    private static final int ALBUMS_PAGE_SIZE = 12;
    private static final int COMMENTS_PAGE_SIZE = 20;
    private static final int FAVORITES_PAGE_SIZE = 20;
    private static final int BROWSE_PHOTO_PAGE_SIZE = 30;


    @Override
    @Transactional
    public void addOrangeItem(OrangeItem item) {
        orangeItemRepository.save(item);
    }

    @Override
    @Transactional
    public void deleteOrangeItem(OrangeItem item) {
        orangeItemRepository.delete(item);
    }

    @Override
    @Transactional
    public void deleteOrangeItem(long id) {
        orangeItemRepository.delete(id);
    }

    @Override
    @Transactional
    public void updateOrangeItem(OrangeItem item) {
        orangeItemRepository.save(item);
    }

    @Override
    @Transactional
    public OrangeItem getByUid(String uid) {
        return orangeItemRepository.findByUID(uid);
    }

    @Override
    @Transactional(readOnly = true)
    public List<OrangeItem> getAllForUser(CustomUser user) {
        return orangeItemRepository.getAllForUser(user);
    }

    @Override
    @Transactional
    public Page<OrangeItem> findAllByAlbumId(Album album, int pageNumber) {
        PageRequest pageRequest = new PageRequest(pageNumber - 1, ALBUMS_PAGE_SIZE, Sort.Direction.DESC, "uploadDate");
        return orangeItemRepository.findByAlbumId(album.getId(), pageRequest);
    }

    @Override
    @Transactional(readOnly = true)
    public Page<OrangeItem> getCommentsForUserItems(CustomUser user, int pageNumber) {
        PageRequest pageRequest = new PageRequest(pageNumber - 1, COMMENTS_PAGE_SIZE);
        return orangeItemRepository.getCommentsForUserItems(user, pageRequest);
    }

    @Override
    @Transactional(readOnly = true)
    public Page<OrangeItem> getUserFavorites(List<OrangeItem> favorites, int pageNumber) {
        PageRequest pageRequest = new PageRequest(pageNumber - 1, FAVORITES_PAGE_SIZE);
        return orangeItemRepository.getUserFavorites(favorites, pageRequest);
    }

    @Override
    @Transactional(readOnly = true)
    public Page<OrangeItem> getFavorited(List<OrangeItem> favorited, int pageNumber) {
        PageRequest pageRequest = new PageRequest(pageNumber - 1, FAVORITES_PAGE_SIZE);
        return orangeItemRepository.getFavorited(favorited, pageRequest);
    }

    @Override
    @Transactional(readOnly = true)
    public Page<OrangeItem> getMoreItemFromAlbum(Album album) {
        Pageable pageRequest = new PageRequest(0, 8, Sort.Direction.DESC, "uploadDate");
        return orangeItemRepository.getMoreItemFromAlbum(album, pageRequest);
    }

    @Override
    @Transactional(readOnly = true)
    public Page<OrangeItem> getLatestPhoto(int pageNumber) {
        PageRequest pageRequest = new PageRequest(pageNumber - 1, BROWSE_PHOTO_PAGE_SIZE);
        return orangeItemRepository.findAllByOrderByUploadDateDesc(pageRequest);
    }

    @Override
    @Transactional(readOnly = true)
    public Page<OrangeItem> getMostCommentedPhoto(int pageNumber) {
        PageRequest pageRequest = new PageRequest(pageNumber - 1, BROWSE_PHOTO_PAGE_SIZE);
        return orangeItemRepository.getMostCommented(pageRequest);
    }

    @Override
    @Transactional(readOnly = true)
    public Page<OrangeItem> getMostFavoritesPhoto(int pageNumber) {
        PageRequest pageRequest = new PageRequest(pageNumber - 1, BROWSE_PHOTO_PAGE_SIZE);
        return orangeItemRepository.getMostFavorited(pageRequest);
    }
}
