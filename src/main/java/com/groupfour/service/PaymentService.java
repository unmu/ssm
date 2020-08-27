package com.groupfour.service;

import java.util.List;

import com.groupfour.entity.CheckItem;
import com.groupfour.entity.MedicinePerscription;

/**
 * 费用模块流程：
 * 1、通过病人的姓名或者身份证查询病人信息，以及他的挂号信息
 * 2、如果挂号信息只有一条，直接通过该挂号信息显示该病人的未缴费处方信息。
 * 3、如果挂号信息有多条，选择一条，查询出该病人未缴费的处方信息。
 * 
 * 缴费管理（缴费，退费）
 * @author Administrator
 *
 */
public interface PaymentService {	
	
	/**
	 * 1、缴费，根据药品和检查项分开处理如下操作
		 * 药品信息为多条数据，需循环处理：
		 * 1、更新缴费状态，1-已缴费
		 * 2、更新药品库存量，1-出库（买药），药品库存数量需减去缴费数量
	 * 
	 * 
		 * * 检查项信息为多条数据，需循环处理：
		 * 1、更新缴费状态，1-已缴费
	 *
	 
	 * 2、保存费用流水时：
	 
	    1、费用流水表添加（流水id通过uuId自动生成，pay_type为1--缴费，缴费金额moeny，缴费时间为当前时间,挂号id）
	  * 2、费用流水详情（detailId通过uuId自动生成，流水id，检查项id，type（1-药品，2-检查项））
	  * 
	 * @param money 缴费金额
	 * @param mpList 需缴费的药品信息
	 * @param checkList 需缴费的检查项信息
	 * @param registerId 挂号id
	 */
	public void pay(Double money,List<MedicinePerscription> mpList,List<CheckItem> checkList, String registerId);
		
	/**
	 * 单个逐条进行退费
	 *(如果是多条进行退还，可在controller层进行循环returnPayment方法)
	 *
	 *根据药品和检查项分开处理如下操作
	 *1、更新退款金额和退款数量
	 *2、更新药品库库存数量，退款库存量需加上退款数量
	 *3、费用流水表添加（流水id通过uuId自动生成，pay_type为2--退费，退还金额moeny，退还时间为当前时间,挂号id）
	 *4、费用流水详情（detailId通过uuId自动生成，流水id，药品id/检查项id，type（1-药品，2-检查项））
	 * 	
	 * @param returnAmount 退款数量
	 * @param returnMoeny 退款金额
	 * @param MedicinePerscription mp 退款的药品信息
	 * @param CheckItem checkItem 退款的检查项信息
	 * @param registerId 挂号id
	 */
	public void returnPayment(Integer returnAmount,Double returnMoeny,MedicinePerscription mp,CheckItem checkItem,String registerId);
		 
}