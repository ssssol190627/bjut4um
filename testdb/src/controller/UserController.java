package controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.*;

import bean.*;
import dao.UserDao;





@Controller
public class UserController {

	/**
	 * 
	 * 返回主页界面
	 * 
	 */
	@RequestMapping(value = "/home1")
	public String toHome1(Model model, HttpSession session) {
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		UserDao dao = (UserDao) context.getBean("dao");
		List<Board> board = dao.queryAllBoard();
		if (board.isEmpty()) {
			return "/login.jsp";
		} else if (session.getAttribute("CurrentUser") == null) {
			return "/index.jsp";
		} else {
			model.addAttribute("AllBoard", board);
			session.setAttribute("AllBoard", board);
			return "/home1.jsp";
		}
	}

	/**
	 * 
	 * 进入板块
	 * 
	 */
	@RequestMapping(value = "/board/{boardid}")
	public String enterBoard(@PathVariable int boardid, Model model, HttpSession session, HttpServletRequest request) {
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		UserDao dao = (UserDao) context.getBean("dao");

		int pageNum = 1;
		if (request.getQueryString() != null) {
			pageNum = Integer.parseInt(request.getParameter("page").toString());
		}
		int pageSize = 2;
		Page p = dao.findAllPostWithPage(pageNum, pageSize, boardid);
		model.addAttribute("page", p);
		session.setAttribute("page", p);
		int si = p.getStartIndex();
		List<Post> pl = p.getList();
		List<Board> bl = dao.queryBoardByBoardId(boardid);
		Board nowboard = bl.get(0);
		//List<User> ul;
	   	List<String> ul=new ArrayList();
    	for (int i = 0; i < pl.size(); i++) {
    		String thisuser = dao.queryByID(pl.get(i).getUserid()).get(0).getUsername();
			ul.add(thisuser);
		}

		// User user=queryUserNameById()
		String boardname = nowboard.getBoardname();
		model.addAttribute("nowBoardName", boardname);
		model.addAttribute("nowBoardId", boardid);
    	model.addAttribute("postuser", ul);
    	session.setAttribute("postuser", ul);
		model.addAttribute("CurrentPost", pl);
		return "/board1.jsp";
	}



	/**
	 * 
	 * 跳转登录界面
	 * 
	 */
	@RequestMapping(value = "/loginpage")
	public String toLoginpage() {
		return "login.jsp";
	}

	/**
	 * 
	 * 登录
	 * 
	 */
	@RequestMapping(value = "/login")
	public String CheckLogin(@RequestParam("username") String username, @RequestParam("password") String password,
			Model model, HttpSession session) {
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");

		UserDao dao = (UserDao) context.getBean("dao");
		List<User> user = dao.queryByName(username);
		if (user.isEmpty()) {
			return "login.jsp";
		}
		if (user.get(0).getPassword().equals(password)) {
			
			
			model.addAttribute("CurrentUser", user.get(0));
			session.setAttribute("CurrentUser", user.get(0));
			return "home1.jsp";
		} else {
			return "login.jsp";
		}
	}

	/**
	 * 
	 * 进入个人中心界面，显示“我的帖子”，“我的回帖”
	 * 
	 */
	@RequestMapping(value = "/accountCenter")
	public String toAccountCenter(Model model, HttpSession session) {
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		User currentuser = (User) session.getAttribute("CurrentUser");
		UserDao dao = (UserDao) context.getBean("dao");

		List<Post> post = dao.queryForPostedByUser(currentuser.getId());
		List<Floor> floor = dao.queryForReplyedByUser(currentuser.getId());
		model.addAttribute("posted", post);
		model.addAttribute("floored", floor);
		return "accountCenter.jsp";
	}

	/**
	 * 
	 * 进入修改密码界面
	 * 
	 */
	@RequestMapping(value = "/userPreferences")
	public String toUserPreferences() {
		return "userPreferences.jsp";
	}

	/**
	 * 
	 * 修改密码
	 * 
	 */
	@RequestMapping(value = "/updatePassword")
	public String toUserPreferences(@RequestParam("passwordOld") String passwordold,
			@RequestParam("passwordNew") String passwordnew, Model model, HttpSession session) {
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		User currentuser = (User) session.getAttribute("CurrentUser");
		UserDao dao = (UserDao) context.getBean("dao");

		if (!currentuser.getPassword().equals(passwordold)) {
			return "userPreferences.jsp";
		}
		currentuser.setPassword(passwordnew);
		boolean result = dao.updatePassword(currentuser);
		if (result) {
			return "accountCenter.jsp";
		} else {
			return "userPreferences.jsp";
		}
	}
	/**
     * 
     * 退出登录
     * 
     */
    @RequestMapping(value = "/quit")
    public String QuitbyUser(HttpSession session) {
    	session.invalidate();
    	return "index.jsp";
    }
    
    /**
     * 
     * 跳转注册界面
     * 
     */
    @RequestMapping(value = "/registerpage")
    public String toRegister() {
    	return "register.jsp";
    }
    
