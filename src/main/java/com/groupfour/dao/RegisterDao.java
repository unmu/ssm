package com.groupfour.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.groupfour.entity.DeptInfo;
import com.groupfour.entity.DoctorInfo;
import com.groupfour.entity.RegisterInfo;

public interface RegisterDao {
	
	public List<DeptInfo> getDeptInfoList();

	public List<DoctorInfo> getDoctInfoListByDeptId(String deptId);

	public int addRegisterInfo(RegisterInfo registerInfo);

	public void updateFlagByRegisterId(@Param("flag")Integer flag, @Param("registerId")String registerId);
}
