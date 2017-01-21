package orange.services;

import orange.entities.Comment;
import orange.entities.OrangeMessage;
import orange.user.CustomUser;
import org.springframework.data.domain.Page;

import java.util.List;

public interface MessageService {
    void addMessage(OrangeMessage message);

    void deleteMessage(OrangeMessage message);

    void deleteMessage(String[] messageUid);

    void updateMessage(OrangeMessage message);

    OrangeMessage findByUid(String uid);

    Page<OrangeMessage> getInboxMessages(CustomUser user, int pageNumber);

    Page<OrangeMessage> getOutboxMessages(CustomUser user, int pageNumber);

    List<OrangeMessage> getInboxList(CustomUser user);
}
