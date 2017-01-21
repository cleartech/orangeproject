package orange.entities;

import orange.user.CustomUser;

import javax.persistence.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

@Entity
@Table(name = "pics")
public class OrangeItem implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;
    @Column(name = "uId", nullable = false)
    private String uId;
    private String name;
    private long size;
    private int width;
    private int height;
    private String type;
    private int rating;


    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "orangeItems")
    private CustomUser user;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "albumItems")
    private Album album;
    private String description;
    @Lob
    private byte[] image;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "orangeItem", orphanRemoval = true)
    private List<Comment> comments = new ArrayList<>();

    @ManyToMany(mappedBy = "favoriteList", cascade = {CascadeType.PERSIST, CascadeType.MERGE})
    private List<CustomUser> addedUsers = new ArrayList<>();

    @Temporal(TemporalType.TIMESTAMP)
    private Date uploadDate;

    private int views;

    public OrangeItem() {
    }

    public OrangeItem(
            String uId, String name, long size, int width,
            int height, String type, int rating, CustomUser user, Album album,
            String description) {
        this.uId = uId;
        this.name = name;
        this.size = size;
        this.width = width;
        this.height = height;
        this.type = type;
        this.rating = rating;
        this.user = user;
        this.album = album;
        this.description = description;

    }

    public void addUserToAddedList(CustomUser user) {
        addedUsers.add(user);
        user.getFavoriteList().add(this);
    }

    public void removeUserFromAddedList(CustomUser user) {
        addedUsers.remove(user);
        user.getFavoriteList().remove(this);
    }

    public void removeAllUserFromAddedList() {
        for (Iterator<CustomUser> iterator = addedUsers.iterator(); iterator.hasNext(); ) {
            CustomUser user = iterator.next();
            user.getFavoriteList().remove(this);
            iterator.remove();
        }
    }

    public void addComment(Comment comment) {
        comments.add(comment);
        comment.setOrangeItem(this);
    }

    public void removeComment(Comment comment) {
        comment.setOrangeItem(null);
        this.comments.remove(comment);
    }

    public List<CustomUser> getAddedUsers() {
        return addedUsers;
    }

    public void setAddedUsers(List<CustomUser> addedUsers) {
        this.addedUsers = addedUsers;
    }


    public boolean isFavoritedByUser(CustomUser user) {
        return addedUsers.contains(user);
    }

    public int getViews() {
        return views;
    }

    public void setViews(int views) {
        this.views = views;
    }

    public Date getUploadDate() {
        return uploadDate;
    }

    public void setUploadDate(Date uploadDate) {
        this.uploadDate = uploadDate;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public List<Comment> getComments() {
        return comments;
    }

    public void setComments(List<Comment> comments) {
        this.comments = comments;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getuId() {
        return uId;
    }

    public void setuId(String uId) {
        this.uId = uId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public long getSize() {
        return size;
    }

    public void setSize(long size) {
        this.size = size;
    }

    public int getWidth() {
        return width;
    }

    public void setWidth(int width) {
        this.width = width;
    }

    public int getHeight() {
        return height;
    }

    public void setHeight(int height) {
        this.height = height;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public CustomUser getUser() {
        return user;
    }

    public void setUser(CustomUser user) {
        this.user = user;
    }

    public Album getAlbum() {
        return album;
    }

    public void setAlbum(Album album) {
        this.album = album;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public byte[] getImage() {
        return image;
    }

    public void setImage(byte[] image) {
        this.image = image;
    }
}
