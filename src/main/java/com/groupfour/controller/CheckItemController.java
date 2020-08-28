package com.groupfour.controller;

import com.groupfour.entity.CheckItem;
import com.groupfour.service.CheckItemService;

import java.util.List;

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
    	System.out.println("insertCheckItem--" + checkItem.getCheckID());
    	System.out.println("insertCheckItem--" + checkItem.getRegisterID());
        boolean flag = checkItemService.insertCheckItem(checkItem);
        return flag;
    }
    
    @RequestMapping("/removeCheckFromRecipe")
    @ResponseBody
    public boolean removeCheckProFromRecipe(String checkId){
    	System.out.println("removeCheckFromRecipe---" + checkId);
        boolean flag = checkItemService.removeItem(checkId);
        return flag;
    }

    @RequestMapping("/updateCheckRecipe")
    @ResponseBody
    public CheckItem updateCheckItem(CheckItem checkItem){
    	checkItemService.updateCheckItem(checkItem);
    	return checkItem;
    }

    public boolean addCheckItem(List<CheckItem> checkItems){
    	checkItemService.addCheckItems(checkItems);
    	return true;

    }

}
