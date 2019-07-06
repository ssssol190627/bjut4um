package dao;

import java.sql.ResultSet;

import java.sql.SQLException;
import java.sql.Types;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import bean.*;

public class UserDao {

	/**
	 * @Fields jdbcTemplate : TODO
	 */

	private JdbcTemplate jdbcTemplate;

	/**
	 * spring閹绘劒绶甸惃鍕
	 * 
	 */
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	/**
	 * 閺屻儴顕楅幍锟介張澶婂缁墽娈戠敮鏍х摍
	 * 
	 */
	public List<Post> queryAllGoodPost() {
		String sql = "select * from post where isGood = 1";
		return jdbcTemplate.query(sql, new PostMapper());
	}

	/**
	 * 閺屻儴顕楅弻鎰緲閸ф澧嶉張澶婂缁墽娈戠敮鏍х摍
	 * 
	 */
	public List<Post> queryAllGoodPostInABoard(Integer boardid) {
		String sql = "select * from post where isGood = 1 and boardid =" + boardid;
		return jdbcTemplate.query(sql, new PostMapper());
	}

	/**
	 * 鐢牕鐡欓崝鐘电翱
	 * 
	 */
	public boolean addGood(Post post) {
		String sql = "UPDATE `post` SET `isGood` = '1' WHERE  (`id` = '" + post.getPostid() + "')";
		return jdbcTemplate.update(sql) == 1;
	}

	/**
	 * 
	 * 鐢牕鐡欓崢鑽ょ翱
	 * 
	 */
	public boolean deleteGood(Post post) {
		String sql = "UPDATE `post` SET `isGood` = '0' WHERE  (`id` = '" + post.getPostid() + "')";
		return jdbcTemplate.update(sql) == 1;
	}

	/**
	 * 通过用户名查询用户
	 * 
	 */
	public List<User> queryByName(String name) {
		String sql = "select id,username,password,email,isExist,isBoardAdmin,isForumAdmin from user where username = '"
				+ name + "'";
		return jdbcTemplate.query(sql, new UserMapper());
	}

	/**
	 * 通过邮箱查询用户
	 * 
	 */
	public List<User> queryByEmail(String email) {
		String sql = "select id,username,password,email,isExist,isBoardAdmin,isForumAdmin from user where email = '"
				+ email + "'";
		return jdbcTemplate.query(sql, new UserMapper());
	}

	/**
	 * 通过用户ID查询用户
	 * 
	 */
	public List<User> queryByID(Integer id) {
		String sql = "select * from user where id = " + id;
		return jdbcTemplate.query(sql, new UserMapper());
	}

	/**
	 * 获取最后一个用户
	 * 
	 */
	public List<User> forLastUser() {
		String sql = "select * from user order by id desc LIMIT 1";
		return jdbcTemplate.query(sql, new UserMapper());
	}

	/**
	 * 获取最后一个层数
	 * 
	 */
	public List<Floor> forLastFloor(int postid) {
		String sql = "select * from floor where postid =" + postid + " order by id desc LIMIT 1";
		return jdbcTemplate.query(sql, new FloorMapper());
	}

	/**
	 * 通过用户名查询用户发的帖子
	 * 
	 */
	public List<Post> queryForPostedByUser(Integer id) {
		String sql = "select * from post where userid = " + id;
		return jdbcTemplate.query(sql, new PostMapper());
	}

	/**
	 * 通过用户名查询用户回复的帖子
	 * 
	 */
	public List<Floor> queryForReplyedByUser(Integer id) {
		String sql = "select boardid,postid,id,ansfloorid,userid,floortime,floorcontent,isGood,isBanned,isExist from floor where userid = "
				+ id;
		return jdbcTemplate.query(sql, new FloorMapper());
	}

	/**
	 * 通过帖子ID查询回复楼层
	 * 
	 */
	public List<Floor> queryForReplyedByPost(Integer id) {
		String sql = "select * from floor where postid = " + id;
		return jdbcTemplate.query(sql, new FloorMapper());
	}

