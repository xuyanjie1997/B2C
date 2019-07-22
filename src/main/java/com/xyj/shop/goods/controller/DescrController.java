package com.xyj.shop.goods.controller;

import java.io.OutputStream;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Workbook;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xyj.shop.goods.model.DescrModel;
import com.xyj.shop.goods.model.GoodsCateModel;
import com.xyj.shop.goods.model.PicModel;
import com.xyj.shop.goods.service.DescrService;
import com.xyj.shop.goods.service.GoodsCateService;
import com.xyj.shop.goods.service.PicService;

import tools.FmtEmpty;
import tools.FmtPOI;

@Controller
@RequestMapping("/descr")
public class DescrController {

	@Autowired
	private DescrService descrService;
	@Autowired
	private GoodsCateService goodsCateService;
	@Autowired
	private PicService picService;
	
	@ResponseBody
	@RequestMapping(value="/selectList" , produces="text/html;charset=UTF-8")
	public String selectList(DescrModel model) {
		DescrModel dm = new DescrModel();
		String code = "%" + model.getCode() + "%";
		String name = "%" + model.getName() + "%";
		dm.setCode(code);
		dm.setName(name);
		dm.setPageOn(true);
		dm.setOrderby("dic_code");
		dm.setPageLimit(model.getPageLimit());
		dm.setPageIndex(model.getPageIndex());
		List<DescrModel> list = descrService.selectList(dm);
		Integer count = descrService.selectCount(dm);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list2", list);
//		map.put("data", list);//		动态表格
//		map.put("code", 0);//		动态表格
//		map.put("count", count);//		动态表格
		map.put("count2", count);
		return new JSONObject(map).toString();
	}
	
	@ResponseBody
	@RequestMapping(value="/getList" , produces="text/html;charset=UTF-8")
	public String getList(DescrModel model , Model m) {
		DescrModel dm = new DescrModel();
		String dicCode = model.getDicCode() ;
		dm.setDicCode(dicCode);
		dm.setPageOn(true);
		dm.setOrderby("name");
		dm.setPageLimit(model.getPageLimit());
		dm.setPageIndex(model.getPageIndex());
		List<DescrModel> list = descrService.getList(dm);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list2", list);
		map.put("count2", descrService.selectCount(dm));
		m.addAttribute("pi", dm.getPageIndex());
		m.addAttribute("pl", dm.getPageLimit());
		return new JSONObject(map).toString();
	}
	
	@ResponseBody
	@RequestMapping(value="/mohuyiji" , produces="text/html;charset=UTF-8")
	public String findOneList(DescrModel model , Model m) {
		DescrModel dm = new DescrModel();
		String dicCode = model.getDicCode() + "%";
		dm.setDicCode(dicCode);
		dm.setPageOn(true);
		dm.setOrderby("name");
		dm.setPageLimit(model.getPageLimit());
		dm.setPageIndex(model.getPageIndex());
		List<DescrModel> list = descrService.findOneList(dm);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list2", list);
		map.put("count2", descrService.selectCount(dm));
		m.addAttribute("pi", dm.getPageIndex());
		m.addAttribute("pl", dm.getPageLimit());
		return new JSONObject(map).toString();
	}
	
	@RequestMapping(value="/chaxun" , produces="text/html;charset=UTF-8")
	public String chaxun(DescrModel dm , String sousuo , HttpServletRequest request , Model model) {
		String name = "%" + sousuo + "%";
		dm.setName(name);
		dm.setOrderby("dic_code");
		List<DescrModel> list = descrService.selectList(dm);
		request.setAttribute("list", new JSONArray(list));
		request.setAttribute("count", descrService.selectCount(dm));
		model.addAttribute("pi", dm.getPageIndex());
		model.addAttribute("pl", dm.getPageLimit());
		return "proweb/liebiao.jsp?type=5";
	}
	
	@ResponseBody
	@RequestMapping("/delete")
	public int delete(String id) {
		PicModel pm = new PicModel();
		pm.setGoodsCode(id);
		picService.deleteThisCode(pm);
		return descrService.delete(id);
	}
	
