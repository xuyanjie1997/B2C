package com.xyj.shop.goods.mapper;

import java.util.List;

import com.xyj.shop.goods.model.GoodsCateModel;
import com.xyj.shop.user.model.UserModel;

public interface IGoodsCateMapper {

	int insert(GoodsCateModel cateModel);
	
	int delete(String id);

	int update(GoodsCateModel cateModel);
	
	int selectCount(GoodsCateModel model);
	
	int selectIfDelete(String id);//	����һ�������¶����������Ŀ��ͬһ���๲��ͬһ���ǰ׺��
	
	List<UserModel> selectcate(GoodsCateModel cateModel);//	����һ�������Լ��ܷ��࣬��ʾ��������
	
	List<UserModel> selectcateone(GoodsCateModel cateModel);//	����һ�����࣬��ʾ��������
	
	List<GoodsCateModel> selectList(GoodsCateModel model);

	GoodsCateModel selectModel(String code);

	List<GoodsCateModel> getCateUp(String parentCode);//	���ݴ���Ĳ���������һ��������parentCode������
	
}