	/**
	 * 通过帖子ID查询帖子
	 * 
	 */
	public List<Post> queryForPostByPostId(Integer id) {
		String sql = "select * from post where id = " + id;
		return jdbcTemplate.query(sql, new PostMapper());
	}

	/**
	 * 查询所有帖子
	 * 
	 */
	public List<Post> queryForAllPost() {
		String sql = "select * from post";
		return jdbcTemplate.query(sql, new PostMapper());
	}

	/**
	 * 获取最后一个举报
	 * 
	 */
	public List<Report> forLastReport() {
		String sql = "select * from report order by reportid desc LIMIT 1";
		return jdbcTemplate.query(sql, new ReportMapper());
	}

	/**
	 * 更改用户密码
	 * 
	 */
	public boolean updatePassword(User user) {
		String sql = "update user set password = ? where id = ?";
		Object userObj[] = new Object[] { user.getPassword(), user.getId() };
		return jdbcTemplate.update(sql, userObj) == 1;
	}

    
    /**
     * 閫氳繃甯栧瓙ID鏌ヨ鎵�鏈夊洖澶嶆ゼ灞�
     * 
     */
    public List<Floor> queryForAllReplyedByPost(Integer id) {
    	String sql = "select * from floor where postid = "+id ;
    	return jdbcTemplate.query(sql, new FloorMapper());
    }
    
    
    /**
     * 濞ｈ濮為悽銊﹀煕
     * 
     */
    public boolean addUser(User user) {
	String sql = "insert into user(id,username,password,email,isExist,isBoardAdmin,isForumAdmin) values(?,?,?,?,?,?,?)";
	return jdbcTemplate.update(sql,
		new Object[] { user.getId(), user.getUsername(), user.getPassword(), user.getEmail(), user.getIsExist(), user.getIsBoardAdmin(), user.getIsForumAdmin()},
		new int[] { Types.INTEGER, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.INTEGER, Types.INTEGER, Types.INTEGER }) == 1;
    }
    
    /**
     * 濞ｈ濮炴稉鐐Г
     * 
     */
    public boolean addReport(Report report) {
	String sql = "insert into report(reportid,boardid,postid,floorid,userid,reporttime,reportbrief,reportcontent,isHandle) values(?,?,?,?,?,?,?,?,?)";
	return jdbcTemplate.update(sql,
		new Object[] { report.getReportid(), report.getBoardid(), report.getPostid(), report.getFloorid(), report.getUserid(), report.getReporttime(), report.getReportbrief(), report.getReportcontent(), report.getIshandle()},
		new int[] { Types.INTEGER, Types.INTEGER, Types.INTEGER, Types.INTEGER, Types.INTEGER, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.INTEGER }) == 1;
    }
    
    /**
     * 濞ｈ濮為崶鐐差槻濡ょ厧鐪�
     * 
     */
    public boolean addFloor(Floor floor) {
	String sql = "insert into floor(boardid,postid,id,ansfloorid,userid,floortime,floorcontent,isGood,isBanned,isExist) values(?,?,?,?,?,?,?,?,?,?)";
	return jdbcTemplate.update(sql,
		new Object[] { floor.getBoardid(), floor.getPostid(), floor.getFloorid(), floor.getAnsfloorid(), floor.getUserid(), floor.getFloortime(), floor.getFloorcontent(), floor.getIsGood(), floor.getIsBanned(), floor.getIsExist()},
		new int[] { Types.INTEGER, Types.INTEGER, Types.INTEGER, Types.INTEGER, Types.INTEGER, Types.VARCHAR, Types.VARCHAR, Types.INTEGER, Types.INTEGER, Types.INTEGER }) == 1;
    }
    
	/**
	 * 闁俺绻冮弶鍨健id閺屻儴顕楅弶鍨健
	 * 
	 */
	public List<Board> queryBoardByBoardId(int boardid) {
		String sql = "select id,name,intro,isExist from board where id = '" + boardid + "'";
		return jdbcTemplate.query(sql, new BoardMapper());
	}

