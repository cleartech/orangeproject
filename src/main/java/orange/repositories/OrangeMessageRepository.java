package orange.repositories;


import orange.entities.OrangeMessage;
import orange.user.CustomUser;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface OrangeMessageRepository extends JpaRepository<OrangeMessage, Integer>{

    @Query("SELECT m FROM OrangeMessage m WHERE m.messageUID =:messageUID ORDER BY m.messageDate ASC")
    OrangeMessage findByUid(@Param("messageUID") String messageUid);

    @Query("SELECT m FROM OrangeMessage m WHERE m.userTo =:userTo AND m.messageType = 'inbox'")
    Page<OrangeMessage> getInboxMessages(
            @Param("userTo") CustomUser userTo,
            Pageable pageable);

    @Query("SELECT m FROM OrangeMessage m WHERE m.userFrom =:userFrom AND m.messageType = 'outbox'")
    Page<OrangeMessage> getOutboxMessages(
            @Param("userFrom") CustomUser userFrom,
            Pageable pageable);

    @Query("SELECT m FROM OrangeMessage m WHERE m.userTo =:userTo AND m.messageType = 'inbox'")
    List<OrangeMessage> getInboxList(
            @Param("userTo") CustomUser userTo);
}
