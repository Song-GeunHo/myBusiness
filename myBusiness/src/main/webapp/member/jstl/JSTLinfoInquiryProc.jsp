<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
%>
<jsp:useBean id="bean" class="member.MemberBean" scope="session" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<sql:setDataSource
	url="jdbc:mysql://127.0.0.1:3306/myBusiness?useUnicode=true&characterEncoding=UTF-8"
	driver="com.mysql.cj.jdbc.Driver" user="root" password="song" var="db"
	scope="application" />
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	<sql:query var="search" dataSource="${db}">
		SELECT * FROM tblmember where id=? 
		<sql:param value="${newIDKey}"/>
	</sql:query>
	<c:forEach var="info" items="${search.rows}">
		
	</c:forEach>
</body>
</html>