package controller;

import java.util.List;


import org.springframework.web.context.request.*;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.*;
import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.*;

import bean.User;
import bean.Post;
import bean.Board;
import bean.Floor;
import bean.Page;
import dao.UserDao;

@Controller
public class UserController {
	
	
	@RequestMapping(value = "/board/{boardid}")
    public String enterBoard(@PathVariable int boardid, Model model, HttpSession session,HttpServletRequest request) {
    	ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
    	UserDao dao = (UserDao) context.getBean("dao");
    	List<Board> bl = dao.queryBoardByBoardId(boardid);
    	Board nowboard = bl.get(0);
    	String boardname=nowboard.getBoardName();
    	model.addAttribute("nowBoardName", boardname);
    	model.addAttribute("nowBoardId", boardid);
    	//String aa=session.getAttribute("NowBoard").toString();
    	List<Post> post = dao.queryPostByBoardId(boardid);
    	model.addAttribute("CurrentPost", post);  
    	int pageNum=1;
       	if(request.getQueryString()!=null) {
       		pageNum=Integer.parseInt(request.getParameter("page").toString() );
       	}
		/*
		 * if () { // 存在 id 参数 } String a=request.getParameter("page").toString();
		 */
		/*
		 * if( request.getParameter("page").toString().equals("")) {
		 * pageNum=Integer.parseInt(request.getParameter("page").toString() ); }
		 */
       	
		  int pageSize=5; 
		  Page p=dao.findAllPostWithPage(pageNum,pageSize,boardid);
		  model.addAttribute("page", p); session.setAttribute("page", p);
		 
    	return "/board1.jsp";
    }
	

	@RequestMapping(value = "/board/{boardid}/post/{postid}")

    public String enterPost(@PathVariable int boardid, Model model, HttpSession session) {
    	  	
    	return "/content001.jsp";
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
    public String CheckLogin(@RequestParam("username") String username, @RequestParam("password") String password, Model model, HttpSession session) {
    	ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");

    	UserDao dao = (UserDao) context.getBean("dao");
    	List<User> user = dao.queryByName(username);
    	if(user.isEmpty()) {
    		return "login.jsp";
    	}
    	if(user.get(0).getPassword().equals(password)) {
    		model.addAttribute("CurrentUser", user.get(0));
    		session.setAttribute("CurrentUser", user.get(0));
    		return "home1.jsp";
    	}
    	else {
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
    	User currentuser = (User)session.getAttribute("CurrentUser");
    	UserDao dao = (UserDao) context.getBean("dao");
    	
    	List<Post>  post = dao.queryForPostedByUser(currentuser.getId());
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

    public String msg(String msg) {
	return "<script>alert('" + msg + "')</script>";
    }
}

