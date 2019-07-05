package controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
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
	public String CheckLogin(@RequestParam("username") String username, @RequestParam("password") String password,
			Model model, HttpSession session) {
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");

		UserDao dao = (UserDao) context.getBean("dao");
		List<Board> board = dao.queryAllBoard();
		List<User> user = dao.queryByName(username);
		if (user.isEmpty()) {
			session.setAttribute("logInWrongType", 1);
			return "login.jsp";
		}
		if (user.get(0).getPassword().equals(password)) {
			int i =3;
			model.addAttribute("logInWrongType", i);
			session.setAttribute("logInWrongType", i);
			model.addAttribute("CurrentUser", user.get(0));
			session.setAttribute("CurrentUser", user.get(0));
			model.addAttribute("AllBoard", board);
			session.setAttribute("AllBoard", board);
    		return "home1.jsp";
    	}
    	else {
    		session.setAttribute("logInWrongType", 2);
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
     * 添加回帖
     * 
     */
    @RequestMapping(value = "/addPost")
    public String addPost() {
    	return "addPost.jsp";
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
    	return "accountCenter.jsp";
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
    		session.setAttribute("checkregister",0);
    		model.addAttribute("checkemaillegal","this email address is not for bjut");
    		return "register.jsp";
    	}
    	UserDao dao = (UserDao) context.getBean("dao");
    	List<User> existedemail = dao.queryByEmail(email);
    	if(!existedemail.isEmpty()) {
    		session.setAttribute("checkregister",1);
    		model.addAttribute("checkemailexisted","this email address has already been registered");
    		return "register.jsp";
    	}
    	List<User> existeduser = dao.queryByName(username);
    	if(!existeduser.isEmpty()) {
    		session.setAttribute("checkregister", 2);
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
    		user.setIsExist(1);
    		user.setIsBoardAdmin(0);
    		user.setIsForumAdmin(0);
    		boolean result = dao.addUser(user);
        	if (result) {
        		session.setAttribute("checkregister",3);
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
		int pageSize = 10;
		Page p = dao.findAllFloorWithPage(pageNum, pageSize, postid);
		model.addAttribute("page", p);
		session.setAttribute("page", p);
		int si = p.getStartIndex();
		List<Floor> fl = p.getList();

		List<Post> posted = dao.queryForPostByPostId(postid);
		Post currentpost = posted.get(0);
		List<User> postuser = dao.queryByID(currentpost.getUserid());
		List<String> ul = new ArrayList();
		for (int i = 0; i < fl.size(); i++) {
			String thisuser = dao.queryByID(fl.get(i).getUserid()).get(0).getUsername();
			ul.add(thisuser);
		}
		
		List<Floor> allfloor =fl;
    	List<String> ansusername = new ArrayList();
		for (int i = 0; i < allfloor.size(); i++) {
			if(allfloor.get(i).getAnsfloorid()==0) {
				List<User> ansusered = dao.queryByID(currentpost.getUserid());
				ansusername.add(ansusered.get(0).getUsername());
			}else {

				List<Floor> ansfloored = dao.queryFloorByFloorIdandPostId(allfloor.get(i).getAnsfloorid(), postid);
				Floor ansfloor = ansfloored.get(0);
				List<User> ansusered = dao.queryByID(ansfloor.getUserid());
				User ansuser = ansusered.get(0);
				ansusername.add(ansuser.getUsername());
			}			
		}
		
		session.setAttribute("ansname", ansusername);

		// List<Floor> floored = dao.queryForReplyedByPost(currentpost.getPostid());
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
	public String toReport(@RequestParam("postId") String postId, @RequestParam("floorId") String floorId,
			@RequestParam("reportType") String reporttype, @RequestParam("reportReason") String reportreason,
			Model model, HttpSession session) {
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		UserDao dao = (UserDao) context.getBean("dao");
		Integer postid = Integer.parseInt(postId);
		Integer floorid;
		if (floorId.length() == 0) {
			floorid = 0;
		} else {
			floorid = Integer.parseInt(floorId);
		}

		List<Post> posted = dao.queryForPostByPostId(postid);
		User currentuser = (User) session.getAttribute("CurrentUser");
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
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddhhmmss");
		report.setReporttime(dateFormat.format(date));
		report.setIshandle(0);
		List<Report> lastreport = dao.forLastReport();
		Integer id;
		if (lastreport.size() == 0) {
			id = 0;
		} else {
			id = lastreport.get(0).getReportid() + 1;
		}
		report.setReportid(id);

		boolean result = dao.addReport(report);
		if (result) {
			model.addAttribute("msg", "<script>alert('添加成功！')</script>");
			return "/content001.jsp";
		} else {
			return "/index.jsp";
		}
	}

	/**
	 * 
	 * 进入板块
	 * 
	 */
	@RequestMapping(value = "/board/{boardid}")
	public String enterBoard(@PathVariable int boardid, Model model, HttpSession session, HttpServletRequest request) throws UnsupportedEncodingException {
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		UserDao dao = (UserDao) context.getBean("dao");
		if (request.getHeader("Referer").toString().contains("addPost")) {
			request.setCharacterEncoding("utf-8");
			String newPostTitle = request.getParameter("title");	
			String newPostContent = request.getParameter("content");
			if ((!newPostTitle.isEmpty()) && (!newPostContent.isEmpty())) {
				Post post = new Post();
				Board board = (Board) session.getAttribute("nowBoard");
				User user = (User) session.getAttribute("CurrentUser");
				SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");// 设置日期格式
				String nowtime = df.format(new Date());
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
				List<Post> pp=dao.queryForAllPost();
				int a=pp.size();
				post.setPostid(a + 1);
				dao.addPost(post);
			}

		}
		int pageNum = 1;
		if (request.getQueryString() != null) {
			pageNum = Integer.parseInt(request.getParameter("page").toString());
		}
		int pageSize = 10;
		Page p = dao.findAllPostWithPage(pageNum, pageSize, boardid);
		model.addAttribute("page", p);
		session.setAttribute("page", p);
		int si = p.getStartIndex();
		List<Post> pl = p.getList();
		List<Board> bl = dao.queryBoardByBoardId(boardid);
		Board nowboard = bl.get(0);
		// List<User> ul;
		List<String> ul = new ArrayList();
		for (int i = 0; i < pl.size(); i++) {
			String thisuser = dao.queryByID(pl.get(i).getUserid()).get(0).getUsername();
			ul.add(thisuser);
		}

		// User user=queryUserNameById()
		// String boardname = nowboard.getBoardname();
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
		for (int i = 0; i < reported.size(); i++) {
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
	public String ManagingReport(@RequestParam("reportid") String reportId, @RequestParam("manage") String manage,
			Model model, HttpSession session) {
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		UserDao dao = (UserDao) context.getBean("dao");

		Integer reportid = Integer.parseInt(reportId);
		List<Report> reports = dao.queryReportByReportId(reportid);
		Report report = reports.get(0);

		if (manage.equals("ban")) {
			if (report.getFloorid() == 0) {
				List<Post> banpost = dao.queryForPostByPostId(report.getPostid());
				banpost.get(0).setIsBanned(1);
				report.setIshandle(1);
				dao.updatePost(banpost.get(0));

			} else {
				List<Floor> banfloor = dao.queryFloorByFloorIdandPostId(report.getFloorid(), report.getPostid());
				banfloor.get(0).setIsBanned(1);
				report.setIshandle(1);
				dao.updateFloor(banfloor.get(0));
			}
		} else if (manage.equals("delete")) {
			if (report.getFloorid() == 0) {
				List<Post> banpost = dao.queryForPostByPostId(report.getPostid());
				banpost.get(0).setIsExist(0);
				report.setIshandle(2);
				dao.updatePost(banpost.get(0));
			} else {
				List<Floor> banfloor = dao.queryFloorByFloorIdandPostId(report.getFloorid(), report.getPostid());
				banfloor.get(0).setIsExist(0);
				report.setIshandle(2);
				dao.updateFloor(banfloor.get(0));
			}
		} else {
			report.setIshandle(3);
		}
		dao.updateHandle(report);

		return "/reportAdmin";
	}

	

  
	/**
	 * 
	 * 管理员加精
	 * 
	 */
	@RequestMapping(value = "/good")
	public String addGood(Model model, HttpSession session, HttpServletRequest request) {
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		User currentuser = (User) session.getAttribute("CurrentUser");
		UserDao dao = (UserDao) context.getBean("dao");
		if (request.getHeader("Referer").toString().contains("good")) {
			String isNotGoodAnymore = request.getParameter("isNotGoodAnymore");
			String isGoodNow = request.getParameter("isGoodNow");
			
			if (isNotGoodAnymore != null) {
				int notGoodPost = Integer.parseInt(isNotGoodAnymore);
				dao.deleteGood(dao.queryForPostByPostId(notGoodPost).get(0));
			}
			if (isGoodNow != null) {
				int goodPostId = Integer.parseInt(isGoodNow);
				Post goodPost=dao.queryForPostByPostId(goodPostId).get(0);
				dao.addGood(goodPost);
				int messageid=dao.queryAllMessage().size()+1;
				SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");// 设置日期格式
				String nowtime = df.format(new Date());
				String goodReason="您的帖子"+goodPost.getTitle()+"被加精啦！！";
				Message message=new Message(messageid,goodPost.getUserid(),nowtime,goodReason,currentuser.getId());
				dao.addMessage(message);
			}
		}
		if (currentuser.getIsForumAdmin() != 0) {
			String searchPostByKeyWord = request.getParameter("searchPostByKeyWord");
			if (searchPostByKeyWord != null) {
				List<Post> pl = dao.queryForPostByPostTitle(searchPostByKeyWord);
				model.addAttribute("searchedPost", pl);
				session.setAttribute("searchedPost", pl);
				List<String> sboardNameList = new ArrayList();
				List<String> suserNameList = new ArrayList();
				for (int i = 0; i < pl.size(); i++) {
					sboardNameList.add(dao.queryBoardByBoardId(pl.get(i).getBoardid()).get(0).getBoardname());
					suserNameList.add(dao.queryByID(pl.get(i).getUserid()).get(0).getUsername());
				}
				model.addAttribute("sboardNameList", sboardNameList);
				session.setAttribute("sboardNameList", sboardNameList);
				model.addAttribute("suserNameList", suserNameList);
				session.setAttribute("suserNameList", suserNameList);
				
			}
			List<Post> pl = dao.queryAllGoodPost();
			model.addAttribute("goodPost", pl);
			session.setAttribute("goodPost", pl);
			List<String> boardNameList = new ArrayList();
			List<String> userNameList = new ArrayList();
			for (int i = 0; i < pl.size(); i++) {
				boardNameList.add(dao.queryBoardByBoardId(pl.get(i).getBoardid()).get(0).getBoardname());
				userNameList.add(dao.queryByID(pl.get(i).getUserid()).get(0).getUsername());
			}
			model.addAttribute("boardNameList", boardNameList);
			session.setAttribute("userNameList", userNameList);
		} else if (currentuser.getIsBoardAdmin() != 0) {
			String searchPostByKeyWord = request.getParameter("searchPostByKeyWord");
			if (searchPostByKeyWord != null) {
				List<Post> pl = dao.queryForPostByPostTitleInABoard(searchPostByKeyWord,currentuser.getIsBoardAdmin() );
				model.addAttribute("searchedPost", pl);
				session.setAttribute("searchedPost", pl);
				List<String> sboardNameList = new ArrayList();
				List<String> suserNameList = new ArrayList();
				for (int i = 0; i < pl.size(); i++) {
					sboardNameList.add(dao.queryBoardByBoardId(pl.get(i).getBoardid()).get(0).getBoardname());
					suserNameList.add(dao.queryByID(pl.get(i).getUserid()).get(0).getUsername());
				}
				model.addAttribute("sboardNameList", sboardNameList);
				session.setAttribute("sboardNameList", sboardNameList);
				model.addAttribute("suserNameList", suserNameList);
				session.setAttribute("suserNameList", suserNameList);

			}
			
			List<Post> pl = dao.queryAllGoodPostInABoard(currentuser.getIsBoardAdmin());
			model.addAttribute("goodPost", pl);
			session.setAttribute("goodPost", pl);
			List<String> boardNameList = new ArrayList();
			List<String> userNameList = new ArrayList();
			for (int i = 0; i < pl.size(); i++) {
				boardNameList.add(dao.queryBoardByBoardId(pl.get(i).getBoardid()).get(0).getBoardname());
				userNameList.add(dao.queryByID(pl.get(i).getUserid()).get(0).getUsername());
			}
			model.addAttribute("boardNameList", boardNameList);
			session.setAttribute("userNameList", userNameList);
		} else {
			return "home1.jsp";
		}
		return "good.jsp";
	}

	public String msg(String msg) {
		return "<script>alert('" + msg + "')</script>";
	}
	
	/**
     * 从个人主页进入申请界面
     * 
     */
	@RequestMapping(value = "/applyBoard")
    public String toApplyBoard(HttpSession session) { 
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
    	UserDao dao = (UserDao) context.getBean("dao");
    	
    	//search for applyingadmin && applyingboard
    	User currentuser = (User)session.getAttribute("CurrentUser");
    	List<Applyingadmin> admined = dao.queryAdminByUserid(currentuser.getId());
    	List<Applyingboard> boarded = dao.queryBoardByUserid(currentuser.getId());
    	session.setAttribute("admined", admined);
    	session.setAttribute("boarded", boarded);
    	
    	List<String> boardname = new ArrayList();
    	for(int i=0;i<admined.size();i++) {
    		List<Board> board = dao.queryBoardByBoardId(admined.get(i).getBoardid());
    		boardname.add(board.get(0).getBoardname());
    	}
		session.setAttribute("boardnames", boardname);
    	//write into session
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
    	Date date = new Date();
    	SimpleDateFormat dateFormat= new SimpleDateFormat("yyyyMMddhhmmss");
    	applyingboard.setApplytime(dateFormat.format(date));
    	applyingboard.setIshandle(0);
    	
    	boolean result = dao.addApplyingboard(applyingboard);    	
    	
    	List<Applyingboard> boarded = dao.queryBoardByUserid(currentuser.getId());
    	session.setAttribute("boarded", boarded);
    	
    	List<Applyingadmin> admined = dao.queryAdminByUserid(currentuser.getId());
    	session.setAttribute("admined", admined);
    	List<String> boardName = new ArrayList();
    	for(int i=0;i<admined.size();i++) {
    		List<Board> b = dao.queryBoardByBoardId(admined.get(i).getBoardid());
    		boardName.add(b.get(0).getBoardname());
    	}
		session.setAttribute("boardnames", boardName);
    	 return "/applyBoard.jsp";
    }
	
    /**
     * 申请成为板块管理员
     * 
     */
	@RequestMapping(value = "/applyforAdmin")
    public String toApplyforAdmin(@RequestParam("boardname") String boardname, @RequestParam("applyreason") String applyreason,HttpSession session) {   
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
    	UserDao dao = (UserDao) context.getBean("dao");
    	
    	User currentuser = (User)session.getAttribute("CurrentUser");
    	List<Applyingadmin> applying = dao.forLastApplyingadmin();
    	List<Board> board = dao.queryByBoardName(boardname);
    	Integer applyingid;
    	if(applying.size()==0) {
    		applyingid = 0;
    	}else {
    		applyingid = applying.get(0).getApplyingid()+1;
    	}
    	
    	Applyingadmin newapply = new Applyingadmin();
    	newapply.setApplyingid(applyingid);
    	newapply.setBoardid(board.get(0).getBoardid());
    	newapply.setApplyingreason(applyreason);
    	newapply.setUserid(currentuser.getId());
    	Date date = new Date();
    	SimpleDateFormat dateFormat= new SimpleDateFormat("yyyyMMddhhmmss");
    	newapply.setApplytime(dateFormat.format(date));
    	newapply.setIshandle(0);
    	
    	boolean result = dao.addApplyingadmin(newapply); 
    	
    	List<Applyingadmin> admined = dao.queryAdminByUserid(currentuser.getId());
    	session.setAttribute("admined", admined);
    	
    	//User currentuser = (User)session.getAttribute("CurrentUser");
    //	List<Applyingadmin> admined = dao.queryAdminByUserid(currentuser.getId());
    	List<Applyingboard> boarded = dao.queryBoardByUserid(currentuser.getId());
    	session.setAttribute("admined", admined);
    	session.setAttribute("boarded", boarded);
    	
    	List<String> boardName = new ArrayList();
    	for(int i=0;i<admined.size();i++) {
    		List<Board> b = dao.queryBoardByBoardId(admined.get(i).getBoardid());
    		boardName.add(b.get(0).getBoardname());
    	}
		session.setAttribute("boardnames", boardName);
    	 return "/applyBoard.jsp";
    }
	
    /**
     * 从个人主页进入站内消息界面
     * 
     */
	@RequestMapping(value = "/adminMessage")
    public String toAdminMessage(HttpSession session) { 
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
    	UserDao dao = (UserDao) context.getBean("dao");
    	
    	User currentuser = (User)session.getAttribute("CurrentUser");
    	List<Message> usermessages = dao.queryMessageByUserid(currentuser.getId());
    	
    	session.setAttribute("usermessages", usermessages);
		return "adminMessage.jsp";
	}
	
    /**
     * 返回超级管理员界面
     * 
     */
	@RequestMapping(value = "/superAdmin")
    public String toSuperAdmin(HttpSession session) { 
		return "superAdmin.jsp";
	}

    /**
     * 超级管理员管理板块信息
     * 
     */
	@RequestMapping(value = "/boardApplyAdmin")
    public String ManageBoardApply(HttpSession session) { 
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
    	UserDao dao = (UserDao) context.getBean("dao");
    	
    	List<Applyingboard> applyboard = dao.queryAllApplyBoard();
    	session.setAttribute("applyboards", applyboard);
		List<String> username = new ArrayList();
		for (int i = 0; i < applyboard.size(); i++) {
			List<User> user = dao.queryByID(applyboard.get(i).getUserid());
			username.add(user.get(0).getUsername());
		}
		session.setAttribute("username", username);
		
    	List<Applyingadmin> applyadmin = dao.queryAllApplyAdmin();
    	session.setAttribute("applyadmins", applyadmin);
		List<String> boardname = new ArrayList();
		for (int i = 0; i < applyadmin.size(); i++) {
			List<Board> board = dao.queryBoardByBoardId(applyadmin.get(i).getBoardid());
			boardname.add(board.get(0).getBoardname());
		}
		session.setAttribute("boardname", boardname);
		List<String> username2 = new ArrayList();
		for (int i = 0; i < applyadmin.size(); i++) {
			List<User> user2 = dao.queryByID(applyadmin.get(i).getUserid());
			username2.add(user2.get(0).getUsername());
		}
		session.setAttribute("username2", username2);
		return "boardApplyAdmin.jsp";
	}
    
	/**
     * 超级管理员管理板块申请
     * 
     */
	@RequestMapping(value = "/manageApplyboard")
    public String ManageApplyBoard(@RequestParam("applyid") String applyId, @RequestParam("newBoard") String newboard, HttpSession session) { 
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
    	UserDao dao = (UserDao) context.getBean("dao");
    	
    	User currentuser = (User)session.getAttribute("CurrentUser");
    	Integer applyid = Integer.parseInt(applyId);
    	List<Applyingboard> applyboarded = dao.queryApplyboardById(applyid);
    	Applyingboard applyboard = applyboarded.get(0);
    	if(newboard.equals("allow")) {
    		applyboard.setIshandle(1);
    		Board board = new Board();
    		List<Board> boarded = dao.forLastBoard();
    		Integer boardid;
    		if(boarded.size()==0) {
    			boardid = 0;
    		}else {
    			Board lastboard = boarded.get(0);
    			boardid = lastboard.getBoardid()+1;
    		}    		
    		board.setBoardid(boardid);
    		board.setBoardintro(applyboard.getApplyingreason());
    		board.setBoardname(applyboard.getBoardname());
    		board.setBoardexist(1);
    		boolean addresult = dao.addBoard(board);
    	}
    	if(newboard.equals("refuse")) {
    		applyboard.setIshandle(2);
    	}
    	
    	boolean resultapply = dao.updateApplyBoardHandle(applyboard);
    	
    	List<Applyingboard> newapplyboard = dao.queryAllApplyBoard();
    	session.setAttribute("applyboards", newapplyboard);
		List<String> username = new ArrayList();
		for (int i = 0; i < newapplyboard.size(); i++) {
			List<User> user = dao.queryByID(newapplyboard.get(i).getUserid());
			username.add(user.get(0).getUsername());
		}
		session.setAttribute("username", username);
		
		return "boardApplyAdmin.jsp";
	}
	
    /**
     * 超级管理员管理管理员申请
     * 
     */
	@RequestMapping(value = "/manageApplyAdmin")
    public String ManageApplyAdmin(@RequestParam("applyid") String applyId, @RequestParam("newAdmin") String newadmin, HttpSession session) { 
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
    	UserDao dao = (UserDao) context.getBean("dao");
    	
    	User currentuser = (User)session.getAttribute("CurrentUser");
    	Integer applyid = Integer.parseInt(applyId);
    	List<Applyingadmin> applyadmined = dao.queryApplyadminById(applyid);
    	Applyingadmin applyadmin = applyadmined.get(0);
    	if(newadmin.equals("allow")) {
    		applyadmin.setIshandle(1);
    		List<User> user = dao.queryByID(applyadmin.getUserid());
    		User updateuser = user.get(0);
    		updateuser.setIsBoardAdmin(applyadmin.getBoardid());
    		boolean userresult = dao.updateUseradmin(updateuser);
    	}
    	if(newadmin.equals("refuse")) {
    		applyadmin.setIshandle(2);
    	}
    	
    	boolean resultapply = dao.updateApplyAdminHandle(applyadmin);
    	
    	List<Applyingadmin> newapplyadmin = dao.queryAllApplyAdmin();
    	session.setAttribute("applyadmins", newapplyadmin);
		List<String> boardname = new ArrayList();
		for (int i = 0; i < newapplyadmin.size(); i++) {
			List<Board> board = dao.queryBoardByBoardId(newapplyadmin.get(i).getBoardid());
			boardname.add(board.get(0).getBoardname());
		}
		session.setAttribute("boardname", boardname);
		List<String> username2 = new ArrayList();
		for (int i = 0; i < newapplyadmin.size(); i++) {
			List<User> user2 = dao.queryByID(newapplyadmin.get(i).getUserid());
			username2.add(user2.get(0).getUsername());
		}
		session.setAttribute("username2", username2);
		
		return "boardApplyAdmin.jsp";
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
    
    /**
    *
    * 回复
    *
    */
    @RequestMapping(value = "/post/{postid}/postReply")
    public String addPostReply(HttpSession session, @RequestParam("ansfloorId") String ansfloorId, @RequestParam("postId") String postId, @RequestParam("replyContent") String replycontent,Model model, HttpServletRequest request) {
    	ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
    	UserDao dao = (UserDao) context.getBean("dao");
    	Integer postid = Integer.parseInt(postId);
    	Integer ansfloorid;
    	if(ansfloorId.equals("")) {
    		ansfloorid=0;
    	}
    	else {
    		ansfloorid = Integer.parseInt(ansfloorId);
    	}
    	User currentuser = (User)session.getAttribute("CurrentUser");
    	List<Post> posted = dao.queryForPostByPostId(postid);
    	Post post = posted.get(0);
    	List<Floor> floored = dao.forLastFloor(postid);
    	Floor newfloor = new Floor();
    	if(floored.size()==0) {
    		newfloor.setFloorid(1);
    	}else {
    		Floor lastfloor = floored.get(0);
    		newfloor.setFloorid(lastfloor.getFloorid()+1);
    	} 	
    	
    	newfloor.setBoardid(post.getBoardid());
    	newfloor.setPostid(postid);
    	
    	newfloor.setAnsfloorid(ansfloorid);
    	newfloor.setUserid(currentuser.getId());
    	newfloor.setFloorcontent(replycontent);
    	Date date = new Date();
    	SimpleDateFormat dateFormat= new SimpleDateFormat("yyyyMMddhhmmss");
    	newfloor.setFloortime(dateFormat.format(date));
    	newfloor.setIsBanned(0);
    	newfloor.setIsGood(0);
    	newfloor.setIsExist(1);
    	boolean result = dao.addFloor(newfloor);
    	
    	
		int numPost=post.getNumpost()+1;
		post.setNumpost(numPost);
		post.setNewtime(newfloor.getFloortime());
		dao.updateReply(post);
    	int pageNum = 1;
    	
    	String pageNumString=request.getParameter("nowPage");
    
    	if (pageNumString != null) {
    		pageNum = Integer.parseInt(pageNumString);
    	}
    	int pageSize = 10;
    	Page p = dao.findAllFloorWithPage(pageNum, pageSize, postid);
    	model.addAttribute("page", p);
    	session.setAttribute("page", p);
    	List<Floor> fl = p.getList();
    	
    	List<Post> posted2 = dao.queryForPostByPostId(postid);
    	Post currentpost = posted2.get(0);
    	List<User> postuser = dao.queryByID(currentpost.getUserid());
    	List<String> ul = new ArrayList();
    	for (int i = 0; i < fl.size(); i++) {
    		String thisuser = dao.queryByID(fl.get(i).getUserid()).get(0).getUsername();
    		ul.add(thisuser);
    	}
    	
    	List<Floor> allfloor = dao.queryAllFloor(postid);
    	List<String> ansusername = new ArrayList();
		for (int i = 0; i < allfloor.size(); i++) {
			if(allfloor.get(i).getAnsfloorid()==0) {
				List<User> ansusered = dao.queryByID(currentpost.getUserid());
				ansusername.add(ansusered.get(0).getUsername());
			}else {
				List<Floor> ansfloored = dao.queryFloorByFloorIdandPostId(allfloor.get(i).getAnsfloorid(), postid);
				Floor ansfloor = ansfloored.get(0);
				List<User> ansusered = dao.queryByID(ansfloor.getUserid());
				User ansuser = ansusered.get(0);
				ansusername.add(ansuser.getUsername());
			}			
		}
		
		session.setAttribute("ansname", ansusername);
    	
    	// List<Floor> floored = dao.queryForReplyedByPost(currentpost.getPostid());
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
	 * 管理员封禁和删除 TODO
     * @throws UnsupportedEncodingException 
	 * 
	 */
	@RequestMapping(value = "/banAndDelete")
	public String setBanAndDelete(Model model, HttpSession session, HttpServletRequest request,HttpServletResponse response) throws UnsupportedEncodingException {
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		User currentuser = (User) session.getAttribute("CurrentUser");
		UserDao dao = (UserDao) context.getBean("dao");
		if (request.getHeader("Referer").toString().contains("banAndDelete")) {
			response.setContentType("text/html;charset=utf-8");
	        request.setCharacterEncoding("utf-8");
			String isBanned = request.getParameter("isBanned");
			String isDeleted = request.getParameter("isDeleted");
			String bdReason = request.getParameter("bdReason");
			if (isBanned!=null) {
				int bannedPostId = Integer.parseInt(isBanned);
				Post bannedPost=dao.queryForPostByPostId(bannedPostId).get(0);
				dao.setBanned(bannedPost);
				int messageid=dao.queryAllMessage().size()+1;
				SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");// 设置日期格式
				String nowtime = df.format(new Date());
				String messageContent="您的帖子"+bannedPost.getTitle()+"由于"+bdReason+"，被封禁了。";
				Message message=new Message(messageid,bannedPost.getUserid(),nowtime,messageContent,currentuser.getId());
				dao.addMessage(message);
			}
			if (isDeleted!=null) {
				int deletedPostId = Integer.parseInt(isDeleted);
				Post deletedPost=dao.queryForPostByPostId(deletedPostId).get(0);
				dao.setDeleted(deletedPost);
				int messageid=dao.queryAllMessage().size()+1;
				SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");// 设置日期格式
				String nowtime = df.format(new Date());
				String messageContent="您的帖子"+deletedPost.getTitle()+"由于"+bdReason+"，被删除了。";
				Message message=new Message(messageid,deletedPost.getUserid(),nowtime,messageContent,currentuser.getId());
				dao.addMessage(message);
			}
		}
		//如果是超级管理员
		if (currentuser.getIsForumAdmin() != 0) {
			if (request.getHeader("Referer").toString().contains("banAndDelete")) {
				String searchPostByKeyWord = request.getParameter("searchPostByKeyWord");
				
				if (searchPostByKeyWord!=null) {
					List<Post> pl = dao.queryForPostByPostTitle(searchPostByKeyWord);
					model.addAttribute("searchedPost", pl);
					session.setAttribute("searchedPost", pl);
					List<String> sboardNameList = new ArrayList();
					List<String> suserNameList = new ArrayList();
					for (int i = 0; i < pl.size(); i++) {
						sboardNameList.add(dao.queryBoardByBoardId(pl.get(i).getBoardid()).get(0).getBoardname());
						suserNameList.add(dao.queryByID(pl.get(i).getUserid()).get(0).getUsername());
					}
					model.addAttribute("sboardNameList", sboardNameList);
					session.setAttribute("sboardNameList", sboardNameList);
					model.addAttribute("suserNameList", suserNameList);
					session.setAttribute("suserNameList", suserNameList);
				} 
			}
			
		}
		//是板块管理员
		else if (currentuser.getIsBoardAdmin() != 0) {
			if (request.getHeader("Referer").toString().contains("banAndDelete")) {
			String searchPostByKeyWord = request.getParameter("searchPostByKeyWord");
			String bdReason = request.getParameter("bdReason");
				if (searchPostByKeyWord!=null) {
					int boardid=currentuser.getIsBoardAdmin();
					List<Post> pl = dao.queryForPostByPostTitleInABoard(searchPostByKeyWord,boardid);
					model.addAttribute("searchedPost", pl);
					session.setAttribute("searchedPost", pl);
					List<String> sboardNameList = new ArrayList();
					List<String> suserNameList = new ArrayList();
					for (int i = 0; i < pl.size(); i++) {
						sboardNameList.add(dao.queryBoardByBoardId(pl.get(i).getBoardid()).get(0).getBoardname());
						suserNameList.add(dao.queryByID(pl.get(i).getUserid()).get(0).getUsername());
					}
					model.addAttribute("sboardNameList", sboardNameList);
					session.setAttribute("sboardNameList", sboardNameList);
					model.addAttribute("suserNameList", suserNameList);
					session.setAttribute("suserNameList", suserNameList);
				} 
			}
		}
		else {
			return "index.jsp";
		}
		return "banAndDelete.jsp";
	}
}