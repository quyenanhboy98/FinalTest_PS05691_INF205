<%-- 
    Document   : Teacher
    Created on : Nov 7, 2017, 9:53:04 PM
    Author     : QuangHau
--%>
<%@page import="controller.TinhChatCacMon"%>
<%@page import="controller.ListPhong"%>
<%@page import="controller.Ngay"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.util.Scanner"%>
<%@page import="java.io.File"%>
<%@page import="java.io.IOException"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="controller.ColoringGraph"%>
<%@page import="controller.ReadExcel"%>
<%@page import="controller.PhongThi"%>
<%@page import="controller.MonHoc"%>
<%@page import="controller.XepPhongThi"%>
<%@page import="controller.Result"%>
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
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Xem lịch thi theo giáo viên</title>
        <style>
            .myButton {
                background-color:#44c767;
                -moz-border-radius:28px;
                -webkit-border-radius:28px;
                border-radius:28px;
                border:1px solid #18ab29;
                display:inline-block;
                cursor:pointer;
                color:#ffffff;
                font-family:Arial;
                font-size:17px;
                padding:16px 31px;
                text-decoration:none;
                text-shadow:0px 1px 0px #2f6627;
                float:left;
                margin-left: 320px;
                margin-bottom: 30px;
            }
            .myButton:hover {
                    background-color:#5cbf2a;
            }
            .myButton:active {
                    position:relative;
                    top:1px;
            }
            .table-fill {
                background: white;
                border-radius:3px;
                border-collapse: collapse;
                height: 320px;
                margin: auto;
                max-width: 800px;
                padding:5px;
                width: 100%;
                box-shadow: 0 5px 10px rgba(0, 0, 0, 0.1);
                animation: float 5s infinite;
              }

              th {
                color:#D5DDE5;;
                background:#1b1e24;
                border-bottom:4px solid #9ea7af;
                border-right: 1px solid #343a45;
                font-size:23px;
                font-weight: 100;
                padding:24px;
                text-align:left;
                text-shadow: 0 1px 1px rgba(0, 0, 0, 0.1);
                vertical-align:middle;
              }

              th:first-child {
                border-top-left-radius:3px;
              }

              th:last-child {
                border-top-right-radius:3px;
                border-right:none;
              }

              tr {
                border-top: 1px solid #C1C3D1;
                border-bottom-: 1px solid #C1C3D1;
                color:#666B85;
                font-size:16px;
                font-weight:normal;
                text-shadow: 0 1px 1px rgba(256, 256, 256, 0.1);
              }

              tr:hover td {
                background:#4E5066;
                color:#FFFFFF;
                border-top: 1px solid #22262e;
              }

              tr:first-child {
                border-top:none;
              }

              tr:last-child {
                border-bottom:none;
              }

              tr:nth-child(odd) td {
                background:#EBEBEB;
              }

              tr:nth-child(odd):hover td {
                background:#4E5066;
              }

              tr:last-child td:first-child {
                border-bottom-left-radius:3px;
              }

              tr:last-child td:last-child {
                border-bottom-right-radius:3px;
              }

              td {
                background:#FFFFFF;
                padding:20px;
                text-align:left;
                vertical-align:middle;
                font-weight:300;
                font-size:18px;
                text-shadow: -1px -1px 1px rgba(0, 0, 0, 0.1);
                border-right: 1px solid #C1C3D1;
                height: 120px;
              }

              td:last-child {
                border-right: 0px;
              }

              th.text-left {
                text-align: left;
              }

              th.text-center {
                text-align: center;
              }

              th.text-right {
                text-align: right;
              }

              td.text-left {
                text-align: left;
              }

              td.text-center {
                text-align: center;
              }

              td.text-right {
                text-align: right;
              }
        </style>
        <script>
            function GiuaKi(){
                document.getElementById("giuaki").style.display = "block";
                document.getElementById("cuoiki").style.display = "none";
            }
            function CuoiKi(){
                document.getElementById("giuaki").style.display = "none";
                document.getElementById("cuoiki").style.display = "block";
            }
        </script>
    </head>
    <body style='background-image:url("img/header.jpg");background-repeat: no-repeat;background-size: cover;'>
        <a href="#" class="myButton" onclick="GiuaKi()">Lịch thi giữa kì</a>
        <a href="#" class="myButton" onclick="CuoiKi()" style="background-color:red;border: red;">Lịch thi cuối kì</a>
        <div id="giuaki" style="display:none;width: 900px;height: 200px">
            <p style="margin-left: 570px;color:white;font-size: 20px">LỊCH THI GIỮA KÌ</p>
            <table class="table-fill" >
                <thead>
                <tr>
                    <th class="text-left"><p>          Ca</p></th>
                    <th class="text-left">Thứ 2</th>
                    <th class="text-left">Thứ 3</th>
                    <th class="text-left">Thứ 4</th>
                    <th class="text-left">Thứ 5</th>
                    <th class="text-left">Thứ 6</th>
                    <th class="text-left">Thứ 7</th>
                    <th class="text-left">Chủ Nhật</th>
                </tr>
                </thead>
                <tbody class="table-hover">
                    <tr>
                        <td class="text-left">Ca 1</td>
                        <td class="text-left"><div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(0).getListmonhoc().containsKey("Ca1")){
                                        ArrayList<String> c1t2 = result.getNgayThi().get(0).getListmonhoc().get("Ca1");
                                        for(int i=0;i<c1t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c1t2.get(i)).getTenMon()+" ("+c1t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                                              </div></td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(1).getListmonhoc().containsKey("Ca1")){
                                        ArrayList<String> c1t2 = result.getNgayThi().get(1).getListmonhoc().get("Ca1");
                                        for(int i=0;i<c1t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c1t2.get(i)).getTenMon()+" ("+c1t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(2).getListmonhoc().containsKey("Ca1")){
                                        ArrayList<String> c1t2 = result.getNgayThi().get(2).getListmonhoc().get("Ca1");
                                        for(int i=0;i<c1t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c1t2.get(i)).getTenMon()+" ("+c1t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(3).getListmonhoc().containsKey("Ca1")){
                                        ArrayList<String> c1t2 = result.getNgayThi().get(3).getListmonhoc().get("Ca1");
                                        for(int i=0;i<c1t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c1t2.get(i)).getTenMon()+" ("+c1t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(4).getListmonhoc().containsKey("Ca1")){
                                        ArrayList<String> c1t2 = result.getNgayThi().get(4).getListmonhoc().get("Ca1");
                                        for(int i=0;i<c1t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c1t2.get(i)).getTenMon()+" ("+c1t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(5).getListmonhoc().containsKey("Ca1")){
                                        ArrayList<String> c1t2 = result.getNgayThi().get(5).getListmonhoc().get("Ca1");
                                        for(int i=0;i<c1t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c1t2.get(i)).getTenMon()+" ("+c1t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(6).getListmonhoc().containsKey("Ca1")){
                                        ArrayList<String> c1t2 = result.getNgayThi().get(6).getListmonhoc().get("Ca1");
                                        for(int i=0;i<c1t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c1t2.get(i)).getTenMon()+" ("+c1t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="text-left"> Ca 2</td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(0).getListmonhoc().containsKey("Ca2")){
                                        ArrayList<String> c2t2 = result.getNgayThi().get(0).getListmonhoc().get("Ca2");
                                        for(int i=0;i<c2t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c2t2.get(i)).getTenMon()+" ("+c2t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(1).getListmonhoc().containsKey("Ca2")){
                                        ArrayList<String> c2t2 = result.getNgayThi().get(1).getListmonhoc().get("Ca2");
                                        for(int i=0;i<c2t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c2t2.get(i)).getTenMon()+" ("+c2t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(2).getListmonhoc().containsKey("Ca2")){
                                        ArrayList<String> c2t2 = result.getNgayThi().get(2).getListmonhoc().get("Ca2");
                                        for(int i=0;i<c2t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c2t2.get(i)).getTenMon()+" ("+c2t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(3).getListmonhoc().containsKey("Ca2")){
                                        ArrayList<String> c2t2 = result.getNgayThi().get(3).getListmonhoc().get("Ca2");
                                        for(int i=0;i<c2t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c2t2.get(i)).getTenMon()+" ("+c2t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(4).getListmonhoc().containsKey("Ca2")){
                                        ArrayList<String> c2t2 = result.getNgayThi().get(4).getListmonhoc().get("Ca2");
                                        for(int i=0;i<c2t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c2t2.get(i)).getTenMon()+" ("+c2t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(5).getListmonhoc().containsKey("Ca2")){
                                        ArrayList<String> c2t2 = result.getNgayThi().get(5).getListmonhoc().get("Ca2");
                                        for(int i=0;i<c2t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c2t2.get(i)).getTenMon()+" ("+c2t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(6).getListmonhoc().containsKey("Ca2")){
                                        ArrayList<String> c2t2 = result.getNgayThi().get(6).getListmonhoc().get("Ca2");
                                        for(int i=0;i<c2t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c2t2.get(i)).getTenMon()+" ("+c2t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="text-left">Ca 3</td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(0).getListmonhoc().containsKey("Ca3")){
                                        ArrayList<String> c3t2 = result.getNgayThi().get(0).getListmonhoc().get("Ca3");
                                        for(int i=0;i<c3t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c3t2.get(i)).getTenMon()+" ("+c3t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(1).getListmonhoc().containsKey("Ca3")){
                                        ArrayList<String> c3t2 = result.getNgayThi().get(1).getListmonhoc().get("Ca3");
                                        for(int i=0;i<c3t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c3t2.get(i)).getTenMon()+" ("+c3t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(2).getListmonhoc().containsKey("Ca3")){
                                        ArrayList<String> c3t2 = result.getNgayThi().get(2).getListmonhoc().get("Ca3");
                                        for(int i=0;i<c3t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c3t2.get(i)).getTenMon()+" ("+c3t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(3).getListmonhoc().containsKey("Ca3")){
                                        ArrayList<String> c3t2 = result.getNgayThi().get(3).getListmonhoc().get("Ca3");
                                        for(int i=0;i<c3t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c3t2.get(i)).getTenMon()+" ("+c3t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(4).getListmonhoc().containsKey("Ca3")){
                                        ArrayList<String> c3t2 = result.getNgayThi().get(4).getListmonhoc().get("Ca3");
                                        for(int i=0;i<c3t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c3t2.get(i)).getTenMon()+" ("+c3t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(5).getListmonhoc().containsKey("Ca3")){
                                        ArrayList<String> c3t2 = result.getNgayThi().get(5).getListmonhoc().get("Ca3");
                                        for(int i=0;i<c3t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c3t2.get(i)).getTenMon()+" ("+c3t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(6).getListmonhoc().containsKey("Ca3")){
                                        ArrayList<String> c3t2 = result.getNgayThi().get(6).getListmonhoc().get("Ca3");
                                        for(int i=0;i<c3t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c3t2.get(i)).getTenMon()+" ("+c3t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="text-left">Ca 4</td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(0).getListmonhoc().containsKey("Ca4")){
                                        ArrayList<String> c4t2 = result.getNgayThi().get(0).getListmonhoc().get("Ca4");
                                        for(int i=0;i<c4t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c4t2.get(i)).getTenMon()+" ("+c4t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(1).getListmonhoc().containsKey("Ca4")){
                                        ArrayList<String> c4t2 = result.getNgayThi().get(1).getListmonhoc().get("Ca4");
                                        for(int i=0;i<c4t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c4t2.get(i)).getTenMon()+" ("+c4t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(2).getListmonhoc().containsKey("Ca4")){
                                        ArrayList<String> c4t2 = result.getNgayThi().get(2).getListmonhoc().get("Ca4");
                                        for(int i=0;i<c4t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c4t2.get(i)).getTenMon()+" ("+c4t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(3).getListmonhoc().containsKey("Ca4")){
                                        ArrayList<String> c4t2 = result.getNgayThi().get(3).getListmonhoc().get("Ca4");
                                        for(int i=0;i<c4t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c4t2.get(i)).getTenMon()+" ("+c4t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(4).getListmonhoc().containsKey("Ca4")){
                                        ArrayList<String> c4t2 = result.getNgayThi().get(4).getListmonhoc().get("Ca4");
                                        for(int i=0;i<c4t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c4t2.get(i)).getTenMon()+" ("+c4t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(5).getListmonhoc().containsKey("Ca4")){
                                        ArrayList<String> c4t2 = result.getNgayThi().get(5).getListmonhoc().get("Ca4");
                                        for(int i=0;i<c4t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c4t2.get(i)).getTenMon()+" ("+c4t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(6).getListmonhoc().containsKey("Ca4")){
                                        ArrayList<String> c4t2 = result.getNgayThi().get(6).getListmonhoc().get("Ca4");
                                        for(int i=0;i<c4t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c4t2.get(i)).getTenMon()+" ("+c4t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="text-left">Ca 5</td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(0).getListmonhoc().containsKey("Ca5")){
                                        ArrayList<String> c5t2 = result.getNgayThi().get(0).getListmonhoc().get("Ca5");
                                        for(int i=0;i<c5t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c5t2.get(i)).getTenMon()+" ("+c5t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(1).getListmonhoc().containsKey("Ca5")){
                                        ArrayList<String> c5t2 = result.getNgayThi().get(1).getListmonhoc().get("Ca5");
                                        for(int i=0;i<c5t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c5t2.get(i)).getTenMon()+" ("+c5t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(2).getListmonhoc().containsKey("Ca5")){
                                        ArrayList<String> c5t2 = result.getNgayThi().get(2).getListmonhoc().get("Ca5");
                                        for(int i=0;i<c5t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c5t2.get(i)).getTenMon()+" ("+c5t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(3).getListmonhoc().containsKey("Ca5")){
                                        ArrayList<String> c5t2 = result.getNgayThi().get(3).getListmonhoc().get("Ca5");
                                        for(int i=0;i<c5t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c5t2.get(i)).getTenMon()+" ("+c5t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(4).getListmonhoc().containsKey("Ca5")){
                                        ArrayList<String> c5t2 = result.getNgayThi().get(4).getListmonhoc().get("Ca5");
                                        for(int i=0;i<c5t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c5t2.get(i)).getTenMon()+" ("+c5t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(5).getListmonhoc().containsKey("Ca5")){
                                        ArrayList<String> c5t2 = result.getNgayThi().get(5).getListmonhoc().get("Ca5");
                                        for(int i=0;i<c5t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c5t2.get(i)).getTenMon()+" ("+c5t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(6).getListmonhoc().containsKey("Ca5")){
                                        ArrayList<String> c5t2 = result.getNgayThi().get(6).getListmonhoc().get("Ca5");
                                        for(int i=0;i<c5t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c5t2.get(i)).getTenMon()+" ("+c5t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="text-left">Ca 6</td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(0).getListmonhoc().containsKey("Ca6")){
                                        ArrayList<String> c6t2 = result.getNgayThi().get(0).getListmonhoc().get("Ca6");
                                        for(int i=0;i<c6t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c6t2.get(i)).getTenMon()+" ("+c6t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(1).getListmonhoc().containsKey("Ca6")){
                                        ArrayList<String> c6t2 = result.getNgayThi().get(1).getListmonhoc().get("Ca6");
                                        for(int i=0;i<c6t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c6t2.get(i)).getTenMon()+" ("+c6t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(2).getListmonhoc().containsKey("Ca6")){
                                        ArrayList<String> c6t2 = result.getNgayThi().get(2).getListmonhoc().get("Ca6");
                                        for(int i=0;i<c6t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c6t2.get(i)).getTenMon()+" ("+c6t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(3).getListmonhoc().containsKey("Ca6")){
                                        ArrayList<String> c6t2 = result.getNgayThi().get(3).getListmonhoc().get("Ca6");
                                        for(int i=0;i<c6t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c6t2.get(i)).getTenMon()+" ("+c6t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(4).getListmonhoc().containsKey("Ca6")){
                                        ArrayList<String> c6t2 = result.getNgayThi().get(4).getListmonhoc().get("Ca6");
                                        for(int i=0;i<c6t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c6t2.get(i)).getTenMon()+" ("+c6t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(5).getListmonhoc().containsKey("Ca6")){
                                        ArrayList<String> c6t2 = result.getNgayThi().get(5).getListmonhoc().get("Ca6");
                                        for(int i=0;i<c6t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c6t2.get(i)).getTenMon()+" ("+c6t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(6).getListmonhoc().containsKey("Ca6")){
                                        ArrayList<String> c6t2 = result.getNgayThi().get(6).getListmonhoc().get("Ca6");
                                        for(int i=0;i<c6t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c6t2.get(i)).getTenMon()+" ("+c6t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="text-left">Ca 7</td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(0).getListmonhoc().containsKey("Ca7")){
                                        ArrayList<String> c7t2 = result.getNgayThi().get(0).getListmonhoc().get("Ca7");
                                        for(int i=0;i<c7t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c7t2.get(i)).getTenMon()+" ("+c7t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(1).getListmonhoc().containsKey("Ca7")){
                                        ArrayList<String> c7t2 = result.getNgayThi().get(1).getListmonhoc().get("Ca7");
                                        for(int i=0;i<c7t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c7t2.get(i)).getTenMon()+" ("+c7t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(2).getListmonhoc().containsKey("Ca7")){
                                        ArrayList<String> c7t2 = result.getNgayThi().get(2).getListmonhoc().get("Ca7");
                                        for(int i=0;i<c7t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c7t2.get(i)).getTenMon()+" ("+c7t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(3).getListmonhoc().containsKey("Ca7")){
                                        ArrayList<String> c7t2 = result.getNgayThi().get(3).getListmonhoc().get("Ca7");
                                        for(int i=0;i<c7t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c7t2.get(i)).getTenMon()+" ("+c7t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(4).getListmonhoc().containsKey("Ca7")){
                                        ArrayList<String> c7t2 = result.getNgayThi().get(4).getListmonhoc().get("Ca7");
                                        for(int i=0;i<c7t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c7t2.get(i)).getTenMon()+" ("+c7t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(5).getListmonhoc().containsKey("Ca7")){
                                        ArrayList<String> c7t2 = result.getNgayThi().get(5).getListmonhoc().get("Ca7");
                                        for(int i=0;i<c7t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c7t2.get(i)).getTenMon()+" ("+c7t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(6).getListmonhoc().containsKey("Ca7")){
                                        ArrayList<String> c7t2 = result.getNgayThi().get(6).getListmonhoc().get("Ca7");
                                        for(int i=0;i<c7t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c7t2.get(i)).getTenMon()+" ("+c7t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="text-left">Ca 8</td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(0).getListmonhoc().containsKey("Ca8")){
                                        ArrayList<String> c8t2 = result.getNgayThi().get(0).getListmonhoc().get("Ca8");
                                        for(int i=0;i<c8t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c8t2.get(i)).getTenMon()+" ("+c8t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(1).getListmonhoc().containsKey("Ca8")){
                                        ArrayList<String> c8t2 = result.getNgayThi().get(1).getListmonhoc().get("Ca8");
                                        for(int i=0;i<c8t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c8t2.get(i)).getTenMon()+" ("+c8t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(2).getListmonhoc().containsKey("Ca8")){
                                        ArrayList<String> c8t2 = result.getNgayThi().get(2).getListmonhoc().get("Ca8");
                                        for(int i=0;i<c8t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c8t2.get(i)).getTenMon()+" ("+c8t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(3).getListmonhoc().containsKey("Ca8")){
                                        ArrayList<String> c8t2 = result.getNgayThi().get(3).getListmonhoc().get("Ca8");
                                        for(int i=0;i<c8t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c8t2.get(i)).getTenMon()+" ("+c8t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(4).getListmonhoc().containsKey("Ca8")){
                                        ArrayList<String> c8t2 = result.getNgayThi().get(4).getListmonhoc().get("Ca8");
                                        for(int i=0;i<c8t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c8t2.get(i)).getTenMon()+" ("+c8t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(5).getListmonhoc().containsKey("Ca8")){
                                        ArrayList<String> c8t2 = result.getNgayThi().get(5).getListmonhoc().get("Ca8");
                                        for(int i=0;i<c8t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c8t2.get(i)).getTenMon()+" ("+c8t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(6).getListmonhoc().containsKey("Ca8")){
                                        ArrayList<String> c8t2 = result.getNgayThi().get(6).getListmonhoc().get("Ca8");
                                        for(int i=0;i<c8t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c8t2.get(i)).getTenMon()+" ("+c8t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="text-left">Ca 9</td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(0).getListmonhoc().containsKey("Ca9")){
                                        ArrayList<String> c9t2 = result.getNgayThi().get(0).getListmonhoc().get("Ca9");
                                        for(int i=0;i<c9t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c9t2.get(i)).getTenMon()+" ("+c9t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(1).getListmonhoc().containsKey("Ca9")){
                                        ArrayList<String> c9t2 = result.getNgayThi().get(1).getListmonhoc().get("Ca9");
                                        for(int i=0;i<c9t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c9t2.get(i)).getTenMon()+" ("+c9t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(2).getListmonhoc().containsKey("Ca9")){
                                        ArrayList<String> c9t2 = result.getNgayThi().get(2).getListmonhoc().get("Ca9");
                                        for(int i=0;i<c9t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c9t2.get(i)).getTenMon()+" ("+c9t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(3).getListmonhoc().containsKey("Ca9")){
                                        ArrayList<String> c9t2 = result.getNgayThi().get(3).getListmonhoc().get("Ca9");
                                        for(int i=0;i<c9t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c9t2.get(i)).getTenMon()+" ("+c9t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(4).getListmonhoc().containsKey("Ca9")){
                                        ArrayList<String> c9t2 = result.getNgayThi().get(4).getListmonhoc().get("Ca9");
                                        for(int i=0;i<c9t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c9t2.get(i)).getTenMon()+" ("+c9t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(5).getListmonhoc().containsKey("Ca9")){
                                        ArrayList<String> c9t2 = result.getNgayThi().get(5).getListmonhoc().get("Ca9");
                                        for(int i=0;i<c9t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c9t2.get(i)).getTenMon()+" ("+c9t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(6).getListmonhoc().containsKey("Ca9")){
                                        ArrayList<String> c9t2 = result.getNgayThi().get(6).getListmonhoc().get("Ca9");
                                        for(int i=0;i<c9t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c9t2.get(i)).getTenMon()+" ("+c9t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="text-left">Ca 10</td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(0).getListmonhoc().containsKey("Ca10")){
                                        ArrayList<String> c10t2 = result.getNgayThi().get(0).getListmonhoc().get("Ca10");
                                        for(int i=0;i<c10t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c10t2.get(i)).getTenMon()+" ("+c10t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(1).getListmonhoc().containsKey("Ca10")){
                                        ArrayList<String> c10t2 = result.getNgayThi().get(1).getListmonhoc().get("Ca10");
                                        for(int i=0;i<c10t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c10t2.get(i)).getTenMon()+" ("+c10t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(2).getListmonhoc().containsKey("Ca10")){
                                        ArrayList<String> c10t2 = result.getNgayThi().get(2).getListmonhoc().get("Ca10");
                                        for(int i=0;i<c10t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c10t2.get(i)).getTenMon()+" ("+c10t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(3).getListmonhoc().containsKey("Ca10")){
                                        ArrayList<String> c10t2 = result.getNgayThi().get(3).getListmonhoc().get("Ca10");
                                        for(int i=0;i<c10t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c10t2.get(i)).getTenMon()+" ("+c10t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(4).getListmonhoc().containsKey("Ca10")){
                                        ArrayList<String> c10t2 = result.getNgayThi().get(4).getListmonhoc().get("Ca10");
                                        for(int i=0;i<c10t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c10t2.get(i)).getTenMon()+" ("+c10t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(5).getListmonhoc().containsKey("Ca10")){
                                        ArrayList<String> c10t2 = result.getNgayThi().get(5).getListmonhoc().get("Ca10");
                                        for(int i=0;i<c10t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c10t2.get(i)).getTenMon()+" ("+c10t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:140px'>
                                <%
                                    if(result.getNgayThi().get(6).getListmonhoc().containsKey("Ca10")){
                                        ArrayList<String> c10t2 = result.getNgayThi().get(6).getListmonhoc().get("Ca10");
                                        for(int i=0;i<c10t2.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(c10t2.get(i)).getTenMon()+" ("+c10t2.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div id="cuoiki" style="display:none;width: 900px;height: 200px;">
            <p style="margin-left: 570px;color:white;font-size: 20px">LỊCH THI CUỐI KÌ</p>
             <table class="table-fill" style="margin-left:0px">
                <thead>
                <tr>
                    <th class="text-left"><p>          Ca</p></th>
                    <th class="text-left">Thứ 2</th>
                    <th class="text-left">Thứ 3</th>
                    <th class="text-left">Thứ 4</th>
                    <th class="text-left">Thứ 5</th>
                    <th class="text-left">Thứ 6</th>
                    <th class="text-left">Thứ 7</th>
                    <th class="text-left">Thứ 2</th>
                    <th class="text-left">Thứ 3</th>
                    <th class="text-left">Thứ 4</th>
                    <th class="text-left">Thứ 5</th>
                    <th class="text-left">Thứ 6</th>
                    <th class="text-left">Thứ 7</th>
                </tr>
                </thead>
                <tbody class="table-hover">
                    <tr>
                        <td class="text-left">Ca 1</td>
                        <td class="text-left">
                            <div style='width:63px'>
                                <%
                                    if(result2.getNgayThi().get(0).getListmonhoc().containsKey("Ca1")){
                                        ArrayList<String> ca = result2.getNgayThi().get(0).getListmonhoc().get("Ca1");
                                        for(int i=0;i<ca.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(ca.get(i)).getTenMon()+" ("+ca.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:63px'>
                                <%
                                    if(result2.getNgayThi().get(1).getListmonhoc().containsKey("Ca1")){
                                        ArrayList<String> ca = result2.getNgayThi().get(1).getListmonhoc().get("Ca1");
                                        for(int i=0;i<ca.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(ca.get(i)).getTenMon()+" ("+ca.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:63px'>
                                <%
                                    if(result2.getNgayThi().get(2).getListmonhoc().containsKey("Ca1")){
                                        ArrayList<String> ca = result2.getNgayThi().get(2).getListmonhoc().get("Ca1");
                                        for(int i=0;i<ca.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(ca.get(i)).getTenMon()+" ("+ca.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:63px'>
                                <%
                                    if(result2.getNgayThi().get(3).getListmonhoc().containsKey("Ca1")){
                                        ArrayList<String> ca = result2.getNgayThi().get(3).getListmonhoc().get("Ca1");
                                        for(int i=0;i<ca.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(ca.get(i)).getTenMon()+" ("+ca.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:63px'>
                                <%
                                    if(result2.getNgayThi().get(4).getListmonhoc().containsKey("Ca1")){
                                        ArrayList<String> ca = result2.getNgayThi().get(4).getListmonhoc().get("Ca1");
                                        for(int i=0;i<ca.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(ca.get(i)).getTenMon()+" ("+ca.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:63px'>
                                <%
                                    if(result2.getNgayThi().get(5).getListmonhoc().containsKey("Ca1")){
                                        ArrayList<String> ca = result2.getNgayThi().get(5).getListmonhoc().get("Ca1");
                                        for(int i=0;i<ca.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(ca.get(i)).getTenMon()+" ("+ca.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:63px'>
                                <%
                                    if(result2.getNgayThi().get(6).getListmonhoc().containsKey("Ca1")){
                                        ArrayList<String> ca = result2.getNgayThi().get(6).getListmonhoc().get("Ca1");
                                        for(int i=0;i<ca.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(ca.get(i)).getTenMon()+" ("+ca.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:63px'>
                                <%
                                    if(result2.getNgayThi().get(7).getListmonhoc().containsKey("Ca1")){
                                        ArrayList<String> ca = result2.getNgayThi().get(7).getListmonhoc().get("Ca1");
                                        for(int i=0;i<ca.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(ca.get(i)).getTenMon()+" ("+ca.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:63px'>
                                <%
                                    if(result2.getNgayThi().get(8).getListmonhoc().containsKey("Ca1")){
                                        ArrayList<String> ca = result2.getNgayThi().get(8).getListmonhoc().get("Ca1");
                                        for(int i=0;i<ca.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(ca.get(i)).getTenMon()+" ("+ca.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:63px'>
                                <%
                                    if(result2.getNgayThi().get(9).getListmonhoc().containsKey("Ca1")){
                                        ArrayList<String> ca = result2.getNgayThi().get(9).getListmonhoc().get("Ca1");
                                        for(int i=0;i<ca.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(ca.get(i)).getTenMon()+" ("+ca.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:63px'>
                                <%
                                    if(result2.getNgayThi().get(10).getListmonhoc().containsKey("Ca1")){
                                        ArrayList<String> ca = result2.getNgayThi().get(10).getListmonhoc().get("Ca1");
                                        for(int i=0;i<ca.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(ca.get(i)).getTenMon()+" ("+ca.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left">
                            <div style='width:63px'>
                                <%
                                    if(result2.getNgayThi().get(11).getListmonhoc().containsKey("Ca1")){
                                        ArrayList<String> ca = result2.getNgayThi().get(11).getListmonhoc().get("Ca1");
                                        for(int i=0;i<ca.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(ca.get(i)).getTenMon()+" ("+ca.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="text-left"> Ca 2</td>
                        <td class="text-left"></td<td class="text-left">
                            <div style='width:63px'>
                                <%
                                    if(result2.getNgayThi().get(0).getListmonhoc().containsKey("Ca2")){
                                        ArrayList<String> ca = result2.getNgayThi().get(0).getListmonhoc().get("Ca2");
                                        for(int i=0;i<ca.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(ca.get(i)).getTenMon()+" ("+ca.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left"></td<td class="text-left">
                            <div style='width:63px'>
                                <%
                                    if(result2.getNgayThi().get(1).getListmonhoc().containsKey("Ca2")){
                                        ArrayList<String> ca = result2.getNgayThi().get(1).getListmonhoc().get("Ca2");
                                        for(int i=0;i<ca.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(ca.get(i)).getTenMon()+" ("+ca.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left"></td<td class="text-left">
                            <div style='width:63px'>
                                <%
                                    if(result2.getNgayThi().get(2).getListmonhoc().containsKey("Ca2")){
                                        ArrayList<String> ca = result2.getNgayThi().get(2).getListmonhoc().get("Ca2");
                                        for(int i=0;i<ca.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(ca.get(i)).getTenMon()+" ("+ca.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left"></td<td class="text-left">
                            <div style='width:63px'>
                                <%
                                    if(result2.getNgayThi().get(3).getListmonhoc().containsKey("Ca2")){
                                        ArrayList<String> ca = result2.getNgayThi().get(3).getListmonhoc().get("Ca2");
                                        for(int i=0;i<ca.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(ca.get(i)).getTenMon()+" ("+ca.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left"></td<td class="text-left">
                            <div style='width:63px'>
                                <%
                                    if(result2.getNgayThi().get(4).getListmonhoc().containsKey("Ca2")){
                                        ArrayList<String> ca = result2.getNgayThi().get(4).getListmonhoc().get("Ca2");
                                        for(int i=0;i<ca.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(ca.get(i)).getTenMon()+" ("+ca.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left"></td<td class="text-left">
                            <div style='width:63px'>
                                <%
                                    if(result2.getNgayThi().get(5).getListmonhoc().containsKey("Ca2")){
                                        ArrayList<String> ca = result2.getNgayThi().get(5).getListmonhoc().get("Ca2");
                                        for(int i=0;i<ca.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(ca.get(i)).getTenMon()+" ("+ca.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left"></td<td class="text-left">
                            <div style='width:63px'>
                                <%
                                    if(result2.getNgayThi().get(6).getListmonhoc().containsKey("Ca2")){
                                        ArrayList<String> ca = result2.getNgayThi().get(6).getListmonhoc().get("Ca2");
                                        for(int i=0;i<ca.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(ca.get(i)).getTenMon()+" ("+ca.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left"></td<td class="text-left">
                            <div style='width:63px'>
                                <%
                                    if(result2.getNgayThi().get(7).getListmonhoc().containsKey("Ca2")){
                                        ArrayList<String> ca = result2.getNgayThi().get(7).getListmonhoc().get("Ca2");
                                        for(int i=0;i<ca.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(ca.get(i)).getTenMon()+" ("+ca.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left"></td<td class="text-left">
                            <div style='width:63px'>
                                <%
                                    if(result2.getNgayThi().get(8).getListmonhoc().containsKey("Ca2")){
                                        ArrayList<String> ca = result2.getNgayThi().get(8).getListmonhoc().get("Ca2");
                                        for(int i=0;i<ca.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(ca.get(i)).getTenMon()+" ("+ca.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left"></td<td class="text-left">
                            <div style='width:63px'>
                                <%
                                    if(result2.getNgayThi().get(9).getListmonhoc().containsKey("Ca2")){
                                        ArrayList<String> ca = result2.getNgayThi().get(9).getListmonhoc().get("Ca2");
                                        for(int i=0;i<ca.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(ca.get(i)).getTenMon()+" ("+ca.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left"></td<td class="text-left">
                            <div style='width:63px'>
                                <%
                                    if(result2.getNgayThi().get(10).getListmonhoc().containsKey("Ca2")){
                                        ArrayList<String> ca = result2.getNgayThi().get(10).getListmonhoc().get("Ca2");
                                        for(int i=0;i<ca.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(ca.get(i)).getTenMon()+" ("+ca.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left"></td<td class="text-left">
                            <div style='width:63px'>
                                <%
                                    if(result2.getNgayThi().get(11).getListmonhoc().containsKey("Ca2")){
                                        ArrayList<String> ca = result2.getNgayThi().get(11).getListmonhoc().get("Ca2");
                                        for(int i=0;i<ca.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(ca.get(i)).getTenMon()+" ("+ca.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="text-left">Ca 3</td>
                        <td class="text-left"></td<td class="text-left">
                            <div style='width:63px'>
                                <%
                                    if(result2.getNgayThi().get(0).getListmonhoc().containsKey("Ca3")){
                                        ArrayList<String> ca = result2.getNgayThi().get(0).getListmonhoc().get("Ca3");
                                        for(int i=0;i<ca.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(ca.get(i)).getTenMon()+" ("+ca.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left"></td<td class="text-left">
                            <div style='width:63px'>
                                <%
                                    if(result2.getNgayThi().get(1).getListmonhoc().containsKey("Ca3")){
                                        ArrayList<String> ca = result2.getNgayThi().get(1).getListmonhoc().get("Ca3");
                                        for(int i=0;i<ca.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(ca.get(i)).getTenMon()+" ("+ca.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left"></td<td class="text-left">
                            <div style='width:63px'>
                                <%
                                    if(result2.getNgayThi().get(2).getListmonhoc().containsKey("Ca3")){
                                        ArrayList<String> ca = result2.getNgayThi().get(2).getListmonhoc().get("Ca3");
                                        for(int i=0;i<ca.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(ca.get(i)).getTenMon()+" ("+ca.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left"></td<td class="text-left">
                            <div style='width:63px'>
                                <%
                                    if(result2.getNgayThi().get(3).getListmonhoc().containsKey("Ca3")){
                                        ArrayList<String> ca = result2.getNgayThi().get(3).getListmonhoc().get("Ca3");
                                        for(int i=0;i<ca.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(ca.get(i)).getTenMon()+" ("+ca.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left"></td<td class="text-left">
                            <div style='width:63px'>
                                <%
                                    if(result2.getNgayThi().get(4).getListmonhoc().containsKey("Ca3")){
                                        ArrayList<String> ca = result2.getNgayThi().get(4).getListmonhoc().get("Ca3");
                                        for(int i=0;i<ca.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(ca.get(i)).getTenMon()+" ("+ca.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left"></td<td class="text-left">
                            <div style='width:63px'>
                                <%
                                    if(result2.getNgayThi().get(5).getListmonhoc().containsKey("Ca3")){
                                        ArrayList<String> ca = result2.getNgayThi().get(5).getListmonhoc().get("Ca3");
                                        for(int i=0;i<ca.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(ca.get(i)).getTenMon()+" ("+ca.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left"></td<td class="text-left">
                            <div style='width:63px'>
                                <%
                                    if(result2.getNgayThi().get(6).getListmonhoc().containsKey("Ca3")){
                                        ArrayList<String> ca = result2.getNgayThi().get(6).getListmonhoc().get("Ca3");
                                        for(int i=0;i<ca.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(ca.get(i)).getTenMon()+" ("+ca.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left"></td<td class="text-left">
                            <div style='width:63px'>
                                <%
                                    if(result2.getNgayThi().get(7).getListmonhoc().containsKey("Ca3")){
                                        ArrayList<String> ca = result2.getNgayThi().get(7).getListmonhoc().get("Ca3");
                                        for(int i=0;i<ca.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(ca.get(i)).getTenMon()+" ("+ca.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left"></td<td class="text-left">
                            <div style='width:63px'>
                                <%
                                    if(result2.getNgayThi().get(8).getListmonhoc().containsKey("Ca3")){
                                        ArrayList<String> ca = result2.getNgayThi().get(8).getListmonhoc().get("Ca3");
                                        for(int i=0;i<ca.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(ca.get(i)).getTenMon()+" ("+ca.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left"></td<td class="text-left">
                            <div style='width:63px'>
                                <%
                                    if(result2.getNgayThi().get(9).getListmonhoc().containsKey("Ca3")){
                                        ArrayList<String> ca = result2.getNgayThi().get(9).getListmonhoc().get("Ca3");
                                        for(int i=0;i<ca.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(ca.get(i)).getTenMon()+" ("+ca.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left"></td<td class="text-left">
                            <div style='width:63px'>
                                <%
                                    if(result2.getNgayThi().get(10).getListmonhoc().containsKey("Ca3")){
                                        ArrayList<String> ca = result2.getNgayThi().get(10).getListmonhoc().get("Ca3");
                                        for(int i=0;i<ca.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(ca.get(i)).getTenMon()+" ("+ca.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left"></td<td class="text-left">
                            <div style='width:63px'>
                                <%
                                    if(result2.getNgayThi().get(11).getListmonhoc().containsKey("Ca3")){
                                        ArrayList<String> ca = result2.getNgayThi().get(11).getListmonhoc().get("Ca3");
                                        for(int i=0;i<ca.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(ca.get(i)).getTenMon()+" ("+ca.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="text-left">Ca 4</td>
                        <td class="text-left"></td<td class="text-left">
                            <div style='width:63px'>
                                <%
                                    if(result2.getNgayThi().get(0).getListmonhoc().containsKey("Ca4")){
                                        ArrayList<String> ca = result2.getNgayThi().get(0).getListmonhoc().get("Ca4");
                                        for(int i=0;i<ca.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(ca.get(i)).getTenMon()+" ("+ca.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left"></td<td class="text-left">
                            <div style='width:63px'>
                                <%
                                    if(result2.getNgayThi().get(1).getListmonhoc().containsKey("Ca4")){
                                        ArrayList<String> ca = result2.getNgayThi().get(1).getListmonhoc().get("Ca4");
                                        for(int i=0;i<ca.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(ca.get(i)).getTenMon()+" ("+ca.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left"></td<td class="text-left">
                            <div style='width:63px'>
                                <%
                                    if(result2.getNgayThi().get(2).getListmonhoc().containsKey("Ca4")){
                                        ArrayList<String> ca = result2.getNgayThi().get(2).getListmonhoc().get("Ca4");
                                        for(int i=0;i<ca.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(ca.get(i)).getTenMon()+" ("+ca.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left"></td<td class="text-left">
                            <div style='width:63px'>
                                <%
                                    if(result2.getNgayThi().get(3).getListmonhoc().containsKey("Ca4")){
                                        ArrayList<String> ca = result2.getNgayThi().get(3).getListmonhoc().get("Ca4");
                                        for(int i=0;i<ca.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(ca.get(i)).getTenMon()+" ("+ca.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left"></td<td class="text-left">
                            <div style='width:63px'>
                                <%
                                    if(result2.getNgayThi().get(4).getListmonhoc().containsKey("Ca4")){
                                        ArrayList<String> ca = result2.getNgayThi().get(4).getListmonhoc().get("Ca4");
                                        for(int i=0;i<ca.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(ca.get(i)).getTenMon()+" ("+ca.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left"></td<td class="text-left">
                            <div style='width:63px'>
                                <%
                                    if(result2.getNgayThi().get(5).getListmonhoc().containsKey("Ca4")){
                                        ArrayList<String> ca = result2.getNgayThi().get(5).getListmonhoc().get("Ca4");
                                        for(int i=0;i<ca.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(ca.get(i)).getTenMon()+" ("+ca.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left"></td<td class="text-left">
                            <div style='width:63px'>
                                <%
                                    if(result2.getNgayThi().get(6).getListmonhoc().containsKey("Ca4")){
                                        ArrayList<String> ca = result2.getNgayThi().get(6).getListmonhoc().get("Ca4");
                                        for(int i=0;i<ca.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(ca.get(i)).getTenMon()+" ("+ca.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left"></td<td class="text-left">
                            <div style='width:63px'>
                                <%
                                    if(result2.getNgayThi().get(7).getListmonhoc().containsKey("Ca4")){
                                        ArrayList<String> ca = result2.getNgayThi().get(7).getListmonhoc().get("Ca4");
                                        for(int i=0;i<ca.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(ca.get(i)).getTenMon()+" ("+ca.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left"></td<td class="text-left">
                            <div style='width:63px'>
                                <%
                                    if(result2.getNgayThi().get(8).getListmonhoc().containsKey("Ca4")){
                                        ArrayList<String> ca = result2.getNgayThi().get(8).getListmonhoc().get("Ca4");
                                        for(int i=0;i<ca.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(ca.get(i)).getTenMon()+" ("+ca.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left"></td<td class="text-left">
                            <div style='width:63px'>
                                <%
                                    if(result2.getNgayThi().get(9).getListmonhoc().containsKey("Ca4")){
                                        ArrayList<String> ca = result2.getNgayThi().get(9).getListmonhoc().get("Ca4");
                                        for(int i=0;i<ca.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(ca.get(i)).getTenMon()+" ("+ca.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left"></td<td class="text-left">
                            <div style='width:63px'>
                                <%
                                    if(result2.getNgayThi().get(10).getListmonhoc().containsKey("Ca4")){
                                        ArrayList<String> ca = result2.getNgayThi().get(10).getListmonhoc().get("Ca4");
                                        for(int i=0;i<ca.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(ca.get(i)).getTenMon()+" ("+ca.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td class="text-left"></td<td class="text-left">
                            <div style='width:63px'>
                                <%
                                    if(result2.getNgayThi().get(11).getListmonhoc().containsKey("Ca4")){
                                        ArrayList<String> ca = result2.getNgayThi().get(11).getListmonhoc().get("Ca4");
                                        for(int i=0;i<ca.size();i++){
                                            out.print("<p style='font-weight:bold'>- "+listStudentsofCourse.get(ca.get(i)).getTenMon()+" ("+ca.get(i)+")"+"</p>");
                                        }
                                    }
                                %>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </body>
</html>
