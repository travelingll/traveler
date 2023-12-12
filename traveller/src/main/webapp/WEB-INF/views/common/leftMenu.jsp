<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>웹페이지</title>
    <style>
        /* 왼쪽 메뉴바 스타일 */
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            width: 200px;
            height: 100%;
            background-color: #f1f1f1;
        }
        
        /* 메인 콘텐츠 스타일 */
        .content {
            margin-left: 200px; /* 왼쪽 메뉴바 너비만큼 여백 추가 */
            padding: 20px;
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <!-- 왼쪽 메뉴바 내용 -->
        <ul>
            <li>메뉴1</li>
            <li>메뉴2</li>
            <li>메뉴3</li>
        </ul>
    </div>
    
    <div class="content">
        <!-- 메인 콘텐츠 내용 -->
        <h1>제목</h1>
        <p>본문 내용</p>
    </div>
</body>
</html>