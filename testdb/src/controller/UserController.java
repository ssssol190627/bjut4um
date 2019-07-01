package controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import org.springframework.web.context.request.*;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.*;
import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.*;

import bean.*;
import dao.UserDao;

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
     * ������ҳ����
     * 
     */
    @RequestMapping(value = "/home1")
    public String toHome1(HttpSession session) {
    	if(session.getAttribute("CurrentUser")==null) {
    		return "/index.jsp";
    	}
    	return "/home1.jsp";
    }
    
    /**
     * 
     * �˳���¼
     * 
     */
    @RequestMapping(value = "/quit")
    public String QuitbyUser(HttpSession session) {
    	session.invalidate();
    	return "index.jsp";
    }
    
    /**
     * 
     * ��תע�����
     * 
     */
    @RequestMapping(value = "/registerpage")
    public String toRegister() {
    	return "register.jsp";
    }
    
	/**
     * 
     * ע��
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
        		model.addAttribute("msg", "<script>alert('��ӳɹ���')</script>");
    			return "home1.jsp";
        	}
        	else {
        		return "register.jsp";
        	}
    	}
    }
    
    /**
     * 
     * ��ת������ʾ����
     * 
     */
    @RequestMapping(value = "/detailedpost/{postid}")
    public String toPost(@PathVariable("postid") int postid, Model model, HttpSession session) {
    	ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
    	UserDao dao = (UserDao) context.getBean("dao");
    	
    	User currentuser = (User)session.getAttribute("CurrentUser");
    	List<Post> posted=dao.queryForPostedByUser(currentuser.getId());
    	Post currentpost = posted.get(postid);
    	List<User> postuser=dao.queryByID(currentpost.getUserid());
    	List<Floor> floored = dao.queryForReplyedByPost(currentpost.getPostid());
    	model.addAttribute("floors", floored);
    	model.addAttribute("postuser", postuser.get(0));
    	model.addAttribute("post", currentpost);
    	return "/content001.jsp";
    }
    
    /**
     * 
     * �ٱ�
     * 
     */
    @RequestMapping(value = "/detailedpost/report")
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
    		model.addAttribute("msg", "<script>alert('��ӳɹ���')</script>");
			return "/content001.jsp";
    	}
    	else {
    		return "/index.jsp";
    	}
    }
    
    /**
     * 
     * ��ȡ���
     * 
     */
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
		 * if () { // ���� id ���� } String a=request.getParameter("page").toString();
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
	
    /**
     * 
     * �Ӱ�������Ӧ������
     * 
     */
	@RequestMapping(value = "/board/{boardid}/post/{postid}")
    public String enterPost(@PathVariable int boardid, Model model, HttpSession session) {
    	  	
    	return "/content001.jsp";
    }

    /**
     * 
     * �����ݿ��л�ȡȫ��ѧ����Ϣ�������ݷ��ظ���ҳindex,jsp
     * 
     */
   /* @RequestMapping(value = "/all")
    public String queryAll(Model model) {
	ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
	//��ioc�����л�ȡdao
	UserDao dao = (UserDao) context.getBean("dao");
	model.addAttribute("Users", dao.queryAll());
	model.addAttribute("tops", dao.topNum(3));
	return "index.jsp";
    }*/

    /**
     * ͨ����������ѧ����ʹ��ģ�����ң���������ظ�index.jsp
     * 
     */
    /*@RequestMapping(value = "/queryByName")
    public String queryByName(String name, Model model) {
    	ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
	//��ioc�����л�ȡdao
    	UserDao dao = (UserDao) context.getBean("dao");
    	model.addAttribute("Users", dao.queryByName(name));
    	model.addAttribute("tops", dao.topNum(3));
    	return "index.jsp";
    }*/

    /**
     * �����ѧ��������������ظ�allҳ�棬��allת������ҳ
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
    		model.addAttribute("msg", "<script>alert('��ӳɹ���')</script>");
    	else
    		model.addAttribute("msg", "<script>alert('��ӳɹ���')</script>");
    	return "all";
    }*/

    /**
     * ͨ��idɾ��ѧ��
     */
    @RequestMapping(value = "/deleteById")
    public String deleteById(String id, Model model) {
	ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
	UserDao dao = (UserDao) context.getBean("dao");
	boolean result = dao.deleteStu(Integer.parseInt(id));
	if (result)
	    model.addAttribute("msg", "<script>alert('ɾ���ɹ���')</script>");
	else
	    model.addAttribute("msg", "<script>alert('ɾ���ɹ���')</script>");
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
    		model.addAttribute("msg", msg("�޸ĳɹ�"));
    	else
    		model.addAttribute("msg", msg("�޸�ʧ��"));
    	return "all";
    }*/

    /**
     * Ҫ������ҳ����Ϣ
     * @param msg
     * @return ����ֵ���ͣ� String
     * @author janinus
>>>>>>> branch 'master' of https://github.com/ssssol190627/bjut4um.git
     */
    public String msg(String msg) {
	return "<script>alert('" + msg + "')</script>";
    }
}