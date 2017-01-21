package orange.user;

import orange.entities.*;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "customusers")
public class CustomUser {
    @Id
    @GeneratedValue
    private long id;

    private String login;
    private String password;

    @Enumerated(EnumType.STRING)
    private UserRole role;

    @Temporal(TemporalType.DATE)
    private Date registrationDate;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    private List<Album> albums = new ArrayList<>();

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    private List<OrangeItem> orangeItems = new ArrayList<>();

    @OneToMany(mappedBy = "userTo", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<OrangeMessage> inBox = new ArrayList<>();

    @OneToMany(mappedBy = "userFrom", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<OrangeMessage> outBox = new ArrayList<>();

    @ManyToMany(cascade = {CascadeType.PERSIST, CascadeType.MERGE})
    @JoinTable(
            name = "userFavorites",
            joinColumns = {@JoinColumn(name = "user_id", referencedColumnName = "id")},
            inverseJoinColumns = {@JoinColumn(name = "item_id", referencedColumnName = "id")}
    )
    private List<OrangeItem> favoriteList = new ArrayList<>();

    public CustomUser(String login, String password, UserRole role) {
        this.login = login;
        this.password = password;
        this.role = role;
    }

    public CustomUser(String login, String password, UserRole role, Date registrationDate) {
        this.login = login;
        this.password = password;
        this.role = role;
        this.registrationDate = registrationDate;
    }

    public List<OrangeItem> getFavoriteList() {
        return favoriteList;
    }

    public void setFavoriteList(List<OrangeItem> favoriteList) {
        this.favoriteList = favoriteList;
    }

    public Date getRegistrationDate() {
        return registrationDate;
    }

    public void setRegistrationDate(Date registrationDate) {
        this.registrationDate = registrationDate;
    }

    public int getUnreadInbox() {
        int unread = 0;
        for (OrangeMessage message : this.inBox) {
            if (!message.isRead()) {
                unread++;
            }
        }
        return unread;
    }

    public void addMessageToInbox(OrangeMessage message) {
        inBox.add(message);
        message.setUserTo(this);
    }

    public void removeMessageFromInbox(OrangeMessage message) {
        message.setUserTo(null);
        this.inBox.remove(message);
    }

    public void addMessageToOutBox(OrangeMessage message) {
        outBox.add(message);
        message.setUserFrom(this);
    }

    public void removeMessageFromOutBox(OrangeMessage message) {
        message.setUserFrom(null);
        this.outBox.remove(message);
    }

    public void addAlbum(Album album) {
        albums.add(album);
    }

    public List<OrangeMessage> getInBox() {
        return inBox;
    }

    public void setInBox(List<OrangeMessage> inBox) {
        this.inBox = inBox;
    }

    public List<OrangeMessage> getOutBox() {
        return outBox;
    }

    public void setOutBox(List<OrangeMessage> outBox) {
        this.outBox = outBox;
    }

    public CustomUser() {
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public UserRole getRole() {
        return role;
    }

    public void setRole(UserRole role) {
        this.role = role;
    }


    public List<Album> getAlbums() {
        return albums;
    }

    public void setAlbums(List<Album> albums) {
        this.albums = albums;
    }

    public List<OrangeItem> getOrangeItems() {
        return orangeItems;
    }

    public void setOrangeItems(List<OrangeItem> orangeItems) {
        this.orangeItems = orangeItems;
    }
}
