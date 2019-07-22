package com.xyj.shop.goods.model;

import tools.Pager;

public class PicModel extends Pager{

	private  Integer id;
    private  String goodsCode;
    private String  url;
    private String  type;
    
    public PicModel() {}
    public PicModel(String goodsCode ) {
    	this.goodsCode=goodsCode;
    	
    }
    public PicModel(String goodsCode , String url , String type) {
    	this.goodsCode=goodsCode;
    	this.url = url;
    	this.type = type;
    }
    
    
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getGoodsCode() {
		return goodsCode;
	}
	public void setGoodsCode(String goodsCode) {
		this.goodsCode = goodsCode;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	@Override
	public String toString() {
		return "GoodsImgModel [id=" + id + ", goodsCode=" + goodsCode + ", url=" + url + ", type=" + type + "]";
	}
	
	
}
