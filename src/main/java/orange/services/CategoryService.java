package orange.services;


import orange.entities.AlbumCategory;

import java.util.List;

public interface CategoryService {
    void addCategory(AlbumCategory category);

    void deleteCategory(AlbumCategory category);

    AlbumCategory getByName(String name);

    List<AlbumCategory> getAll();
}
