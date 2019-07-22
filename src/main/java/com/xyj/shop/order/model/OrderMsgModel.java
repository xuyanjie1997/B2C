package com.xyj.shop.order.model;

import tools.Pager;

public class OrderMsgModel  extends Pager{

	private Integer id;
	private String code ; 
	private String usercode;
	private String time;
	private String attn;
	private String address;
	private String tel;
	private Float heji;
	private String state;
	
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
	public String getUsercode() {
		return usercode;
	}
	public void setUsercode(String usercode) {
		this.usercode = usercode;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getAttn() {
		return attn;
	}
	public void setAttn(String attn) {
		this.attn = attn;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public Float getHeji() {
		return heji;
	}
	public void setHeji(Float heji) {
		this.heji = heji;
	}

	
	
	
}
