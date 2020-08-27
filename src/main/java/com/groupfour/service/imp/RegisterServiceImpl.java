package com.groupfour.service.imp;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.groupfour.dao.PatientDao;
import com.groupfour.dao.RegisterDao;
import com.groupfour.entity.DeptInfo;
import com.groupfour.entity.DoctorInfo;
import com.groupfour.entity.PatientInfo;
import com.groupfour.entity.RegisterInfo;
import com.groupfour.service.RegisterService;

@Service
public class RegisterServiceImpl implements RegisterService {

	@Autowired
	private RegisterDao registerDao;
	
	@Override
	public List<DeptInfo> getDeptInfoList() {
		return registerDao.getDeptInfoList();
	}

	@Override
	public List<DoctorInfo> getDoctInfoListByDeptId(String deptId) {
		return registerDao.getDoctInfoListByDeptId(deptId);
	}

	@Override
	public boolean addRegisterInfo(RegisterInfo info) {
		try{
			int n = registerDao.addRegisterInfo(info);
			if(n>0){
				return true;
			}
		}catch (Exception e){
			e.printStackTrace();
		}
		return false;
	}

}
