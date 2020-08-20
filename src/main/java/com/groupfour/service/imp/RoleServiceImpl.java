package com.groupfour.service.imp;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.groupfour.dao.RoleDao;
import com.groupfour.entity.Users;
import com.groupfour.service.RoleService;

@Service
public class RoleServiceImpl implements RoleService{
	
	@Autowired
	private RoleDao roleDao;

	public List<Users> getAllRoleList(){
		return roleDao.getAllRoleList();
	}
}