	/**
	 * 闁俺绻冮弶鍨健id閺屻儴顕楃敮鏍х摍
	 * 
	 */
	public List<Post> queryPostByBoardId(int boardid) {
		String sql = "select boardid,id,title,userid,posttime,newTime,postcontent,numpost,isGood,isBanned,isExist from post where boardid = '"
				+ boardid + "'and isBanned = 0  and isExist = 1  ";
		return jdbcTemplate.query(sql, new PostMapper());
	}

	/**
	 * 閫氳繃鏉垮潡id鏌ヨ鎵�鏈夊笘瀛�
	 * 
	 */
	public List<Post> queryAllPostByBoardId(int boardid) {
		String sql = "select boardid,id,title,userid,posttime,newTime,postcontent,numpost,isGood,isBanned,isExist from post where boardid = '"
				+ boardid + "'  ";
		return jdbcTemplate.query(sql, new PostMapper());
	}

	/**
	 * 闁俺绻冮弶鍨健閸氬秵鐓＄拠锟�
	 * 
	 */
	public List<Board> queryByBoardName(String name) {
		String sql = "select id,name,intro,isExist from board where name = '" + name + "'";
		return jdbcTemplate.query(sql, new BoardMapper());
	}

	public List<Post> findThisBoardPage(int startIndex, int pageSize, int boardid) {
		String sql = "select boardid,id,title,userid,posttime,newTime,postcontent,numPost,isGood,isBanned,isExist from post where boardid = '"
				+ boardid + "' and isBanned = 0 and isExist = 1 ORDER BY newTime DESC limit " + startIndex + "," + pageSize;
		return jdbcTemplate.query(sql, new PostMapper());
	}

	public Page<Post> findAllPostWithPage(int pageNum, int pageSize, int boardid) {
		List<Post> allPost = queryPostByBoardId(boardid);
		int totalRecord = allPost.size();

		Page p = new Page(pageNum, pageSize, totalRecord);

		int startIndex = p.getStartIndex();
		List<Post> thisPagePostList = findThisBoardPage(startIndex, pageSize, boardid);
		p.setList(thisPagePostList);

		return p;
	}

	public List<Floor> findThisPostPage(int startIndex, int pageSize, int postid) {
		String sql = "select * from floor where postid = '" + postid + "'  and isExist = 1 limit " + startIndex + "," + pageSize;
		return jdbcTemplate.query(sql, new FloorMapper());
	}

	public Page<Floor> findAllFloorWithPage(int pageNum, int pageSize, int postid) {
		List<Floor> allFloor = queryForReplyedByPost(postid);
		int totalRecord = allFloor.size();

		Page p = new Page(pageNum, pageSize, totalRecord);

		int startIndex = p.getStartIndex();
		List<Floor> thisPagePostList = findThisPostPage(startIndex, pageSize, postid);
		p.setList(thisPagePostList);

		return p;
	}

	/**
	 * 鏌ヨ鎵�鏈夋澘鍧�
	 * 
	 * @return 杩斿洖鍊肩被鍨嬶細 List<Board>
	 * @author miuu
	 */
	public List<Board> queryAllBoard() {
		String sql = "select id,name,intro,isExist from board where id>0";
		// 灏嗘煡璇㈢粨鏋滄槧灏勫埌User绫讳腑锛屾坊鍔犲埌list涓紝骞惰繑鍥�
		return jdbcTemplate.query(sql, new BoardMapper());
	}

	/**
	 * 鏌ヨ鎵�鏈変妇鎶�
	 * 
	 */
	public List<Report> queryAllReport() {
		String sql = "select * from report";
		// 灏嗘煡璇㈢粨鏋滄槧灏勫埌User绫讳腑锛屾坊鍔犲埌list涓紝骞惰繑鍥�
		return jdbcTemplate.query(sql, new ReportMapper());
	}

	/**
	 * 閫氳繃reportid鏌ヨ涓炬姤
	 * 
	 */
	public List<Report> queryReportByReportId(int reportid) {
		String sql = "select * from report where reportid = " + reportid;
		return jdbcTemplate.query(sql, new ReportMapper());
	}

