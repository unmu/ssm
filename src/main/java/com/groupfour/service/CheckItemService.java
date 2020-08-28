package com.groupfour.service;

import com.groupfour.entity.CheckItem;

/**
 * @project hosp
 * @create 2020-08-27 21:05
 */
public interface CheckItemService {

    /**
     * 保存检查项目
     * @param checkItem
     */
    public boolean insertCheckItem(CheckItem checkItem);
}
