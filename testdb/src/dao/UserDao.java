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
    	String sql = "select * from post where postid = "+id ;
    	return jdbcTemplate.query(sql, new PostMapper());
    }
    
    /** 
     * 获取最后一个举报
    * 
    */
   public List<Report> forLastReport() {
	   String sql = "select * from report order by id desc LIMIT 1" ;
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
		new Object[] { report.getReportId(), report.getBoardId(), report.getPostId(), report.getFloorId(), report.getUserId(), report.getReportTime(), report.getReportBrief(), report.getReportContent(), report.getIsHandle()},
		new int[] { Types.INTEGER, Types.INTEGER, Types.INTEGER, Types.INTEGER, Types.INTEGER, Types.DATE, Types.VARCHAR, Types.VARCHAR, Types.INTEGER }) == 1;
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
	
	public List<Post> findThisPostPage(int startIndex,int pageSize,int boardid){
		int EndIndex=startIndex+pageSize;
		String sql = "select boardid,id,title,userid,posttime,newTime,postcontent,isGood,isBanned,isExist,numpost from post where boardid = '" + boardid +"' limit "+startIndex+","+EndIndex;
		return jdbcTemplate.query(sql, new PostMapper());
	}
	public Page<Post> findAllPostWithPage(int pageNum,int pageSize,int boardid){
		List<Post> allPost=queryPostByBoardId(boardid);
		int totalRecord = allPost.size();
		
		Page p=new Page(pageNum,2,totalRecord);
		
		int startIndex = p.getStartIndex();
		p.setList(findThisPostPage(startIndex,pageSize,boardid));
		
		return p;
	}
	
    /**
	 * 查询所有板块
	 * 
	 * @return 返回值类型： List<Board>
	 * @author miuu
	 */
	public List<Board> queryAllBoard() {
		String sql = "select id,name,intro,isExist from board";
		// 将查询结果映射到User类中，添加到list中，并返回
		return jdbcTemplate.query(sql, new BoardMapper());
	}
	

    /**
     * 删除学生
     * 
     * @param id
     * @return 返回值类型： boolean
     * @author janinus
     */
    public boolean deleteStu(Integer id) {
	String sql = "delete from User where id = ?";
	return jdbcTemplate.update(sql, id) == 1;
    }

    /**
     * 更新学生信息
     * 
     * @param User
     * @return 返回值类型： boolean
     * @author janinus
     */
    /*public boolean updateStu(User User) {
	String sql = "update User set name=? ,javaScore=?,htmlScore = ? ,cssScore = ?,totalScore = ? where id = ?";
	Object stuObj[] = new Object[] { User.getUsername(), User.getJavaScore(), User.getHtmlScore(),
		User.getCssScore(), User.getJavaScore()+User.getHtmlScore()+User.getCssScore(), User.getId() };
	return jdbcTemplate.update(sql, stuObj) == 1;
    }*/

    /**
     * 返回总成绩前n名学生
     * 
     * @param num
     * @return 返回值类型： List<User>
     * @author janinus
     */
   /* public List<User> topNum(int num) {
	String sql = "select id,name,javaScore+htmlScore+cssScore from User order by javaScore+htmlScore+cssScore desc ,name asc limit ?";
	return jdbcTemplate.query(sql, new RowMapper<User>() {

	    @Override
	    public User mapRow(ResultSet rs, int rowNum) throws SQLException {
		// TODO Auto-generated method stub
		User User = new User();
		User.setId(rs.getInt(1));
		User.setUsername(rs.getString(2));
		User.setTotalScore(rs.getDouble(3));
		return User;
	    }
	}, num);
    }*/
    
	/**
	 * 
	 * BoardMapper数据库映射
	 * 
	 */
	class BoardMapper implements RowMapper<Board> {

		public Board mapRow(ResultSet rs, int rowNum) throws SQLException {
			// TODO Auto-generated method stub
			Board board = new Board();
			board.setBoardId(rs.getInt(1));
			board.setBoardName(rs.getString(2));
			board.setBoardintro(rs.getString(3));
			board.setBoardExist(rs.getInt(4));
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
    		Floor.setBoardId(rs.getInt(1));
    		Floor.setPostId(rs.getInt(2));
    		Floor.setFloorId(rs.getInt(3));
    		Floor.setAnsfloorId(rs.getInt(4));
    		Floor.setUserId(rs.getInt(5));
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
     * ReportMapper数据库映射
     * 
     */
    class ReportMapper implements RowMapper<Report> {

    	public Report mapRow(ResultSet rs, int rowNum) throws SQLException {
    		// TODO Auto-generated method stub
    		Report Report = new Report();
    		Report.setReportId(rs.getInt(1));
    		Report.setBoardId(rs.getInt(2));
    		Report.setPostId(rs.getInt(3));
    		Report.setFloorId(rs.getInt(4));
    		Report.setUserId(rs.getInt(5));
    		Report.setReportTime(rs.getString(6));
    		Report.setReportBrief(rs.getString(7));
    		Report.setReportContent(rs.getString(8));
    		Report.setIsHandle(rs.getInt(9));

    		return Report;
    	}

    }
}
