package com.xyj.shop.order.mapper;

import java.util.List;

import com.xyj.shop.order.model.OrderMsgModel;

public interface IOrderMsgMapper {

	List<OrderMsgModel> selectList(OrderMsgModel m);

	int selectCount(OrderMsgModel m);

	OrderMsgModel selectModel(String id);

	int update(OrderMsgModel msgmodel);

	List<OrderMsgModel> selectAll();

	int add(OrderMsgModel msgmodel);

}
