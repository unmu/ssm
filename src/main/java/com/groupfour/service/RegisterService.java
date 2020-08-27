package com.groupfour.service;

import java.util.List;

import com.groupfour.entity.DeptInfo;
import com.groupfour.entity.DoctorInfo;
import com.groupfour.entity.PatientInfo;
import com.groupfour.entity.RegisterInfo;


/**
 * 挂号管理
 * @author Administrator
 *
 */
public interface RegisterService {
	
	/**
	 * 查询所有科室信息
	 * 在进入页面时查询
	 * @return
	 */
	public List<DeptInfo> getDeptInfoList();
	
	/**
	 * 通过科室查询医生信息
	 * @param deptId
	 * @return
	 */
	public List<DoctorInfo> getDoctInfoListByDeptId(String deptId);
	
	/**
	 * 保存挂号信息（需要保存病人id，科室id，医生id）
	 * @param info
	 */
	public boolean addRegisterInfo(RegisterInfo info);

	
}
