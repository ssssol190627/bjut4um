package bean;

public class Board {
	
	private int boardid;
	public String boardname;
	private String intro;
	private Integer isExist;
	
	
	
	public Board() {}
	
	public int getBoardid() {
		return boardid;
	}
	public void setBoardid(int boardid) {
		this.boardid=boardid;
	}
	
	public String getBoardname() {
		return boardname;
	}
	public void setBoardname(String boardname) {
		this.boardname=boardname;
	}
	public String getBoardintro() {
		return intro;
	}
	public void setBoardintro(String intro) {
		this.intro=intro;
	}
	public Integer getIsExist() {
		return isExist;
	}
	public void setIsExist(Integer isExist) {
		this.isExist=isExist;
	}
}
