package controller;

import controller.TinhChatCacMon;
import controller.ColoringGraph;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

public class XepPhongThi {
	public static ArrayList<Ngay> XepLichThiGiuaKi(Map<String,ArrayList<String>> color,Map<String,TinhChatCacMon> listStudentsofCourse){
		ArrayList<Ngay> ngayThiGiuaKi = new ArrayList<Ngay>();
		
		//Xep Lich Cho Thi Giua Ki
		for(int i=0;i<7;i++){
			if(i==6){
				ngayThiGiuaKi.add(new Ngay("CN",new ArrayList<String>(),new HashMap<String,Integer>()));
			}
			else{
				ngayThiGiuaKi.add(new Ngay("Thu"+Integer.toString(i+2),new ArrayList<String>(),new HashMap<String,Integer>()));
			}
		}
		
		for(String x:color.keySet()){
			ArrayList<String> listMonHoc2 = color.get(x);
			ArrayList<String> listMonHoc = new ArrayList<String>();
			for(int z=0;z<listMonHoc2.size();z++){
                            if(listMonHoc2.get(z).charAt(2) != '0'){
                                listMonHoc.add(listMonHoc2.get(z));
                            }
			}
			ArrayList<String> listHocSinh = new ArrayList<String>();
			for(int index=0;index<listMonHoc.size();index++){
				for(String z:listStudentsofCourse.get(listMonHoc.get(index)).getDanhSachSinhVien()){
					listHocSinh.add(z);
				}
			}
			//get students number of every color(up)
			for(int index3=0;index3<ngayThiGiuaKi.size();index3++){
				if(ngayThiGiuaKi.get(index3).getSomau().size()<10){
					boolean check = false;
					for(int index4=0;index4<listHocSinh.size();index4++){
						if(ngayThiGiuaKi.get(index3).listsinhvien.containsKey(listHocSinh.get(index4))){
							if(ngayThiGiuaKi.get(index3).listsinhvien.get(listHocSinh.get(index4))>=3){
								check = true;
								break;
							}
						}
					}
					if(check == true){
						continue;
					}
					else{
						ngayThiGiuaKi.get(index3).somau.add(x);
						for(int index4=0;index4<listHocSinh.size();index4++){
							if(ngayThiGiuaKi.get(index3).listsinhvien.containsKey(listHocSinh.get(index4))){
								int num = ngayThiGiuaKi.get(index3).listsinhvien.get(listHocSinh.get(index4));
								num++;
								ngayThiGiuaKi.get(index3).listsinhvien.remove(listHocSinh.get(index4));
								ngayThiGiuaKi.get(index3).listsinhvien.put(listHocSinh.get(index4), num);
							}
							else{
								ngayThiGiuaKi.get(index3).listsinhvien.put(listHocSinh.get(index4), 1);
							}
						}
						break;
					}
				}
			}
		}
		
		for(int i=0;i<ngayThiGiuaKi.size();i++){
			for(int z=0;z<ngayThiGiuaKi.get(i).getSomau().size();z++){
				Map<String,ArrayList<String>> soCa = ngayThiGiuaKi.get(i).getListmonhoc();
				ArrayList<String> listmonhoc = new ArrayList<String>();
				for(int z1=0;z1<color.get(ngayThiGiuaKi.get(i).getSomau().get(z)).size();z1++){
                                    if(color.get(ngayThiGiuaKi.get(i).getSomau().get(z)).get(z1).charAt(2)!= '0')
						listmonhoc.add(color.get(ngayThiGiuaKi.get(i).getSomau().get(z)).get(z1));
					
				}
                                if(listmonhoc.size() > 0){
                                    soCa.put("Ca"+Integer.toString(soCa.size()+1), listmonhoc);
                                    ngayThiGiuaKi.get(i).setListmonhoc(soCa);
                                }
			}
		}
		
		return ngayThiGiuaKi;
	}
	
