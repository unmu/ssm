package com.groupfour.entity;

public class CheckItem {
	
	String checkID;  //开具检查项目id
	String registerID;
	String itemID;  //检查项目id
	int amount;    //检查次数
	float money;  //金额
	int returnAmount; //退还次数
	float returnMoney; //退还金额
	int flag;   //0-未缴费  1-已缴费  2-已退费
	String remark;
	InspectionItem inspectionItem;
	
	
	public String getCheckID() {
		return checkID;
	}
	public void setCheckID(String checkID) {
		this.checkID = checkID;
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
	public InspectionItem getInspectionItem() {
		return inspectionItem;
	}
	public void setInspectionItem(InspectionItem inspectionItem) {
		this.inspectionItem = inspectionItem;
	}
	
	
	
}
