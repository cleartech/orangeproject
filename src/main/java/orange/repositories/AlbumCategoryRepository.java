package orange.repositories;

import orange.entities.AlbumCategory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface AlbumCategoryRepository extends JpaRepository<AlbumCategory, Integer> {
    @Query("SELECT c FROM AlbumCategory c WHERE c.name =:name")
    AlbumCategory getByName(@Param("name") String name);
}
