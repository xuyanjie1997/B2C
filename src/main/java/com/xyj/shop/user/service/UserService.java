package com.xyj.shop.user.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import tools.MD5;
import com.xyj.shop.user.mapper.IUserMapper;
import com.xyj.shop.user.model.UserModel;

import tools.FmtEmpty;

@Service
public class UserService {
	
	@Autowired
	private IUserMapper userMapper;

	private int insert(UserModel userModel) {
		String pass = userModel.getPassword();
		userModel.setPassword(MD5.encode(pass));
		return userMapper.insert(userModel);
	}

	public int insertIfNotExist(UserModel userModel) {
	     if (selectModel(userModel) == null) {
	        	return FmtEmpty.isEmpty(insert(userModel)) ? 2 : 0;
	        }
		return 1;
	}

	public UserModel selectModel(UserModel userModel) {
		return userMapper.selectModel(userModel);
	}

	public List<UserModel> selectList(UserModel model) {
		return userMapper.selectList(model);
	}

	public int selectCount(UserModel model) {
		return userMapper.selectCount(model);
	}

	public int delete(String id) {
		return userMapper.delete(id);
	}

	public int passupd(UserModel userModel) {
		return userMapper.passupd(userModel);
	}

	public int update(UserModel userModel) {
		String pass =  userModel.getPassword();
		pass = MD5.encode(pass);
		userModel.setPassword(pass);
		return userMapper.update(userModel);
	}
	
}
