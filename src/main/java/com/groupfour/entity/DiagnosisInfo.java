package com.groupfour.entity;

import java.util.Date;

public class DiagnosisInfo {
	
    private String diagnosisId;
 
    private RegisterInfo registerInfo; 

    private Date onsetDate; //发病日期

    private String narration; //主要诉求

    private String hpi; //现病史

    private String pmp; //以往病史

    private String allergyHistory;  

    private String diagContent; 

    private String diagRemarks; 

    private String disposalPlan;  
   
    public String getDiagnosisId() {
        return diagnosisId;
    }

    public void setDiagnosisId(String diagnosisId) {
        this.diagnosisId = diagnosisId == null ? null : diagnosisId.trim();
    }

    public Date getOnsetDate() {
        return onsetDate;
    }

    public void setOnsetDate(Date onsetDate) {
        this.onsetDate = onsetDate;
    }

    public String getNarration() {
        return narration;
    }

    public void setNarration(String narration) {
        this.narration = narration == null ? null : narration.trim();
    }

    public String getHpi() {
        return hpi;
    }

    public void setHpi(String hpi) {
        this.hpi = hpi == null ? null : hpi.trim();
    }

    public String getPmp() {
        return pmp;
    }

    public void setPmp(String pmp) {
        this.pmp = pmp == null ? null : pmp.trim();
    }

    public String getAllergyHistory() {
        return allergyHistory;
    }

    public void setAllergyHistory(String allergyHistory) {
        this.allergyHistory = allergyHistory == null ? null : allergyHistory.trim();
    }

    public String getDiagContent() {
        return diagContent;
    }

    public void setDiagContent(String diagContent) {
        this.diagContent = diagContent == null ? null : diagContent.trim();
    }

    public String getDiagRemarks() {
        return diagRemarks;
    }

    public void setDiagRemarks(String diagRemarks) {
        this.diagRemarks = diagRemarks == null ? null : diagRemarks.trim();
    }

    public String getDisposalPlan() {
        return disposalPlan;
    }

    public void setDisposalPlan(String disposalPlan) {
        this.disposalPlan = disposalPlan == null ? null : disposalPlan.trim();
    }

	public RegisterInfo getRegisterInfo() {
		return registerInfo;
	}

	public void setRegisterInfo(RegisterInfo registerInfo) {
		this.registerInfo = registerInfo;
	}
}