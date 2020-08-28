package com.groupfour.service;

import java.util.List;

import com.groupfour.entity.CheckItem;
import com.groupfour.entity.DiagnosisInfo;
import com.groupfour.entity.MedicinePerscription;
import com.groupfour.entity.RegisterInfo;

public interface DiagnosisService {

	/**
	 * 显示病人列表信息（病人姓名）
	 * 1、获取登录医生的病人当天挂号信息。
	 * 2、如果是admin进行登录，可以查出所有的挂号信息。
	 * 3、每个挂号信息包括病人信息
	 * 
	 * @param doctorId 登录人的id，
	 * @return list<RegisterInfo> 挂号信息，病人信息
	 */
	
	public List<RegisterInfo> getRegisterInfoByDoctorId(String doctorId);
	
	/**
	 * 1，当点击某条就诊病人的时候，传入的值应该为挂号单的id
	 * 2、需要获取病人基本信息，获取病人诊断信息，病人处方信息，病人开具的检查项目
	 * 2、挂号单和病人诊断信息是一对一，挂号单和处方信息是一对多，，挂号单和检查项目一对多
	 * @param registerId   
	 * @param
	 * @return
	 */
	public RegisterInfo getRegisterInfoByRegisterId(String registerId);
	
	/**
	 * 插入病人诊断信息，同时更改病人就诊状态，变为已就诊。
	 * 就诊成功后，需跳到病人查房开具页
	 *  主键取自uuid
	 * @param info
	 * @return 
	 */
	public boolean insertDiagnosisInfo(DiagnosisInfo info);
	
	/**
	 * 插入一条
	 * 插入病人药品处方信息
	 * @param cmPerscription
	 * @return medicinePerscription
	 */
	public MedicinePerscription insertMedicinePerscription(MedicinePerscription medicinePerscription);
	
	/**
	 * 多条一起插入
	 * 插入病人药品处方信息
	 * @param cmpList
	 * @return mpList
	 */
	//public List<MedicinePerscription> saveMedicinePerscriptions(List<MedicinePerscription> mpList);
	public boolean saveMedicinePerscriptions(List<MedicinePerscription> mpList);
	
	/**
	 * 删除某条药品信息
	 * @param perscriptionId
	 * @return
	 */
	public boolean deleteMedicinePerscriptionByPerscriptionId(String perscriptionId);
	/**
	 * 插入一条
	 * 插入病人检查项目信息
	 * @param cmPerscription
	 * @return
	 */
	public CheckItem insertCheckItem(CheckItem checkItem);
	
	/**
	 * 插入多条
	 * 插入病人检查项目信息
	 * @param checkList
	 * @return
	 */
	public List<CheckItem> saveCheckItem(List<CheckItem> checkList);
	
	/**
	 * 删除某条检查项目信息
	 * @param perscriptionId
	 * @return
	 */
	public boolean deleteCheckItemByCheckId(String checkId);
	
	/**
	 * 通过挂号但显示该病人诊断信息
	 * @param registerId
	 * @return
	 */
	public DiagnosisInfo getDiagnosisInfoByRegisterId(String registerId);

	/**
	 * 通过挂号单显示该病人开具的药品处方信息
	 * @param registerId
	 * @param flag 是否缴费
	 * @return
	 */
	public List<MedicinePerscription> getMpListByRegisterId(String registerId,Integer flag);
	
	/**
	 * 通过挂号单显示该病人的检查项目
	 * @param registerId
	 * @param flag 是否缴费
	 * @return
	 */
	public List<CheckItem> getCheckItemListByRegisterId(String registerId,Integer flag);

	public boolean addMedicinePerscriptions(String registerId, String medicineId, int num, double money);

}
