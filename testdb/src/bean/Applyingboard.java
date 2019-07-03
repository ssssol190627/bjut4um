package bean;

public class Applyingboard {
	
	private Integer applyingid;
	private String boardname;
	private String applyingreason;
	private Integer userid;
	private String applytime;
	private Integer ishandle;
	
	public Applyingboard() {}
	
	public Integer getApplyingid() {
		return applyingid;
	}
	public void setApplyingid(Integer applyingid) {
		this.applyingid=applyingid;
	}
	public String getBoardname() {
		return boardname;
	}
	public void setBoardname(String boardname) {
		this.boardname=boardname;
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
