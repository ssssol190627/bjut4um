package bean;

public class Board {
	
	private Integer boardid;
	private String boardname;
	private String intro;
	private int isExist;
	
	public Board() {}
	
	public Integer getBoardid() {
		return boardid;
	}
	public void setBoardid(Integer boardid) {
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
	public Integer getBoardexist() {
		return isExist;
	}
	public void setBoardexist(Integer isExist) {
		this.isExist=isExist;
	}
}
