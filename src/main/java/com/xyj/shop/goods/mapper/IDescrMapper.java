package com.xyj.shop.goods.mapper;

import java.util.List;

import com.xyj.shop.goods.model.DescrModel;

public interface IDescrMapper {

	int selectCount(DescrModel model);
	
	List<DescrModel> selectList(DescrModel model);

	int delete(String id);

	DescrModel selectModel(String code);

	int insert(DescrModel model);

	int update(DescrModel model);

	List<DescrModel> selectAll();

	List<DescrModel> getList(DescrModel dm);

	List<DescrModel> selectOneList(String goodscode);

	List<DescrModel> findOneList(DescrModel dm);
	
}
