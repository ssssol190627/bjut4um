package bean;

public class Board {
	
	private Integer boardid;
	private String boardname;
	private String intro;
	private Integer isExist;
	
	public Board() {}
	
	public Integer getBoardId() {
		return boardid;
	}
	public void setBoardId(Integer boardid) {
		this.boardid=boardid;
	}
	public String getBoardName() {
		return boardname;
	}
	public void setBoardName(String boardname) {
		this.boardname=boardname;
	}
	public String getBoardintro() {
		return intro;
	}
	public void setBoardintro(String intro) {
		this.intro=intro;
	}
	public Integer getBoardExist() {
		return isExist;
	}
	public void setBoardExist(Integer isExist) {
		this.isExist=isExist;
	}
}
