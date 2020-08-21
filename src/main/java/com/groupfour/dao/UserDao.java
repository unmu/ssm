package com.groupfour.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.groupfour.entity.Users;

public interface UserDao {

	public List<Users> getAllUserList();

	public List<Users> searchUserList(@Param("userName")String userName, @Param("roleId")Integer roleId);

	public boolean insertUser(Users users);
	
	public boolean insertUserRole(@Param("userId") String userId,@Param("roleId") Integer roleId);

	public Users getUserByUserId(@Param("userId")String userId);
	
	public boolean updateUser(Users users);
	
	public boolean updateUserRole(@Param("userId") String userId,@Param("roleId") Integer roleId);

	public void deleteUser(@Param("deleteId")String deleteId);

	public void deleteUserRole(@Param("deleteId")String deleteId);

}
