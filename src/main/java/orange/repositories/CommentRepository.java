package orange.repositories;

import orange.entities.Comment;
import orange.entities.OrangeItem;
import orange.user.CustomUser;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface CommentRepository extends JpaRepository<Comment, Integer> {

    @Query("SELECT c FROM Comment c WHERE c.orangeItem =:orangeItem ORDER BY c.commentDate DESC")
    List<Comment> getCommentForItem(@Param("orangeItem") OrangeItem orangeItem);

    List<Comment> findTop5ByOrangeItemOrderByCommentDateDesc(OrangeItem item);

    Page<Comment> findAllCommentByOrangeItemOrderByCommentDateDesc(@Param("orangeItem") OrangeItem item, Pageable pageable);

    @Query("SELECT COUNT(c.id) FROM Comment c WHERE c.orangeItem.user =:user")
    int getUserCommentsQty(@Param("user") CustomUser user);
}
