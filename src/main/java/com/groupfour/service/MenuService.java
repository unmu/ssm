package com.groupfour.service;

import java.util.List;

import com.groupfour.entity.Menu;

public interface MenuService {

	/**
	 * 获取所有父菜单信息
	 * @return
	 */
	public List<Menu> getParentMenuList();

	/**
	 * 根据父菜单信息，查询该父菜单对应的功能菜单信息
	 * @return
	 */
	public List<Menu> getChildMenuListByParentId(Integer parentId);
	
	/**
	 *  添加菜单信息，menuId自增
	 *  如果添加父菜单，则parentId = 0, menuUrl = "#"
	 * @param menu
	 * @return
	 */
	public Menu insertMenu(Menu menu);
	
	/**
	 * 通过menuId获取menu信息
	 * @param menuId
	 * @return
	 */
	public Menu getMenuById(Integer menuId);
	
	/**
	 * 根据menu参数更新菜单信息
	 * @param menu
	 * @return
	 */
	public boolean updateMenu(Menu menu);
	
	/**
	 * 通过menuId判断其是否被使用，若被使用，则不能删除（在Controller中进行判断）；
	 * 若未被使用，需判断menuId是否是分类菜单，通过menuId查询其menu信息，
	 * 若对应menu信息的parent = 0，则其为一父类菜单，否则为子类菜单，子类菜单可直接删除
	 * 若其为父类菜单，需判断其有无子类菜单，若无子类菜单，则直接删除；否则不能删除。
	 * @param menuId
	 * @return
	 */
	public boolean deleteMenu(Integer menuId);
	
}
