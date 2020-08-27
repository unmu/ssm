package com.groupfour.entity;

public class PaymentFlow {
	
	String payID; 
	int payType;
	float payMoney; 
	//payTime  更新时自动记录当前时间  但是创建时不会  所以存两次
	
	
	public String getPayID() {
		return payID;
	}
	public void setPayID(String payID) {
		this.payID = payID;
	}
	public int getPayType() {
		return payType;
	}
	public void setPayType(int payType) {
		this.payType = payType;
	}
	public float getPayMoney() {
		return payMoney;
	}
	public void setPayMoney(float payMoney) {
		this.payMoney = payMoney;
	}
	

}
