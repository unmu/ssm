package com.groupfour.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.groupfour.entity.Menu;
import com.groupfour.service.MenuService;

@Controller
@RequestMapping("menu")
public class MenuController {
	
	@Autowired
	private MenuService service;
	
	@RequestMapping("menuList")
	public String menuList(ModelMap modelMap) {
		System.out.println("to menu/menuList");
		List<Menu> list = service.getParentMenuList();
		modelMap.addAttribute("menuList", list);
		return "main/menuList";
	}
	
	@RequestMapping("getChildMenusByParentId")
	@ResponseBody
	public List<Menu> getChildMenuListByParentId(Integer parentId) {
		System.out.println("do getChildMenusByParentId");
		List<Menu> list = service.getChildMenuListByParentId(parentId);
		return list;
	}
	
	@RequestMapping("getMenuById")
	@ResponseBody
	public Menu getMenuById(Integer menuId) {
		System.out.println("do getMenuId");
		return service.getMenuById(menuId);
	}
	
	@RequestMapping("insertMenu")
	@ResponseBody
	public Menu insertMenu(String menuName, String menuUrl, Integer parentId) {
		System.out.println("do insertMenu");
		Menu menu = new Menu();
		if (parentId == null) {
			menu.setParentId(0);
			menu.setMenuUri("#");
		} else {
			menu.setParentId(parentId);
			menu.setMenuUri(menuUrl);
		}
		menu.setMenuName(menuName);
		System.out.println(menuName);
		return service.insertMenu(menu);
	}
	
	@RequestMapping("updateMenu")
	@ResponseBody
	public boolean updateMenu(Integer menuId, String menuName, String menuUrl, Integer parentId) {
		System.out.println("do updateMenu" + parentId);
		Menu menu = new Menu();
		menu.setMenuId(menuId);
		menu.setMenuName(menuName);
		if (parentId == 0) {
			menu.setMenuUri("#");
		} else {
			menu.setMenuUri(menuUrl);
		}
		menu.setParentId(parentId);
		return service.updateMenu(menu);
	}
	
	@RequestMapping("deleteMenu")
	@ResponseBody
	public boolean deleteMenu(Integer menuId) {
		System.out.println("do deleteMenu");
		System.out.println(service.deleteMenuPermissed(menuId));
		if (service.deleteMenuPermissed(menuId) == true) {
			return service.deleteMenu(menuId);
		}
		return false;
	}
	
}
