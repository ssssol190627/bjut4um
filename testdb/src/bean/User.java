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
    public Integer getIsExist() {
    	return isExist;
    }
    public void setIsExist(Integer isExist) {
    	this.isExist=isExist;
    }
    public Integer getIsBoardAdmin() {
    	return isBoardAdmin;
    }
    public void setIsBoardAdmin(Integer isBoardAdmin) {
    	this.isBoardAdmin=isBoardAdmin;
    }
    public Integer getIsForumAdmin() {
    	return isForumAdmin;
    }
    public void setIsForumAdmin(Integer isForumAdmin) {
    	this.isForumAdmin=isForumAdmin;
    }
}
