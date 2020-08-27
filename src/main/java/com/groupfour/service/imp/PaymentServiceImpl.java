package com.groupfour.service.imp;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.groupfour.dao.PaymentDao;
import com.groupfour.entity.CheckItem;
import com.groupfour.entity.MedicinePerscription;
import com.groupfour.entity.RegisterInfo;
import com.groupfour.service.PaymentService;

@Service
public class PaymentServiceImpl implements PaymentService{
	
	@Autowired
	private PaymentDao paymentDao;

	@Override
	public List<RegisterInfo> searchRegisterUnpaidListByIDName(String userID, String userName) {
		// TODO Auto-generated method stub
		return paymentDao.searchRegisterUnpaidListByIDName(userID, userName);
	}

	@Override
	public List<CheckItem> getCheckItemListByRegisterId(String registerId, int flag) {
		// TODO Auto-generated method stub
		return paymentDao.getCheckItemListByRegisterId(registerId, flag);
	}

	@Override
	public List<MedicinePerscription> getMpListByRegisterId(String registerId, int flag) {
		// TODO Auto-generated method stub
		return paymentDao.getMpListByRegisterId(registerId, flag);
	}

	@Override
	public void updatePayment(String registerId) {
		// TODO Auto-generated method stub
		
		//��ùҺŵ���ҩƷid������
		List<MedicinePerscription> medicinePerscriptions = paymentDao.getMpListByRegisterId(registerId, 0);
		String medicineId;
		int amount;		
		for (int i = 0; i < medicinePerscriptions.size(); i++) {
			//update��Ʒ���
			medicineId = medicinePerscriptions.get(i).getMedicineInfo().getMedicineId();
			amount = medicinePerscriptions.get(i).getAmount();			
			paymentDao.updateMedicineInfo(medicineId, amount);
			System.out.println("ҩƷID"+medicineId+":"+amount+"(����)");  
		}		
		
		
		//updateҩƷ����
		int flag = 1;
		paymentDao.updateMedicinePerscription(registerId, flag);
		//update��Ŀ����
		paymentDao.updateCheckItem(registerId, flag);

	}

	@Override
	public void pay(Double money, List<MedicinePerscription> mpList, List<CheckItem> checkList, String registerId) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void returnPayment(Integer returnAmount, Double returnMoeny, MedicinePerscription mp, CheckItem checkItem,
			String registerId) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public boolean returnPaymentMP(String perscriptionId, int returnAmount,double returnMoney,int amount,double money) {
		return paymentDao.returnPaymentMP(perscriptionId, returnAmount, returnMoney, amount, money);
	}
	
	@Override
	public boolean returnPaymentNum(String medicineId, int stockQuantity) {
		return paymentDao.returnPaymentNum(medicineId, stockQuantity);
	}
	
	@Override
	public List<RegisterInfo> searchRegisterList(String cardNum, String patientName) {
		return paymentDao.searchRegisterList(cardNum, patientName);
	}

	@Override
	public boolean returnPaymentCI(String checkID, int returnAmount, double returnMoney, int amount, double money) {
		return paymentDao.returnPaymentCI(checkID, returnAmount, returnMoney, amount, money);
	}



}
