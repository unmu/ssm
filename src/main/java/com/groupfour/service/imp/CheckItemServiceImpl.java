package com.groupfour.service.imp;

import com.groupfour.dao.CheckItemDao;
import com.groupfour.entity.CheckItem;
import com.groupfour.service.CheckItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

/**
 * @project hosp
 * @create 2020-08-27 21:05
 */
@Service
public class CheckItemServiceImpl implements CheckItemService {

    @Autowired
    private CheckItemDao checkItemDao;

    @Override
    public boolean insertCheckItem(CheckItem checkItem) {
        checkItemDao.insertCheckItem(checkItem);
        return true;
    }
    
    public boolean removeItem(String checkId){
    	int flag=checkItemDao.deleteById(checkId);
    	if(flag==1)return true;
    	else return false;
    	
    }
    public boolean updateCheckItem(CheckItem checkItem){
    	int flag = checkItemDao.updateById(checkItem);
    	if(flag==1)return true;
    	else return false;
    }

    public boolean addCheckItems(List<CheckItem> checkItems){
    	for(CheckItem c:checkItems){
    		 checkItemDao.insertCheckItem(c);
    	}
    	return true;
    }

	public List<CheckItem> getCheckItemByRegisterId(String registerId) {
		// TODO Auto-generated method stub
//		return null;
		return checkItemDao.getCheckItemByRegisterId(registerId);
	}
}
