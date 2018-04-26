<%-- 
    Document   : Student
    Created on : Nov 9, 2017, 4:43:56 PM
    Author     : QuangHau
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            .button{
                background-color: #f44336; 
                color: black; 
                border: 2px solid #f44336;
                border: none;
                color: white;
                padding: 10px 25px;
                text-align: center;
                text-decoration: none;
                display: inline-block;
                font-size: 16px;
                margin: 4px 2px;
                -webkit-transition-duration: 0.4s; /* Safari */
                transition-duration: 0.4s;
                cursor: pointer;
                border-radius: 5px;
            }

            .button:hover {
                background-color: white;
                color: #f44336;
            }
            
            .mssv{
                width: 50%;
                padding: 18px 20px;
                margin: 8px 0;
                display: inline-block;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
                font-size: 20px;
                margin-top: 250px;
            }
        </style>
    </head>
    <body style="background-image: url('img/header-bg.jpg');background-size: cover;background-repeat: no-repeat">
                <form style="text-align: center" action="result.jsp" method="GET">
                    <input class="mssv" type="text" placeholder="Nhập mã số sinh viên..." name="mssv"/><br>
                    <input class="button" type='submit' value ='Xem Lịch Thi' />
		</form>
	</div>
</div>
    </body>
</html>
