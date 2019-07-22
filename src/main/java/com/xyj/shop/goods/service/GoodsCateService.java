package com.xyj.shop.goods.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.xyj.shop.goods.mapper.IGoodsCateMapper;
import com.xyj.shop.goods.model.GoodsCateModel;
import com.xyj.shop.user.model.UserModel;

import tools.FmtEmpty;

@Service
public class GoodsCateService {

	@Autowired
	private IGoodsCateMapper goodsCateMapper;

	public List<GoodsCateModel> selectList(GoodsCateModel model) {
		return goodsCateMapper.selectList(model);
	}

	public int selectCount(GoodsCateModel model) {
		return goodsCateMapper.selectCount(model);
	}

	public int delete(String id) {
		GoodsCateModel mf = goodsCateMapper.selectModel(id);
		String id2 = "%" + id + "%";
		if(goodsCateMapper.selectIfDelete(id2) >= 2  && mf.getParentCode().equals("ALL")) {
			return 0 ; //	一级分类下若存在二级分类，则无法删除
		}
		return goodsCateMapper.delete(id);
	}

	public int update(GoodsCateModel cateModel) {
		goodsCateMapper.update(cateModel);
		return 3;
	}

	public List<UserModel> selectcate(GoodsCateModel cateModel) {
		return goodsCateMapper.selectcate(cateModel);
	}
	
	public List<UserModel> selectcateone(GoodsCateModel cateModel) {
		return goodsCateMapper.selectcateone(cateModel);
	}

	public int insertIfNotExist(GoodsCateModel cateModel) {
		String code = cateModel.getCode();
		if(selectModel(code) == null) {
			return FmtEmpty.isEmpty(insert(cateModel)) ? 2 : 0;
		}
		return 1;
	}

	public GoodsCateModel selectModel(String code) {
		return goodsCateMapper.selectModel(code);
	}

	private int insert(GoodsCateModel cateModel) {
		return goodsCateMapper.insert(cateModel);
	}

	public List<GoodsCateModel> selectByParentCode(String pcode) {
		GoodsCateModel goodscate = new GoodsCateModel();
		goodscate.setParentCode(pcode);
		return goodsCateMapper.selectList(goodscate);
	}

	public List<GoodsCateModel> getCateUp(String parentCode) {
		return goodsCateMapper.getCateUp(parentCode);
	}
	
}
