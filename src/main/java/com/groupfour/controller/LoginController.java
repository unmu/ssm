package com.groupfour.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.groupfour.entity.Users;
import com.groupfour.service.LoginService;

@Controller
@SessionAttributes("users")
public class LoginController {// 获取数据

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
	
	@RequestMapping("main")
	public String login() {
		return "main";
	}
	
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

}
