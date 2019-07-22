package com.xyj.shop.goods.mapper;

import java.util.List;

import com.xyj.shop.goods.model.GoodsCateModel;
import com.xyj.shop.user.model.UserModel;

public interface IGoodsCateMapper {

	int insert(GoodsCateModel cateModel);
	
	int delete(String id);

	int update(GoodsCateModel cateModel);
	
	int selectCount(GoodsCateModel model);
	
	int selectIfDelete(String id);//	查找一级分类下二级分类的数目（同一分类共用同一编号前缀）
	
	List<UserModel> selectcate(GoodsCateModel cateModel);//	查找一级分类以及总分类，显示在下拉框
	
	List<UserModel> selectcateone(GoodsCateModel cateModel);//	查找一级分类，显示在下拉框
	
	List<GoodsCateModel> selectList(GoodsCateModel model);

	GoodsCateModel selectModel(String code);

	List<GoodsCateModel> getCateUp(String parentCode);//	根据传入的参数查找上一级分类是parentCode的数据
	
}
