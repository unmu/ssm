package com.groupfour.entity;

import java.util.List;

public class Menu {
	
	private Integer menuId;
	private String menuName;
	private String menuUrl;
	private Integer parentId;
	private List<Menu> childrenMenuList;
	public Integer getMenuId() {
		return menuId;
	}
	public void setMenuId(Integer menuId) {
		this.menuId = menuId;
	}
	public String getMenuName() {
		return menuName;
	}
	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}
	public String getMenuUrl() {
		return menuUrl;
	}
	public void setMenuUri(String menuUrl) {
		this.menuUrl = menuUrl;
	}
	public Integer getParentId() {
		return parentId;
	}
	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}
	public List<Menu> getChildrenMenuList() {
		return childrenMenuList;
	}
	public void setChildrenMenuList(List<Menu> childrenMenuList) {
		this.childrenMenuList = childrenMenuList;
	}

}
