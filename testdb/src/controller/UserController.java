package controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.web.context.request.*;

import com.mysql.cj.Query;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.*;
import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.*;

import bean.*;
import dao.UserDao;
import java.util.Date;
@Controller
public class UserController {
	/**
     * 
     * ��ת��¼����
     * 
     */
    @RequestMapping(value = "/loginpage")
    public String toLoginpage() {
    	return "login.jsp";
    }
    
	/**
     * 
     * ��¼
     * 
     */
    @RequestMapping(value = "/login")
    public String CheckLogin(@RequestParam("username") String username, @RequestParam("password") String password, Model model, HttpSession session) {
    	ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");

    	UserDao dao = (UserDao) context.getBean("dao");
		List<Board> board = dao.queryAllBoard();
    	List<User> user = dao.queryByName(username);
    	if(user.isEmpty()) {
    		return "login.jsp";
    	}
    	if(user.get(0).getPassword().equals(password)) {
    		model.addAttribute("CurrentUser", user.get(0));
    		session.setAttribute("CurrentUser", user.get(0));
			model.addAttribute("AllBoard", board);
			session.setAttribute("AllBoard", board);
    		return "home1.jsp";
    	}
    	else {
    		return "login.jsp";
    	}
    }
	
    /**
     * 
     * ����������Ľ��棬��ʾ���ҵ����ӡ������ҵĻ�����
     * 
     */
    @RequestMapping(value = "/accountCenter")
    public String toAccountCenter(Model model, HttpSession session) {
    	ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
    	User currentuser = (User)session.getAttribute("CurrentUser");
    	UserDao dao = (UserDao) context.getBean("dao");
    	
    	List<Post>  post = dao.queryForPostedByUser(currentuser.getId());
    	List<Floor> floor = dao.queryForReplyedByUser(currentuser.getId());
    	session.setAttribute("posted", post);
    	session.setAttribute("floored", floor);
    	return "accountCenter.jsp";
    }
    
    /**
     * 
     * �����޸��������
     * 
     */
    @RequestMapping(value = "/userPreferences")
    public String toUserPreferences() {
    	return "userPreferences.jsp";
    }
    
