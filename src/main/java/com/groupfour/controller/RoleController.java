package com.groupfour.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.groupfour.entity.Menu;
import com.groupfour.entity.Role;
import com.groupfour.entity.Users;
import com.groupfour.service.RoleService;

@Controller
@RequestMapping("role")
public class RoleController {

	@Autowired
	private RoleService service;

	@RequestMapping("roleList")
	public String roleList(ModelMap modelMap) {
		System.out.println("to roleList");
		List<Role> roleList = service.getAllRoleList();
		List<Menu> menuList = service.getAllMenuList();
		modelMap.addAttribute("roleList", roleList);
		modelMap.addAttribute("menuList", menuList);
		return "main/roleList";
	}

	@RequestMapping("insertRole")
	@ResponseBody
	public Role insertUser(String roleName) {
		System.out.println("insertRole");
		Role role = new Role();
		role.setRoleName(roleName);
		role = service.insertRole(role);
		return role;
	}

	@RequestMapping("deleteRole")
	@ResponseBody
	public Integer deleteRole(Integer roleId) {
		System.out.println("deleteRole");
		List<Users> users = service.getUsersRoleByRoleId(roleId);
		if (users.size() == 0) {
			boolean flag = service.deleteRole(roleId);
			if (flag) {
				return 1; // "删除成功";
			} else {
				return 2; // "删除失败";
			}
		} else {
			System.out.println("###");
			return 3; // "该角色尚在使用中，不能删除";
		}
	}

	@RequestMapping("updateRole")
	@ResponseBody
	public boolean updateRole(String roleName, Integer roleId) {
		System.out.println("updateRole");
		Role role = new Role();
		role.setRoleId(roleId);
		role.setRoleName(roleName);
		return service.updateRole(role);
	}

	@RequestMapping("getMenuListByRoleId")
	@ResponseBody
	public List<Menu> getMenuListByRoleId(Integer roleId) {
		System.out.println("getMenuListByRoleId");
		List<Menu> menuList = service.getMenusByRoleId(roleId);
//		for (Menu menu : menuList) {
//			List<Menu> childMenu  = menu.getChildrenMenuList();
//		}
		return menuList;
	}
	
	@RequestMapping("editRoleMenu")
	@ResponseBody
	public boolean editRoleMenu(Integer roleId, String menus) {
		System.out.println("editRoleMenu");
		String str = menus.endsWith("|") ? menus.substring(0, menus.length() - 1) : menus;
		String[] str1 = str.split("\\|");
		Integer[] menuIds = new Integer[str1.length];
		for (int i = 0; i < str1.length; i++) {
			menuIds[i] = Integer.valueOf(str1[i]);
		}
		System.out.println(service.editRoleMenu(roleId, menuIds));
		return service.editRoleMenu(roleId, menuIds);
	}

}
