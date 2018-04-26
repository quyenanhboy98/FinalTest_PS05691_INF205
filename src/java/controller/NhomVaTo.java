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
public class NhomVaTo {
    String Nhom;
    String To;

    public NhomVaTo(String Nhom, String To) {
        this.Nhom = Nhom;
        this.To = To;
    }

    public String getNhom() {
        return Nhom;
    }

    public void setNhom(String Nhom) {
        this.Nhom = Nhom;
    }

    public String getTo() {
        return To;
    }

    public void setTo(String To) {
        this.To = To;
    }
    
}
