package com.xyj.shop.order.controller;

import java.util.List;

import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xyj.shop.order.model.AreaModel;
import com.xyj.shop.order.service.AreaService;

@Controller
@RequestMapping("/area")
public class AreaController {

	@Autowired
	private AreaService areaService;
	
	@ResponseBody
	@RequestMapping("/selectSheng")
	public String sheng(){	
		List<AreaModel> list = areaService.selectSheng();
		return new JSONArray(list).toString();
	}
	
}
