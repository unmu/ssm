package com.groupfour.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.groupfour.entity.PatientInfo;

public interface PatientDao {

	public List<PatientInfo> searchPatientByNameAndCardNum(@Param("patientName")String patientName, @Param("cardNum")String cardNum);

	public PatientInfo getPatientByPatientCard(@Param("patientCard")String patientCard);

	public void insertPatientInfo(PatientInfo info);

}
