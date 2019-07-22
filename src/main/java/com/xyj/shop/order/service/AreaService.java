package com.xyj.shop.order.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.xyj.shop.order.mapper.IAreaMapper;
import com.xyj.shop.order.model.AreaModel;

@Service
public class AreaService {

	@Autowired
	private IAreaMapper areaMapper;

	public List<AreaModel> selectSheng() {
		return areaMapper.selectSheng();
	}
	
}
