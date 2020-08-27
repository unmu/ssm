package com.groupfour.entity;

public class MedicinePerscription {
	
	private String perscriptionId;
	private String registerId;
	private String medicineId;
	private String flag;
	private String amount;
	private String money;
	private String returnAmount;
	private String returnMoney;
	private String remark;
	private MedicineInfo medicineInfo;
	
	public String getPerscriptionId() {
		return perscriptionId;
	}
	public void setPerscriptionId(String perscriptionId) {
		this.perscriptionId = perscriptionId;
	}
	public String getRegisterId() {
		return registerId;
	}
	public void setRegisterId(String registerId) {
		this.registerId = registerId;
	}
	public String getMedicineId() {
		return medicineId;
	}
	public void setMedicineId(String medicineId) {
		this.medicineId = medicineId;
	}
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}
	public String getAmount() {
		return amount;
	}
	public void setAmount(String amount) {
		this.amount = amount;
	}
	public String getMoney() {
		return money;
	}
	public void setMoney(String money) {
		this.money = money;
	}
	public String getReturnAmount() {
		return returnAmount;
	}
	public void setReturnAmount(String returnAmount) {
		this.returnAmount = returnAmount;
	}
	public String getReturnMoney() {
		return returnMoney;
	}
	public void setReturnMoney(String returnMoney) {
		this.returnMoney = returnMoney;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public MedicineInfo getMedicineInfo() {
		return medicineInfo;
	}
	public void setMedicineInfo(MedicineInfo medicineInfo) {
		this.medicineInfo = medicineInfo;
	}
	
	
}
