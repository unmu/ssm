package com.groupfour.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.groupfour.entity.Users;
import com.groupfour.service.LoginService;

@Controller
public class LoginController {// 获取数据

	@Autowired
	private LoginService service;

	@RequestMapping("login")
	public ModelAndView login(String username, String password) {
		Users users = service.getUsersByNameAndPwd(username, password);
		// Users users = service.getUsersByNameAndPwd("admin", "123456");
		// System.out.println(users.getUserName() + " " + users.getPassword());
		ModelAndView view = new ModelAndView();
		view.addObject("users", users);
		view.setViewName("main");
		return view;
	}

}
