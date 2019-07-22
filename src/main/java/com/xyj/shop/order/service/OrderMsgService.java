package com.xyj.shop.order.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.xyj.shop.order.mapper.IOrderMsgMapper;
import com.xyj.shop.order.model.OrderMsgModel;

@Service
public class OrderMsgService {

	@Autowired
	private IOrderMsgMapper orderMsgMapper;

	public List<OrderMsgModel> selectList(OrderMsgModel m) {
		return orderMsgMapper.selectList(m);
	}

	public int selectCount(OrderMsgModel m) {
		return orderMsgMapper.selectCount(m);
	}

	public OrderMsgModel selectModel(String id) {
		return orderMsgMapper.selectModel(id);
	}

	public int update(OrderMsgModel msgmodel) {
		return orderMsgMapper.update(msgmodel);
	}

	public List<OrderMsgModel> selectAll() {
		return orderMsgMapper.selectAll();
	}

	public int add(OrderMsgModel msgmodel) {
		return orderMsgMapper.add(msgmodel);
	}
	
}
