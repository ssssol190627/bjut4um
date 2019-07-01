package bean;

public class Report {
	private Integer reportid;
	private Integer boardid;
	private Integer postid;
	private Integer floorid;
	private Integer userid;
	private String reporttime;
	private String reportbrief;
	private String reportcontent;
	private Integer ishandle;
	
	public Report() {}
	
	public Integer getReportId() {
		return reportid;
	}
	public void setReportId(Integer reportid) {
		this.reportid=reportid;
	}
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
	public Integer getUserId() {
		return userid;
	}
	public void setUserId(Integer userid) {
		this.userid=userid;
	}
	public String getReportTime() {
		return reporttime;
	}
	public void setReportTime(String reporttime) {
		this.reporttime=reporttime;
	}
	public String getReportBrief() {
		return reportbrief;
	}
	public void setReportBrief(String reportbrief) {
		this.reportbrief=reportbrief;
	}
	public String getReportContent() {
		return reportcontent;
	}
	public void setReportContent(String reportcontent) {
		this.reportcontent=reportcontent;
	}
	public Integer getIsHandle() {
		return ishandle;
	}
	public void setIsHandle(Integer ishandle) {
		this.ishandle=ishandle;
	}
}
