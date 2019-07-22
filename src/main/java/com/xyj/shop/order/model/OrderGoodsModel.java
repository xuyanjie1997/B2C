package com.xyj.shop.order.model;

import java.util.List;

import com.xyj.shop.goods.model.DescrModel;
import com.xyj.shop.goods.model.PicModel;

public class OrderGoodsModel {

	private Integer id;
	private String orderCode;
	private String goodsCode;
	private Integer amount;
	private Integer price;
	private List<DescrModel> delist;
	private List<PicModel> pic;

	public OrderGoodsModel(){
		
	}
	
	public OrderGoodsModel(String orderCode, String goodsCode ){
		this.orderCode = orderCode;
		this.goodsCode = goodsCode;
	}
	
	
	public List<DescrModel> getDelist() {
		return delist;
	}

	public void setDelist(List<DescrModel> delist) {
		this.delist = delist;
	}

	public List<PicModel> getPic() {
		return pic;
	}

	public void setPic(List<PicModel> pic) {
		this.pic = pic;
	}

	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getOrderCode() {
		return orderCode;
	}

	public void setOrderCode(String orderCode) {
		this.orderCode = orderCode;
	}

	public String getGoodsCode() {
		return goodsCode;
	}

	public void setGoodsCode(String goodsCode) {
		this.goodsCode = goodsCode;
	}

	public Integer getAmount() {
		return amount;
	}

	public void setAmount(Integer amount) {
		this.amount = amount;
	}

	public Integer getPrice() {
		return price;
	}

	public void setPrice(Integer price) {
		this.price = price;
	}

	
}
