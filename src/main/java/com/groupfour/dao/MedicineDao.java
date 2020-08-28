package com.groupfour.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.groupfour.entity.InspectionItem;
import com.groupfour.entity.MedicineInfo;

public interface MedicineDao {

	public List<MedicineInfo> getMedicineList(String medicineName);

	public List<MedicineInfo> getAllMedicineList();
	
	public List<InspectionItem> getInspectionItemList(@Param("itemName")String itemName);

}
