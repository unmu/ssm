package com.groupfour.service.imp;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.groupfour.dao.MenuDao;
import com.groupfour.entity.Menu;
import com.groupfour.service.MenuService;

@Service
public class MenuServiceImpl implements MenuService {

	@Autowired
	private MenuDao dao;
	
	@Autowired
	private MenuService service;
	
	@Override
	public List<Menu> getParentMenuList() {
		return dao.getParentMenuList();
	}

	@Override
	public List<Menu> getChildMenuListByParentId(Integer parentId) {
		List<Menu> childrenMenuList = new ArrayList<Menu>();
		childrenMenuList = dao.getChildMenuListByParentId(parentId);
		return childrenMenuList;
	}

	@Override
	public Menu insertMenu(Menu menu) {
		dao.insertMenu(menu);
		return menu;
	}

	@Override
	public Menu getMenuById(Integer menuId) {
		return dao.getMenuById(menuId);
	}

	@Override
	public boolean updateMenu(Menu menu) {
		return dao.updateMenu(menu);
	}

	@Override
	public boolean deleteMenu(Integer menuId) {
		return dao.deleteMenu(menuId);
	}

}
