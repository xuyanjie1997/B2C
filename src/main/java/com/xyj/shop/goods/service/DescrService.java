package com.xyj.shop.goods.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.xyj.shop.goods.mapper.IDescrMapper;
import com.xyj.shop.goods.model.DescrModel;

import tools.FmtEmpty;

@Service
public class DescrService {

	@Autowired
	private IDescrMapper descrMapper;

	public List<DescrModel> selectList(DescrModel model) {
		return descrMapper.selectList(model) ;
	}

	public int selectCount(DescrModel model) {
		return descrMapper.selectCount(model);
	}

	public int delete(String id) {
		return descrMapper.delete(id);
	}

	public DescrModel selectModel(String code) {
		return descrMapper.selectModel(code);
	}

	public int  insertIfNotExist(DescrModel model) {
		String code = model.getCode();
		if(selectModel(code) == null) {
			return FmtEmpty.isEmpty(insert(model)) ? 2 : 0;
		}
		return 1;
	}

	public int insert(DescrModel model) {
		return descrMapper.insert(model);
	}

	public int update(DescrModel model) {
		descrMapper.update(model);
		return 3;
	}

	public List<DescrModel> selectAll() {
		return descrMapper.selectAll();
	}

	public List<DescrModel> getList(DescrModel dm) {
		return descrMapper.getList(dm);
	}

	public List<DescrModel> selectOneList(String goodscode) {
		return descrMapper.selectOneList(goodscode);
	}

	public List<DescrModel> findOneList(DescrModel dm) {
		return descrMapper.findOneList(dm);
	} 
	
}
