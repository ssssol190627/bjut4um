package bean;

public class Applyingadmin {
	
	private Integer applyingid;
	private Integer boardid;
	private String applyingreason;
	private Integer userid;
	private String applytime;
	private Integer ishandle;
	
	public Applyingadmin() {}
	
	public Integer getApplyingid() {
		return applyingid;
	}
	public void setApplyingid(Integer applyingid) {
		this.applyingid=applyingid;
	}
	public Integer getBoardid() {
		return boardid;
	}
	public void setBoardid(Integer boardid) {
		this.boardid=boardid;
	}
	public String getApplyingreason() {
		return applyingreason;
	}
	public void setApplyingreason(String applyingreason) {
		this.applyingreason=applyingreason;
	}
	public Integer getUserid() {
		return userid;
	}
	public void setUserid(Integer userid) {
		this.userid=userid;
	}
	public String getApplytime() {
		return applytime;
	}
	public void setApplytime(String applytime) {
		this.applytime=applytime;
	}
	public Integer getIshandle() {
		return ishandle;
	}
	public void setIshandle(Integer ishandle) {
		this.ishandle=ishandle;
	}
}
