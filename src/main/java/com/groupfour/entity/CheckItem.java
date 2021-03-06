package com.groupfour.entity;

public class CheckItem {
	
	private Integer checkID;
	private String registerID;
	private String itemID; 
	private int amount; 
	private float money;
	private int returnAmount;
	private float returnMoney; 
	private int flag; 
	private String remark;
	private InspectionItem inspectionItem;
	
	
	public Integer getCheckID() {
		return checkID;
	}
	public void setCheckID(Integer checkID) {
		this.checkID = checkID;
	}
	public InspectionItem getInspectionItem() {
		return inspectionItem;
	}
	public void setInspectionItem(InspectionItem inspectionItem) {
		this.inspectionItem = inspectionItem;
	}
	public String getRegisterID() {
		return registerID;
	}
	public void setRegisterID(String registerID) {
		this.registerID = registerID;
	}
	public String getItemID() {
		return itemID;
	}
	public void setItemID(String itemID) {
		this.itemID = itemID;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public float getMoney() {
		return money;
	}
	public void setMoney(float money) {
		this.money = money;
	}
	public int getReturnAmount() {
		return returnAmount;
	}
	public void setReturnAmount(int returnAmount) {
		this.returnAmount = returnAmount;
	}
	public float getReturnMoney() {
		return returnMoney;
	}
	public void setReturnMoney(float returnMoney) {
		this.returnMoney = returnMoney;
	}
	public int getFlag() {
		return flag;
	}
	public void setFlag(int flag) {
		this.flag = flag;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
}
