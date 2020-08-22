package com.groupfour.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import com.groupfour.entity.Users;
import com.groupfour.service.LoginService;

@Controller
@SessionAttributes("users")
public class LoginController {// 获取数据
	
	private String path = "/Hospital";//项目名（路径）

	@Autowired
	private LoginService service;

//	@RequestMapping("login")
//	public ModelAndView login(String username, String password) {
//		Users users = service.getUsersByNameAndPwd(username, password);
//		ModelAndView view = new ModelAndView();
//		view.addObject("users", users);
//		view.setViewName("main");
//		return view;
//	}
	
	// 打开login.jsp的入口
	@RequestMapping("login")
    public String toLogin() {
        return "login";
    }
	
	@RequestMapping("main")
	public String login() {
		return "main";
	}
	
	// 登录-用户名密码正确验证
	@RequestMapping("loginCheck")
	@ResponseBody
	public boolean loginCheck(Model model, String username, String password) {
	    System.out.println(username+":"+password);
		Users users = service.getUsersByNameAndPwd(username, password);
		System.out.println("用户:"+users);
		boolean flag= false;
		if (users!=null) {
			model.addAttribute("users",users);
			flag = true;
		}
		return flag;
	}

	// 退出登录
	@RequestMapping("logout")
	public String logout(HttpSession session, SessionStatus sessionStatus) {
		System.out.println("logout");
		//销毁session
		session.removeAttribute("users");
		session.invalidate();
		sessionStatus.setComplete();
		return "redirect: " + path + "/login";
	}

}
