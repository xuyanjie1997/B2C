package com.xyj.shop.user.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import tools.MD5;

import com.xyj.shop.user.model.UserModel;
import com.xyj.shop.user.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {

	@Autowired
	private UserService userService;
	
	//	http://localhost:8088/xshop/web/page/main.jsp
	//	http://localhost:8088/xshop/web/login.jsp
	
	@ResponseBody
	@RequestMapping("/reg")
	public int reg(UserModel userModel) {
		System.out.println("-------"+userModel.getUsercode());
		return userService.insertIfNotExist(userModel);
	}
	
	@ResponseBody
	@RequestMapping("/proreg")
	public int proreg(UserModel userModel , String repassword , HttpServletRequest request) {
		if (isOkAuthCode(request) == false) { 
            return 3;
        }
		if(userModel.getPassword().equals(repassword) == false) {
			return 5;
		}
		return userService.insertIfNotExist(userModel);
	}
	
	@ResponseBody
	@RequestMapping("/login")
	public int login(UserModel userModel , HttpServletRequest request) {
		if (isOkAuthCode(request) == false) { 
            return 3;
        }
		UserModel um = new UserModel();
		um.setUsercode(userModel.getUsercode());
		UserModel udb = userService.selectModel(um);
		if( udb == null) {
			return 1;
		}
        String pass = userModel.getPassword();
        pass = MD5.encode(pass);
        if (udb.getPassword().equals(pass)) {
            request.getSession().setAttribute("user", udb);  
            return 0;
        } 
        if("0".equals(userModel.getIsAdmin())) {
            return 2;
        }else {
        	return 4;
        }
	}
	
	@ResponseBody
	@RequestMapping("/prologin")
	public int prologin(UserModel userModel , HttpServletRequest request) {
		if (isOkAuthCode(request) == false) { 
            return 3;
        }
		UserModel um = new UserModel();
		um.setUsercode(userModel.getUsercode());
		UserModel udb = userService.selectModel(um);
		if( udb == null) {
			return 1;
		}
        String pass = userModel.getPassword();
        pass = MD5.encode(pass);
        if (udb.getPassword().equals(pass)) {
            request.getSession().setAttribute("prouser", udb);  
            return 0;
        }else {
        	return 4;
        }
	}
	
	private boolean isOkAuthCode(HttpServletRequest request) {
        Object authCode = request.getSession().getAttribute("authcode");
        String code = request.getParameter("authcode");
        return authCode.toString().equals(code);
	}
	
	@ResponseBody
	@RequestMapping(value="/selectList",produces="text/html;charset=UTF-8")
	public String selectList(UserModel userModel){
		String usercode = "%"+userModel.getUsercode()+"%";
		String name = "%"+userModel.getName()+"%";
		UserModel model = new UserModel();
		model.setUsercode(usercode);
		model.setName(name);
		model.setPageIndex(userModel.getPageIndex());
		model.setPageLimit(userModel.getPageLimit());
		model.setPageOn(true);
		List<UserModel> list = userService.selectList(model);
		Map<String, Object> map = new HashMap<String, Object>();
	    map.put("list", list);
	    map.put("count", userService.selectCount(model));
	    return new JSONObject(map).toString();
	}
	
	@ResponseBody
	@RequestMapping("/selectModel")
	public UserModel selectModel(UserModel userModel) {
		return userService.selectModel(userModel);
	}
	
	@ResponseBody
	@RequestMapping("/delete")
	public int delete(String id , HttpServletRequest request) {
		UserModel sessionuser = (UserModel)request.getSession().getAttribute("user");
		if(id.equals(sessionuser.getUsercode())) {
			return 2;
		}
		return userService.delete(id);		
	}
	
	@ResponseBody
	@RequestMapping("/passupd")
	public int passupd(UserModel userModel , HttpServletRequest request) {
		String id = userModel.getUsercode();
		UserModel sessionuser = (UserModel)request.getSession().getAttribute("user");
		if(id.equals(sessionuser.getUsercode())) {
			return 2;
		}
		return userService.passupd(userModel);	
	}
	
	@ResponseBody
	@RequestMapping("/update")
	public int update(UserModel userModel) {
		return userService.update(userModel);
	}
	
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request) {
		request.getSession().removeAttribute("user");
		return "login.jsp";
	}
	
	@ResponseBody
	@RequestMapping("/prologout")
	public int prologout(HttpServletRequest request) {
		request.getSession().removeAttribute("prouser");
		return 1;
	}
	
}
