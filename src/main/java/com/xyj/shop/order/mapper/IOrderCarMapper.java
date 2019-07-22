package com.xyj.shop.order.mapper;

import java.util.List;

import com.xyj.shop.order.model.OrderCarModel;

public interface IOrderCarMapper {

	List<OrderCarModel> selectAll(OrderCarModel mm);

	int insert(OrderCarModel mm);

	int update(OrderCarModel mm);
	
	int updateById(OrderCarModel mm);

	List<OrderCarModel> selectList(OrderCarModel m);

	int selectCount(OrderCarModel m);

	int del(String id);

	List<OrderCarModel> selectByUser(String usercode);

	String selectCodeById(String id);
	
}
