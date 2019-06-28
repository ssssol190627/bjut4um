package bean;

public class Floor {
	
	private Integer boardid;
	private Integer postid;
	private Integer floorid;
	private Integer ansfloorid;
	private Integer userid;
	private String floortime;
	private String floorcontent;
	private Integer isGood;
	private Integer isBanned;
	private Integer isExist;
	
	public Floor() {}
	
	public Integer getBoardId() {
		return boardid;
	}
	public void setBoardId(Integer boardid) {
		this.boardid=boardid;
	}
	public Integer getPostId() {
		return postid;
	}
	public void setPostId(Integer postid) {
		this.postid=postid;
	}
	public Integer getFloorId() {
		return floorid;
	}
	public void setFloorId(Integer floorid) {
		this.floorid=floorid;
	}
	public Integer getAnsfloorId() {
		return ansfloorid;
	}
	public void setAnsfloorId(Integer ansfloorid) {
		this.ansfloorid=ansfloorid;
	}
	public Integer getUserId() {
		return userid;
	}
	public void setUserId(Integer userid) {
		this.userid=userid;
	}
	public String getFloortime() {
		return floortime;
	}
	public void setFloortime(String floortime) {
		this.floortime=floortime;
	}
	public String getFloorcontent() {
		return floorcontent;
	}
	public void setFloorcontent(String floorcontent) {
		this.floorcontent = floorcontent;
	}
	public Integer getIsGood() {
		return isGood;
	}
	public void setIsGood(Integer isGood) {
		this.isGood=isGood;
	}
	public Integer getIsBanned() {
		return isBanned;
	}
	public void setIsBanned(Integer isBanned) {
		this.isBanned=isBanned;
	}
	public Integer getIsExist() {
		return isExist;
	}
	public void setIsExist(Integer isExist) {
		this.isExist=isExist;
	}
}

