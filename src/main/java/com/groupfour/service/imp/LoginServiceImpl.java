package com.groupfour.service.imp;

import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.groupfour.dao.LoginDao;
import com.groupfour.entity.Menu;
import com.groupfour.entity.Users;
import com.groupfour.service.LoginService;

@Service
public class LoginServiceImpl implements LoginService {

	@Autowired
	private LoginDao dao;

	@Override
	@Transactional//可省？
	public Users getUsersByNameAndPwd(String username, String password) {
		System.out.println("getUsersByNameAndPwd " + username + " " + password);
		Users user = dao.getUsersByNameAndPwd(username, password);
		if (user != null && user.getRole() != null && user.getRole().getRoleId() != null) {
			// 通过roleId查询夫菜单信息
			List<Menu> menuList = dao.getMenuListByRoleIdAndParenMenu(user.getRole().getRoleId(), 0);//默认parent = 0
			// 循环输出所有父级菜单信息，通过菜单id查询该父菜单对于的子菜单信息
			for (Menu parentMenu : menuList) {
				List<Menu> childMenus = dao.getMenuListByRoleIdAndParenMenu(user.getRole().getRoleId(), parentMenu.getMenuId());
				parentMenu.setChildrenMenuList(childMenus);
				Iterator<Menu> it = childMenus.iterator();
				while (it.hasNext()) {
					Menu menu = it.next();
					System.out.println(menu.getMenuId() + "," + menu.getMenuName());
				}
			}
			user.getRole().setMenuList(menuList);
		}
		return user;
	}

}
