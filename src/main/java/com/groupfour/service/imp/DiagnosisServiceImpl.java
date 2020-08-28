package com.groupfour.service.imp;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.groupfour.dao.DiagnosisDao;
import com.groupfour.dao.RegisterDao;
import com.groupfour.entity.CheckItem;
import com.groupfour.entity.DiagnosisInfo;
import com.groupfour.entity.MedicinePerscription;
import com.groupfour.entity.RegisterInfo;
import com.groupfour.service.DiagnosisService;

@Service
public class DiagnosisServiceImpl implements DiagnosisService {

	@Autowired
	private DiagnosisDao diagnosisDao;
	
	@Autowired
	private RegisterDao registerDao;

	@Override
	public List<RegisterInfo> getRegisterInfoByDoctorId(String doctorId) {
		return diagnosisDao.getRegisterInfoByDoctorId(doctorId);
	}

	@Override
	public RegisterInfo getRegisterInfoByRegisterId(String registerId) {
		return diagnosisDao.getRegisterInfoByRegisterId(registerId);
	}

	@Override
	@Transactional
	public boolean insertDiagnosisInfo(DiagnosisInfo info) {
		try {
			info.setDiagnosisId(UUID.randomUUID().toString());
			diagnosisDao.insertDiagnosisInfo(info);
			//修改为已就诊
			registerDao.updateFlagByRegisterId(1, info.getRegisterInfo().getRegisterId());
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		
	}

	@Override
	public MedicinePerscription insertMedicinePerscription(MedicinePerscription medicinePerscription) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean saveMedicinePerscriptions(List<MedicinePerscription> mpList) {
		return diagnosisDao.saveMedicinePerscription(mpList);
	}

	@Override
	public boolean deleteMedicinePerscriptionByPerscriptionId(String perscriptionId) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public CheckItem insertCheckItem(CheckItem checkItem) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<CheckItem> saveCheckItem(List<CheckItem> checkList) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean deleteCheckItemByCheckId(String checkId) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public DiagnosisInfo getDiagnosisInfoByRegisterId(String registerId) {
		return diagnosisDao.getDiagnosisInfoByRegisterId(registerId);
	}

	@Override
	public List<MedicinePerscription> getMpListByRegisterId(String registerId, Integer flag) {
		return diagnosisDao.getMpListByRegisterId(registerId, flag);
	}

	@Override
	public List<CheckItem> getCheckItemListByRegisterId(String registerId, Integer flag) {
		return diagnosisDao.getCheckItemListByRegisterId(registerId, flag);
	}
	
	@Override
	public boolean addMedicinePerscriptions(String registerId,String medicineId,int num, double money) {
		return diagnosisDao.addMedicinePerscription(registerId,medicineId,num, money);
	}
}
