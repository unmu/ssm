package com.groupfour.service.imp;

import com.groupfour.dao.CheckItemDao;
import com.groupfour.entity.CheckItem;
import com.groupfour.service.CheckItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
        checkItem.setCheckID(UUID.randomUUID().toString());
        checkItemDao.insertCheckItem(checkItem);
        return true;
    }
}
