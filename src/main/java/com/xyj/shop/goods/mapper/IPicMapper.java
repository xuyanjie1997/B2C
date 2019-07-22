package com.xyj.shop.goods.mapper;

import java.util.List;

import com.xyj.shop.goods.model.PicModel;

public interface IPicMapper {

	List<PicModel> selectAll(PicModel picModel);

	int insert(PicModel picModel);

	int deleteModel(PicModel picModel);

	int update(PicModel picModel);

	PicModel selectById(Integer id);

	int deleteThisCode(PicModel picModel);

	List<PicModel> findMainPic(PicModel picModel);

}
