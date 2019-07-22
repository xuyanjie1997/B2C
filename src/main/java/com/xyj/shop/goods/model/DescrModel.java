package com.xyj.shop.goods.model;

import java.math.BigDecimal;
import tools.Pager;

public class DescrModel extends Pager {

	private Integer id;
	private String code;
	private String name;
	private BigDecimal price;
	private String description;
	private Integer amount;
	private String state;
	private String dicCode;
	
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
	public BigDecimal getPrice() {
		return price;
	}
	public void setPrice(BigDecimal price) {
		this.price = price;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public Integer getAmount() {
		return amount;
	}
	public void setAmount(Integer amount) {
		this.amount = amount;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getDicCode() {
		return dicCode;
	}
	public void setDicCode(String dicCode) {
		this.dicCode = dicCode;
	}
	@Override
	public String toString() {
		return "DescrModel [id=" + id + ", code=" + code + ", name=" + name + ", price=" + price + ", description="
				+ description + ", amount=" + amount + ", state=" + state + ", dicCode=" + dicCode + "]";
	}
	
	
	
}
