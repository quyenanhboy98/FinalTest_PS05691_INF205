package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

public class ColoringGraph {
	
	public static ArrayList<dinh> Change(Map<String,Set<String>> GraphMonHoc){
		ArrayList<dinh> GraphMonHoc_2 = new ArrayList<dinh>();
		for(String x:GraphMonHoc.keySet()){
			GraphMonHoc_2.add(new dinh(x,GraphMonHoc.get(x)));
		}
		return GraphMonHoc_2;
	}
	
	public static Map<String,ArrayList<String>> coloring(Map<String,Set<String>> GraphMonHoc){
		ArrayList<dinh> GraphMonHoc_2 = ColoringGraph.Change(GraphMonHoc);
		Collections.sort(GraphMonHoc_2, new dinhComparator());
		//////////////////////////////////////////////////
		Map<String, ArrayList<String>> vertex_color_index = new HashMap<String, ArrayList<String>>();
		Map<String,Boolean> colored = new HashMap<String,Boolean>();
		for(String x:GraphMonHoc.keySet()){
			colored.put(x, Boolean.FALSE);
		}
		for(int i=0;i<GraphMonHoc_2.size();i++){
			if(colored.get(GraphMonHoc_2.get(i).getTendinh()) == false){
				Set<String> setDinhKe = GraphMonHoc_2.get(i).getCacdinhke();
				ArrayList<String> listtemp = new ArrayList<String>();
				listtemp.add(GraphMonHoc_2.get(i).getTendinh());
                                colored.remove(GraphMonHoc_2.get(i).getTendinh());
                                colored.put(GraphMonHoc_2.get(i).getTendinh(), true);
				for(String x:GraphMonHoc.keySet()){
					if(setDinhKe.contains(x)==false && colored.get(x)==false){
						boolean check = false;
						for(int c=0;c<listtemp.size();c++){
							if(GraphMonHoc.get(listtemp.get(c)).contains(x)){
								check = true;
								break;
							}
						}
						if(check==true)
							continue;
						else{
							colored.remove(x);
							colored.put(x, true);
							
							if(listtemp.contains(x)== false)
								listtemp.add(x);
						}
					}
				}
				vertex_color_index.put("Color"+Integer.toString(vertex_color_index.size()+1), listtemp);
			}
		}
		return vertex_color_index;
	}
	
	public static Map<String,Set<String>> CreateGraph(String filename) throws IOException{
		Map<String,Set<String>> GraphMonHoc = new HashMap<>();
		Map<String,ArrayList<String>> DanhSachSinhVienVoiMonHoc = ColoringGraph.LayDanhSachSinhVienVoiMonHoc(filename);
		for(String x:DanhSachSinhVienVoiMonHoc.keySet()){
			for(int i=0;i<DanhSachSinhVienVoiMonHoc.get(x).size();i++){
				if(GraphMonHoc.containsKey(DanhSachSinhVienVoiMonHoc.get(x).get(i))){
					Set<String> setTemp = GraphMonHoc.get(DanhSachSinhVienVoiMonHoc.get(x).get(i));
					for(int z=0;z<DanhSachSinhVienVoiMonHoc.get(x).size();z++){
						if(i!=z){
							setTemp.add(DanhSachSinhVienVoiMonHoc.get(x).get(z));
						}
					}
					GraphMonHoc.remove(DanhSachSinhVienVoiMonHoc.get(x).get(i));
					GraphMonHoc.put(DanhSachSinhVienVoiMonHoc.get(x).get(i), setTemp);
				}
				else{
					Set<String> setTemp = new HashSet<String>();
					for(int z=0;z<DanhSachSinhVienVoiMonHoc.get(x).size();z++){
						if(i!=z){
							setTemp.add(DanhSachSinhVienVoiMonHoc.get(x).get(z));
						}
					}
					GraphMonHoc.put(DanhSachSinhVienVoiMonHoc.get(x).get(i), setTemp);
				}
				
			}
		}
		return GraphMonHoc;
	}
	
	public static Map<String,ArrayList<String>> LayDanhSachSinhVienVoiMonHoc(String filename) throws IOException{
		Map<String,ArrayList<String>> DanhSachSinhVienVoiMonHoc = new HashMap<>();
		ArrayList<MonHoc> mh = ReadExcel.readMonHoc(filename);
		for(int i=0;i<mh.size();i++){
			if(DanhSachSinhVienVoiMonHoc.containsKey(mh.get(i).getMSSV())==false){
				ArrayList<String> listMH = new ArrayList<String>();
				listMH.add(mh.get(i).getMaMH());
				DanhSachSinhVienVoiMonHoc.put(mh.get(i).getMSSV(),listMH);
			}else{
				ArrayList<String> listMH = DanhSachSinhVienVoiMonHoc.get(mh.get(i).getMSSV());
				listMH.add(mh.get(i).getMaMH());
				DanhSachSinhVienVoiMonHoc.remove(mh.get(i).getMSSV());
				DanhSachSinhVienVoiMonHoc.put(mh.get(i).getMSSV(),listMH);
			}
		}
		return DanhSachSinhVienVoiMonHoc;
		
	}
        
