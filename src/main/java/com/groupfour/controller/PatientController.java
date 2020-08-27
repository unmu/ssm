package com.groupfour.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.groupfour.entity.DiagnosisInfo;
import com.groupfour.entity.MedicineInfo;
import com.groupfour.entity.MedicinePerscription;
import com.groupfour.entity.RegisterInfo;
import com.groupfour.entity.Users;
import com.groupfour.service.DiagnosisService;
import com.groupfour.service.MedicineService;

@Controller
@RequestMapping("dt")
public class PatientController {

	@Autowired
	private DiagnosisService service;
	
	@Autowired
	private MedicineService medicineService;
	
	@Autowired
	private DiagnosisService diagnosisService;
	
	@RequestMapping("optPatient")
	public String optPatientA(Model model,HttpSession session){
		List<RegisterInfo> registerList = new ArrayList<RegisterInfo>();
		Users users = (Users) session.getAttribute("users");
		registerList = diagnosisService.getRegisterInfoByDoctorId(users.getUserId());
		model.addAttribute("diagList", registerList);
		return "dt/optPatient";
	}
	
	@RequestMapping("dtInfoAdd")
	public String dtInfoAdd(Model model, String registerId){
		
		RegisterInfo registerInfo = diagnosisService.getRegisterInfoByRegisterId(registerId);
		model.addAttribute("registerInfo", registerInfo);
		return "dt/diagnosisInfoAdd";
	}
	
	@RequestMapping("saveDiagnosisInfo")
	@ResponseBody
	public boolean saveDiagnosisInfo(Model model, DiagnosisInfo diagnosisInfo){
		boolean flag = diagnosisService.insertDiagnosisInfo(diagnosisInfo);
		return flag;
	}
	
	@RequestMapping("patientPerscription")
	public String patientPerscription(Model model, String registerId){
		RegisterInfo registerInfo = diagnosisService.getRegisterInfoByRegisterId(registerId);
		model.addAttribute("registerInfo", registerInfo);
		return "dt/patientPerscription";
	}
	
	/*private String registerId="23a6cd4fe78211eabb22005056c00001";
	
	@RequestMapping("optPatient")
	public String medicList(Model model) {
		System.out.println("optPatient");
		
		RegisterInfo registerInfo = service.getRegisterInfoByRegisterId(registerId);
		System.out.println(registerInfo.getRegisterId());
		
//		List<MedicinePerscription> mpList = service.getMpListByRegisterId(registerId, 0);
//		System.out.println(mpList.get(0).getPerscriptionId());
		
		model.addAttribute("registerInfo",registerInfo);
//		model.addAttribute("mpList", mpList);		
		return "dt/medicList";
	}
	
	
		
	@RequestMapping("searchMedicine")
	@ResponseBody
	public List<MedicineInfo> searchMedic(String medicineName){		
		//通过模糊查询查药
		System.out.println("searchMedicine");
		List<MedicineInfo> mList = medicineService.getMedicineInfoList(medicineName);	
		return mList;
	}
	
	@RequestMapping("addMedic")
	@ResponseBody
	public boolean addMedic(String medicineId,int num){		
		boolean flag = service.addMedicinePerscriptions(registerId,medicineId,num);	
        return flag;
	}
	
	@RequestMapping("addMedic")
	@ResponseBody
	public Integer addMedic(List<MedicinePerscription> mList){
		boolean flag = service.saveMedicinePerscriptions(mList);
		if(flag==true){
			return 1;
		}
		else{
			return 2;
		}
		
	}
	
	
	
//	@RequestMapping("searchMedicineInfoList")
//	@ResponseBody
//	public List<MedicineInfo> searchMedicineInfoList(String medicineName) {
//		return medicineService.getMedicineInfoList(medicineName);
//	}
	
//	@RequestMapping("saveMpList")
//	@ResponseBody
//	public List<MedicinePerscription> saveMpList(@RequestBody List<MedicinePerscription> mpList) {
//		service.saveMedicinePerscriptions(mpList);
//		return service.getMpListByRegisterId(mpList.get(0).getRegisterId(), 0);
//	}
*/
}