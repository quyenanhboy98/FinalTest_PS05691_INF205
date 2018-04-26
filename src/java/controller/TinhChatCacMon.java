/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.util.HashSet;
import java.util.Set;

/**
 *
 * @author QuangHau
 */
public class TinhChatCacMon{
        String tenmon = "";
	Set<String> DanhSachNhom = new HashSet<>();
	Set<String> DanhSachTo = new HashSet<>();
	Set<String> DanhSachSinhVien = new HashSet<>();
	String giuaki;
	public TinhChatCacMon(Set<String> danhSachNhom, Set<String> danhSachTo, Set<String> danhSachSinhVien,String giuaki) {
		DanhSachNhom = danhSachNhom;
		DanhSachTo = danhSachTo;
		DanhSachSinhVien = danhSachSinhVien;
		this.giuaki = giuaki;
	}
	public Set<String> getDanhSachNhom() {
		return DanhSachNhom;
	}
	public void setDanhSachNhom(Set<String> danhSachNhom) {
		DanhSachNhom = danhSachNhom;
	}
	public Set<String> getDanhSachTo() {
		return DanhSachTo;
	}
	public void setDanhSachTo(Set<String> danhSachTo) {
		DanhSachTo = danhSachTo;
	}
	public Set<String> getDanhSachSinhVien() {
		return DanhSachSinhVien;
	}
	public void setDanhSachSinhVien(Set<String> danhSachSinhVien) {
		DanhSachSinhVien = danhSachSinhVien;
	}
	
	public String getGiuaKi(){
		return giuaki;
					
	}
	
	public String getCuoiKi(){
		if(DanhSachTo.size() == 0)
			return "PM";
		else{
			return "LT";
		}
	}
        
        public String getTenMon(){
            return this.tenmon;
        }
        
        public void setTenMon(String x){
            this.tenmon = x;
        }
}