	/**
	 * 閫氳繃floorid鏌ヨ鍏蜂綋妤煎眰
	 * 
	 */
	public List<Floor> queryFloorByFloorIdandPostId(int floorid, int postid) {
		String sql = "select * from floor where id = " + floorid + " and postid = " + postid;
		return jdbcTemplate.query(sql, new FloorMapper());
	}

	/**
	 * 鏌ヨ鎵�鏈夋ゼ灞�
	 * 
	 */
	public List<Floor> queryAllFloor(Integer postid) {
		String sql = "select * from floor where postid = "+ postid ;
		// 灏嗘煡璇㈢粨鏋滄槧灏勫埌User绫讳腑锛屾坊鍔犲埌list涓紝骞惰繑鍥�
		return jdbcTemplate.query(sql, new FloorMapper());
	}

	/**
	 * 
	 * 
	 */
	public boolean updateHandle(Report report) {
		String sql = "update report set isHandle = ? where reportid = ?";
		Object reportObj[] = new Object[] { report.getIshandle(), report.getReportid() };
		return jdbcTemplate.update(sql, reportObj) == 1;
	}

	/**
	 * 
	 * 
	 */
	public boolean updatePost(Post post) {
		String sql = "update post set isBanned = ? , isExist = ? where id = ?";
		Object postObj[] = new Object[] { post.getIsBanned(), post.getIsExist(),post.getPostid() };
		return jdbcTemplate.update(sql, postObj) == 1;
	}
	
	/**
	 * 
	 * 
	 */
	public boolean updateReply(Post post) {
		String sql = "update post set numPost = ? , newTime = ? where id = ?";
		Object replyObj[] = new Object[] { post.getNumpost(), post.getNewtime(),post.getPostid() };
		return jdbcTemplate.update(sql, replyObj) == 1;
	}
	
	/**
	 * 
	 * 
	 */
	public boolean updateFloor(Floor floor) {
		String sql = "update floor set isBanned = ? , isExist = ? where postid = ? and id = ?";
		Object floorObj[] = new Object[] { floor.getIsBanned(), floor.getIsExist(),floor.getPostid(),floor.getFloorid() };
		return jdbcTemplate.update(sql, floorObj) == 1;
	}
	
	/**
	 * 娣诲姞甯栧瓙
	 * 
	 */
	public boolean addPost(Post post) {
		String sql = "insert into post(boardid,id,title,userid,posttime,newTime,postcontent,numPost,isGood,isBanned,isExist) values(?,?,?,?,?,?,?,?,?,?,?)";
		int a = 0;
		return jdbcTemplate.update(sql,
				new Object[] { post.getBoardid(), post.getPostid(), post.getTitle(), post.getUserid(),
						post.getPosttime(), post.getNewtime(), post.getPostcontent(),  post.getNumpost() ,post.getIsGood(),
						post.getIsBanned(), post.getIsExist()},
				new int[] { Types.INTEGER, Types.INTEGER, Types.VARCHAR, Types.INTEGER, Types.VARCHAR, Types.VARCHAR,
						Types.VARCHAR, Types.INTEGER, Types.INTEGER, Types.INTEGER, Types.INTEGER }) == 1;
	}

	/**
	 * 鏍规嵁鍏抽敭璇嶆ā绯婃煡璇�
	 * 
	 */
	public List<Post> findBooksAjax(String name) {
		String sql = "select distinct title from post where title like \"%" + name + "%\"";
		return jdbcTemplate.query(sql, new PostTitleMapper());
	}
	/**
	 * 鍦ㄤ竴涓澘鍧楅噷閫氳繃甯栧瓙title鏌ヨ甯栧瓙
	 * 
	 */
	public List<Post> queryForPostByPostTitleInABoard(String title, int boardid) {
		String sql = "select boardid,id,title,userid,posttime,newTime,postcontent,numpost,isGood,isBanned,isExist from post where title = '"
				+ title + "' and boardid = '" + boardid + "'";
		return jdbcTemplate.query(sql, new PostMapper());
	}

