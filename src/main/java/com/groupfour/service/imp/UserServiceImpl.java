package com.groupfour.service.imp;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.groupfour.dao.UserDao;
import com.groupfour.entity.Users;
import com.groupfour.service.UserService;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDao userDao;

	@Override
	public boolean insertUser(Users users) {
		if (users != null && !"".equals(users.getUserId())) {
			users.setPassword("111111");
			boolean flag = userDao.insertUser(users);
			if (flag) {
				if (users.getRole() != null && users.getRole().getRoleId() != null) {
					boolean flag1 = userDao.insertUserRole(users.getUserId(), users.getRole().getRoleId());
					if (flag1) {
						return true;
					}
				}
			}
		}
		return false;
	}

	@Override
	@Transactional
	public boolean updateUser(Users users) {
		if(users!=null&&!"".equals(users.getUserId())){
			System.out.println(users.getUserName());
			boolean flag=userDao.updateUser(users);
			if (flag) {
				if(users.getRole()!=null&&!"".equals(users.getRole().getRoleId())){
					System.out.println(users.getRole().getRoleId());
					boolean flag1=userDao.updateUserRole(users.getUserId(), users.getRole().getRoleId());
					if (flag1) {
						return true;
					}
				}
			}
		}
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
	public Users getUserByUserId(String userId) {
		return userDao.getUserByUserId(userId);
	}
	
	@Override
	public boolean deleteUser(String deleteId) {
	    try {
            userDao.deleteUserRole(deleteId);
            userDao.deleteUser(deleteId);
            return true;
        }catch (Exception e){
	        e.printStackTrace();
            return false;
        }
	}

}
