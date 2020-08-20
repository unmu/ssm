package com.groupfour.service;

import java.util.List;

import com.groupfour.entity.Users;


public interface UserService {
	
	/**
	 * 查询所有用户信息,包括用户角色信息
	 * @return
	 */
	public List<Users> getAllUserList();
	
	/**
	 * 通过用户名和角色id查询用户信息
	 * @param arg0
	 * @param arg1
	 * @return
	 */
	List<Users> searchUserList(String userName, Integer roleId);
	
	/**
	 * 添加用户信息sys_user，包括该用户对应的角色信息sys_user_role
	 * 其中password要求赋值“111111”
	 * @param users
	 */
	public void inserUser(Users users);
	
	/**
	 * 通过用户名删除该用户信息，sys_user
	 * 包括该用户对应的角色信息sys_user_role
	 * @param userName
	 * @return
	 */
	public boolean deleteUser(String userName);
	
	/**
	 * 通过用户名取用户信息sys_user，sys_user_role（userId，user_name，roleId）
	 * @param userName
	 * @return
	 */
	public Users getUserByUserId(String userName);
	
	/**
	 * 根据user修改sys_user，sys_user_role的信息
	 * @param user
	 * @return
	 */
	public boolean updateUser(Users user);

}
