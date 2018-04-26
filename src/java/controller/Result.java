/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.util.ArrayList;
import java.util.Map;

/**
 *
 * @author QuangHau
 */
public class Result{
	ArrayList<Ngay> ngayThi;
	Map<String,ArrayList<String>> raiPhong;
	public Result(ArrayList<Ngay> ngayThi, Map<String, ArrayList<String>> raiPhong) {
		super();
		this.ngayThi = ngayThi;
		this.raiPhong = raiPhong;
	}
	public ArrayList<Ngay> getNgayThi() {
		return ngayThi;
	}
	public void setNgayThi(ArrayList<Ngay> ngayThi) {
		this.ngayThi = ngayThi;
	}
	public Map<String, ArrayList<String>> getRaiPhong() {
		return raiPhong;
	}
	public void setRaiPhong(Map<String, ArrayList<String>> raiPhong) {
		this.raiPhong = raiPhong;
	}
        public void HoanViGiuaKi(){
            if(ngayThi.size()==7){
                ArrayList<Ngay> ngayThiMoi = ngayThi;
                Ngay temp = ngayThiMoi.get(1);
                ngayThiMoi.set(1, ngayThiMoi.get(6));
                ngayThiMoi.set(6, temp);
                
                Ngay temp2 = ngayThiMoi.get(2);
                ngayThiMoi.set(2, ngayThiMoi.get(4));
                ngayThiMoi.set(4, temp2);
                
                Ngay temp3 = ngayThiMoi.get(3);
                ngayThiMoi.set(3, ngayThiMoi.get(5));
                ngayThiMoi.set(5, temp3);
                
                Ngay temp4 = ngayThiMoi.get(1);
                ngayThiMoi.set(1, ngayThiMoi.get(5));
                ngayThiMoi.set(5, temp4);
                
                this.ngayThi = ngayThiMoi;
            }
        }
        public void HoanViCuoiKi(){
            if(ngayThi.size() == 12){
                ArrayList<Ngay> ngayThiMoi = ngayThi;
                Ngay temp = ngayThiMoi.get(1);
                ngayThiMoi.set(1, ngayThiMoi.get(7));
                ngayThiMoi.set(7, temp);
                
                Ngay temp2 = ngayThiMoi.get(2);
                ngayThiMoi.set(2, ngayThiMoi.get(9));
                ngayThiMoi.set(9, temp2);
                
                Ngay temp3 = ngayThiMoi.get(3);
                ngayThiMoi.set(3, ngayThiMoi.get(11));
                ngayThiMoi.set(11, temp3);
                
                this.ngayThi = ngayThiMoi;
            }
        }
}
