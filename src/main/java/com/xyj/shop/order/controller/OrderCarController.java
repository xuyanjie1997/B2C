package com.xyj.shop.order.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xyj.shop.order.model.OrderCarModel;
import com.xyj.shop.order.service.OrderCarService;
import com.xyj.shop.user.model.UserModel;

import tools.FmtEmpty;

@Controller
@RequestMapping("/car")
public class OrderCarController {

	@Autowired
	private OrderCarService orderCarService;
	
	@ResponseBody
	@RequestMapping("/add")
	public int add(OrderCarModel carmodel , HttpSession session) {
		OrderCarModel mm = new OrderCarModel();
		Object obj = session.getAttribute("prouser");
		if(obj == null) {
			return 2;
		}
		String usercode = ((UserModel)obj).getUsercode();
		mm.setUserCode(usercode);
		mm.setGoodsCode(carmodel.getGoodsCode());
		List<OrderCarModel> list = orderCarService.selectAll(mm);
		if(FmtEmpty.isEmpty(list)) {
			mm.setNum(1);
			return orderCarService.insert(mm);
		}else {
			mm = list.get(0);
			mm.setNum(mm.getNum()+1);
			return orderCarService.update(mm);
		}
	}
	
	@ResponseBody
	@RequestMapping(value="/selectList" , produces="text/html;charset=UTF-8")
	public String selectList(OrderCarModel carmodel) {
		OrderCarModel m = new OrderCarModel();
		m.setUserCode(carmodel.getUserCode());
		List<OrderCarModel> list = orderCarService.selectList(m);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("count", orderCarService.selectCount(m));
		return new JSONObject(map).toString();
	}
	
	@ResponseBody
	@RequestMapping("/del")
	public int del(String id) {
		return orderCarService.del(id);
	}
	
	@ResponseBody
	@RequestMapping(value="/selectByUser" , produces="text/html;charset=UTF-8")
	public String selectByUser(String usercode) {
		List<OrderCarModel> list = orderCarService.selectByUser(usercode);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		return new JSONObject(map).toString();
	}	
	
	@ResponseBody
	@RequestMapping("/chnum")
	public int updatenum(OrderCarModel carmodel) {
		return orderCarService.updateById(carmodel);
	}
	
	
	@ResponseBody
	@RequestMapping("/selectCodeById")
	public String selectCodeById(String id) {	
		return orderCarService.selectCodeById(id);
	}	
	
}
