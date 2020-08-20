package com.groupfour.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.groupfour.entity.Menu;

public interface MenuDao {

	public List<Menu> getParentMenuList();

	public List<Menu> getChildMenuListByParentId(@Param("parentId")Integer parentId);

	public void insertMenu(Menu menu);

	public Menu getMenuById(@Param("menuId")Integer menuId);
	
	public boolean updateMenu(Menu menu);
	
	public boolean deleteMenu(@Param("menuId")Integer menuId);

}
