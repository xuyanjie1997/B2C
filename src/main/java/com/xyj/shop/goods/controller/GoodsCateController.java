package com.xyj.shop.goods.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xyj.shop.goods.model.DescrModel;
import com.xyj.shop.goods.model.GoodsCateModel;
import com.xyj.shop.goods.service.DescrService;
import com.xyj.shop.goods.service.GoodsCateService;
import com.xyj.shop.user.model.UserModel;

import tools.FmtEmpty;

@Controller
@RequestMapping("/goodscate")
public class GoodsCateController {

	@Autowired
	private GoodsCateService goodsCateService;
	@Autowired
	private DescrService descrService;
	
	@ResponseBody
	@RequestMapping(value="/selectList" ,  produces="text/html;charset=UTF-8")
	public String selectList(GoodsCateModel cateModel){
		String code = "%"+cateModel.getCode()+"%";
		String name = "%"+cateModel.getName()+"%";
		GoodsCateModel model = new GoodsCateModel();
		model.setCode(code);
		model.setName(name);
		model.setPageIndex(cateModel.getPageIndex());
		model.setPageLimit(cateModel.getPageLimit());
		model.setOrderby("parent_code");
		model.setPageOn(true);
		List<GoodsCateModel> list = goodsCateService.selectList(model);
		Map<String, Object> map = new HashMap<String, Object>();
	    map.put("list", list);
	    map.put("count", goodsCateService.selectCount(model));
	    return new JSONObject(map).toString();
	} 
	
	@ResponseBody
	@RequestMapping("/delete")
	public int delete(String id) {
		DescrModel dm = new DescrModel();
		GoodsCateModel gcm = goodsCateService.selectModel(id);
		String parentcode = gcm.getParentCode();
		dm.setDicCode(id);
		int cc = descrService.selectCount(dm);
		if(cc > 0) {
			return 9;
		}else if(parentcode.equals("AAA") || parentcode.equals("ALL")) { // 
			return 8;
		}else {			
			return goodsCateService.delete(id);  
		}
	}
	
	
	@ResponseBody
	@RequestMapping(value="/selectcate" , produces="text/html;charset=UTF-8")
	public String selectAll(GoodsCateModel cateModel ) {
		cateModel.setOrderby("name");
		List<UserModel> listum = goodsCateService.selectcate(cateModel);
		return new JSONArray(listum).toString();
	}
	
	@RequestMapping("/addorupd")
	public String addorupd(String code , Model model) {
		if(!FmtEmpty.isEmpty(code)) {
			model.addAttribute("model", goodsCateService.selectModel(code));
		}
		GoodsCateModel gc = new GoodsCateModel();
		model.addAttribute("cate", goodsCateService.selectcate(gc));
		return "page/goods/cateaddorupd.jsp";
	}
	
	@ResponseBody
	@RequestMapping("/addupdsave")
	public int inert(GoodsCateModel cateModel) {
		String code = cateModel.getCode();
		if(goodsCateService.selectModel(code) == null) {
			goodsCateService.insertIfNotExist(cateModel);
			return 0 ; 
		}else if(goodsCateService.selectModel(code) != null){			
			return goodsCateService.update(cateModel);
		}else {
			return 4;
		}	
	}
	
	@ResponseBody
	@RequestMapping("/getCateUp")
	public List<GoodsCateModel> getCateUp(String parentCode){
		return goodsCateService.getCateUp(parentCode);
	}
	
}