	/**
	 * 甯栧瓙灏佺
	 * 
	 */
	public boolean setBanned(Post post) {
		String sql = "UPDATE `post` SET `isBanned` = '1' WHERE  (`id` = '" + post.getPostid() + "')";
		return jdbcTemplate.update(sql) == 1;
	}

	/**
	 * 
	 * 甯栧瓙瑙ｅ皝
	 * 
	 */
	public boolean delBanned(Post post) {
		String sql = "UPDATE `post` SET `isBanned` = '0' WHERE  (`id` = '" + post.getPostid() + "')";
		return jdbcTemplate.update(sql) == 1;
	}

	/**
	 * 甯栧瓙鍒犻櫎
	 * 
	 */
	public boolean setDeleted(Post post) {
		String sql = "UPDATE `post` SET `isExist` = '0' WHERE  (`id` = '" + post.getPostid() + "')";
		return jdbcTemplate.update(sql) == 1;
	}

	/**
	 * 
	 * 甯栧瓙鎭㈠
	 * 
	 */
	public boolean delDeleted(Post post) {
		String sql = "UPDATE `post` SET `isExist` = '1' WHERE  (`id` = '" + post.getPostid() + "')";
		return jdbcTemplate.update(sql) == 1;
	}

	/**
	 * 鏌ヨ鎵�鏈夌郴缁熶俊鎭�
	 * 
	 */
	public List<Message> queryAllMessage() {
		String sql = "select * from message ";
		return jdbcTemplate.query(sql, new MessageMapper());
	}

	/**
	 * 娣诲姞message
	 * 
	 */
	public boolean addMessage(Message message) {
		String sql = "insert into message (`messageid`, `userid`, `messagetime`, `messagecontent`, `adminid`)  values(?,?,?,?,?)";
		return jdbcTemplate.update(sql,
				new Object[] { message.getMessageid(), message.getUserid(), message.getMessagetime(),
						message.getMessagecontent(), message.getAdminid() },
				new int[] { Types.INTEGER, Types.INTEGER, Types.VARCHAR, Types.VARCHAR, Types.INTEGER }) == 1;
	}

	/**
	 * 鑾峰彇鏈�鍚庝竴涓澘鍧楃敵璇�
	 * 
	 */
	public List<Applyingboard> forLastApplyingboard() {
		String sql = "select * from applyingboard order by applyingid desc LIMIT 1";
		return jdbcTemplate.query(sql, new ApplyingboardMapper());
	}

	/**
	 * 鑾峰彇鏈�鍚庝竴涓鐞嗗憳鐢宠
	 * 
	 */
	public List<Applyingadmin> forLastApplyingadmin() {
		String sql = "select * from applyingadmin order by applyingid desc LIMIT 1";
		return jdbcTemplate.query(sql, new ApplyingadminMapper());
	}

	/**
	 * 娣诲姞涓�涓澘鍧楃敵璇蜂俊鎭�
	 * 
	 */
	public boolean addApplyingboard(Applyingboard applyingboard) {
		String sql = "insert into applyingboard(applyingid,boardname,applyingreason,userid,applyingtime,ishandle) values(?,?,?,?,?,?)";
		return jdbcTemplate.update(sql,
				new Object[] { applyingboard.getApplyingid(), applyingboard.getBoardname(),
						applyingboard.getApplyingreason(), applyingboard.getUserid(), applyingboard.getApplytime(),
						applyingboard.getIshandle() },
				new int[] { Types.INTEGER, Types.VARCHAR, Types.VARCHAR, Types.INTEGER, Types.VARCHAR,
						Types.INTEGER }) == 1;
	}

	/**
	 * 娣诲姞涓�涓鐞嗗憳鐢宠淇℃伅
	 * 
	 */
	public boolean addApplyingadmin(Applyingadmin applyingadmin) {
		String sql = "insert into applyingadmin(applyingid,boardid,applyingreason,userid,applyingtime,ishandle) values(?,?,?,?,?,?)";
		return jdbcTemplate.update(sql,
				new Object[] { applyingadmin.getApplyingid(), applyingadmin.getBoardid(),
						applyingadmin.getApplyingreason(), applyingadmin.getUserid(), applyingadmin.getApplytime(),
						applyingadmin.getIshandle() },
				new int[] { Types.INTEGER, Types.INTEGER, Types.VARCHAR, Types.INTEGER, Types.VARCHAR,
						Types.INTEGER }) == 1;
	}

