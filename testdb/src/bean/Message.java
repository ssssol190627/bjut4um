package bean;

public class Message {
	
	private Integer messageid;
	private Integer userid;
	private String messagetime;
	private String messagecontent;
	private Integer adminid;
	
	public Message() {}
	public Message(Integer messageid,Integer userid,String messagetime,String messagecontent,Integer adminid) {
		this.messageid=messageid;
		this.userid=userid;
		this.messagetime=messagetime;
		this.messagecontent=messagecontent;
		this.adminid=adminid;
	}
	public Integer getMessageid() {
		return messageid;
	}
	public void setMessageid(Integer messageid) {
		this.messageid=messageid;
	}
	public Integer getUserid() {
		return userid;
	}
	public void setUserid(Integer userid) {
		this.userid=userid;
	}
	public String getMessagetime() {
		return messagetime;
	}
	public void setMessagetime(String messagetime) {
		this.messagetime=messagetime;
	}
	public String getMessagecontent() {
		return messagecontent;
	}
	public void setMessagecontent(String messagecontent) {
		this.messagecontent=messagecontent;
	}
	public Integer getAdminid() {
		return adminid;
	}
	public void setAdminid(Integer adminid) {
		this.adminid=adminid;
	}
}