	/**
     * 
     * 注册
     * 
     */
    @RequestMapping(value = "/checkingregister")
    public String CheckRegister(@RequestParam("email") String email, @RequestParam("username") String username, @RequestParam("password") String password, Model model, HttpSession session) {
    	ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");

    	if(!email.contains("bjut.edu.cn")) {
    		model.addAttribute("checkemaillegal","this email address is not for bjut");
    		return "register.jsp";
    	}
    	UserDao dao = (UserDao) context.getBean("dao");
    	List<User> existedemail = dao.queryByEmail(email);
    	if(!existedemail.isEmpty()) {
    		model.addAttribute("checkemailexisted","this email address has already been registered");
    		return "register.jsp";
    	}
    	List<User> existeduser = dao.queryByName(username);
    	if(!existeduser.isEmpty()) {
    		model.addAttribute("checkusernameexisted", "this name has been used");
    		return "register.jsp";
    	}
    	else {
    		User user= new User();
    		List<User> lastuser = dao.forLastUser();
    		Integer id = lastuser.get(0).getId()+1;
    		user.setId(id);
    		user.setUsername(username);
    		user.setPassword(password);
    		user.setEmail(email);
    		user.setisExist(1);
    		user.setisBoardAdmin(0);
    		user.setisForumAdmin(0);
    		boolean result = dao.addUser(user);
        	if (result) {
        		model.addAttribute("msg", "<script>alert('添加成功！')</script>");
    			return "home1.jsp";
        	}
        	else {
        		return "register.jsp";
        	}
    	}
    }
    
    /**
     * 
     * 跳转帖子显示界面
     * 
     */
    @RequestMapping(value = "/post/{postid}")
    public String toPost(@PathVariable("postid") int postid, Model model, HttpSession session, HttpServletRequest request) {
    	ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
    	UserDao dao = (UserDao) context.getBean("dao");
    	
    	int pageNum = 1;
		if (request.getQueryString() != null) {
			pageNum = Integer.parseInt(request.getParameter("page").toString());
		}
		int pageSize = 2;
		Page p = dao.findAllFloorWithPage(pageNum, pageSize, postid);
		model.addAttribute("page", p);
		session.setAttribute("page", p);
		int si = p.getStartIndex();
		List<Floor> fl = p.getList();
	 
    	List<Post> posted=dao.queryForPostByPostId(postid); 
    	Post currentpost = posted.get(0); 
    	List<User> postuser=dao.queryByID(currentpost.getUserid());
    	List<String> ul=new ArrayList();
    	for (int i = 0; i < fl.size(); i++) {
    		String thisuser = dao.queryByID(fl.get(i).getUserid()).get(0).getUsername();
			ul.add(thisuser);
		}
    	
    	//List<Floor> floored = dao.queryForReplyedByPost(currentpost.getPostid());
    	model.addAttribute("floor", fl);
    	session.setAttribute("floor", fl);
    	model.addAttribute("postuser", postuser.get(0));
    	session.setAttribute("postuser", postuser.get(0));
    	model.addAttribute("flooruser", ul);
    	session.setAttribute("flooruser", ul);
    	model.addAttribute("post", currentpost);
    	session.setAttribute("post", currentpost);
    	return "/content001.jsp";
    } 
    
    /**
     * 
     * 举报
     * 
     */
    @RequestMapping(value = "/report")
    public String toReport(@RequestParam("postId") String postId, @RequestParam("floorId") String floorId, @RequestParam("reportType") String reporttype, @RequestParam("reportReason") String reportreason, Model model, HttpSession session) {
    	ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
    	UserDao dao = (UserDao) context.getBean("dao");
    	Integer postid = Integer.parseInt(postId);
    	Integer floorid = Integer.parseInt(floorId);
    	
    	List<Post> posted = dao.queryForPostByPostId(postid);
    	User currentuser = (User)session.getAttribute("CurrentUser");
    	Post post = new Post();
    	post = posted.get(0);
    	Report report = new Report();
    	report.setBoardId(post.getBoardid());
    	report.setPostId(postid);
    	report.setFloorId(floorid);
    	report.setUserId(currentuser.getId());
    	report.setReportBrief(reporttype);
    	report.setReportContent(reportreason);
    	Date date = new Date();
    	SimpleDateFormat dateFormat= new SimpleDateFormat("yyyyMMddhhmmss");
    	report.setReportTime(dateFormat.format(date));
    	report.setIsHandle(0);
    	List<Report> lastreport = dao.forLastReport();
    	Integer id;
    	if(lastreport.size()==0) {
    		id = 0;
    	}else {
    		id = lastreport.get(0).getReportId()+1;
    	}
		report.setReportId(id);
		
		boolean result = dao.addReport(report);
    	if (result) {
    		model.addAttribute("msg", "<script>alert('添加成功！')</script>");
			return "/content001.jsp";
    	}
    	else {
    		return "/index.jsp";
    	}
    }
    
	public String msg(String msg) {
		return "<script>alert('" + msg + "')</script>";
	}
}
