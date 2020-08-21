package com.groupfour.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.groupfour.entity.Menu;
import com.groupfour.entity.Users;

public interface LoginDao {
	
	public Users getUsersByNameAndPwd(@Param("userName")String username, @Param("password")String password);
	//LoginMapper.xml中的user_name=#{userName} and password=#{password}的userName和password
	
	public List<Menu> getMenuListByRoleIdAndParenMenu(@Param("roleId")Integer roleId, @Param("parentId")Integer parentId);

	public List<Menu> getParentMenuList(@Param("roleId")Integer roleId);

	public List<Menu> getChildrenMenuListByParentAndRole(@Param("parentId")Integer menuId, @Param("roleId")Integer roleId);

}
