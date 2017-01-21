package orange.entities;

import orange.user.CustomUser;

import javax.persistence.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "albums")
public class Album implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;
    private String albumUID;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private CustomUser user;

    private String albumName;
    private String albumDescr;

    @OneToMany(mappedBy = "album", cascade = CascadeType.ALL)
    private List<OrangeItem> albumItems = new ArrayList<>();

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "category_id")
    private AlbumCategory category;

    @Temporal(TemporalType.TIMESTAMP)
    private Date creationDate;

    public Album() {
    }

    public Album(String albumUID, CustomUser user, String albumName,
                 String albumDescr, AlbumCategory category, Date creationDate) {
        this.albumUID = albumUID;
        this.user = user;
        this.albumName = albumName;
        this.albumDescr = albumDescr;
        this.category = category;
        this.creationDate = creationDate;
    }

    public Date getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(Date creationDate) {
        this.creationDate = creationDate;
    }

    public AlbumCategory getCategory() {
        return category;
    }

    public void setCategory(AlbumCategory category) {
        this.category = category;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getAlbumUID() {
        return albumUID;
    }

    public void setAlbumUID(String albumUID) {
        this.albumUID = albumUID;
    }

    public CustomUser getUser() {
        return user;
    }

    public void setUser(CustomUser user) {
        this.user = user;
    }

    public String getAlbumName() {
        return albumName;
    }

    public void setAlbumName(String albumName) {
        this.albumName = albumName;
    }

    public String getAlbumDescr() {
        return albumDescr;
    }

    public void setAlbumDescr(String albumDescr) {
        this.albumDescr = albumDescr;
    }

    public List<OrangeItem> getAlbumItems() {
        return albumItems;
    }

    public void setAlbumItems(List<OrangeItem> albumItems) {
        this.albumItems = albumItems;
    }
}
