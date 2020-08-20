package com.groupfour.service;

import com.groupfour.entity.Users;

public interface LoginService {
	//通过用户名和密码查询用户信息
	public Users getUsersByNameAndPwd(String username, String password);

	
}
