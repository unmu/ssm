package com.groupfour.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.groupfour.entity.Users;
import com.groupfour.service.RoleService;
import com.groupfour.service.UserService;

@Controller
@RequestMapping("users")
public class UserController {
	@Autowired
	private UserService service;
	@Autowired
	private RoleService roleService;

	@RequestMapping("userList")
	public String getAllUsers(Model model) {
		PageHelper.startPage(1, 4);
		List userList = this.service.getAllUserList();
		List roleList = this.roleService.getAllRoleList();
		PageInfo page = new PageInfo(userList);
		model.addAttribute("page", page);
		System.out.println(page);
		model.addAttribute("roleList", roleList);
		return "main/userList";
	}

	@RequestMapping("searchUsers")
	@ResponseBody
	public PageInfo<Users> searchUsers(String userName, Integer roleId, Integer pageNumber, Integer pageSize) {
		System.out.println(userName + ":" + roleId);
		System.out.println(pageSize + ":" + pageNumber);
		PageHelper.startPage(pageNumber.intValue(), pageSize.intValue());
		List<Users> users = this.service.searchUserList(userName, roleId);
		PageInfo page = new PageInfo(users);
		System.out.println(page);
		return page;
	}
	
	@RequestMapping("addUser")
	@ResponseBody
	public String addUser(String addId, String addName, String addPass, String addPhone) {
		System.out.println(addId);
		Users users = new Users();
		service.inserUser(users);
		return "main/userList";
	}

}
