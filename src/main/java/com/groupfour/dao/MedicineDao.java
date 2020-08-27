package com.groupfour.dao;

import java.util.List;

import com.groupfour.entity.MedicineInfo;

public interface MedicineDao {

	public List<MedicineInfo> getMedicineList(String medicineName);

	public List<MedicineInfo> getAllMedicineList();
	
	

}
