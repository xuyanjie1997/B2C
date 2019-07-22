package com.xyj.shop.order.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xyj.shop.order.model.OrderMsgModel;
import com.xyj.shop.order.service.OrderMsgService;

@Controller
@RequestMapping("/ordermsg")
public class OrderMsgController {

	@Autowired
	private OrderMsgService orderMsgService;
	
	@ResponseBody
	@RequestMapping(value="/selectList",produces="text/html;charset=UTF-8")
	public String selectList(OrderMsgModel msgmodel) {
		String usercode = "%"+msgmodel.getUsercode()+"%";
		String code = "%"+msgmodel.getCode()+"%";
		String address = "%"+ msgmodel.getAddress() +"%";
		String state = msgmodel.getState();
		OrderMsgModel m = new OrderMsgModel();
		m.setUsercode(usercode);
		m.setAddress(address);
		m.setCode(code);
		m.setState(state);
		m.setPageOn(true);
		m.setPageIndex(msgmodel.getPageIndex());
		m.setPageLimit(msgmodel.getPageLimit());
		List<OrderMsgModel> list = orderMsgService.selectList(m);
		Map<String, Object> map = new HashMap<String, Object>();
	    map.put("list", list);
	    map.put("count", orderMsgService.selectCount(m));
	    return new JSONObject(map).toString();
	}
	
	@ResponseBody
	@RequestMapping("/selectModel")
	public OrderMsgModel selectModel(String id) {
		return orderMsgService.selectModel(id);
	}
	
	@ResponseBody
	@RequestMapping("/update")
	public int update(OrderMsgModel msgmodel) {
		return orderMsgService.update(msgmodel);
	}
	
	@ResponseBody
	@RequestMapping("/selectAll")
	public String selectAll() {
		List<OrderMsgModel> list = orderMsgService.selectAll();
		return new JSONArray(list).toString();
	}
	
	@ResponseBody
	@RequestMapping("/add")
	public String add(OrderMsgModel msgmodel) {
		String ordercode = UUID.randomUUID().toString(); 
		msgmodel.setCode(ordercode);
		msgmodel.setState("未发货");
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		msgmodel.setTime(df.format(new Date()));
		orderMsgService.add(msgmodel);
		return ordercode;
	}
	
	@ResponseBody
	@RequestMapping(value="/selectByUser",produces="text/html;charset=UTF-8")
	public String selectByUser(OrderMsgModel msgmodel) {
		String usercode = msgmodel.getUsercode();
		OrderMsgModel m = new OrderMsgModel();
		m.setUsercode(usercode);
		m.setPageOn(true);
		m.setPageIndex(msgmodel.getPageIndex());
		m.setPageLimit(msgmodel.getPageLimit());
		List<OrderMsgModel> list = orderMsgService.selectList(m);
		Map<String, Object> map = new HashMap<String, Object>();
	    map.put("list", list);
	    map.put("count", orderMsgService.selectCount(m));
	    return new JSONObject(map).toString();
	}
	
}
