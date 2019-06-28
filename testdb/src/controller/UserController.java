package controller;

import java.util.List;
import org.springframework.web.context.request.*;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.*;
import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.*;

import bean.User;
import bean.Post;
import bean.Floor;
import dao.UserDao;

@Controller
public class UserController {
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

    /**
     * 
     * 从数据库中获取全部学生信息，将数据返回给主页index,jsp
     * 
     */
   /* @RequestMapping(value = "/all")
    public String queryAll(Model model) {
	ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
	//从ioc容器中获取dao
	UserDao dao = (UserDao) context.getBean("dao");
	model.addAttribute("Users", dao.queryAll());
	model.addAttribute("tops", dao.topNum(3));
	return "index.jsp";
    }*/

    /**
     * 通过姓名查找学生，使用模糊查找，将结果返回给index.jsp
     * 
     */
    /*@RequestMapping(value = "/queryByName")
    public String queryByName(String name, Model model) {
    	ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
	//从ioc容器中获取dao
    	UserDao dao = (UserDao) context.getBean("dao");
    	model.addAttribute("Users", dao.queryByName(name));
    	model.addAttribute("tops", dao.topNum(3));
    	return "index.jsp";
    }*/

    /**
     * 添加新学生，并将结果返回给all页面，由all转发到主页
     */
   /* @RequestMapping(value = "/add")
    public String addStu(String name, String javaScore, String htmlScore, String cssScore, Model model) {
    	ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
    	UserDao dao = (UserDao) context.getBean("dao");
    	User User = new User();
    	User.setUsername(name);
    	User.setJavaScore(Double.parseDouble(javaScore));
    	User.setHtmlScore(Double.parseDouble(htmlScore));
    	User.setCssScore(Double.parseDouble(cssScore));
    	boolean result = dao.addStu(User);
    	if (result)
    		model.addAttribute("msg", "<script>alert('添加成功！')</script>");
    	else
    		model.addAttribute("msg", "<script>alert('添加成功！')</script>");
    	return "all";
    }*/

    /**
     * 通过id删除学生
     */
    @RequestMapping(value = "/deleteById")
    public String deleteById(String id, Model model) {
	ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
	UserDao dao = (UserDao) context.getBean("dao");
	boolean result = dao.deleteStu(Integer.parseInt(id));
	if (result)
	    model.addAttribute("msg", "<script>alert('删除成功！')</script>");
	else
	    model.addAttribute("msg", "<script>alert('删除成功！')</script>");
	return "all";
    }

    /**
     * 
     * @param id
     * @param name
     * @param javaScore
     * @param htmlScore
     * @param cssScore
     */
    /*@RequestMapping(value = "/update")
    public String updateStu(String id, String name, String javaScore, String htmlScore, String cssScore, Model model) {
    	ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
    	UserDao dao = (UserDao) context.getBean("dao");
    	User User = new User();
    	User.setId(Integer.parseInt(id));
    	User.setUsername(name);
    	User.setJavaScore(Double.parseDouble(javaScore));
    	User.setHtmlScore(Double.parseDouble(htmlScore));
    	User.setCssScore(Double.parseDouble(cssScore));
    	boolean result = dao.updateStu(User);
    	if (result)
    		model.addAttribute("msg", msg("修改成功"));
    	else
    		model.addAttribute("msg", msg("修改失败"));
    	return "all";
    }*/

    /**
     * 要弹出的页面消息
     * @param msg
     */
    public String msg(String msg) {
	return "<script>alert('" + msg + "')</script>";
    }
}