	public static ArrayList<Ngay> XepLichThiCuoiKi(Map<String,ArrayList<String>> color,Map<String,TinhChatCacMon> listStudentsofCourse){
		//Xep Lich Cho Thi Cuoi Ki
		ArrayList<Ngay> ngayThiCuoiKi = new ArrayList<Ngay>();
		for(int i=0;i<12;i++){
			if(i<6){
				ngayThiCuoiKi.add(new Ngay("Thu"+Integer.toString(i+2),new ArrayList<String>(),new HashMap<String,Integer>()));
			}
			else{
				ngayThiCuoiKi.add(new Ngay("Thu"+Integer.toString(i-6+2),new ArrayList<String>(),new HashMap<String,Integer>()));
			}
		}
		
		for(String x:color.keySet()){
			ArrayList<String> listMonHoc2 = color.get(x);
			ArrayList<String> listMonHoc = new ArrayList<String>();
			for(int z=0;z<listMonHoc2.size();z++){
				if(listMonHoc2.get(z).charAt(2) != '0'){
					listMonHoc.add(listMonHoc2.get(z));
				}
			}
			ArrayList<String> listHocSinh = new ArrayList<String>();
			for(int index=0;index<listMonHoc.size();index++){
				for(String z:listStudentsofCourse.get(listMonHoc.get(index)).getDanhSachSinhVien()){
					listHocSinh.add(z);
				}
			}
			
			//get students number of every color(up)
			for(int index3=0;index3<ngayThiCuoiKi.size();index3++){
				if(ngayThiCuoiKi.get(index3).getSomau().size()<4){
					boolean check = false;
					for(int index4=0;index4<listHocSinh.size();index4++){
						if(ngayThiCuoiKi.get(index3).listsinhvien.containsKey(listHocSinh.get(index4))){
							if(ngayThiCuoiKi.get(index3).listsinhvien.get(listHocSinh.get(index4))>=3){
								check = true;
								break;
							}
						}
					}
					if(check == true){
						continue;
					}
					else{
						ngayThiCuoiKi.get(index3).somau.add(x);
						for(int index4=0;index4<listHocSinh.size();index4++){
							if(ngayThiCuoiKi.get(index3).listsinhvien.containsKey(listHocSinh.get(index4))){
								int num = ngayThiCuoiKi.get(index3).listsinhvien.get(listHocSinh.get(index4));
								num++;
								ngayThiCuoiKi.get(index3).listsinhvien.remove(listHocSinh.get(index4));
								ngayThiCuoiKi.get(index3).listsinhvien.put(listHocSinh.get(index4), num);
							}
							else{
								ngayThiCuoiKi.get(index3).listsinhvien.put(listHocSinh.get(index4), 1);
							}
						}
						break;
					}
				}
			}
		}
		
		for(int i=0;i<ngayThiCuoiKi.size();i++){
			for(int z=0;z<ngayThiCuoiKi.get(i).getSomau().size();z++){
				Map<String,ArrayList<String>> soCa = ngayThiCuoiKi.get(i).getListmonhoc();
				ArrayList<String> listmonhoc = new ArrayList<String>();
				for(int z1=0;z1<color.get(ngayThiCuoiKi.get(i).getSomau().get(z)).size();z1++){
					if(color.get(ngayThiCuoiKi.get(i).getSomau().get(z)).get(z1).charAt(2)!= '0')
						listmonhoc.add(color.get(ngayThiCuoiKi.get(i).getSomau().get(z)).get(z1));
				}
				if(listmonhoc.size()>0){
					soCa.put("Ca"+Integer.toString(soCa.size()+1), listmonhoc);
					ngayThiCuoiKi.get(i).setListmonhoc(soCa);
				}
				
			}
		}
		return ngayThiCuoiKi;
	}
	
