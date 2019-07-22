package com.xyj.shop.goods.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.xyj.shop.goods.mapper.IPicMapper;
import com.xyj.shop.goods.model.PicModel;

@Service
public class PicService {
	
	@Autowired
	private IPicMapper picMapper;

	public List<PicModel> selectAll(PicModel PicModel){
		return picMapper.selectAll(PicModel);
	}

	public void updateActive(PicModel PicModel) {
		picMapper.update(PicModel);
	}

	public int deleteModel(PicModel PicModel) {
		return picMapper.deleteModel(PicModel);
	}

	public void insert(PicModel picModel) {
		picMapper.insert(picModel);
	}
	
	public PicModel selectById(Integer id) {
		return picMapper.selectById(id);
	}

	public int deleteThisCode(PicModel picModel) {
		return picMapper.deleteThisCode(picModel);
	}

	public List<PicModel> findMainPic(PicModel picModel) {
		return picMapper.findMainPic(picModel);
	}
	
}
