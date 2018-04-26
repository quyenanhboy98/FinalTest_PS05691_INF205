/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.util.Map;

/**
 *
 * @author QuangHau
 */
public class SinhVien_Nhom_To {
    Map<String,NhomVaTo> sinhvien;

    public SinhVien_Nhom_To(Map<String, NhomVaTo> sinhvien) {
        this.sinhvien = sinhvien;
    }

    public Map<String, NhomVaTo> getSinhvien() {
        return sinhvien;
    }

    public void setSinhvien(Map<String, NhomVaTo> sinhvien) {
        this.sinhvien = sinhvien;
    }
    
}
