package com.groupfour.service;

import java.util.List;

import com.groupfour.entity.PatientInfo;

public interface PatientService {

	/**
	 * 通过病人姓名或者身份证查询病人信息。
	 * 前端页面在接收list的时候：
	 * 如果list只有一条，页面直接显示对应的病人信息，
	 * 如果list有多条，弹出对话框，列出所有的病人信息，选择其中一条病人，页面显示该病人信息。
	 * 如果list没有数据，需弹出对话框，对病人从信息进行录入。
	 * @param name  病人姓名
	 * @param cardNum  病人身份证
	 * @return
	 */
	public List<PatientInfo> getPaientListByCardNumAndName(String name,String cardNum);

	/**
	 * 通过病人卡号，取到该病人基本信息
	 * @param patientCard
	 * @return
	 */
	public PatientInfo getPatientByPatientCard(String patientCard);
	
	/**
	 * 添加病人基本信息
	 * 病人信息id通过uuid获取，(如果有些通过自增获取。需要数据库添加时获取主键id)
	 * @param info
	 * @return info
	 */
	public PatientInfo insertPatientInfo(PatientInfo info);

	/**
	 * 通过病人姓名、身份证号获取病人信息
	 * @param patientName
	 * @param cardNum
	 * @return
	 */
	public List<PatientInfo> searchPatientByNameAndCardNum(String patientName, String cardNum);

}