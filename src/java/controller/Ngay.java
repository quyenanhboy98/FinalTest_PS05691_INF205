/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author QuangHau
 */
public class Ngay{
	String tenngay;
	ArrayList<String> somau;
	Map<String,Integer> listsinhvien;
	Map<String,ArrayList<String>> listmonhoc = new HashMap<String,ArrayList<String>>();
	
	public Ngay(String tenngay, ArrayList<String> somau, Map<String, Integer> listsinhvien) {
		super();
		this.tenngay = tenngay;
		this.somau = somau;
		this.listsinhvien = listsinhvien;
	}

	public String getTenngay() {
		return tenngay;
	}

	public void setTenngay(String tenngay) {
		this.tenngay = tenngay;
	}

	public ArrayList<String> getSomau() {
		return somau;
	}

	

	public Map<String, ArrayList<String>> getListmonhoc() {
		return listmonhoc;
	}

	public void setListmonhoc(Map<String, ArrayList<String>> listmonhoc) {
		this.listmonhoc = listmonhoc;
	}

	public void setSomau(ArrayList<String> somau) {
		this.somau = somau;
	}

	public Map<String, Integer> getListsinhvien() {
		return listsinhvien;
	}

	public void setListsinhvien(Map<String, Integer> listsinhvien) {
		this.listsinhvien = listsinhvien;
	}
}
