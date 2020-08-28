package com.groupfour.dao;

import com.groupfour.entity.CheckItem;

/**
 * @author hezhiyu
 * @project hosp
 * @create 2020-08-27 21:06
 */
public interface CheckItemDao {

    /**
     * 保存检查项目
     * @param checkItem
     */
    public void insertCheckItem(CheckItem checkItem);
}