	/**
	 * 閫氳繃鐢ㄦ埛ID鏌ヨ宸叉彁浜よ繃鐨勭鐞嗗憳鐢宠
	 * 
	 */
	public List<Applyingadmin> queryAdminByUserid(Integer userid) {
		String sql = "select * from applyingadmin where userid = " + userid;
		return jdbcTemplate.query(sql, new ApplyingadminMapper());
	}

	/**
	 * 閫氳繃鐢ㄦ埛ID鏌ヨ宸叉彁浜よ繃鐨勬澘鍧楃敵璇�
	 * 
	 */
	public List<Applyingboard> queryBoardByUserid(Integer userid) {
		String sql = "select * from applyingboard where userid = " + userid;
		return jdbcTemplate.query(sql, new ApplyingboardMapper());
	}

	/**
	 * 閫氳繃鐢ㄦ埛ID鏌ヨ绯荤粺淇℃伅
	 * 
	 */
	public List<Message> queryMessageByUserid(Integer userid) {
		String sql = "select * from message where userid = " + userid;
		return jdbcTemplate.query(sql, new MessageMapper());
	}

	/**
	 * 鏌ヨ鍏ㄩ儴鏉垮潡鐢宠淇℃伅
	 * 
	 */
	public List<Applyingboard> queryAllApplyBoard() {
		String sql = "select * from applyingboard ";
		return jdbcTemplate.query(sql, new ApplyingboardMapper());
	}

	/**
	 * 鏌ヨ鍏ㄩ儴绠＄悊鍛樼敵璇蜂俊鎭�
	 * 
	 */
	public List<Applyingadmin> queryAllApplyAdmin() {
		String sql = "select * from applyingadmin ";
		return jdbcTemplate.query(sql, new ApplyingadminMapper());
	}

	/**
	 * 閫氳繃甯栧瓙title鏌ヨ甯栧瓙
	 * 
	 */
	public List<Post> queryForPostByPostTitle(String title) {
		String sql = "select boardid,id,title,userid,posttime,newTime,postcontent,numpost,isGood,isBanned,isExist from post where title = '"
				+ title + "'";
		return jdbcTemplate.query(sql, new PostMapper());

	}

	/**
	 * 閫氳繃鏉垮潡鐢宠id鏌ヨ鏉垮潡鐢宠
	 * 
	 */
	public List<Applyingboard> queryApplyboardById(Integer applyid) {
		String sql = "select * from applyingboard where applyingid =" + applyid;
		return jdbcTemplate.query(sql, new ApplyingboardMapper());
	}

	/**
	 * 鏇存柊鏉垮潡鐢宠澶勭悊淇℃伅
	 */
	public boolean updateApplyBoardHandle(Applyingboard applyboard) {
		String sql = "update applyingboard set ishandle = ? where applyingid = ?";
		Object applyboardObj[] = new Object[] { applyboard.getIshandle(), applyboard.getApplyingid() };
		return jdbcTemplate.update(sql, applyboardObj) == 1;
	}

	/**
	 * 鑾峰彇鏈�鍚庝竴涓澘鍧楃敵璇�
	 * 
	 */
	public List<Board> forLastBoard() {
		String sql = "select * from board order by id desc LIMIT 1";
		return jdbcTemplate.query(sql, new BoardMapper());
	}

	/**
	 * 娣诲姞鏉垮潡
	 * 
	 */
	public boolean addBoard(Board board) {
		String sql = "insert into board(id,name,intro,isExist) values(?,?,?,?)";
		return jdbcTemplate.update(sql,
				new Object[] { board.getBoardid(), board.getBoardname(), board.getBoardintro(), board.getBoardexist() },
				new int[] { Types.INTEGER, Types.VARCHAR, Types.VARCHAR, Types.INTEGER }) == 1;
	}

