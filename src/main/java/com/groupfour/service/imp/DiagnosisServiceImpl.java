package com.groupfour.service.imp;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.groupfour.dao.DiagnosisDao;
import com.groupfour.entity.CheckItem;
import com.groupfour.entity.DiagnosisInfo;
import com.groupfour.entity.MedicinePerscription;
import com.groupfour.entity.RegisterInfo;
import com.groupfour.service.DiagnosisService;

@Service
public class DiagnosisServiceImpl implements DiagnosisService {

	@Autowired
	private DiagnosisDao diagnosisDao;

	@Override
	public List<RegisterInfo> getRegisterInfoByDoctorId(String doctorId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public RegisterInfo getRegisterInfoByRegisterId(String registerId) {
		return diagnosisDao.getRegisterInfoByRegisterId(registerId);
	}

	@Override
	public boolean insertDiagnosisInfo(DiagnosisInfo info) {
		// TODO Auto-generated method stub
		return false;
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
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<MedicinePerscription> getMpListByRegisterId(String registerId, Integer flag) {
		return diagnosisDao.getMpListByRegisterId(registerId, flag);
	}

	@Override
	public List<CheckItem> getCheckItemListByRegisterId(String registerId, Integer flag) {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public boolean addMedicinePerscriptions(String registerId,String medicineId,int num) {
		return diagnosisDao.addMedicinePerscription(registerId,medicineId,num);
	}
}
