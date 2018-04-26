<%-- 
    Document   : Export
    Created on : Nov 16, 2017, 10:42:35 AM
    Author     : QuangHau
--%>
<%@page import="controller.SinhVien_Nhom_To"%>
<%@page import="controller.ReadExcel"%>
<%@page import="controller.PhongThi"%>
<%@page import="controller.PhongThi"%>
<%@page import="java.util.Set"%>
<%@page import="controller.Ngay"%>
<%@page import="controller.Ngay"%>
<%@page import="controller.TinhChatCacMon"%>
<%@page import="controller.ColoringGraph"%>
<%@page import="controller.XepPhongThi"%>
<%@page import="controller.Result"%>
<%@page import="controller.Result"%>
<%@page import="controller.Result"%>
<%@page import="controller.ListPhong"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFCell"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFRow"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFSheet"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFWorkbook"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFCell"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFRow"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFSheet"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%>
<%@page import="java.io.File"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.FileOutputStream"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String file = application.getRealPath("/") + "KetQuaDangKyMonHoc.xlsx";
    String file2 = application.getRealPath("/") + "DanhSachPhongThi.xlsx";
    Map<String,ArrayList<String>> color = ColoringGraph.coloring(ColoringGraph.CreateGraph(file));
    Map<String,TinhChatCacMon> listStudentsofCourse = ColoringGraph.LayDanhSachMonHocVoiSinhVien(file);

    ArrayList<Ngay> ngayThiGiuaKi = XepPhongThi.XepLichThiGiuaKi(color,listStudentsofCourse);
    ArrayList<Ngay> ngayThiCuoiKi = XepPhongThi.XepLichThiCuoiKi(color,listStudentsofCourse);

    /*for(int i=0;i<ngayThiCuoiKi.size();i++){
            System.out.println(ngayThiCuoiKi.get(i).getTenngay());
            System.out.println(ngayThiCuoiKi.get(i).getListmonhoc());
    }*/

    Map<String,Set<String>> graph = ColoringGraph.CreateGraph(file);
    ArrayList<PhongThi> phongthi = ReadExcel.readPhongThi(file2);

    Map<String,ListPhong> mapMon_phong_sv_giuaKi = new HashMap<String,ListPhong>();
    Map<String,ListPhong> mapMon_phong_sv_cuoiKi = new HashMap<String,ListPhong>();

    //raiphonggiuaki
    Result result = XepPhongThi.RaiPhongGiuaKi(phongthi,ngayThiGiuaKi,listStudentsofCourse,file);
    result.HoanViGiuaKi();
    //get map "Phong Thi" with size of "Phong Thi"
    Map<String,Integer> mapPhongThi = new HashMap<>();
    for(int i=0;i<phongthi.size();i++){
            mapPhongThi.put(phongthi.get(i).getMP(), phongthi.get(i).getSucChua());
    }
    ////
    for(String x:result.getRaiPhong().keySet()){
            ListPhong listphong = new ListPhong();
            int sucChuaPhong = 0;
            int sosinhvien = listStudentsofCourse.get(x).getDanhSachSinhVien().size();
            for(int i=0;i<result.getRaiPhong().get(x).size();i++){
                    sucChuaPhong = sucChuaPhong + mapPhongThi.get(result.getRaiPhong().get(x).get(i));
            }

            ArrayList<String> listsinhvienmonhoc = new ArrayList<String>();
            for(String g:listStudentsofCourse.get(x).getDanhSachSinhVien()){
                    listsinhvienmonhoc.add(g);
            }
            Map<String,ArrayList<String>> index_listphong = new HashMap<String,ArrayList<String>>();
            int z=0;
            for(int i=0;i<result.getRaiPhong().get(x).size();i++){
                    if(i!=result.getRaiPhong().get(x).size()-1){
                            ArrayList<String> listsinhvien = new ArrayList<String>();
                            int soSinhVienCanThem = (int)Math.ceil(((double)mapPhongThi.get(result.getRaiPhong().get(x).get(i))/(double)sucChuaPhong)*(double)sosinhvien);
                            soSinhVienCanThem = z+soSinhVienCanThem;
                            for(;z<soSinhVienCanThem;z++){
                                    listsinhvien.add(listsinhvienmonhoc.get(z));
                            }
                            z=soSinhVienCanThem;
                            index_listphong.put(result.getRaiPhong().get(x).get(i), listsinhvien);
                    }
                    else{
                            ArrayList<String> listsinhvien = new ArrayList<String>();
                            for(;z<listsinhvienmonhoc.size();z++){
                                    listsinhvien.add(listsinhvienmonhoc.get(z));
                            }
                            index_listphong.put(result.getRaiPhong().get(x).get(i), listsinhvien);
                    }
            }
            listphong.setIndex_listphong(index_listphong);
            mapMon_phong_sv_giuaKi.put(x, listphong);
    }

    //raiphongcuoiki
    Result result2 = XepPhongThi.RaiPhongCuoiKi(phongthi,ngayThiCuoiKi,listStudentsofCourse,file);
    result2.HoanViCuoiKi();
    for(String x:result2.getRaiPhong().keySet()){
            ListPhong listphong = new ListPhong();
            int sucChuaPhong = 0;
            int sosinhvien = listStudentsofCourse.get(x).getDanhSachSinhVien().size();
            for(int i=0;i<result2.getRaiPhong().get(x).size();i++){
                    sucChuaPhong = sucChuaPhong + mapPhongThi.get(result2.getRaiPhong().get(x).get(i));
            }

            ArrayList<String> listsinhvienmonhoc = new ArrayList<String>();
            for(String g:listStudentsofCourse.get(x).getDanhSachSinhVien()){
                    listsinhvienmonhoc.add(g);
            }
            Map<String,ArrayList<String>> index_listphong = new HashMap<String,ArrayList<String>>();
            int z=0;
            for(int i=0;i<result2.getRaiPhong().get(x).size();i++){
                    if(i!=result2.getRaiPhong().get(x).size()-1){
                            ArrayList<String> listsinhvien = new ArrayList<String>();
                            int soSinhVienCanThem = (int)Math.ceil(((double)mapPhongThi.get(result2.getRaiPhong().get(x).get(i))/(double)sucChuaPhong)*(double)sosinhvien);
                            soSinhVienCanThem = z+soSinhVienCanThem;
                            for(;z<soSinhVienCanThem;z++){
                                    listsinhvien.add(listsinhvienmonhoc.get(z));
                            }
                            z=soSinhVienCanThem;
                            index_listphong.put(result2.getRaiPhong().get(x).get(i), listsinhvien);
                    }
                    else{
                            ArrayList<String> listsinhvien = new ArrayList<String>();
                            for(;z<listsinhvienmonhoc.size();z++){
                                    listsinhvien.add(listsinhvienmonhoc.get(z));
                            }
                            index_listphong.put(result2.getRaiPhong().get(x).get(i), listsinhvien);
                    }
            }
            listphong.setIndex_listphong(index_listphong);
            mapMon_phong_sv_cuoiKi.put(x, listphong);
    }
