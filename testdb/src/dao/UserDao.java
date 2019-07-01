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
     * 查询所有学生
     * 
     * @return 返回值类型： List<User>
     * @author janinus
     */
    public List<User> queryAll() {
	String sql = "select id,name,javaScore,htmlScore,cssScore from User";
	//将查询结果映射到User类中，添加到list中，并返回
	return jdbcTemplate.query(sql, new UserMapper());
    }

    /**
     * 通过用户名查询
     * 
     */
    public List<User> queryByName(String name) {
    	String sql = "select id,username,password,email,isExist,isBroadAdmin,isForumAdmin from user where username = '"+name +"'" ;
    	return jdbcTemplate.query(sql, new UserMapper());
    }

    /**
     * 通过用户名查询用户发的帖子
     * 
     */
    public List<Post> queryForPostedByUser(Integer id) {
    	String sql = "select boardid,id,title,userid,posttime,newTime,postcontent,isGood,isBanned,isExist,numpost from post where userid =  '"+id +"'" ;
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
     * 更改用户密码
     * 
     */
    public boolean updatePassword(User user) {
    	String sql = "update User set password = ? where id = ?";
    	Object userObj[] = new Object[] { user.getPassword(), user.getId() };
    	return jdbcTemplate.update(sql, userObj) == 1;
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
    		Post.setIsGood(rs.getInt(8));
    		Post.setIsBanned(rs.getInt(9));
    		Post.setIsExist(rs.getInt(10));
    		Post.setNumpost(rs.getInt(11));

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
}