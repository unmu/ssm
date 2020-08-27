package com.groupfour.controller;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.groupfour.entity.CheckItem;
import com.groupfour.entity.MedicinePerscription;
import com.groupfour.entity.RegisterInfo;
import com.groupfour.service.DiagnosisService;
import com.groupfour.service.PaymentService;

@Controller
@RequestMapping("opcharge")
public class PaymentController {
	
	@Autowired
	private PaymentService payService;
	
	@Autowired
	private DiagnosisService diagnosisService;
	
	@RequestMapping("opcharge")
	public String opcharge(){
		return "opcharge/opcharge";
	}
	
	@RequestMapping("searchRegisterUnpaid")
	@ResponseBody
	public List<RegisterInfo> searchRegisterUnpaid(String userID, String userName) {
		System.out.println("searchRegisterUnpaid");
		System.out.println("userID" + ":" + userID);
		System.out.println("userName" + ":" + userName);
		List<RegisterInfo> registerInfo = payService.searchRegisterUnpaidListByIDName(userID,userName);
		System.out.println("registerInfo" + ":" + registerInfo);            
		return registerInfo;

	}
	
	@RequestMapping("searchMedicineListUnpaid")
	@ResponseBody
	public List<MedicinePerscription> searchMedicineListUnpaid(String RegisterId) {
		System.out.println("searchMedicineListUnpaid");
		System.out.println("RegisterID" + ":" + RegisterId);
		List<MedicinePerscription> medicinePerscriptions = payService.getMpListByRegisterId(RegisterId,0);
		
		System.out.println("medicinePerscriptions" + ":" + medicinePerscriptions);            
				
		return medicinePerscriptions;

	}
	
	@RequestMapping("searchItemListUnpaid")
	@ResponseBody
	public List<CheckItem> searchItemListUnpaid(String RegisterId) {
		System.out.println("searchItemListUnpaid");
		System.out.println("RegisterID" + ":" + RegisterId);
		List<CheckItem> checkItems = payService.getCheckItemListByRegisterId(RegisterId,0);
		
		System.out.println("checkItems" + ":" + checkItems);            
				
		return checkItems;

	}
	
	@RequestMapping("pay")
	@ResponseBody
	public void pay(String RegisterId) {
		System.out.println("pay");
		System.out.println("RegisterID" + ":" + RegisterId);
		payService.updatePayment(RegisterId);
	}
	
	//---------------------------------------------------
	
	@RequestMapping("oprefund")
	public String menuList(Model model) {
		return "opcharge/oprefund";
	}
	
	@RequestMapping("searchRegisterOpre")
	@ResponseBody
	public List<RegisterInfo> searchRegisterOpre(String cardNum,String patientName) {
		List<RegisterInfo> registerList = payService.searchRegisterList(cardNum, patientName);
		System.out.println("挂号单："+registerList);
		return registerList;
	}
	
	@RequestMapping("searchRegisterInfoRefund")
	@ResponseBody
	public RegisterInfo searchRegisterInfoRefund(String registerId) {
		RegisterInfo registerInfo = diagnosisService.getRegisterInfoByRegisterId(registerId);
		return registerInfo;
	}
	
	@RequestMapping("searchMpListRefund")
	@ResponseBody
	public List<MedicinePerscription> searchMpListRefund(String registerId) {
		List<MedicinePerscription> mpList=diagnosisService.getMpListByRegisterId(registerId, 1);
		return mpList;
	}
	
	@RequestMapping("searchItemListRefund")
	@ResponseBody
	public List<CheckItem> searchItemListRefund(String registerId) {
		List<CheckItem> itemList=diagnosisService.getCheckItemListByRegisterId(registerId, 1);
		return itemList;
	}
	
	@RequestMapping("returnItem")
	@ResponseBody
	public String returnItem(String registerID,String checkID,int refundNum,int returnAmount,double returnMoney,double money,int amount,double price) {
//		double returnMoneyNum = Double.parseDouble(returnMoney)+ refundNum*price;
//        returnMoney = String.format("%.2f",returnMoneyNum);
//		int returnAmountNum = Integer.valueOf(returnAmount).intValue()+refundNum;
//		returnAmount = String.valueOf( returnAmountNum);
//		int amountNum = Integer.valueOf(amount).intValue()-refundNum;
//		amount = String.valueOf(amountNum);
//		double moneyNum=Double.parseDouble(money) - refundNum*price;
//		money = String.format("%.2f",moneyNum);
		returnMoney=returnMoney+refundNum*price;
		returnAmount=returnAmount+refundNum;
		money=money-refundNum*price;
		amount=amount-refundNum;
		boolean result = payService.returnPaymentCI(checkID, returnAmount, returnMoney, amount, money);
		System.out.println(result);
		return registerID;
	}
	
	@RequestMapping("returnMedic")
	@ResponseBody
	public String returnMedic(String registerId,String perscriptionId,int stockQuantity,String medicineId,int refundNum,int returnAmount,double returnMoney,double money,int amount,double price) {
//		double returnMoneyNum = Double.parseDouble(returnMoney)+ refundNum*price;
//        returnMoney = String.format("%.2f",returnMoneyNum);
//		int returnAmountNum = Integer.valueOf(returnAmount).intValue()+refundNum;
//		returnAmount = String.valueOf( returnAmountNum);
//		int amountNum = Integer.valueOf(amount).intValue()-refundNum;
//		amount = String.valueOf(amountNum);
//		double moneyNum=Double.parseDouble(money) - refundNum*price;
//		money = String.format("%.2f",moneyNum);
		returnMoney=returnMoney+refundNum*price;
		returnAmount=returnAmount+refundNum;
		money=money-refundNum*price;
		amount=amount-refundNum;
		stockQuantity=stockQuantity+refundNum;
		boolean result1 = payService.returnPaymentMP(perscriptionId, returnAmount, returnMoney,amount,money);
		System.out.println(result1);
		boolean result2 = payService.returnPaymentNum(medicineId, stockQuantity);
		System.out.println(result2);
		return registerId;
	}

}
