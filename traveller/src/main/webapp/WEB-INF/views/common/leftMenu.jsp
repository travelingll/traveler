<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>웹페이지</title>
    <style>
        /* 왼쪽 메뉴바 스타일 */
        .sidebar {
            position: absolute;
            top: 40%;
            left: 0;
            width: 200px;
            height: 40%;
        }
        /* 메인 콘텐츠 스타일 */
        .content-main {
            margin-left: 200px; /* 왼쪽 메뉴바 너비만큼 여백 추가 */
            padding: 20px;
         	position:pixed;
        }
        
        .sidebar ul li{
        list-style-type: none;
        font-size:20pt;
        }
        a {
  		    text-decoration: none;
    		color: inherit;
  }
    </style>
</head>
<body>
    <div class="sidebar">
        <!-- 왼쪽 메뉴바 내용 -->
        <ul>
            <li><b><a href="#">메뉴1</a></b></li>
            <li><b><a href="#">메뉴2</a></b></li>
            <li><b><a href="#">메뉴3</a></b></li>
        </ul>
    </div>
    
    <div class="content-main">
        <!-- 메인 콘텐츠 내용 -->
    </div>
</body>
</html>