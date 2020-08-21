package com.groupfour.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.groupfour.entity.Role;
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
		System.out.println("to userList");
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
		System.out.println("searchUsers");
		System.out.println(userName + ":" + roleId);
		System.out.println(pageSize + ":" + pageNumber);
		PageHelper.startPage(pageNumber.intValue(), pageSize.intValue());
		List<Users> users = this.service.searchUserList(userName, roleId);
		PageInfo page = new PageInfo(users);
		System.out.println(page);
		return page;
	}

//	@RequestMapping("addUser")
//	@ResponseBody
//	public String addUser(String addId, String addName, String addPass, String addPhone) {
//		System.out.println(addId);
//		Users users = new Users();
//		service.inserUser(users);
//		return "main/userList";
//	}

	@RequestMapping("insertUser")
	@ResponseBody
	public boolean insertUser(Users users) {
		System.out.println("insertUser");
		System.out.println(users);
		boolean flag = this.service.insertUser(users);
		return flag;
	}

	@RequestMapping("getUserByUserId")
	@ResponseBody
	public Users getUserByUserId(String userId) {
		System.out.println("getUserByUserId");
		Users user = this.service.getUserByUserId(userId);
		return user;
	}

	@RequestMapping("updateUser")
	@ResponseBody
	public boolean updateUser(String userId, String userName, Integer roleId) {
		System.out.println("updateUser");
		Users users = new Users();
		users.setUserId(userId);
		users.setUserName(userName);
		Role role = new Role();
		role.setRoleId(roleId);
		users.setRole(role);
		boolean flag = this.service.updateUser(users);
		return flag;

	}

	@RequestMapping("deleteUser")
	@ResponseBody
	public String deleteUser(String deleteId) {
		System.out.println("deleteUser");
		System.out.println(deleteId);
		service.deleteUser(deleteId);
		return "main/userList";
	}

}
