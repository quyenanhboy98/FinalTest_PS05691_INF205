/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

/**
 *
 * @author QuangHau
 */
public class mydata {
    String tenphong;
	public mydata(String tenphong, int succhua, boolean tinhtrang) {
		super();
		this.tenphong = tenphong;
		this.succhua = succhua;
		this.tinhtrang = tinhtrang;
	}
	int succhua;
	boolean tinhtrang;
	public int getSucchua() {
		return succhua;
	}
	public void setSucchua(int succhua) {
		this.succhua = succhua;
	}
	public boolean isTinhtrang() {
		return tinhtrang;
	}
	public void setTinhtrang(boolean tinhtrang) {
		this.tinhtrang = tinhtrang;
	}
	public String getTenphong() {
		return tenphong;
	}
	public void setTenphong(String tenphong) {
		this.tenphong = tenphong;
	}
}
