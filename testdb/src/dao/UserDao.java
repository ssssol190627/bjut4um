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
     * spring提供的类
     * 
     */
    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
	this.jdbcTemplate = jdbcTemplate;
    }

    /**
     * 通过用户名查询用户
     * 
     */
    public List<User> queryByName(String name) {
    	String sql = "select id,username,password,email,isExist,isBroadAdmin,isForumAdmin from user where username = '"+name +"'" ;
    	return jdbcTemplate.query(sql, new UserMapper());
    }
    
    /**
     * 通过邮箱查询用户
     * 
     */
    public List<User> queryByEmail(String email) {
    	String sql = "select id,username,password,email,isExist,isBroadAdmin,isForumAdmin from user where email = '"+email +"'" ;
    	return jdbcTemplate.query(sql, new UserMapper());
    }
    
    /**
     * 通过用户ID查询用户
     * 
     */
    public List<User> queryByID(Integer id) {
    	String sql = "select * from user where id = "+id ;
    	return jdbcTemplate.query(sql, new UserMapper());
    }
    
    /** 
     * 获取最后一个用户
    * 
    */
   public List<User> forLastUser() {
	    String sql = "select * from user order by id desc LIMIT 1" ;
   		return jdbcTemplate.query(sql, new UserMapper());
   }
   
   /** 
    * 获取最后一个层数
   * 
   */
  public List<Floor> forLastFloor(int postid) {
	   String sql = "select * from floor where postid ="+postid+" order by id desc LIMIT 1";
	   return jdbcTemplate.query(sql, new FloorMapper());
  }

    /**
     * 通过用户名查询用户发的帖子
     * 
     */
    public List<Post> queryForPostedByUser(Integer id) {
    	String sql = "select * from post where userid = "+id ;
    	return jdbcTemplate.query(sql, new PostMapper());
    }
    
    /**
     * 通过用户名查询用户回复的帖子
     * 
     */
    public List<Floor> queryForReplyedByUser(Integer id) {
    	String sql = "select boardid,postid,id,ansfloorid,userid,floortime,floorcontent,isGood,isBanned,isExist from floor where userid = "+id ;
    	return jdbcTemplate.query(sql, new FloorMapper());
    }
    
    /**
     * 通过帖子ID查询回复楼层
     * 
     */
    public List<Floor> queryForReplyedByPost(Integer id) {
    	String sql = "select * from floor where postid = "+id ;
    	return jdbcTemplate.query(sql, new FloorMapper());
    }
    
    /**
     * 通过帖子ID查询帖子
     * 
     */
    public List<Post> queryForPostByPostId(Integer id) {
    	String sql = "select * from post where id = "+id ;
    	return jdbcTemplate.query(sql, new PostMapper());
    }
    
    /** 
     * 获取最后一个举报
    * 
    */
   public List<Report> forLastReport() {
	   String sql = "select * from report order by reportid desc LIMIT 1" ;
   		return jdbcTemplate.query(sql, new ReportMapper());
   }
    
    /**
     * 更改用户密码
     * 
     */
    public boolean updatePassword(User user) {
    	String sql = "update User set password = ? where id = ?";
    	Object userObj[] = new Object[] { user.getPassword(), user.getId() };
    	return jdbcTemplate.update(sql, userObj) == 1;
    }
    
    /**
     * 添加用户
     * 
     */
    public boolean addUser(User user) {
	String sql = "insert into user(id,username,password,email,isExist,isBroadAdmin,isForumAdmin) values(?,?,?,?,?,?,?)";
	return jdbcTemplate.update(sql,
		new Object[] { user.getId(), user.getUsername(), user.getPassword(), user.getEmail(), user.getisExist(), user.getisBoardAdmin(), user.getisForumAdmin()},
		new int[] { Types.INTEGER, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.INTEGER, Types.INTEGER, Types.INTEGER }) == 1;
    }
    
    /**
     * 添加举报
     * 
     */
    public boolean addReport(Report report) {
	String sql = "insert into Report(reportid,boardid,postid,floorid,userid,reporttime,reportbrief,reportcontent,isHandle) values(?,?,?,?,?,?,?,?,?)";
	return jdbcTemplate.update(sql,
		new Object[] { report.getReportid(), report.getBoardid(), report.getPostid(), report.getFloorid(), report.getUserid(), report.getReporttime(), report.getReportbrief(), report.getReportcontent(), report.getIshandle()},
		new int[] { Types.INTEGER, Types.INTEGER, Types.INTEGER, Types.INTEGER, Types.INTEGER, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.INTEGER }) == 1;
    }
    
    /**
     * 添加回复楼层
     * 
     */
    public boolean addFloor(Floor floor) {
	String sql = "insert into floor(boardid,postid,id,ansfloorid,userid,floortime,floorcontent,isGood,isBanned,isExist) values(?,?,?,?,?,?,?,?,?,?)";
	return jdbcTemplate.update(sql,
		new Object[] { floor.getBoardid(), floor.getPostid(), floor.getFloorid(), floor.getAnsfloorid(), floor.getUserid(), floor.getFloortime(), floor.getFloorcontent(), floor.getIsgood(), floor.getIsbanned(), floor.getIsexist()},
		new int[] { Types.INTEGER, Types.INTEGER, Types.INTEGER, Types.INTEGER, Types.INTEGER, Types.VARCHAR, Types.VARCHAR, Types.INTEGER, Types.INTEGER, Types.INTEGER }) == 1;
    }
    
	/**
	 * 通过板块id查询板块
	 * 
	 */
	public List<Board> queryBoardByBoardId(int boardid) {
		String sql = "select id,name,intro,isExist from board where id = '" + boardid + "'";
		return jdbcTemplate.query(sql, new BoardMapper());
	}
	
	/**
	 * 通过板块id查询帖子
	 * 
	 */
	public List<Post> queryPostByBoardId(int boardid) {
		String sql = "select boardid,id,title,userid,posttime,newTime,postcontent,isGood,isBanned,isExist,numpost from post where boardid = '" + boardid + "'";
		return jdbcTemplate.query(sql, new PostMapper());
	}
	
	/**
	 * 通过板块名查询
	 * 
	 */
	public List<Board> queryByBoardName(String name) {
		String sql = "select id,name,intro,isExist from board where name = '" + name + "'";
		return jdbcTemplate.query(sql, new BoardMapper());
	}
	
	public List<Post> findThisBoardPage(int startIndex,int pageSize,int boardid){
		String sql = "select boardid,id,title,userid,posttime,newTime,postcontent,isGood,isBanned,isExist,numpost from post where boardid = '" + boardid +"' limit "+startIndex+","+pageSize;
		return jdbcTemplate.query(sql, new PostMapper());
	}
	
	public Page<Post> findAllPostWithPage(int pageNum,int pageSize,int boardid){
		List<Post> allPost=queryPostByBoardId(boardid);
		int totalRecord = allPost.size();
		
		Page p=new Page(pageNum,2,totalRecord);
		
		int startIndex = p.getStartIndex();
		List<Post> thisPagePostList=findThisBoardPage(startIndex,pageSize,boardid);
		p.setList(thisPagePostList);
		
		return p;
	}
	
	public List<Floor> findThisPostPage(int startIndex,int pageSize,int postid){
		String sql = "select * from floor where postid = '" + postid +"' limit "+startIndex+","+pageSize;
		return jdbcTemplate.query(sql, new FloorMapper());
	}
	
	public Page<Floor> findAllFloorWithPage(int pageNum,int pageSize,int postid){
		List<Floor> allFloor=queryForReplyedByPost(postid);
		int totalRecord = allFloor.size();
		
		Page p=new Page(pageNum,2,totalRecord);
		
		int startIndex = p.getStartIndex();
		List<Floor> thisPagePostList=findThisPostPage(startIndex,pageSize,postid);
		p.setList(thisPagePostList);
		
		return p;
	}
	
    /**
	 * 查询所有板块
	 * 
	 * @return 返回值类型： List<Board>
	 * @author miuu
	 */
	public List<Board> queryAllBoard() {
		String sql = "select id,name,intro,isExist from board where id>0";
		// 将查询结果映射到User类中，添加到list中，并返回
		return jdbcTemplate.query(sql, new BoardMapper());
	}
	
    /**
	 * 查询所有举报
	 * 
	 */
	public List<Report> queryAllReport() {
		String sql = "select * from report";
		// 将查询结果映射到User类中，添加到list中，并返回
		return jdbcTemplate.query(sql, new ReportMapper());
	}
	
	/**
	 * 通过reportid查询举报
	 * 
	 */
	public List<Report> queryReportByReportId(int reportid) {
		String sql = "select * from report where reportid = " + reportid;
		return jdbcTemplate.query(sql, new ReportMapper());
	}
	
	/**
	 * 通过floorid查询具体楼层
	 * 
	 */
	public List<Floor> queryFloorByFloorId(int floorid) {
		String sql = "select * from floor where id = " + floorid;
		return jdbcTemplate.query(sql, new FloorMapper());
	}
	
	/**
	 * 通过floorid查询具体楼层
	 * 
	 */
	public boolean updateHandle(Report report) {
		String sql = "update Report set isHandle = ? where reportid = ?";
    	Object reportObj[] = new Object[] { report.getIshandle(), report.getReportid() };
    	return jdbcTemplate.update(sql, reportObj) == 1;
	}
	
    /** 
     * 获取最后一个板块申请
    * 
    */
   public List<Applyingboard> forLastApplyingboard() {
	   String sql = "select * from applyingboard order by applyingid desc LIMIT 1" ;
   		return jdbcTemplate.query(sql, new ApplyingboardMapper());
   }
   
   /** 
    * 获取最后一个管理员申请
   * 
   */
  public List<Applyingadmin> forLastApplyingadmin() {
	   String sql = "select * from applyingadmin order by applyingid desc LIMIT 1" ;
  		return jdbcTemplate.query(sql, new ApplyingadminMapper());
  }
   
   /**
    * 添加一个板块申请信息
    * 
    */
   public boolean addApplyingboard(Applyingboard applyingboard) {
	String sql = "insert into applyingboard(applyingid,boardname,applyingreason,userid,applyingtime,ishandle) values(?,?,?,?,?,?)";
	return jdbcTemplate.update(sql,
		new Object[] { applyingboard.getApplyingid(), applyingboard.getBoardname(), applyingboard.getApplyingreason(), applyingboard.getUserid(), applyingboard.getApplytime(), applyingboard.getIshandle()},
		new int[] { Types.INTEGER, Types.VARCHAR, Types.VARCHAR, Types.INTEGER, Types.VARCHAR, Types.INTEGER }) == 1;
   }
   
   /**
    * 添加一个管理员申请信息
    * 
    */
   public boolean addApplyingadmin(Applyingadmin applyingadmin) {
	String sql = "insert into applyingadmin(applyingid,boardid,applyingreason,userid,applyingtime,ishandle) values(?,?,?,?,?,?)";
	return jdbcTemplate.update(sql,
		new Object[] { applyingadmin.getApplyingid(), applyingadmin.getBoardid(), applyingadmin.getApplyingreason(), applyingadmin.getUserid(), applyingadmin.getApplytime(), applyingadmin.getIshandle()},
		new int[] { Types.INTEGER, Types.INTEGER, Types.VARCHAR, Types.INTEGER, Types.VARCHAR, Types.INTEGER }) == 1;
   }
   
   /**
    * 通过用户ID查询已提交过的管理员申请
    * 
    */
   public List<Applyingadmin> queryAdminByUserid(Integer userid){
	   String sql = "select * from applyingadmin where userid = " + userid;
	   return jdbcTemplate.query(sql, new ApplyingadminMapper());
   }
   
   /**
    * 通过用户ID查询已提交过的板块申请
    * 
    */
   public List<Applyingboard> queryBoardByUserid(Integer userid){
	   String sql = "select * from applyingboard where userid = " + userid;
	   return jdbcTemplate.query(sql, new ApplyingboardMapper());
   }
   
   /**
    * 通过用户ID查询系统信息
    * 
    */
   public List<Message> queryMessageByUserid(Integer userid){
	   String sql = "select * from message where userid = " + userid;
	   return jdbcTemplate.query(sql, new MessageMapper());
   }
    
	/**
	 * 
	 * BoardMapper数据库映射
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
     * UserMapper数据库映射
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
    		User.setisExist(rs.getInt(5));
    		User.setisBoardAdmin(rs.getInt(6));
    		User.setisForumAdmin(rs.getInt(7));

    		return User;
    	}

    }
    
    /**
     * 
     * PostMapper数据库映射
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
     * FloorMapper数据库映射
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
    		Floor.setIsgood(rs.getInt(8));
    		Floor.setIsbanned(rs.getInt(9));
    		Floor.setIsexist(rs.getInt(10));

    		return Floor;
    	}
    }
    
    /**
     * 
     * ReportMapper数据库映射
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
     * ApplyingboardMapper数据库映射
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
     * ApplyingadminMapper数据库映射
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
     * MessageMapper数据库映射
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