	//////////////////////
	public static Result RaiPhongGiuaKi(ArrayList<PhongThi> phongthi,ArrayList<Ngay> ngayThiGiuaKi,Map<String,TinhChatCacMon> listStudentsofCourse,String file) throws IOException{
		//get DanhSachMonHoc
		Map<String,Integer> Phong_Thuc_Hanh = new HashMap<String,Integer>();
		Map<String,Integer> Phong_TH_MTCN = new HashMap<String,Integer>();
		Map<String,Integer> Phong_Li_Thuyet = new HashMap<String,Integer>();
		Map<String,Integer> Phong_Hoa_That = new HashMap<String,Integer>();
		Map<String,Integer> Phong_Noi_That = new HashMap<String,Integer>();
		int succhualithuyet = 0,succhuathuchanh = 0;
		//get danhsachphongthi
		Map<String,ArrayList<String>> RaiPhong = new HashMap<String,ArrayList<String>>();
		for(int i=0;i<phongthi.size();i++){
			if(phongthi.get(i).getTinhChatPhong().equals("PM")){
				if(phongthi.get(i).getNote().equals("Phòng máy Khoa MTCN"))
					Phong_TH_MTCN.put(phongthi.get(i).getMP(),phongthi.get(i).getSucChua());
				else{
					succhuathuchanh = succhuathuchanh + phongthi.get(i).getSucChua();
					Phong_Thuc_Hanh.put(phongthi.get(i).getMP(),phongthi.get(i).getSucChua());
				}
					
			}		
			else if(phongthi.get(i).getTinhChatPhong().equals("LT")){
				succhualithuyet = succhualithuyet + phongthi.get(i).getSucChua();
				Phong_Li_Thuyet.put(phongthi.get(i).getMP(),phongthi.get(i).getSucChua());
			}
			else if(phongthi.get(i).getTinhChatPhong().equals("H"))
				Phong_Hoa_That.put(phongthi.get(i).getMP(),phongthi.get(i).getSucChua());
			else if(phongthi.get(i).getTinhChatPhong().equals("NT"))
				Phong_Noi_That.put(phongthi.get(i).getMP(),phongthi.get(i).getSucChua());
		}
		Map<String,ArrayList<String>> caduthi = new HashMap<>();
		for(int i=0;i<ngayThiGiuaKi.size();i++){
			Map<String,ArrayList<String>> danhSachCaThi = ngayThiGiuaKi.get(i).getListmonhoc();
			for(String x:danhSachCaThi.keySet()){
				ArrayList<String> danhSachMonThi = danhSachCaThi.get(x);
				ArrayList<String> danhSachMonThiLiThuyet = new ArrayList<String>();
				ArrayList<String> danhSachMonThiThucHanh = new ArrayList<String>();
				for(int index2 = 0;index2 < danhSachMonThi.size();index2++){
					if(listStudentsofCourse.get(danhSachMonThi.get(index2)).getGiuaKi().equals("LT"))
						danhSachMonThiLiThuyet.add(danhSachMonThi.get(index2));
					else if(listStudentsofCourse.get(danhSachMonThi.get(index2)).getGiuaKi().equals("PM"))
						danhSachMonThiThucHanh.add(danhSachMonThi.get(index2));
				}
				//get so luong li thuyet
				ArrayList<String> listmondu = new ArrayList<String>();
				int now_lithuyet = succhualithuyet,now_thuchanh = succhuathuchanh;
				ArrayList<mydata> Phong_Li_Thuyet_SuDung = new ArrayList<mydata>();
				for(String zzz:Phong_Li_Thuyet.keySet()){
					Phong_Li_Thuyet_SuDung.add(new mydata(zzz,Phong_Li_Thuyet.get(zzz),false));
				}
				ArrayList<mydata> Phong_Thuc_Hanh_SuDung = new ArrayList<mydata>();
				for(String zzz:Phong_Thuc_Hanh.keySet()){
					Phong_Thuc_Hanh_SuDung.add(new mydata(zzz,Phong_Thuc_Hanh.get(zzz),false));
				}
				/////////////////////
				for(int index_lithuyet =0;index_lithuyet<danhSachMonThiLiThuyet.size();index_lithuyet++){
					ArrayList<String> soPhongDapUng_lithuyet = new ArrayList<String>();
					if(Phong_Li_Thuyet_SuDung.size() > 0 && now_lithuyet > listStudentsofCourse.get(danhSachMonThiLiThuyet.get(index_lithuyet)).getDanhSachSinhVien().size()){
						int soLuongHocSinh = listStudentsofCourse.get(danhSachMonThiLiThuyet.get(index_lithuyet)).getDanhSachSinhVien().size();
						ArrayList<Integer> chiSoXoa = new ArrayList<Integer>();
						int temp = 0;
						for(int index_phong=0;index_phong<Phong_Li_Thuyet_SuDung.size();index_phong++){
							if(temp < soLuongHocSinh){
								chiSoXoa.add(index_phong);
								soPhongDapUng_lithuyet.add(Phong_Li_Thuyet_SuDung.get(index_phong).tenphong);
								temp = temp + Phong_Li_Thuyet_SuDung.get(index_phong).succhua;
								now_lithuyet = now_lithuyet - Phong_Li_Thuyet_SuDung.get(index_phong).succhua;
							}
							else{
								break;
							}
						}
						for(int index_phong = chiSoXoa.size()-1;index_phong >=0;index_phong--){
							Phong_Li_Thuyet_SuDung.remove(index_phong);
						}
						RaiPhong.put(danhSachMonThiLiThuyet.get(index_lithuyet), soPhongDapUng_lithuyet);
					}
					else{
						listmondu.add(danhSachMonThiLiThuyet.get(index_lithuyet));
					}
				}
				/////////////
				for(int index_thuchanh =0;index_thuchanh<danhSachMonThiThucHanh.size();index_thuchanh++){
					ArrayList<String> soPhongDapUng_thuchanh = new ArrayList<String>();
					if(Phong_Thuc_Hanh_SuDung.size() > 0 && now_thuchanh > listStudentsofCourse.get(danhSachMonThiThucHanh.get(index_thuchanh)).getDanhSachSinhVien().size()){
						int soLuongHocSinh = listStudentsofCourse.get(danhSachMonThiThucHanh.get(index_thuchanh)).getDanhSachSinhVien().size();
						ArrayList<Integer> chiSoXoa = new ArrayList<Integer>();
						int temp = 0;
						for(int index_phong=0;index_phong<Phong_Thuc_Hanh_SuDung.size();index_phong++){
							if(temp < soLuongHocSinh){
								chiSoXoa.add(index_phong);
								soPhongDapUng_thuchanh.add(Phong_Thuc_Hanh_SuDung.get(index_phong).tenphong);
								temp = temp + Phong_Thuc_Hanh_SuDung.get(index_phong).succhua;
								now_thuchanh = now_thuchanh - Phong_Thuc_Hanh_SuDung.get(index_phong).succhua;
							}
							else{
								break;
							}
						}
						for(int index_phong = chiSoXoa.size()-1;index_phong >=0;index_phong--){
							Phong_Thuc_Hanh_SuDung.remove(index_phong);
						}
						RaiPhong.put(danhSachMonThiThucHanh.get(index_thuchanh), soPhongDapUng_thuchanh);
					}
					else{
						listmondu.add(danhSachMonThiThucHanh.get(index_thuchanh));
					}
				}
				if(listmondu.size() > 0){
					caduthi.put("Cadu"+Integer.toString(caduthi.size()+1), listmondu);
				}
					
				////////////////////
			}
		}
		if(caduthi.size() > 0){
			Map<String,ArrayList<String>> color = ColoringGraph.coloring(ColoringGraph.CreateGraph(file));
			ArrayList<String> listmonhocdu = new ArrayList<String>();
			for(String x:caduthi.keySet()){
				for(int i=0;i<caduthi.get(x).size();i++){
					listmonhocdu.add(caduthi.get(x).get(i));
				}
			}
			Object[] set = color.keySet().toArray();
			for(Object x:set){
				ArrayList<String> listmonhochientai = color.get(x);
				ArrayList<String> listmonhochientai_new = new ArrayList<String>();
				for(int i=0;i<listmonhochientai.size();i++){
					if(listmonhocdu.contains(listmonhochientai.get(i))==false){
						listmonhochientai_new.add(listmonhochientai.get(i));
					}
				}
				color.remove(x);
				color.put(x.toString(), listmonhochientai_new);
			}
			for(String x:caduthi.keySet()){
				color.put(x, caduthi.get(x));
			}
			ArrayList<Ngay> ngayThiGiuaKi2 = XepLichThiGiuaKi(color,listStudentsofCourse);
			return RaiPhongGiuaKi(phongthi,ngayThiGiuaKi2,listStudentsofCourse,file);
		}	
		else{
			Result rs = new Result(ngayThiGiuaKi,RaiPhong);
			return rs;
		}
	}
	
