
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
	
	public Integer getReportid() {
		return reportid;
	}
	public void setReportid(Integer reportid) {
		this.reportid=reportid;
	}
	public Integer getBoardid() {
		return boardid;
	}
	public void setBoardid(Integer boardid) {
		this.boardid=boardid;
	}
	public Integer getPostid() {
		return postid;
	}
	public void setPostid(Integer postid) {
		this.postid=postid;
	}
	public Integer getFloorid() {
		return floorid;
	}
	public void setFloorid(Integer floorid) {
		this.floorid=floorid;
	}
	public Integer getUserid() {
		return userid;
	}
	public void setUserid(Integer userid) {
		this.userid=userid;
	}
	public String getReporttime() {
		return reporttime;
	}
	public void setReporttime(String reporttime) {
		this.reporttime=reporttime;
	}
	public String getReportbrief() {
		return reportbrief;
	}
	public void setReportbrief(String reportbrief) {
		this.reportbrief=reportbrief;
	}
	public String getReportcontent() {
		return reportcontent;
	}
	public void setReportcontent(String reportcontent) {
		this.reportcontent=reportcontent;
	}
	public Integer getIshandle() {
		return ishandle;
	}
	public void setIshandle(Integer ishandle) {
		this.ishandle=ishandle;
	}
}
