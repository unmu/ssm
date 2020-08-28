package com.groupfour.dao;

import org.apache.ibatis.annotations.Param;

import com.groupfour.entity.CheckItem;


public interface CheckItemDao {

    /**
     * 保存检查项目
     * @param checkItem
     */
    public void insertCheckItem(CheckItem checkItem);

    public int deleteById(@Param("checkId")String checkId);
    public int updateById(CheckItem checkItem); 
}
