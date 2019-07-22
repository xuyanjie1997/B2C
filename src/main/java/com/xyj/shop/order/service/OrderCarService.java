package com.xyj.shop.order.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.xyj.shop.order.mapper.IOrderCarMapper;
import com.xyj.shop.order.model.OrderCarModel;

@Service
public class OrderCarService {

	@Autowired
	private IOrderCarMapper  orderCarMapper ;

	public List<OrderCarModel> selectAll(OrderCarModel mm) {
		return orderCarMapper.selectAll(mm);
	}

	public int insert(OrderCarModel mm) {
		return orderCarMapper.insert(mm);
	}

	public int update(OrderCarModel mm) {
		return orderCarMapper.update(mm);
	}
	
	public int updateById(OrderCarModel mm) {
		return orderCarMapper.updateById(mm);
	}

	public List<OrderCarModel> selectList(OrderCarModel m) {
		return orderCarMapper.selectList(m);
	}

	public int selectCount(OrderCarModel m) {
		return orderCarMapper.selectCount(m);
	}

	public int del(String id) {
		return orderCarMapper.del(id);
	} 
	
	public List<OrderCarModel> selectByUser(String usercode) {
		return orderCarMapper.selectByUser(usercode);
	}

	public String selectCodeById(String id) {
		return orderCarMapper.selectCodeById(id);
	} 
	
}