	@RequestMapping("/addorupd")
	public String addorupd(String code , Model model) {
		if(!FmtEmpty.isEmpty(code)) {
			DescrModel dem = descrService.selectModel(code);
			model.addAttribute("model", dem);
			String dicCode = dem.getDicCode();
			String ca1 = goodsCateService.selectModel(dicCode).getParentCode();
			model.addAttribute("ca1", ca1);
			model.addAttribute("cate2", goodsCateService.selectByParentCode(ca1));
		}
		GoodsCateModel gc = new GoodsCateModel();
		model.addAttribute("cate", goodsCateService.selectcateone(gc));
		return "page/goods/descraddorupd.jsp";
	}
	
	@ResponseBody
	@RequestMapping(value="/selecttwo" , produces="text/html;charset=UTF-8")
	public String  selecttwo(String fristcate) {
		if(!FmtEmpty.isEmpty(fristcate)) {
			GoodsCateModel gcm = new GoodsCateModel();
			gcm.setParentCode(fristcate);
			List<GoodsCateModel> list = goodsCateService.selectList(gcm);
			return new JSONArray(list).toString();
		}else {
			return null;
		}

	}
	
	@ResponseBody
	@RequestMapping("/addupdsave")
	public int inorup(DescrModel model , String SecondCate) {
		String code = model.getCode();
		if(descrService.selectModel(code) == null){
			model.setDicCode(SecondCate);
			descrService.insertIfNotExist(model);
			return 0 ;
		}else if(descrService.selectModel(code) != null) {
			return descrService.update(model);
		}else {
			return 5;
		}
	}
	
	@ResponseBody
	@RequestMapping(value="/selectAll" , produces="text/html;charset=UTF-8")
	public String selectAll() {
		List<DescrModel> list = descrService.selectAll();
		return new JSONArray(list).toString();
	}
	
	@ResponseBody
	@RequestMapping("/selectModel")
	public DescrModel selectModel(String goodscode) {
		return descrService.selectModel(goodscode);
	}
	
	@ResponseBody
	@RequestMapping(value="/findone" , produces="text/html;charset=UTF-8")
	public String findone(String goodscode) {		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("model", descrService.selectOneList(goodscode));
		return new JSONObject(map).toString();
	}

	@RequestMapping("exportExcel")
	public void exportExcel(HttpServletResponse response ,  DescrModel model) throws Exception {
		
		model.setPageLimit(1000);
		List<DescrModel> dataList = descrService.selectList(model);
		List<String> propList = Arrays.asList("code" , "name" , "description" , "price" , "state" , "dicCode");
		List<String> fieldName = Arrays.asList("编号" , "名称" , "描述" , "价格" , "状态" , "上级类");
		
		Workbook wb = FmtPOI.exportExcel(dataList, propList, fieldName);
				
		response.setContentType("multipart/form-data");
//		response.setHeader("Content-Disposition", "attachment;filename=GoodsDescrTable.xls");//	中文文件名会出现下载文件为xls问题（原中文文件名消失）
		
		String fileName = "商品信息表.xls";
		response.setHeader("Content-Disposition", "attachment;filename="+new String(fileName.getBytes("UTF-8"),"ISO8859-1"));
		
		OutputStream out = response.getOutputStream();
		wb.write(out);
		wb.close();
		out.close();
	}
	
	@RequestMapping("exportTemp")
	public void exportTemp(HttpServletResponse response) throws Exception {
		
		List<String> fieldName = Arrays.asList("编号" , "名称" , "描述" , "价格" , "状态" , "上级类");
		
		Workbook wb = FmtPOI.exportExcel(null, null, fieldName);
				
		response.setContentType("multipart/form-data");
		
		String fileName = "商品信息表模板.xls";
		response.setHeader("Content-Disposition", "attachment;filename="+new String(fileName.getBytes("UTF-8"),"ISO8859-1"));
		
		OutputStream out = response.getOutputStream();
		wb.write(out);
		wb.close();
		out.close();
	}
	
}
