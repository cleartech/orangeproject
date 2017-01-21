package orange.services;

import orange.entities.Comment;
import orange.entities.OrangeItem;
import orange.repositories.CommentRepository;
import orange.user.CustomUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class CommentServiceImpl implements CommentService {

    private static final int COMMENTS_PAGE_SIZE = 20;

    @Autowired
    private CommentRepository commentRepository;

    @Override
    @Transactional
    public void saveComment(Comment comment) {
        commentRepository.save(comment);
    }

    @Override
    @Transactional
    public void deleteComment(Comment comment) {
        commentRepository.delete(comment);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Comment> getCommentForItem(OrangeItem orangeItem) {
        return commentRepository.getCommentForItem(orangeItem);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Comment> findTop5ByOrangeItemOrderByCommentDateDesc(OrangeItem item) {
        return commentRepository.findTop5ByOrangeItemOrderByCommentDateDesc(item);
    }

    @Override
    @Transactional(readOnly = true)
    public Page<Comment> findAllComments(OrangeItem item, int pageNumber) {
        PageRequest pageRequest = new PageRequest(pageNumber - 1, COMMENTS_PAGE_SIZE);

        return commentRepository.findAllCommentByOrangeItemOrderByCommentDateDesc(item, pageRequest);
    }

    @Override
    @Transactional(readOnly = true)
    public int getUserCommentsQty(CustomUser user) {
        return commentRepository.getUserCommentsQty(user);
    }
}
