package com.groupfour.service;

import java.util.List;

import com.groupfour.entity.Menu;
import com.groupfour.entity.Role;
import com.groupfour.entity.Users;

public interface RoleService {

	/**
	 * 获取所有角色信息
	 * @return
	 */
	public List<Role> getAllRoleList();
	
	/**
	 * 添加角色信息
	 * @param role
	 * @return
	 */
	public Role insertRole(Role role);

	/**
	 * 判断该角色是否被使用，若角色正在使用，给出提示“正在使用中”；否则，删除该角色
	 * @param roleId
	 * @return
	 */
	public List<Users> getUsersRoleByRoleId(Integer roleId);
	
	/**
	 * 通过roleId删除该角色信息 - sys_role
	 * 包括该角色对应的菜单权限信息 - sys_role_menu
	 * @param roleId
	 * @return
	 */
	public boolean deleteRole(Integer roleId);
	
	/**
	 * 根据role修改sys_role
	 * @param role
	 * @return
	 */
	public boolean updateRole(Role role);
	
	/**
	 * 查询所有的菜单信息
	 * @return
	 */
	public List<Menu> getAllMenuList();
	
	/**
	 * 查询roleId对应的菜单信息
	 * 包括父菜单和父菜单对应的子菜单信息
	 * @param roleId
	 * @return
	 */
	public List<Menu> getMenusByRoleId(Integer roleId);
	
	/**
	 * 先删除roleId对应的所有菜单，接着重新添加
	 * @param roleId
	 * @param menuIds
	 * @return
	 */
	public boolean editRoleMenu(Integer roleId, Integer[] menuIds);

}
