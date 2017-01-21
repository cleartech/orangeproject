package orange.services;

import orange.entities.OrangeMessage;
import orange.repositories.OrangeMessageRepository;
import orange.user.CustomUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class MessageServiceImpl implements MessageService {

    private static final int MESSAGE_PAGE_SIZE = 20;

    @Autowired
    private OrangeMessageRepository messageRepository;

    @Override
    @Transactional
    public void addMessage(OrangeMessage message) {
        messageRepository.save(message);
    }

    @Override
    @Transactional
    public void updateMessage(OrangeMessage message) {
        messageRepository.save(message);
    }

    @Override
    @Transactional
    public void deleteMessage(OrangeMessage message) {
        messageRepository.delete(message);
    }

    @Override
    @Transactional
    public void deleteMessage(String[] messageUid) {
        for (String s : messageUid) {
            messageRepository.delete(messageRepository.findByUid(s));
        }
    }

    @Override
    @Transactional
    public OrangeMessage findByUid(String messageUID) {
        return messageRepository.findByUid(messageUID);
    }

    @Override
    @Transactional(readOnly = true)
    public Page<OrangeMessage> getInboxMessages(CustomUser user, int pageNumber) {
        PageRequest pageRequest = new PageRequest(pageNumber - 1, MESSAGE_PAGE_SIZE, Sort.Direction.DESC, "messageDate");
        return messageRepository.getInboxMessages(user, pageRequest);
    }

    @Override
    @Transactional(readOnly = true)
    public Page<OrangeMessage> getOutboxMessages(CustomUser user, int pageNumber) {
        PageRequest pageRequest = new PageRequest(pageNumber - 1, MESSAGE_PAGE_SIZE, Sort.Direction.DESC, "messageDate");
        return messageRepository.getOutboxMessages(user, pageRequest);
    }

    @Override
    @Transactional(readOnly = true)
    public List<OrangeMessage> getInboxList(CustomUser user) {
        return messageRepository.getInboxList(user);
    }
}
