package orange.services;


import orange.entities.Comment;
import orange.entities.OrangeItem;
import orange.user.CustomUser;
import org.springframework.data.domain.Page;

import java.util.List;

public interface CommentService {
    void saveComment(Comment comment);

    void deleteComment(Comment comment);

    List<Comment> getCommentForItem(OrangeItem itemUid);

    List<Comment> findTop5ByOrangeItemOrderByCommentDateDesc(OrangeItem item);

    Page<Comment> findAllComments(OrangeItem item, int currentPage);

    int getUserCommentsQty(CustomUser user);
}
