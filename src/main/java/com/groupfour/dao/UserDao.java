package com.groupfour.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.groupfour.entity.Users;

public interface UserDao {

	public List<Users> getAllUserList();

	public List<Users> searchUserList(@Param("userName")String userName, @Param("roleId")Integer roleId);

	public void inserUser(@Param("users")Users users);
}