	/**
	 * 閫氳繃绠＄悊鍛樼敵璇穒d鏌ヨ绠＄悊鍛樼敵璇�
	 * 
	 */
	public List<Applyingadmin> queryApplyadminById(Integer applyid) {
		String sql = "select * from applyingadmin where applyingid =" + applyid;
		return jdbcTemplate.query(sql, new ApplyingadminMapper());
	}

	/**
	 * 鏇存柊绠＄悊鍛樼敵璇峰鐞嗕俊鎭�
	 */
	public boolean updateApplyAdminHandle(Applyingadmin applyadmin) {
		String sql = "update applyingadmin set ishandle = ? where applyingid = ?";
		Object applyadminObj[] = new Object[] { applyadmin.getIshandle(), applyadmin.getApplyingid() };
		return jdbcTemplate.update(sql, applyadminObj) == 1;
	}

	/**
	 * 鏇存柊鐢ㄦ埛绠＄悊鍛樹俊鎭�
	 */
	public boolean updateUseradmin(User user) {
		String sql = "update user set isBoardAdmin = ? where id = ?";
		Object userObj[] = new Object[] { user.getIsBoardAdmin(), user.getId() };
		return jdbcTemplate.update(sql, userObj) == 1;
	}
   
    
	/**
	 * 
	 * BoardMapper鏁版嵁搴撴槧灏�
	 * 
	 */
	class BoardMapper implements RowMapper<Board> {

		public Board mapRow(ResultSet rs, int rowNum) throws SQLException {
			// TODO Auto-generated method stub
			Board board = new Board();
			board.setBoardid(rs.getInt(1));
			board.setBoardname(rs.getString(2));
			board.setBoardintro(rs.getString(3));
			board.setBoardexist(rs.getInt(4));
			return board;
		}

	}

	/**
	 * 
	 * UserMapper鏁版嵁搴撴槧灏�
	 * 
	 */

	class UserMapper implements RowMapper<User> {

		public User mapRow(ResultSet rs, int rowNum) throws SQLException {
			// TODO Auto-generated method stub
			User User = new User();
			User.setId(rs.getInt(1));
			User.setUsername(rs.getString(2));
			User.setPassword(rs.getString(3));
			User.setEmail(rs.getString(4));
			User.setIsExist(rs.getInt(5));
			User.setIsBoardAdmin(rs.getInt(6));
			User.setIsForumAdmin(rs.getInt(7));

			return User;
		}

	}

	/**
	 * 
	 * PostTitleMapper鏁版嵁搴撴槧灏�
	 * 
	 */
	class PostTitleMapper implements RowMapper<Post> {

		public Post mapRow(ResultSet rs, int rowNum) throws SQLException {
			// TODO Auto-generated method stub
			Post Post = new Post();
			Post.setBoardid(0);
			Post.setPostid(0);
			Post.setTitle(rs.getString(1));
			Post.setUserid(0);
			Post.setPosttime("");
			Post.setNewtime("");
			Post.setPostcontent("");
			Post.setNumpost(0);
			Post.setIsGood(0);
			Post.setIsBanned(0);
			Post.setIsExist(0);

			return Post;
		}
	}
    
    
    /**
     * 
     * PostMapper鏁版嵁搴撴槧灏�
     * 
     */
    class PostMapper implements RowMapper<Post> {

    	public Post mapRow(ResultSet rs, int rowNum) throws SQLException {
    		// TODO Auto-generated method stub
    		Post Post = new Post();
    		Post.setBoardid(rs.getInt(1));
    		Post.setPostid(rs.getInt(2));
    		Post.setTitle(rs.getString(3));
    		Post.setUserid(rs.getInt(4));
    		Post.setPosttime(rs.getString(5));
    		Post.setNewtime(rs.getString(6));
    		Post.setPostcontent(rs.getString(7));
    		Post.setNumpost(rs.getInt(8));
    		Post.setIsGood(rs.getInt(9));
    		Post.setIsBanned(rs.getInt(10));
    		Post.setIsExist(rs.getInt(11));

    		return Post;
    	}

    }
    