        public static Map<String,String> LayTenSinhVien(String filename) throws IOException{
		Map<String,String> listhocsinh = new HashMap<String,String>();
                ArrayList<MonHoc> mh = ReadExcel.readMonHoc(filename);
		for(int i=0;i<mh.size();i++){
			if(listhocsinh.containsKey(mh.get(i).getMSSV())==false){
                            listhocsinh.put(mh.get(i).getMSSV(),mh.get(i).getHo()+" "+ mh.get(i).getTen());
                        }
		}
                return listhocsinh;
	}
        
        public static Map<String,ArrayList<SinhVien_Nhom_To>> LayNhomTo(String filename) throws IOException{
            Map<String,ArrayList<SinhVien_Nhom_To>> result = new HashMap<>();
            ArrayList<MonHoc> mh = ReadExcel.readMonHoc(filename);
            for(int i=0;i<mh.size();i++){
                if(result.containsKey(mh.get(i).getMaMH())){
                    ArrayList<SinhVien_Nhom_To> listsinhvien = result.get(mh.get(i).getMaMH());
                    Map<String,NhomVaTo> sinhvien = new HashMap<>();
                    sinhvien.put(mh.get(i).getMSSV(), new NhomVaTo(mh.get(i).getNhom(),mh.get(i).getTo()));
                    listsinhvien.add(new SinhVien_Nhom_To(sinhvien));
                    result.remove(mh.get(i).getMaMH());
                    result.put(mh.get(i).getMaMH(),listsinhvien );
                }
                else{
                    ArrayList<SinhVien_Nhom_To> listsinhvien = new ArrayList<>();
                    Map<String,NhomVaTo> sinhvien = new HashMap<>();
                    sinhvien.put(mh.get(i).getMSSV(), new NhomVaTo(mh.get(i).getNhom(),mh.get(i).getTo()));
                    listsinhvien.add(new SinhVien_Nhom_To(sinhvien));
                    result.put(mh.get(i).getMaMH(),listsinhvien );
                }
            }
            return result;
        }
            
	//test//
	public static Map<String,TinhChatCacMon> LayDanhSachMonHocVoiSinhVien(String filename) throws IOException{
		Map<String,TinhChatCacMon> DanhSachMonHocVoiSinhVien = new HashMap<>();
		ArrayList<MonHoc> mh = ReadExcel.readMonHoc(filename);
		for(int i=0;i<mh.size();i++){
			if(DanhSachMonHocVoiSinhVien.containsKey(mh.get(i).getMaMH())){
				Set<String> setmoi = DanhSachMonHocVoiSinhVien.get(mh.get(i).getMaMH()).getDanhSachSinhVien();
				setmoi.add(mh.get(i).getMSSV());
				Set<String> nhommoi = DanhSachMonHocVoiSinhVien.get(mh.get(i).getMaMH()).getDanhSachNhom();
				if(mh.get(i).getNhom().equals("")==false)
					nhommoi.add(mh.get(i).getNhom());
				Set<String> tomoi = DanhSachMonHocVoiSinhVien.get(mh.get(i).getMaMH()).getDanhSachTo();
				if(mh.get(i).getTo().equals("")==false)
					tomoi.add(mh.get(i).getTo());
				String thigiuaki = DanhSachMonHocVoiSinhVien.get(mh.get(i).getMaMH()).getGiuaKi() ;
				DanhSachMonHocVoiSinhVien.remove(mh.get(i).getMaMH());
                                TinhChatCacMon tccm = new TinhChatCacMon(nhommoi,tomoi,setmoi,thigiuaki);
                                tccm.setTenMon(mh.get(i).getTenMH());
				DanhSachMonHocVoiSinhVien.put(mh.get(i).getMaMH(), tccm);
			}
			else{
				Set<String> setmoi = new HashSet<>();
				setmoi.add(mh.get(i).getMSSV());
				Set<String> nhommoi = new HashSet<>();
				Set<String> tomoi = new HashSet<>();
				if(mh.get(i).getNhom().equals("")==false)	
					nhommoi.add(mh.get(i).getNhom());
				if(mh.get(i).getTo().equals("")==false)
					tomoi.add(mh.get(i).getTo());
                                TinhChatCacMon tccm = new TinhChatCacMon(nhommoi,tomoi,setmoi,mh.get(i).getThigiuaki());
                                tccm.setTenMon(mh.get(i).getTenMH());
				DanhSachMonHocVoiSinhVien.put(mh.get(i).getMaMH(), tccm);
			}
		}
		return DanhSachMonHocVoiSinhVien;
	}
}
class dinh{
	private String tendinh;
	private Set<String> cacdinhke;
	public dinh(String tendinh, Set<String> cacdinhke) {
		this.tendinh = tendinh;
		this.cacdinhke = cacdinhke;
	}
	public String getTendinh() {
		return tendinh;
	}
	public void setTendinh(String tendinh) {
		this.tendinh = tendinh;
	}
	public Set<String> getCacdinhke() {
		return cacdinhke;
	}
	public void setCacdinhke(Set<String> cacdinhke) {
		this.cacdinhke = cacdinhke;
	}
}
class dinhComparator implements Comparator<dinh>{

	@Override
	public int compare(dinh a, dinh b) {
		return a.getCacdinhke().size() < b.getCacdinhke().size() ? 1 : a.getCacdinhke().size() == b.getCacdinhke().size() ? 0 : -1;
	}
	
}