    /**
     * 
     * �޸�����
     * 
     */
    @RequestMapping(value = "/updatePassword")
    public String toUserPreferences(@RequestParam("passwordOld") String passwordold, @RequestParam("passwordNew") String passwordnew, Model model, HttpSession session) {
    	ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
    	User currentuser = (User)session.getAttribute("CurrentUser");
    	UserDao dao = (UserDao) context.getBean("dao");

    	if(!currentuser.getPassword().equals(passwordold)) {
    		return "userPreferences.jsp";
    	}
    	currentuser.setPassword(passwordnew);
    	boolean result = dao.updatePassword(currentuser);
    	if(result) {
    		return "accountCenter.jsp";
    	}else {
    		return "userPreferences.jsp";
    	}
    }

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
		if (session.getAttribute("CurrentUser") == null) {
			return "/index.jsp";
		} else {
			model.addAttribute("AllBoard", board);
			session.setAttribute("AllBoard", board);
			return "/home1.jsp";
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
    @RequestMapping(value = "/post/report")
    public String toReport(@RequestParam("postId") String postId, @RequestParam("floorId") String floorId, @RequestParam("reportType") String reporttype, @RequestParam("reportReason") String reportreason, Model model, HttpSession session) {
    	ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
    	UserDao dao = (UserDao) context.getBean("dao");
    	Integer postid = Integer.parseInt(postId);
    	Integer floorid;
    	if(floorId.length()==0) {
    		floorid = 0;
    	}else {
    		floorid = Integer.parseInt(floorId);
    	}
    	 
    	
     	List<Post> posted = dao.queryForPostByPostId(postid);
    	User currentuser = (User)session.getAttribute("CurrentUser");
    	Post post = new Post();
    	post = posted.get(0);
    	Report report = new Report();
    	report.setBoardid(post.getBoardid());
    	report.setPostid(postid);
    	report.setFloorid(floorid);
    	report.setUserid(currentuser.getId());
    	report.setReportbrief(reporttype);
    	report.setReportcontent(reportreason);
    	Date date = new Date();
    	SimpleDateFormat dateFormat= new SimpleDateFormat("yyyyMMddhhmmss");
    	report.setReporttime(dateFormat.format(date));
    	report.setIshandle(0);
    	List<Report> lastreport = dao.forLastReport();
    	Integer id;
    	if(lastreport.size()==0) {
    		id = 0;
    	}else {
    		id = lastreport.get(0).getReportid()+1;
    	}
		report.setReportid(id);
		
		boolean result = dao.addReport(report);
    	if (result) {
    		model.addAttribute("msg", "<script>alert('添加成功！')</script>");
			return "/content001.jsp";
    	}
    	else {
    		return "/index.jsp";
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
		if(request.getHeader("Referer").toString().equals("http://localhost:8080/testdb/addPost")) {
			String newPostTitle=request.getParameter("title");
			String newPostContent=request.getParameter("content");
			if((!newPostTitle.isEmpty())&&(!newPostContent.isEmpty())) {
				Post post=new Post();
		    	Board board=(Board)session.getAttribute("nowBoard");
		    	User user=(User)session.getAttribute("CurrentUser");
		    	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
		    	String nowtime=df.format(new Date());
		    	post.setBoardid(board.getBoardid());
		    	post.setTitle(newPostTitle);
		    	post.setPostcontent(newPostContent);
		    	post.setUserid(user.getId());
		    	post.setPosttime(nowtime);
		    	post.setNewtime(nowtime);
		    	post.setIsBanned(0);
		    	post.setIsGood(0);
		    	post.setIsExist(1);
		    	post.setNumpost(0);
		    	post.setPostid(dao.queryForAllPost().size()+1);
		    	dao.addPost(post);
			}
			
		}
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
		//String boardname = nowboard.getBoardname();
		model.addAttribute("nowBoard", nowboard);
		session.setAttribute("nowBoard", nowboard);
    	model.addAttribute("postuser", ul);
    	session.setAttribute("postuser", ul);
		model.addAttribute("CurrentPost", pl);
		session.setAttribute("CurrentPost", pl);
		return "/board1.jsp";
	}
	
    /**
     * 
     * 从板块进入相应帖子中
     * 
     */
	@RequestMapping(value = "/board/{boardid}/post/{postid}")
    public String enterPost(@PathVariable int boardid, Model model, HttpSession session) {
    	return "/content001.jsp";
    }
	
    /**
     * 
     * 从主页进入板块管理员界面
     * 
     */
	@RequestMapping(value = "/boardAdmin")
    public String toBoardAdmin() {
    	 return "/boardAdmin.jsp";
    }

    /**
     * 
     * 从板块管理员界面进入管理举报信息界面
     * 
     */
	@RequestMapping(value = "/reportAdmin")
    public String toReportAdmin(Model model, HttpSession session) {
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
    	UserDao dao = (UserDao) context.getBean("dao");
    	
    	List<Report> reported = dao.queryAllReport();
    	List<String> username = new ArrayList();
    	for(int i=0;i<reported.size();i++) {
    		List<User> user = dao.queryByID(reported.get(i).getUserid());
    		username.add(user.get(0).getUsername());
    	}
		session.setAttribute("usernames", username); 
    	session.setAttribute("reported", reported);
    	 return "/reportAdmin.jsp";
    }
	
    /**
     * 
     * 管理举报信息
     * 
     */
	@RequestMapping(value = "/manageReport")
    public String ManagingReport(@RequestParam("reportid") String reportId, @RequestParam("manage") String manage, Model model, HttpSession session) {
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
    	UserDao dao = (UserDao) context.getBean("dao");
    	
    	Integer reportid = Integer.parseInt(reportId);
    	List<Report> reports = dao.queryReportByReportId(reportid);
    	Report report = reports.get(0);
    	
    	if(manage.equals("ban")) {
    		if(report.getFloorid()==0) {
    			List<Post> banpost = dao.queryForPostByPostId(report.getPostid());
    			banpost.get(0).setIsBanned(1);
    			report.setIshandle(1);
    			
    		}else {
    			List<Floor> banfloor = dao.queryFloorByFloorId(report.getFloorid());
    			banfloor.get(0).setIsbanned(1);
    			report.setIshandle(1);
    		}
    	}else if(manage.equals("delete")) {
    		if(report.getFloorid()==0) {
    			List<Post> banpost = dao.queryForPostByPostId(report.getPostid());
    			banpost.get(0).setIsExist(0);
    			report.setIshandle(2);
    		}else {
    			List<Floor> banfloor = dao.queryFloorByFloorId(report.getFloorid());
    			banfloor.get(0).setIsexist(0);
    			report.setIshandle(2);
    		}
    	}else {
    		report.setIshandle(3);
    	}
    	dao.updateHandle(report);
    	
    	return "/reportAdmin";
    }
	
    /**
     * 
     * 回复
     * 
     */
	@RequestMapping(value = "/post/postReply")
    public String addPostReply(HttpSession session, @RequestParam("postId") String postId, @RequestParam("replyContent") String replycontent) {
    	ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
    	UserDao dao = (UserDao) context.getBean("dao");
    	
    	Integer postid = Integer.parseInt(postId);
    	//Integer floorid = Integer.parseInt(floorId);
    	User currentuser = (User)session.getAttribute("CurrentUser");
    	
    	List<Post> posted = dao.queryForPostByPostId(postid);
    	Post post = posted.get(0);
    	List<Floor> floored = dao.forLastFloor(postid);
    	Floor lastfloor = floored.get(0);
    	
    	Floor newfloor = new Floor();
    	newfloor.setBoardid(post.getBoardid());
    	newfloor.setPostid(postid);
    	newfloor.setFloorid(lastfloor.getFloorid()+1);
    	newfloor.setAnsfloorid(0);
    	newfloor.setUserid(currentuser.getId());
    	newfloor.setFloorcontent(replycontent);
    	Date date = new Date();
    	SimpleDateFormat dateFormat= new SimpleDateFormat("yyyyMMddhhmmss");
    	newfloor.setFloortime(dateFormat.format(date));
    	newfloor.setIsbanned(0);
    	newfloor.setIsgood(0);
    	newfloor.setIsexist(1);
    	
		boolean result = dao.addFloor(newfloor);
		return "/content001.jsp";
    }
	
    /**
     * 从个人主页进入申请界面
     * 
     */
	@RequestMapping(value = "/applyBoard")
    public String toApplyBoard() {
    	 return "/applyBoard.jsp";
    }
	
    /**
     * 申请一个新的板块
     * 
     */
	@RequestMapping(value = "/applyNewboard")
    public String toapplyNewBoard(HttpSession session, @RequestParam("boardname") String boardname, @RequestParam("boardreason") String boardreason) {
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
    	UserDao dao = (UserDao) context.getBean("dao");
    	
    	User currentuser = (User)session.getAttribute("CurrentUser");
    	List<Applyingboard> applying = dao.forLastApplyingboard();
    	Integer applyingid;
    	if(applying.size()==0) {
    		applyingid = 0;
    	}else {
    		applyingid = applying.get(0).getApplyingid()+1;
    	}
    	Applyingboard applyingboard = new Applyingboard();
    	applyingboard.setApplyingid(applyingid);
    	applyingboard.setBoardname(boardname);
    	applyingboard.setApplyingreason(boardreason);
    	applyingboard.setUserid(currentuser.getId());
    	
    	boolean result = dao.addApplyingboard(applyingboard);    	
    	 return "/applyBoard.jsp";
    }

    /**
     * 
     *发表新帖
     * 
    /**
     */
    @RequestMapping(value = "/addPost")
    public String addPost(Model model, HttpSession session) {
    	
    	return "addPost.jsp";
    }
    
 
    
    public String msg(String msg) {
	return "<script>alert('" + msg + "')</script>";
    }
    
    /**
     * ajax查数据库
     * @throws IOException 
     */
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException{
        response.setContentType("text/html;charset=utf-8");
        request.setCharacterEncoding("utf-8");
        //获取搜索框输入的内容
        String name=request.getParameter("name");
        //向server层调用相应的业务     
        
        ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
    	UserDao dao = (UserDao) context.getBean("dao");
    	List<Post> pl=dao.findBooksAjax(name);
    	String res = "";
    	for(int i=0;i<pl.size();i++) {
    		if(i==0)
    			res=pl.get(i).getTitle();
    		else
    			res=res+","+pl.get(i).getTitle();
    	}
        //返回结果
        response.getWriter().write(res);
    }

    /**
     * ajax查数据库_2
     * @throws IOException 
     */
    @RequestMapping(value = "/findPostsAjaxServlet")
    @ResponseBody
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException{
        doGet(request, response);
    }
}