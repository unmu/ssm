package com.groupfour.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.groupfour.entity.CheckItem;
import com.groupfour.entity.DiagnosisInfo;
import com.groupfour.entity.MedicinePerscription;
import com.groupfour.entity.RegisterInfo;

public interface DiagnosisDao {

	public RegisterInfo getRegisterInfoByRegisterId(@Param("registerId")String registerId);
	
	public List<MedicinePerscription> getMpListByRegisterId(@Param("registerId")String registerId,@Param("flag")Integer flag);

	public boolean saveMedicinePerscription(List<MedicinePerscription> mpList);

	public boolean addMedicinePerscription(@Param("registerId")String registerId, @Param("medicineId")String medicineId,@Param("num")int num, @Param("money")double money);
	
	public List<CheckItem> getCheckItemListByRegisterId(@Param("registerId")String registerId,@Param("flag")Integer flag);

	public List<RegisterInfo> getRegisterInfoByDoctorId(@Param("doctorId")String doctorId);

	public void insertDiagnosisInfo(DiagnosisInfo diagnosisInfo);
	
	public DiagnosisInfo getDiagnosisInfoByRegisterId(String registerId);

	public void deleteMedicinePerscriptionByPerscriptionId(@Param("perscriptionId")int perscriptionId);
}
