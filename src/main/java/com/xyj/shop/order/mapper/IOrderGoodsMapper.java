package com.xyj.shop.order.mapper;

import java.util.List;

import com.xyj.shop.order.model.OrderGoodsModel;

public interface IOrderGoodsMapper {

	List<OrderGoodsModel> selectList(OrderGoodsModel ommodel);

	OrderGoodsModel selectModel(OrderGoodsModel m);

	int insert(OrderGoodsModel ommodel);

	int update(OrderGoodsModel ommodel);

	int delete(String id);

	List<OrderGoodsModel> selectByOrder(OrderGoodsModel ommodel);
	
}
