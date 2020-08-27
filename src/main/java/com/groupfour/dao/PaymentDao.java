package com.groupfour.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.groupfour.entity.CheckItem;
import com.groupfour.entity.MedicinePerscription;
import com.groupfour.entity.RegisterInfo;

public interface PaymentDao {
	
	public List<RegisterInfo> searchRegisterUnpaidListByIDName(@Param("userID")String userID, @Param("userName")String userName);
	
	public List<MedicinePerscription> getMpListByRegisterId(@Param("registerId")String registerId,@Param("flag")int flag);

	public List<CheckItem> getCheckItemListByRegisterId(@Param("registerId")String registerId,@Param("flag")int flag);
	
	public void updateMedicineInfo(@Param("medicineId")String medicineId,@Param("amount")int amount);

	public void updateMedicinePerscription(@Param("registerId")String registerId,@Param("flag")int flag);
	
	public void updateCheckItem(@Param("registerId")String registerId,@Param("flag")int flag);

	public List<RegisterInfo> searchRegisterList(@Param("cardNum")String cardNum, @Param("patientName")String patientName);
	
	public boolean returnPaymentMP(@Param("perscriptionId")String perscriptionId,@Param("returnAmount")int returnAmount,@Param("returnMoney")double returnMoney,@Param("amount")int amount,@Param("money")double money);
	
	public boolean returnPaymentCI(@Param("checkID")String checkID, @Param("returnAmount")int returnAmount, @Param("returnMoney")double returnMoney, @Param("amount")int amount, @Param("money")double money);

	public boolean returnPaymentNum(@Param("medicineId")String medicineId, @Param("stockQuantity")int stockQuantity);

}
