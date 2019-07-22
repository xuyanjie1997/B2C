package com.xyj.shop.order.model;

import java.util.List;

import com.xyj.shop.goods.model.DescrModel;
import com.xyj.shop.goods.model.PicModel;

public class OrderCarModel {

	private Integer id;
	private String userCode;
	private String goodsCode;
	private Integer num;
	
	private List<DescrModel> delist;
	private List<PicModel> pic;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getUserCode() {
		return userCode;
	}
	public void setUserCode(String userCode) {
		this.userCode = userCode;
	}
	public String getGoodsCode() {
		return goodsCode;
	}
	public void setGoodsCode(String goodsCode) {
		this.goodsCode = goodsCode;
	}
	public Integer getNum() {
		return num;
	}
	public void setNum(Integer num) {
		this.num = num;
	}
	public List<DescrModel> getDescr() {
		return delist;
	}
	public void setDescr(List<DescrModel> delist) {
		this.delist = delist;
	}
	public List<PicModel> getPic() {
		return pic;
	}
	public void setPic(List<PicModel> pic) {
		this.pic = pic;
	}
	
	
	
}
