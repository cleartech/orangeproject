package orange.entities;

import orange.user.CustomUser;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "orange_messages")
public class OrangeMessage implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;

    private String messageUID;

    @ManyToOne(fetch = FetchType.LAZY)
    private CustomUser userTo;

    @ManyToOne(fetch = FetchType.LAZY)
    private CustomUser userFrom;

    private String messageTheme;
    private String messageText;
//    @Column(name = "was_read", nullable = false, columnDefinition = "TINYINT(1)")
    //problem arises when "hbm2ddl.auto" changed from create-drop to validate
    @Column(name = "was_read", columnDefinition = "BIT", length = 1)
    private boolean read;
    @Temporal(TemporalType.TIMESTAMP)
    private Date messageDate;

    private String messageType;

    public OrangeMessage() {
    }

    public OrangeMessage(CustomUser userTo, CustomUser userFrom, String messageTheme,
                         String messageText, Date messageDate, boolean read) {
        this.userTo = userTo;
        this.userFrom = userFrom;
        this.messageTheme = messageTheme;
        this.messageText = messageText;
        this.read = read;
        this.messageDate = messageDate;
    }

    public String getMessageType() {
        return messageType;
    }

    public void setMessageType(String messageType) {
        this.messageType = messageType;
    }

    public Date getMessageDate() {
        return messageDate;
    }

    public void setMessageDate(Date messageDate) {
        this.messageDate = messageDate;
    }

    public String getMessageUID() {
        return messageUID;
    }

    public void setMessageUID(String messageUID) {
        this.messageUID = messageUID;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public CustomUser getUserTo() {
        return userTo;
    }

    public void setUserTo(CustomUser userTo) {
        this.userTo = userTo;
    }

    public CustomUser getUserFrom() {
        return userFrom;
    }

    public void setUserFrom(CustomUser userFrom) {
        this.userFrom = userFrom;
    }

    public String getMessageTheme() {
        return messageTheme;
    }

    public void setMessageTheme(String messageTheme) {
        this.messageTheme = messageTheme;
    }

    public String getMessageText() {
        return messageText;
    }

    public void setMessageText(String messageText) {
        this.messageText = messageText;
    }

    public boolean isRead() {
        return read;
    }

    public void setRead(boolean read) {
        this.read = read;
    }
}
