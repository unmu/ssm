package com.groupfour.service.imp;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.groupfour.dao.MedicineDao;
import com.groupfour.entity.InspectionItem;
import com.groupfour.entity.MedicineInfo;
import com.groupfour.service.MedicineService;

@Service
public class MedicineServiceImpl implements MedicineService{

	
	@Autowired
	public MedicineDao medicinedao;
	
	@Override
	public List<MedicineInfo> getMedicineInfoList(String medicineName) {
		
		return medicinedao.getMedicineList(medicineName);
	}

	@Override
	public MedicineInfo getMedicineInfoByMedicineId(String medicineId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<MedicineInfo> getMedicineInfosByMedicineIds(String[] medicineIds) {
		// TODO Auto-generated method stub
		return null;
	}

	

	@Override
	public List<MedicineInfo> getAllMedicineInfoList() {
	     return medicinedao.getAllMedicineList();
	}

	@Override
	public List<InspectionItem> getInspectionItemList(String itemName) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public InspectionItem getInspectionItemByItemId(String itemId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<InspectionItem> getInspectionItemByItemIds(String[] itemIds) {
		// TODO Auto-generated method stub
		return null;
	}

}