    /**
     * 
     * FloorMapper鏁版嵁搴撴槧灏�
     * 
     */
    class FloorMapper implements RowMapper<Floor> {

    	public Floor mapRow(ResultSet rs, int rowNum) throws SQLException {
    		// TODO Auto-generated method stub
    		Floor Floor = new Floor();
    		Floor.setBoardid(rs.getInt(1));
    		Floor.setPostid(rs.getInt(2));
    		Floor.setFloorid(rs.getInt(3));
    		Floor.setAnsfloorid(rs.getInt(4));
    		Floor.setUserid(rs.getInt(5));
    		Floor.setFloortime(rs.getString(6));
    		Floor.setFloorcontent(rs.getString(7));
    		Floor.setIsGood(rs.getInt(8));
    		Floor.setIsBanned(rs.getInt(9));
    		Floor.setIsExist(rs.getInt(10));

    		return Floor;
    	}
    }
    
    /**
     * 
     * ReportMapper鏁版嵁搴撴槧灏�
     * 
     */
    class ReportMapper implements RowMapper<Report> {

    	public Report mapRow(ResultSet rs, int rowNum) throws SQLException {
    		// TODO Auto-generated method stub
    		Report Report = new Report();
    		Report.setReportid(rs.getInt(1));
    		Report.setBoardid(rs.getInt(2));
    		Report.setPostid(rs.getInt(3));
    		Report.setFloorid(rs.getInt(4));
    		Report.setUserid(rs.getInt(5));
    		Report.setReporttime(rs.getString(6));
    		Report.setReportbrief(rs.getString(7));
    		Report.setReportcontent(rs.getString(8));
    		Report.setIshandle(rs.getInt(9));

    		return Report;
    	}
    }

    
    /**
     * 
     * ApplyingboardMapper鏁版嵁搴撴槧灏�
     * 
     */

    class ApplyingboardMapper implements RowMapper<Applyingboard> {

    	public Applyingboard mapRow(ResultSet rs, int rowNum) throws SQLException {
    		// TODO Auto-generated method stub
    		Applyingboard Applyingboard = new Applyingboard();
    		Applyingboard.setApplyingid(rs.getInt(1));
    		Applyingboard.setBoardname(rs.getString(2));
    		Applyingboard.setApplyingreason(rs.getString(3));
    		Applyingboard.setUserid(rs.getInt(4));
    		Applyingboard.setApplytime(rs.getString(5));
    		Applyingboard.setIshandle(rs.getInt(6));

    		return Applyingboard;
    	}

    }
    
    /**
     * 
     * ApplyingadminMapper鏁版嵁搴撴槧灏�
     * 
     */

    class ApplyingadminMapper implements RowMapper<Applyingadmin> {

    	public Applyingadmin mapRow(ResultSet rs, int rowNum) throws SQLException {
    		// TODO Auto-generated method stub
    		Applyingadmin Applyingadmin = new Applyingadmin();
    		Applyingadmin.setApplyingid(rs.getInt(1));
    		Applyingadmin.setBoardid(rs.getInt(2));
    		Applyingadmin.setApplyingreason(rs.getString(3));
    		Applyingadmin.setUserid(rs.getInt(4));
    		Applyingadmin.setApplytime(rs.getString(5));
    		Applyingadmin.setIshandle(rs.getInt(6));

    		return Applyingadmin;
    	}

    }
    
    /**
     * 
     * MessageMapper鏁版嵁搴撴槧灏�
     * 
     */

    class MessageMapper implements RowMapper<Message> {

    	public Message mapRow(ResultSet rs, int rowNum) throws SQLException {
    		// TODO Auto-generated method stub
    		Message Message = new Message();
    		Message.setMessageid(rs.getInt(1));
    		Message.setUserid(rs.getInt(2));
    		Message.setMessagetime(rs.getString(3));
    		Message.setMessagecontent(rs.getString(4));
    		Message.setAdminid(rs.getInt(5));

    		return Message;
    	}

    }

}

