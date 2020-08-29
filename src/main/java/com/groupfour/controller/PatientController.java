package com.groupfour.controller;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.groupfour.entity.CheckItem;
import com.groupfour.entity.DiagnosisInfo;
import com.groupfour.entity.InspectionItem;
import com.groupfour.entity.MedicineInfo;
import com.groupfour.entity.MedicinePerscription;
import com.groupfour.entity.RegisterInfo;
import com.groupfour.entity.Users;
import com.groupfour.service.CheckItemService;
import com.groupfour.service.DiagnosisService;
import com.groupfour.service.MedicineService;

@Controller
@RequestMapping("dt")
public class PatientController {

	@Autowired
	private DiagnosisService diagnosisService;
	
	@Autowired
	private MedicineService medicineService;
	
	@Autowired
	private CheckItemService checkItemService;
	
//	@Autowired
//	private CheckItemService checkItemSerive;
	
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
		System.out.println("saveDiagnosisInfo");
		boolean flag = diagnosisService.insertDiagnosisInfo(diagnosisInfo);
		System.out.println(flag);
		return flag;
	}
	
	@RequestMapping("patientPerscription")
	public String patientPerscription(Model model, String registerId){
		System.out.println("patientPerscription");
		System.out.println(registerId);
		RegisterInfo registerInfo = diagnosisService.getRegisterInfoByRegisterId(registerId);
		System.out.println("registerInfo---" + registerInfo.getRegisterId());
		model.addAttribute("registerInfo", registerInfo);
		//显示已诊断信息
		DiagnosisInfo diagnosisInfo = diagnosisService.getDiagnosisInfoByRegisterId(registerId);
		System.out.println("diagnosisInfo---" + diagnosisInfo.getDiagnosisId());
		model.addAttribute("diagnosisInfo", diagnosisInfo);
		//显示已添加的药品
		List<MedicinePerscription> mpList = diagnosisService.getMpListByRegisterId(registerId, 0);
		//System.out.println(mpList.get(0).getPerscriptionId());
		model.addAttribute("mpList", mpList);	
		//显示已添加的检查项
		List<CheckItem> ciList = checkItemService.getCheckItemByRegisterId(registerId);
		model.addAttribute("ciList", ciList);
		Iterator<CheckItem> it = ciList.iterator();
		while (it.hasNext()) {
			CheckItem cix = it.next();
			System.out.println(cix.getCheckID());
		}
//		System.out.println("getCheckItemByRegisterId");
		return "dt/patientPerscription";
	}
	
	//通过模糊查询药品信息
	@RequestMapping("searchItemInfoList")
	@ResponseBody
	public List<InspectionItem> searchItemInfoList(String itemName) {
			
		List<InspectionItem> list = new ArrayList();
		list = medicineService.getInspectionItemList(itemName);
		System.out.println("查询检查信息的条数"+list.size());
		return list;
			
	}

	
	//fmn
	
	@RequestMapping("searchMedicine")
	@ResponseBody
	public List<MedicineInfo> searchMedic(String medicineName){		
		//通过模糊查询查药
		List<MedicineInfo> mList = medicineService.getMedicineInfoList(medicineName);	
		System.out.println(mList);
		return mList;
		
	}
	
	@RequestMapping("addMedic")
	@ResponseBody
	public boolean addMedic(String registerId,String medicineId,int num, double money){		
		boolean flag = diagnosisService.addMedicinePerscriptions(registerId,medicineId,num, money);	
        return flag;
	}
	
	@RequestMapping("deleteMedicinePerscriptionByPerscriptionId")
	@ResponseBody
	public boolean deleteMedicinePerscriptionByPerscriptionId(int perscriptionId) {
		System.out.println(perscriptionId);
		boolean flag = diagnosisService.deleteMedicinePerscriptionByPerscriptionId(perscriptionId);
		return flag;
	}
	
}
