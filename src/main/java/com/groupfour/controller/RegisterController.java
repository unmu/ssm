package com.groupfour.controller;

import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.groupfour.entity.DeptInfo;
import com.groupfour.entity.DoctorInfo;
import com.groupfour.entity.PatientInfo;
import com.groupfour.entity.RegisterInfo;
import com.groupfour.service.PatientService;
import com.groupfour.service.RegisterService;

@Controller
@RequestMapping("opreg")
public class RegisterController {

	@Autowired
	private RegisterService service;
	
	@Autowired
	private PatientService patientService;

	
	@RequestMapping("loadOptRegistPage")
	public String regist() {
		System.out.println("loadOptRegistPage");
		return "opreg/optRegist";
	}
	
	@RequestMapping("searchPatient")
	@ResponseBody
	public List<PatientInfo> searchPatient(String patientName, String cardNum) {
		System.out.println("searchPatient " + patientName + " " + cardNum);
		List<PatientInfo> list = patientService.searchPatientByNameAndCardNum(patientName, cardNum);
		Iterator<PatientInfo> it = list.iterator();
		while (it.hasNext()) {
			PatientInfo p = it.next();
			System.out.println("name" + p.getPatientName());
		}
		return list;
	}
	
	@RequestMapping("getPatientByPatientCard")
	@ResponseBody
	public PatientInfo getPatientByPatientCard(String patientCard) {
		System.out.println("getPatientByPatientCard");
		return patientService.getPatientByPatientCard(patientCard);
	}
	
	private String getUUID(int n) {
		String uuid = "";
		for (int i = 0; i < n; i++) {
			Integer num = UUID.randomUUID().toString().hashCode();
			Integer u = (num < 0 ? -num : num);
			uuid += u.toString();
		}
		return uuid;
	}
	
	@RequestMapping("insertPatient")
	@ResponseBody
	public PatientInfo insertPatient(String patientName, Integer sex, Integer age, String cardNum, String tel, String address, 
			String nationality, String nation, String education, String profession, String blood, Integer marriage) {
		System.out.println("insertPatient");
		PatientInfo info = new PatientInfo();
		String patientCard = getUUID(1);//UUID生成10位patientCard
        System.out.println(patientCard);
        info.setPatientCard(patientCard);
		info.setPatientName(patientName);
		info.setSex(sex);
		info.setAge(age);
		info.setCardNum(cardNum);
		info.setTel(tel);
		info.setAddress(address);
		info.setNationality(nationality);
		info.setNation(nation);
		info.setEducation(education);
		info.setProfession(profession);
		info.setBlood(blood);
		info.setMarriage(marriage);
		return patientService.insertPatientInfo(info);
	}
	
	@RequestMapping("getDeptInfoList")
	@ResponseBody
	public List<DeptInfo> getDeptInfoList() {
		System.out.println("getDeptInfoList");
		List<DeptInfo> list = service.getDeptInfoList();
		return list;
	}
	
	@RequestMapping("getDoctInfoListByDeptId")
	@ResponseBody
	public List<DoctorInfo> getDoctInfoListByDeptId(String deptId) {
		System.out.println("getDoctInfoListByDeptId");
		List<DoctorInfo> list = service.getDoctInfoListByDeptId(deptId);
		return list;
	}
	
	@RequestMapping(value = "addRegisterInfo")
	@ResponseBody
	public boolean addRegisterInfo(String patientCard,String deptId,String doctorId,Integer expensesType,Integer diagnosisType,Integer registerType,Double money) {
		System.out.println("addRegisterInfo");
		PatientInfo patientInfo = new PatientInfo();
		patientInfo.setPatientCard(patientCard);

		DeptInfo deptInfo = new DeptInfo();
		deptInfo.setDeptId(deptId);

		DoctorInfo doctorInfo = new DoctorInfo();
		doctorInfo.setDoctorId(doctorId);

		RegisterInfo into = new RegisterInfo();
		String registerId = getUUID(1);//UUID生成10位patientCard
        System.out.println(registerId);
        into.setRegisterId(registerId);
		
		into.setPatientInfo(patientInfo);
		into.setDeptInfo(deptInfo);
		into.setDoctorInfo(doctorInfo);
		into.setExpensesType(expensesType);
		into.setDiagnosisType(diagnosisType);
		into.setRegisterType(registerType);
		into.setMoney(money);
		into.setFlag(0);

		return service.addRegisterInfo(into);
	}
}
