<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="encrypt" class="member.Encrypt"/>
<%
		request.setCharacterEncoding("UTF-8");
		String value = request.getParameter("value");
		value = encrypt.getEncrypt(value);
%>
<html>
<head>
<meta charset="UTF-8">
<script>
const value = <%=value%>;
location.href = `login.jsp?value = ${value}`;
</script>
</head>
<body>

</body>
</html>