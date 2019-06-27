package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import bean.User;
import bean.Post;
import bean.Board;

public class UserDao {

    /**
     * @Fields jdbcTemplate : TODO
     */

    private JdbcTemplate jdbcTemplate;

    /**
     * spring提供的类
     * 
     * @param jdbcTemplate
     *            返回值类型： void
     * @author janinus
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
     * 通过用户名查询
     * 
     */
    public List<Post> queryForPostedByUser(Integer id) {
    	String sql = "select boardid,postid,title,userid,posttime,postcontent,isGood,isBanned,isExist from post where userid = "+id ;
    	return jdbcTemplate.query(sql, new PostMapper());
    }
    
    /**
     * 添加学生
     * 
     * @param User
     * @return 返回值类型： boolean
     * @author janinus
     */
   /* public boolean addStu(User User) {
	String sql = "insert into User(id,name,javaScore,htmlScore,cssScore,totalScore) values(100,?,?,?,?,?)";
	return jdbcTemplate.update(sql,
		new Object[] { User.getUsername(), User.getJavaScore(), User.getHtmlScore(),
			User.getCssScore(), User.getJavaScore()+User.getHtmlScore()+User.getCssScore()},
		new int[] { Types.VARCHAR, Types.DOUBLE, Types.DOUBLE, Types.DOUBLE , Types.DOUBLE}) == 1;
    }*/

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
    		Post.setPostcontent(rs.getString(6));
    		Post.setIsGood(rs.getInt(7));
    		Post.setIsBanned(rs.getInt(8));
    		Post.setIsExist(rs.getInt(9));

    		return Post;
    	}

    }
    
    
}

