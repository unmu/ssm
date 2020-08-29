package com.groupfour.entity;

public class MedicinePerscription {
	
	private Integer perscriptionId;
	private String registerId;
	private String medicineId;
	private String flag;
	private Integer amount;
	private double money;
	private int returnAmount;
	private double returnMoney;
	private String remark;
	private MedicineInfo medicineInfo;
	
	public Integer getPerscriptionId() {
		return perscriptionId;
	}
	public void setPerscriptionId(Integer perscriptionId) {
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
	public Integer getAmount() {
		return amount;
	}
	public void setAmount(Integer amount) {
		this.amount = amount;
	}
	public double getMoney() {
		return money;
	}
	public void setMoney(double money) {
		this.money = money;
	}
	public int getReturnAmount() {
		return returnAmount;
	}
	public void setReturnAmount(int returnAmount) {
		this.returnAmount = returnAmount;
	}
	public double getReturnMoney() {
		return returnMoney;
	}
	public void setReturnMoney(double returnMoney) {
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
