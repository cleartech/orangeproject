package orange.services;

import orange.entities.AlbumCategory;
import orange.repositories.AlbumCategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class CategoryServiceImpl implements CategoryService {

    @Autowired
    private AlbumCategoryRepository categoryRepository;

    @Override
    @Transactional
    public void addCategory(AlbumCategory category) {
        categoryRepository.save(category);
    }

    @Override
    @Transactional
    public void deleteCategory(AlbumCategory category) {
        categoryRepository.delete(category);
    }

    @Override
    @Transactional
    public AlbumCategory getByName(String name) {
        return categoryRepository.getByName(name);
    }

    @Override
    @Transactional(readOnly = true)
    public List<AlbumCategory> getAll() {
        return categoryRepository.findAll();
    }
}
