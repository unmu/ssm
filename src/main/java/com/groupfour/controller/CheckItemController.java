package com.groupfour.controller;

import com.groupfour.entity.CheckItem;
import com.groupfour.service.CheckItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @project hosp
 * @create 2020-08-27 21:03
 */
@Controller
@RequestMapping("dt")
public class CheckItemController {


    @Autowired
    private CheckItemService checkItemService;

    @RequestMapping("insertCheckItem")
    @ResponseBody
    public boolean insertCheckItem(CheckItem checkItem){

        boolean flag = checkItemService.insertCheckItem(checkItem);

        return flag;
    }

}
