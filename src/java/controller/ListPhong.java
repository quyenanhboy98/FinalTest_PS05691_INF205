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
public class ListPhong {
    Map<String,ArrayList<String>> index_listphong;

	public Map<String, ArrayList<String>> getIndex_listphong() {
		return index_listphong;
	}

	public void setIndex_listphong(Map<String, ArrayList<String>> index_listphong) {
		this.index_listphong = index_listphong;
	}

	public ListPhong(Map<String, ArrayList<String>> index_listphong) {
		super();
		this.index_listphong = index_listphong;
	}
	
	public ListPhong(){}
}
