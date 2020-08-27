package com.groupfour.entity;

import com.groupfour.entity.CheckItem;
import com.groupfour.entity.DeptInfo;
import com.groupfour.entity.DiagnosisInfo;
import com.groupfour.entity.DoctorInfo;
import com.groupfour.entity.MedicinePerscription;
import com.groupfour.entity.PatientInfo;

import java.util.Date;
import java.util.List;

public class RegisterInfo {
	
	private String registerId;

    private Integer expensesType;

    private Integer diagnosisType;

    private Integer registerType;

    private Double money;
    
    private Integer flag;
    
    private Date registerTime;
    
    private PatientInfo patientInfo;
    
    private DeptInfo deptInfo;
    
    private DoctorInfo doctorInfo;
    
    private DiagnosisInfo diagnosisInfo;
    
    private List<MedicinePerscription> mpList;
    
    private List<CheckItem> checkList;

	public String getRegisterId() {
		return registerId;
	}

	public Date getRegisterTime() {
		return registerTime;
	}

	public void setRegisterTime(Date registerTime) {
		this.registerTime = registerTime;
	}

	public void setRegisterId(String registerId) {
		this.registerId = registerId;
	}

	public Integer getExpensesType() {
		return expensesType;
	}

	public void setExpensesType(Integer expensesType) {
		this.expensesType = expensesType;
	}

	public Integer getDiagnosisType() {
		return diagnosisType;
	}

	public void setDiagnosisType(Integer diagnosisType) {
		this.diagnosisType = diagnosisType;
	}

	public Integer getRegisterType() {
		return registerType;
	}

	public void setRegisterType(Integer registerType) {
		this.registerType = registerType;
	}

	public Double getMoney() {
		return money;
	}

	public void setMoney(Double money) {
		this.money = money;
	}

	public Integer getFlag() {
		return flag;
	}

	public void setFlag(Integer flag) {
		this.flag = flag;
	}

	public PatientInfo getPatientInfo() {
		return patientInfo;
	}

	public void setPatientInfo(PatientInfo patientInfo) {
		this.patientInfo = patientInfo;
	}

	public DeptInfo getDeptInfo() {
		return deptInfo;
	}

	public void setDeptInfo(DeptInfo deptInfo) {
		this.deptInfo = deptInfo;
	}

	public DoctorInfo getDoctorInfo() {
		return doctorInfo;
	}

	public void setDoctorInfo(DoctorInfo doctorInfo) {
		this.doctorInfo = doctorInfo;
	}

	public DiagnosisInfo getDiagnosisInfo() {
		return diagnosisInfo;
	}

	public void setDiagnosisInfo(DiagnosisInfo diagnosisInfo) {
		this.diagnosisInfo = diagnosisInfo;
	}

	public List<MedicinePerscription> getMpList() {
		return mpList;
	}

	public void setMpList(List<MedicinePerscription> mpList) {
		this.mpList = mpList;
	}

	public List<CheckItem> getCheckList() {
		return checkList;
	}

	public void setCheckList(List<CheckItem> checkList) {
		this.checkList = checkList;
	}

    

}
