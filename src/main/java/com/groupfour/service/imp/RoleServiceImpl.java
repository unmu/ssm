package com.groupfour.service.imp;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.groupfour.dao.LoginDao;
import com.groupfour.dao.MenuDao;
import com.groupfour.dao.RoleDao;
import com.groupfour.entity.Menu;
import com.groupfour.entity.Role;
import com.groupfour.entity.Users;
import com.groupfour.service.RoleService;

@Service
public class RoleServiceImpl implements RoleService{
	
	@Autowired
	private RoleDao roleDao;
	
	@Autowired
	private LoginDao loginDao;
	
	@Autowired
	private MenuDao menuDao;

	@Override
	public List<Role> getAllRoleList(){
		return roleDao.getAllRoleList();
	}

	@Override
	public Role insertRole(Role role) {
		roleDao.insertRole(role);
		return role;
	}
	
	@Override
	public boolean deleteRole(Integer roleId) {
		if (roleId != null) {
			boolean flag = roleDao.deleteRole(roleId);
			if (flag) {
				roleDao.deleteRoleMenu(roleId);
				return true;
			}
		}
		return false;
	}
	
	@Override
	public boolean updateRole(Role role) {
		if (role != null && role.getRoleId() != null) {
			return roleDao.updateRole(role);
		}
		return false;
	}

	@Override
	public List<Menu> getMenusByRoleId(Integer roleId) {
		List<Menu> menuList = new ArrayList<Menu>();
		menuList = loginDao.getParentMenuList(roleId);
		for (Menu menu : menuList) {
			List<Menu> childrenMenuList = new ArrayList<Menu>();
			childrenMenuList = loginDao.getChildrenMenuListByParentAndRole(menu.getParentId(), roleId);
			System.out.println(childrenMenuList);
			menu.setChildrenMenuList(childrenMenuList);
		}
		return menuList;
	}

	@Override
	public List<Users> getUsersRoleByRoleId(Integer roleId) {
		return roleDao.getUsersRoleByRoleId(roleId);
	}

	@Override
	public List<Menu> getAllMenuList() {
		List<Menu> menuList = new ArrayList<Menu>();
		menuList = menuDao.getAllMenuList();
		for (Menu menu : menuList) {
			List<Menu> childrenMenuList = new ArrayList<Menu>();
			Integer parentId = menu.getMenuId();
			childrenMenuList = menuDao.getChildMenuListByParentId(parentId);
			System.out.println("getAllMenuList" + childrenMenuList);
			menu.setChildrenMenuList(childrenMenuList);
		}
		return menuList;
	}

	@Override
	public boolean editRoleMenu(Integer roleId, Integer[] menuIds) {
		try {
			roleDao.deleteRoleMenu(roleId);
			roleDao.insertRoleMenu(roleId, menuIds);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
}
