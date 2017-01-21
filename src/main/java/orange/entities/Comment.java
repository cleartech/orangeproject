package orange.entities;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "comments")
public class Comment implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;

    private String commentUID;

    @ManyToOne(fetch = FetchType.LAZY)
    private OrangeItem orangeItem;

    private String authorLogin;

    @Lob
    private String commentText;

    @Temporal(TemporalType.TIMESTAMP)
    private Date commentDate;

    public Comment() {
    }

    public Comment(OrangeItem orangeItem, String commentText, Date commentDate) {
        this.orangeItem = orangeItem;
        this.commentText = commentText;
        this.commentDate = commentDate;
    }

    public String getAuthorLogin() {
        return authorLogin;
    }

    public void setAuthorLogin(String authorLogin) {
        this.authorLogin = authorLogin;
    }

    public String getCommentUID() {
        return commentUID;
    }

    public void setCommentUID(String commentUID) {
        this.commentUID = commentUID;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public OrangeItem getOrangeItem() {
        return orangeItem;
    }

    public void setOrangeItem(OrangeItem orangeItem) {
        this.orangeItem = orangeItem;
    }

    public String getCommentText() {
        return commentText;
    }

    public void setCommentText(String commentText) {
        this.commentText = commentText;
    }

    public Date getCommentDate() {
        return commentDate;
    }

    public void setCommentDate(Date commentDate) {
        this.commentDate = commentDate;
    }
}
