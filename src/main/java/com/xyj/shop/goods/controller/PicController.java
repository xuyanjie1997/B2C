package com.xyj.shop.goods.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.xyj.shop.goods.model.PicModel;
import com.xyj.shop.goods.service.PicService;


@Controller
@RequestMapping("/pic")
public class PicController {

    @Autowired
    private PicService picService;

    private String PATH = "D:/Office/image/";

    @RequestMapping("/upload")
    @ResponseBody
    public String upload(HttpServletRequest request, String code) throws IllegalStateException, IOException {
        CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(
                request.getSession().getServletContext());
        if (multipartResolver.isMultipart(request)) {
            MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
            Iterator<String> iter = multiRequest.getFileNames();
            while (iter.hasNext()) {
                MultipartFile file = multiRequest.getFile(iter.next().toString());
                if (file != null) {
                    String filename = file.getOriginalFilename();
                    String saveName = UUID.randomUUID().toString() + filename.substring(filename.lastIndexOf("."));
                    String path = PATH + saveName;
                    file.transferTo(new File(path));
                    picService.insert(new PicModel(code, saveName, "2"));
                }
            }
        }
        Map<String, String> result = new HashMap<String, String>();
        result.put("code", "0");
        return  new JSONObject(result).toString();
    }

    @RequestMapping(value = "/getList", produces = "application/json;charset=UTF-8")
    @ResponseBody
    private String getList(String code) {
    	PicModel PicModel = new PicModel();
//    	System.out.println("CODE = "+code);
    	PicModel.setGoodsCode(code);
    	PicModel.setOrderby("type");
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("list", picService.selectAll(PicModel));
        return new JSONObject(map).toString();
    }

    @RequestMapping("/del")
    @ResponseBody
    public String del(PicModel PicModel) {
        File file = new File(PATH + PicModel.getUrl());
        file.delete();
        return picService.deleteModel(PicModel) + "";
    }

    @RequestMapping("/setMain")
    @ResponseBody
    public String setMain(PicModel PicModel) {
        Integer id = PicModel.getId();
        PicModel t = picService.selectById(id);
        List<PicModel> list = picService.selectAll(t);
        for (PicModel ppm : list) {
            if (id.equals(ppm.getId())) {
                ppm.setType("1");
            } else if (ppm.getType().equals("1")) {
                ppm.setType("2");
            } else {
                continue;
            }
            picService.updateActive(ppm);
        }
        return "1";
    }
    
    @RequestMapping("/findPic")
    @ResponseBody
    public String findPic(String goodsCode) {
    	PicModel PicModel = new PicModel();
    	PicModel.setGoodsCode(goodsCode);
    	Map<String, Object> map = new HashMap<String, Object>();
        map.put("pic", picService.findMainPic(PicModel));
        return new JSONObject(map).toString();
    }
    
}
