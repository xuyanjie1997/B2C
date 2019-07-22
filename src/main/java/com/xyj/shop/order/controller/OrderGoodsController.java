package com.xyj.shop.order.controller;

import java.util.HashMap;
import java.util.Map;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xyj.shop.order.model.OrderGoodsModel;
import com.xyj.shop.order.service.OrderGoodsService;

@Controller
@RequestMapping("/ordergoods")
public class OrderGoodsController {
	
	@Autowired
	private OrderGoodsService orderGoodsService;
	
	@ResponseBody
	@RequestMapping(value="/selectList" , produces="text/html;charset=UTF-8")
	private String selectList(String orderCode) {
//		System.out.println("------------------"+orderCode);
		OrderGoodsModel ommodel = new OrderGoodsModel();
		ommodel.setOrderCode(orderCode);
		Map<String, Object> map = new HashMap<String, Object>();
	    map.put("list", orderGoodsService.selectList(ommodel));
	    System.out.println(orderGoodsService.selectList(ommodel));
		return new JSONObject(map).toString();
	}

	@ResponseBody
	@RequestMapping(value="/selectByOrder" , produces="text/html;charset=UTF-8")
	private String selectByOrder(String orderCode) {
		OrderGoodsModel ommodel = new OrderGoodsModel();
		ommodel.setOrderCode(orderCode);
		Map<String, Object> map = new HashMap<String, Object>();
	    map.put("list", orderGoodsService.selectByOrder(ommodel));
		return new JSONObject(map).toString();
	}
	
	@ResponseBody
	@RequestMapping("/add")
	public int add(String orderCode , String goodsCode , String amount , String price) {
		OrderGoodsModel ommodel = new OrderGoodsModel();
		Integer a = Integer.parseInt(amount);
		Integer b = Integer.parseInt(price);
		ommodel.setAmount(a);
		ommodel.setPrice(b);
		ommodel.setGoodsCode(goodsCode);
		ommodel.setOrderCode(orderCode);
		return orderGoodsService.insert(ommodel);
	}
	
	@ResponseBody
	@RequestMapping("/delete")
	public int delete(String id) {
		return orderGoodsService.delete(id);
	}
	
}
