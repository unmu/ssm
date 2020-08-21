package com.groupfour.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.groupfour.entity.Role;
import com.groupfour.entity.Users;

public interface RoleDao {
	
	/**
	 * 获取所有
	 * @return
	 */
	public List<Role> getAllRoleList();
	
	/**
	 * 添加角色信息
	 * @param role
	 * @return
	 */
	public Integer insertRole(Role role);
	
	/**
	 * 添加该角色对应的菜单权限
	 * @param roleId
	 * @param menuIds
	 * @return
	 */
	public boolean insertRoleMenu(@Param("roleId") Integer roleId, @Param("menuIds") Integer[] menuIds);

	/**
	 * 修改sys_role
	 * @param role
	 * @return
	 */
	public boolean updateRole(Role role);
	
	/**
	 * 删除sys_role中的 role_id = roleId的记录
	 * @param roleId
	 * @return
	 */
	public boolean deleteRole(Integer roleId);
	
	/**
	 * 删除roleId对应的sys_role_menu中role_id = roleId的记录
	 * @param roleId
	 * @return
	 */
	public boolean deleteRoleMenu(Integer roleId);

	/**
	 * 查询roleId对应的用户信息
	 * @param roleId
	 * @return
	 */
	public List<Users> getUsersRoleByRoleId(Integer roleId);

	
	
}
