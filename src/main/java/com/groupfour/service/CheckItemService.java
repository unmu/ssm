package com.groupfour.service;

import java.util.List;

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
    
    public boolean removeItem(String checkId);
    public boolean updateCheckItem(CheckItem checkItem);
    public boolean addCheckItems(List<CheckItem> checkItems);

	public List<CheckItem> getCheckItemByRegisterId(String registerId);
}
