package com.xyj.shop.order.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.xyj.shop.order.mapper.IOrderGoodsMapper;
import com.xyj.shop.order.model.OrderGoodsModel;

@Service
public class OrderGoodsService {

	@Autowired
	private IOrderGoodsMapper orderGoodsMapper;

	public List<OrderGoodsModel> selectList(OrderGoodsModel ommodel) {
		return orderGoodsMapper.selectList(ommodel);
	}

	public int insert(OrderGoodsModel ommodel) {
		String ordercode = ommodel.getOrderCode();
		String goodscode = ommodel.getGoodsCode();
		OrderGoodsModel m = new OrderGoodsModel(ordercode,goodscode);
		if(orderGoodsMapper.selectModel(m) == null) {
			return orderGoodsMapper.insert(ommodel);
		}else if(orderGoodsMapper.selectModel(m) != null){
			Integer am = ommodel.getAmount();
			ommodel.setAmount(ommodel.getAmount() + am);
			Integer pri = ommodel.getPrice();
			ommodel.setPrice(ommodel.getPrice() + pri);
			orderGoodsMapper.update(ommodel);
			return 2;
		}
		return 3;
	}

	public int delete(String id) {
		return orderGoodsMapper.delete(id);
	}

	public List<OrderGoodsModel> selectByOrder(OrderGoodsModel ommodel) {
		return orderGoodsMapper.selectByOrder(ommodel);
	}
	
}