	public static Result RaiPhongCuoiKi(ArrayList<PhongThi> phongthi,ArrayList<Ngay> ngayThiGiuaKi,Map<String,TinhChatCacMon> listStudentsofCourse,String file) throws IOException{
		//get DanhSachMonHoc
		Map<String,Integer> Phong_Thuc_Hanh = new HashMap<String,Integer>();
		Map<String,Integer> Phong_TH_MTCN = new HashMap<String,Integer>();
		Map<String,Integer> Phong_Li_Thuyet = new HashMap<String,Integer>();
		Map<String,Integer> Phong_Hoa_That = new HashMap<String,Integer>();
		Map<String,Integer> Phong_Noi_That = new HashMap<String,Integer>();
		int succhualithuyet = 0,succhuathuchanh = 0;
		//get danhsachphongthi
		Map<String,ArrayList<String>> RaiPhong = new HashMap<String,ArrayList<String>>();
		for(int i=0;i<phongthi.size();i++){
			if(phongthi.get(i).getTinhChatPhong().equals("PM")){
				if(phongthi.get(i).getNote().equals("Phòng máy Khoa MTCN"))
					Phong_TH_MTCN.put(phongthi.get(i).getMP(),phongthi.get(i).getSucChua());
				else{
					succhuathuchanh = succhuathuchanh + phongthi.get(i).getSucChua();
					Phong_Thuc_Hanh.put(phongthi.get(i).getMP(),phongthi.get(i).getSucChua());
				}
					
			}		
			else if(phongthi.get(i).getTinhChatPhong().equals("LT")){
				succhualithuyet = succhualithuyet + phongthi.get(i).getSucChua();
				Phong_Li_Thuyet.put(phongthi.get(i).getMP(),phongthi.get(i).getSucChua());
			}
			else if(phongthi.get(i).getTinhChatPhong().equals("H"))
				Phong_Hoa_That.put(phongthi.get(i).getMP(),phongthi.get(i).getSucChua());
			else if(phongthi.get(i).getTinhChatPhong().equals("NT"))
				Phong_Noi_That.put(phongthi.get(i).getMP(),phongthi.get(i).getSucChua());
		}
		Map<String,ArrayList<String>> caduthi = new HashMap<>();
		for(int i=0;i<ngayThiGiuaKi.size();i++){
			Map<String,ArrayList<String>> danhSachCaThi = ngayThiGiuaKi.get(i).getListmonhoc();
			for(String x:danhSachCaThi.keySet()){
				ArrayList<String> danhSachMonThi = danhSachCaThi.get(x);
				ArrayList<String> danhSachMonThiLiThuyet = new ArrayList<String>();
				ArrayList<String> danhSachMonThiThucHanh = new ArrayList<String>();
				for(int index2 = 0;index2 < danhSachMonThi.size();index2++){
					if(listStudentsofCourse.get(danhSachMonThi.get(index2)).getCuoiKi().equals("LT"))
						danhSachMonThiLiThuyet.add(danhSachMonThi.get(index2));
					else if(listStudentsofCourse.get(danhSachMonThi.get(index2)).getCuoiKi().equals("PM"))
						danhSachMonThiThucHanh.add(danhSachMonThi.get(index2));
				}
				//get so luong li thuyet
				ArrayList<String> listmondu = new ArrayList<String>();
				int now_lithuyet = succhualithuyet,now_thuchanh = succhuathuchanh;
				ArrayList<mydata> Phong_Li_Thuyet_SuDung = new ArrayList<mydata>();
				for(String zzz:Phong_Li_Thuyet.keySet()){
					Phong_Li_Thuyet_SuDung.add(new mydata(zzz,Phong_Li_Thuyet.get(zzz),false));
				}
				ArrayList<mydata> Phong_Thuc_Hanh_SuDung = new ArrayList<mydata>();
				for(String zzz:Phong_Thuc_Hanh.keySet()){
					Phong_Thuc_Hanh_SuDung.add(new mydata(zzz,Phong_Thuc_Hanh.get(zzz),false));
				}
				/////////////////////
				for(int index_lithuyet =0;index_lithuyet<danhSachMonThiLiThuyet.size();index_lithuyet++){
					ArrayList<String> soPhongDapUng_lithuyet = new ArrayList<String>();
					if(Phong_Li_Thuyet_SuDung.size() > 0 && now_lithuyet > listStudentsofCourse.get(danhSachMonThiLiThuyet.get(index_lithuyet)).getDanhSachSinhVien().size()){
						int soLuongHocSinh = listStudentsofCourse.get(danhSachMonThiLiThuyet.get(index_lithuyet)).getDanhSachSinhVien().size();
						ArrayList<Integer> chiSoXoa = new ArrayList<Integer>();
						int temp = 0;
						for(int index_phong=0;index_phong<Phong_Li_Thuyet_SuDung.size();index_phong++){
							if(temp < soLuongHocSinh){
								chiSoXoa.add(index_phong);
								soPhongDapUng_lithuyet.add(Phong_Li_Thuyet_SuDung.get(index_phong).tenphong);
								temp = temp + Phong_Li_Thuyet_SuDung.get(index_phong).succhua;
								now_lithuyet = now_lithuyet - Phong_Li_Thuyet_SuDung.get(index_phong).succhua;
							}
							else{
								break;
							}
						}
						for(int index_phong = chiSoXoa.size()-1;index_phong >=0;index_phong--){
							Phong_Li_Thuyet_SuDung.remove(index_phong);
						}
						RaiPhong.put(danhSachMonThiLiThuyet.get(index_lithuyet), soPhongDapUng_lithuyet);
					}
					else{
						listmondu.add(danhSachMonThiLiThuyet.get(index_lithuyet));
					}
				}
				/////////////
				for(int index_thuchanh =0;index_thuchanh<danhSachMonThiThucHanh.size();index_thuchanh++){
					ArrayList<String> soPhongDapUng_thuchanh = new ArrayList<String>();
					if(Phong_Thuc_Hanh_SuDung.size() > 0 && now_thuchanh > listStudentsofCourse.get(danhSachMonThiThucHanh.get(index_thuchanh)).getDanhSachSinhVien().size()){
						int soLuongHocSinh = listStudentsofCourse.get(danhSachMonThiThucHanh.get(index_thuchanh)).getDanhSachSinhVien().size();
						ArrayList<Integer> chiSoXoa = new ArrayList<Integer>();
						int temp = 0;
						for(int index_phong=0;index_phong<Phong_Thuc_Hanh_SuDung.size();index_phong++){
							if(temp < soLuongHocSinh){
								chiSoXoa.add(index_phong);
								soPhongDapUng_thuchanh.add(Phong_Thuc_Hanh_SuDung.get(index_phong).tenphong);
								temp = temp + Phong_Thuc_Hanh_SuDung.get(index_phong).succhua;
								now_thuchanh = now_thuchanh - Phong_Thuc_Hanh_SuDung.get(index_phong).succhua;
							}
							else{
								break;
							}
						}
						for(int index_phong = chiSoXoa.size()-1;index_phong >=0;index_phong--){
							Phong_Thuc_Hanh_SuDung.remove(index_phong);
						}
						RaiPhong.put(danhSachMonThiThucHanh.get(index_thuchanh), soPhongDapUng_thuchanh);
					}
					else{
						listmondu.add(danhSachMonThiThucHanh.get(index_thuchanh));
					}
				}
				if(listmondu.size() > 0){
					caduthi.put("Cadu"+Integer.toString(caduthi.size()+1), listmondu);
				}
					
				////////////////////
			}
		}
		if(caduthi.size() > 0){
			Map<String,ArrayList<String>> color = ColoringGraph.coloring(ColoringGraph.CreateGraph(file));
			ArrayList<String> listmonhocdu = new ArrayList<String>();
			for(String x:caduthi.keySet()){
				for(int i=0;i<caduthi.get(x).size();i++){
					listmonhocdu.add(caduthi.get(x).get(i));
				}
			}
			Object[] set = color.keySet().toArray();
			for(Object x:set){
				ArrayList<String> listmonhochientai = color.get(x);
				ArrayList<String> listmonhochientai_new = new ArrayList<String>();
				for(int i=0;i<listmonhochientai.size();i++){
					if(listmonhocdu.contains(listmonhochientai.get(i))==false){
						listmonhochientai_new.add(listmonhochientai.get(i));
					}
				}
				color.remove(x);
				color.put(x.toString(), listmonhochientai_new);
			}
			for(String x:caduthi.keySet()){
				color.put(x, caduthi.get(x));
			}
			ArrayList<Ngay> ngayThiCuoiKi_new = XepLichThiCuoiKi(color,listStudentsofCourse);
			return RaiPhongCuoiKi(phongthi,ngayThiCuoiKi_new,listStudentsofCourse,file);
		}	
		else{
			Result rs = new Result(ngayThiGiuaKi,RaiPhong);
			return rs;
		}
	}
	
}