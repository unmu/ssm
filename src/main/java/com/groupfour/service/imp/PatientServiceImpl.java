package com.groupfour.service.imp;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.groupfour.dao.PatientDao;
import com.groupfour.entity.PatientInfo;
import com.groupfour.service.PatientService;

@Service
public class PatientServiceImpl implements PatientService {

	@Autowired
	private PatientDao dao; 
	
	@Override
	public List<PatientInfo> getPaientListByCardNumAndName(String name, String cardNum) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public PatientInfo getPatientByPatientCard(String patientCard) {
		return dao.getPatientByPatientCard(patientCard);
	}

	@Override
	public PatientInfo insertPatientInfo(PatientInfo info) {
		dao.insertPatientInfo(info);
		return info;
	}

	@Override
	public List<PatientInfo> searchPatientByNameAndCardNum(String patientName, String cardNum) {
		System.out.println("RegistService-searchPatientByNameAndCardNum-" + patientName);
		return dao.searchPatientByNameAndCardNum(patientName, cardNum);
	}

}
