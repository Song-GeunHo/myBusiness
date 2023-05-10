<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.Encrypt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<sql:setDataSource
	url="jdbc:mysql://127.0.0.1:3306/myBusiness?useUnicode=true&characterEncoding=UTF-8"
	driver="com.mysql.cj.jdbc.Driver" user="root" password="song" var="db"
	scope="application" />
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<sql:query var="login" dataSource="${db}">
		SELECT count(*) FROM tblmember where id=? and pwd=? 
		<sql:param value="${param.id}"/>
		<sql:param value="${Encrypt.getEncrypt(param.pw)}"/>
	</sql:query>
	<c:forEach var="success" items="${login.rows}">
		<c:choose>
			<c:when test="${success['count(*)'] == '1'}">
				<c:set var="newIDKey" value="${param.id}" scope="session"/>
				<script>alert("로그인 성공");</script>
				<script>location.href = "JSTLlogin.jsp";</script>
			</c:when>
			<c:otherwise>
				<script>alert("로그인 실패");</script>
				<script>location.href = "JSTLlogin.jsp";</script>
			</c:otherwise>
		</c:choose>	
	</c:forEach>
</body>
</html>