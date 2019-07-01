package bean;

public class User {

    private Integer id;//user id
    private String username;//user username
    private String password;//user password
    private String email; //email
    private Integer isExist;
    private Integer isBoardAdmin;
    private Integer isForumAdmin;
    
    public User(){}
    
    public Integer getId() {
	return id;
    }
    public void setId(Integer id) {
	this.id = id;
    }
    public String getUsername() {
	return username;
    }
    public void setUsername(String name) {
	this.username = name;
    }
    public String getPassword() {
    	return password;
    }
    public void setPassword(String password) {
    	this.password=password;
    }
    public String getEmail() {
    	return email;
    }
    public void setEmail(String email) {
    	this.email=email;
    }
    public Integer getisExist() {
    	return isExist;
    }
    public void setisExist(Integer isExist) {
    	this.isExist=isExist;
    }
    public Integer getisBoardAdmin() {
    	return isBoardAdmin;
    }
    public void setisBoardAdmin(Integer isBoardAdmin) {
    	this.isBoardAdmin=isBoardAdmin;
    }
    public Integer getisForumAdmin() {
    	return isForumAdmin;
    }
    public void setisForumAdmin(Integer isForumAdmin) {
    	this.isForumAdmin=isForumAdmin;
    }
}
