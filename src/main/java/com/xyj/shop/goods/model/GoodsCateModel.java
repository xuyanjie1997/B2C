package com.xyj.shop.goods.model;

import tools.Pager;

public class GoodsCateModel  extends Pager{

	private Integer id;
	private String code;
	private String name;
	private String descr;
	private String parentCode;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescr() {
		return descr;
	}
	public void setDescr(String descr) {
		this.descr = descr;
	}
	public String getParentCode() {
		return parentCode;
	}
	public void setParentCode(String parentCode) {
		this.parentCode = parentCode;
	}
	@Override
	public String toString() {
		return "GoodsCateModel [id=" + id + ", code=" + code + ", name=" + name + ", descr=" + descr + ", parentCode="
				+ parentCode + "]";
	}
	
	
	
}
