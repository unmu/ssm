package com.groupfour.service;

import java.util.List;

import com.groupfour.entity.InspectionItem;
import com.groupfour.entity.MedicineInfo;

public interface MedicineService {

	/**
	 * 通过药品名称进行模糊查询药品信息。
	 * @param medicineName
	 * @return
	 */
	public List<MedicineInfo> getMedicineInfoList(String medicineName);
	
	/**
	 * 选择一条药品信息
	 *   获取某条药品信息
	 * @param medicineId
	 * @return
	 */
	public MedicineInfo getMedicineInfoByMedicineId(String medicineId);
	
	/**
	 * 选择多条药品信息
	 *   获取多条药品信息，
	 * @param medicineIds  数组，被勾选的所有药品
	 * @return
	 */
	public List<MedicineInfo> getMedicineInfosByMedicineIds(String[] medicineIds);
	
	/**
	 * 通过检查项名称进行模糊查询医院检查项目。
	 * @param itemName
	 * @return
	 */
	public List<InspectionItem> getInspectionItemList(String itemName);
	
	/**
	 * 选择一条检查项目
	 *   获取某条检查项目信息，，可以将该内容赋值给病人检查项处方
	 * @param itemId
	 * @return
	 */
	public InspectionItem getInspectionItemByItemId(String itemId);
	
	/**
	 * 选择多条检查项目
	 *   获取多条检查项目信息，，可以将该内容赋值给病人检查项处方
	 * @param itemIds 数组
	 * @return
	 */
	public List<InspectionItem> getInspectionItemByItemIds(String[] itemIds);
	
	/**
	 * 通过检查项名称进行模糊查询医院检查项目。
	 * @param itemName
	 * @return
	 */
	
	public List<MedicineInfo> getAllMedicineInfoList();
}