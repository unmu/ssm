package com.groupfour.entity;

import com.groupfour.entity.DeptInfo;

public class DoctorInfo {
	
	private String doctorId;

    private String doctorName;

    private Integer sex;//0--ÄÐ£¬1--Å®

    private Integer age;

    private Integer workAge;

    private DeptInfo deptInfo;
    
    public String getDoctorId() {
        return doctorId;
    }

    public void setDoctorId(String doctorId) {
        this.doctorId = doctorId == null ? null : doctorId.trim();
    }

    public String getDoctorName() {
        return doctorName;
    }

    public void setDoctorName(String doctorName) {
        this.doctorName = doctorName == null ? null : doctorName.trim();
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    public Integer getWorkAge() {
        return workAge;
    }

    public void setWorkAge(Integer workAge) {
        this.workAge = workAge;
    }

	public Integer isSex() {
		return sex;
	}

	public void setSex(Integer sex) {
		this.sex = sex;
	}

	public DeptInfo getDeptInfo() {
		return deptInfo;
	}

	public void setDeptInfo(DeptInfo deptInfo) {
		this.deptInfo = deptInfo;
	}

}