%>

<%
    Map<String,String> laytensinhvien = ColoringGraph.LayTenSinhVien(file);
    Map<String,ArrayList<SinhVien_Nhom_To>> LayNhomTo = ColoringGraph.LayNhomTo(file);
%>

<%  
    PrintWriter pw = null;
    try{
        String filename = "LichThi.xlsx";
        String excelFileName = application.getRealPath("/")+filename;//name of excel file
        //giuaki
        String sheetName = "Giữa kì";//name of sheet

        XSSFWorkbook wb = new XSSFWorkbook();
        XSSFSheet sheet = wb.createSheet(sheetName) ;
        
        //for(String x:listStudentsofCourse)
        //iterating r number of rows
        int dem = 1;
        //create row header
        if(dem==1){
            XSSFRow row = sheet.createRow(0);
            XSSFCell cell0 = row.createCell(0);
            cell0.setCellValue("Mã MH");
            XSSFCell cell1 = row.createCell(1);
            cell1.setCellValue("Tên MH");
            XSSFCell cell2 = row.createCell(2);
            cell2.setCellValue("Thứ");
            XSSFCell cell3 = row.createCell(3);
            cell3.setCellValue("Ca");
            XSSFCell cell4 = row.createCell(4);
            cell4.setCellValue("MSSV");
            XSSFCell cell5 = row.createCell(5);
            cell5.setCellValue("Tên SV");
            XSSFCell cell6 = row.createCell(6);
            cell6.setCellValue("Nhóm");
            XSSFCell cell7 = row.createCell(7);
            cell7.setCellValue("Tổ");
            XSSFCell cell8 = row.createCell(8);
            cell8.setCellValue("Phòng");
            XSSFCell cell9 = row.createCell(9);
            cell9.setCellValue("Hình thức thi");
        }
        /////////////////
        for(int i=0;i<result.getNgayThi().size();i++){
            for(String x:result.getNgayThi().get(i).getListmonhoc().keySet()){
                ArrayList<String> listcacmon = result.getNgayThi().get(i).getListmonhoc().get(x);
                for(int z=0;z<listcacmon.size();z++){
                    Set<String> listStudent = listStudentsofCourse.get(listcacmon.get(z)).getDanhSachSinhVien();
                    //ArrayList<SinhVien_Nhom_To> laynhomto = LayNhomTo.get(listcacmon.get(z));
                    for(String k:listStudent){
                        XSSFRow row = sheet.createRow(dem);
                        XSSFCell cell0 = row.createCell(0);
                        cell0.setCellValue(listcacmon.get(z));
                        XSSFCell cell1 = row.createCell(1);
                        cell1.setCellValue(listStudentsofCourse.get(listcacmon.get(z)).getTenMon());
                        XSSFCell cell2 = row.createCell(2);
                        cell2.setCellValue(result.getNgayThi().get(i).getTenngay());
                        XSSFCell cell3 = row.createCell(3);
                        cell3.setCellValue(x);
                        XSSFCell cell4 = row.createCell(4);
                        cell4.setCellValue(k);
                        XSSFCell cell5 = row.createCell(5);
                        cell5.setCellValue(laytensinhvien.get(k));
                       
                            ArrayList<SinhVien_Nhom_To> list_sv_nhomto = LayNhomTo.get(listcacmon.get(z));
                            for(int l=0;l<list_sv_nhomto.size();l++){
                                if(list_sv_nhomto.get(l).getSinhvien().containsKey(k)){
                                    XSSFCell cell6 = row.createCell(6);
                                    cell6.setCellValue(list_sv_nhomto.get(l).getSinhvien().get(k).getNhom());
                                    XSSFCell cell7 = row.createCell(7);
                                    cell7.setCellValue(list_sv_nhomto.get(l).getSinhvien().get(k).getTo());
                                    break;
                                }
                            }
                        
                        /*for(String lll:LayNhomTo.keySet()){
                            ArrayList<SinhVien_Nhom_To> list_sv_nhomto = LayNhomTo.get(lll);
                            for(int l=0;l<list_sv_nhomto.size();l++){
                                if(list_sv_nhomto.get(l).getSinhvien().containsKey(k)){
                                    XSSFCell cell6 = row.createCell(6);
                                    cell6.setCellValue(list_sv_nhomto.get(l).getSinhvien().get(k).getNhom());
                                    XSSFCell cell7 = row.createCell(7);
                                    cell7.setCellValue(list_sv_nhomto.get(l).getSinhvien().get(k).getTo());
                                    break;
                                }
                            }
                        }*/
                        for(String zzz:mapMon_phong_sv_giuaKi.keySet()){
                            if(zzz.equals(listcacmon.get(z))){
                                for(String yyy:mapMon_phong_sv_giuaKi.get(zzz).getIndex_listphong().keySet()){
                                    if(mapMon_phong_sv_giuaKi.get(zzz).getIndex_listphong().get(yyy).contains(k)){
                                        XSSFCell cell8 = row.createCell(8);
                                        cell8.setCellValue(yyy);
                                        break;
                                    }
                                }
                            }
                        }
                        XSSFCell cell9 = row.createCell(9);
                        cell9.setCellValue(listStudentsofCourse.get(listcacmon.get(z)).getGiuaKi());
                        dem++;
                    }
                }
            }
            
            
            
        }
        
        String sheetName2 = "Cuối kì";//name of sheet

        XSSFSheet sheet2 = wb.createSheet(sheetName2) ;
        
        //for(String x:listStudentsofCourse)
        //iterating r number of rows
        int dem2 = 1;
        //khoi tao header
        if(dem2==1){
            XSSFRow row = sheet2.createRow(0);
            XSSFCell cell0 = row.createCell(0);
            cell0.setCellValue("Mã MH");
            XSSFCell cell1 = row.createCell(1);
            cell1.setCellValue("Tên MH");
            XSSFCell cell2 = row.createCell(2);
            cell2.setCellValue("Thứ");
            XSSFCell cell3 = row.createCell(3);
            cell3.setCellValue("Ca");
            XSSFCell cell4 = row.createCell(4);
            cell4.setCellValue("MSSV");
            XSSFCell cell5 = row.createCell(5);
            cell5.setCellValue("Tên SV");
            XSSFCell cell6 = row.createCell(6);
            cell6.setCellValue("Nhóm");
            XSSFCell cell7 = row.createCell(7);
            cell7.setCellValue("Tổ");
            XSSFCell cell8 = row.createCell(8);
            cell8.setCellValue("Phòng");
            XSSFCell cell9 = row.createCell(9);
            cell9.setCellValue("Hình thức thi");
        }
        /////
        for(int i=0;i<result2.getNgayThi().size();i++){
            for(String x:result2.getNgayThi().get(i).getListmonhoc().keySet()){
                ArrayList<String> listcacmon = result2.getNgayThi().get(i).getListmonhoc().get(x);
                for(int z=0;z<listcacmon.size();z++){
                    Set<String> listStudent = listStudentsofCourse.get(listcacmon.get(z)).getDanhSachSinhVien();
                    //ArrayList<SinhVien_Nhom_To> laynhomto = LayNhomTo.get(listcacmon.get(z));
                    for(String k:listStudent){
                        XSSFRow row = sheet2.createRow(dem2);
                        XSSFCell cell0 = row.createCell(0);
                        cell0.setCellValue(listcacmon.get(z));
                        XSSFCell cell1 = row.createCell(1);
                        cell1.setCellValue(listStudentsofCourse.get(listcacmon.get(z)).getTenMon());
                        XSSFCell cell2 = row.createCell(2);
                        cell2.setCellValue(result2.getNgayThi().get(i).getTenngay());
                        XSSFCell cell3 = row.createCell(3);
                        cell3.setCellValue(x);
                        XSSFCell cell4 = row.createCell(4);
                        cell4.setCellValue(k);
                        XSSFCell cell5 = row.createCell(5);
                        cell5.setCellValue(laytensinhvien.get(k));
                        ArrayList<SinhVien_Nhom_To> list_sv_nhomto = LayNhomTo.get(listcacmon.get(z));
                        for(int l=0;l<list_sv_nhomto.size();l++){
                            if(list_sv_nhomto.get(l).getSinhvien().containsKey(k)){
                                XSSFCell cell6 = row.createCell(6);
                                cell6.setCellValue(list_sv_nhomto.get(l).getSinhvien().get(k).getNhom());
                                XSSFCell cell7 = row.createCell(7);
                                cell7.setCellValue(list_sv_nhomto.get(l).getSinhvien().get(k).getTo());
                                break;
                            }
                        }
                        /*for(String lll:LayNhomTo.keySet()){
                            ArrayList<SinhVien_Nhom_To> list_sv_nhomto = LayNhomTo.get(lll);
                            for(int l=0;l<list_sv_nhomto.size();l++){
                                if(list_sv_nhomto.get(l).getSinhvien().containsKey(k)){
                                    XSSFCell cell6 = row.createCell(6);
                                    cell6.setCellValue(list_sv_nhomto.get(l).getSinhvien().get(k).getNhom());
                                    XSSFCell cell7 = row.createCell(7);
                                    cell7.setCellValue(list_sv_nhomto.get(l).getSinhvien().get(k).getTo());
                                    break;
                                }
                            }
                        }*/
                        for(String zzz:mapMon_phong_sv_cuoiKi.keySet()){
                            if(zzz.equals(listcacmon.get(z))){
                                for(String yyy:mapMon_phong_sv_cuoiKi.get(zzz).getIndex_listphong().keySet()){
                                    if(mapMon_phong_sv_cuoiKi.get(zzz).getIndex_listphong().get(yyy).contains(k)){
                                        XSSFCell cell8 = row.createCell(8);
                                        cell8.setCellValue(yyy);
                                        break;
                                    }
                                }
                            }
                        }
                        XSSFCell cell9 = row.createCell(9);
                        cell9.setCellValue(listStudentsofCourse.get(listcacmon.get(z)).getCuoiKi());
                        dem2++;
                    }
                }
            }
            
            
            
        }

        FileOutputStream fileOut = new FileOutputStream(excelFileName);

        //write this workbook to an Outputstream.
        wb.write(fileOut);
        fileOut.flush();
        fileOut.close();
        response.sendRedirect(filename);
    }
    catch(Exception e){
        out.println(e);
    }
%>
