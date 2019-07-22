package com.xyj.shop.user.mapper;

import java.util.List;

import com.xyj.shop.user.model.UserModel;

public interface IUserMapper {

	int insert(UserModel userModel);

	UserModel selectModel(UserModel userModel);

	List<UserModel> selectList(UserModel model);

	int selectCount(UserModel model);

	int delete(String id);

	int passupd(UserModel userModel);
	
	int update(UserModel userModel);
	
}
