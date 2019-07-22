package com.xyj.shop.user.model;

import tools.Pager;

public class UserModel  extends Pager{

	private Integer id;
	private String usercode;
	private String password;
	private String name ;
	private String isAdmin ;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getUsercode() {
		return usercode;
	}
	public void setUsercode(String usercode) {
		this.usercode = usercode;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}

	public String getIsAdmin() {
		return isAdmin;
	}
	public void setIsAdmin(String isAdmin) {
		this.isAdmin = isAdmin;
	}
	@Override
	public String toString() {
		return "UserModel [id=" + id + ", usercode=" + usercode + ", password=" + password + ", name=" + name
				+ ", isAdmin=" + isAdmin + "]";
	}
	
	
	
}
