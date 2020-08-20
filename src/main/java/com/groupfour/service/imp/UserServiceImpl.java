package com.groupfour.service.imp;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.groupfour.dao.UserDao;
import com.groupfour.entity.Users;
import com.groupfour.service.UserService;

@Service
public class UserServiceImpl implements UserService{
	
	@Autowired
	private UserDao userDao;
	

	@Override
	public void inserUser(Users users) {
		userDao.inserUser(users);
	}

	@Override
	public boolean deleteUser(String userName) {
		return false;
	}

	@Override
	public boolean updateUser(Users user) {
		return false;
	}

	@Override
	public List<Users> getAllUserList() {
		return userDao.getAllUserList();
	}

	@Override
	public List<Users> searchUserList(String userName, Integer roleId) {
		return userDao.searchUserList(userName, roleId);
	}

	@Override
	public Users getUserByUserId(String userName) {
		return null;
	}
}
