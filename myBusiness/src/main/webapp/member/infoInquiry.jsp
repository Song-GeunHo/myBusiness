<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
%>
<%@ page	import="member.MemberBean"%>
<jsp:useBean id="mgr" class="member.MemberMgr" />
<%
String id = (String) session.getAttribute("idKey");
MemberBean bean = mgr.getMember(id);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
@import url("styles/style.css");

div {
	margin-top: 50px;
}

table {
	border: 1px solid white;
}

td, th, h1 {
	padding: 10px;
}

td {
	border: 1px solid white
}

th {
	border: 2px solid white;
	background-color: #FFCC00;
	color: black;
}
</style>
</head>
<body>
	<div align="center">
		<h1>회원정보 조회</h1>
		<table>
			<tr>
				<th>아이디</th>
				<td><%=bean.getId()%></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><%=bean.getPwd()%></td>
			</tr>
			<tr>
				<th>이름</th>
				<td><%=bean.getName()%></td>
			</tr>
			<tr>
				<th>성별</th>
				<%
				if (bean.getGender().equals("1")) {
				%>
				<td>남자</td>
				<%
				} else {
				%>
				<td>여자</td>
				<%
				}
				%>
			</tr>
			<tr>
				<th>생년월일</th>
				<td><%=bean.getBirthday()%></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td><%=bean.getEmail()%></td>
			</tr>
			<tr>
				<th>우편번호</th>
				<td><%=bean.getZipcode()%></td>
			</tr>
			<tr>
				<th>주소</th>
				<td><%=bean.getAddress()%></td>
			</tr>
			<%
			String str = "";
			String[] hobby = { "인터넷", "여행", "게임", "영화", "운동" };
			String[] hobbyNum = bean.getHobby();

			for (int i = 0; i < hobbyNum.length; i++) {
				if (hobbyNum[i].equals("1")) {
					str += hobby[i] + ", ";
				}
			}

			if (str.charAt(str.length() - 1) == ' ') {
				str = str.substring(0, str.length() - 2);
			}
			%>
			<tr>
				<th>취미</th>
				<td><%=str%></td>
			</tr>
			<tr>
				<th>직업</th>
				<td><%=bean.getJob()%></td>
			</tr>
			<tr>
				<th>국적</th>
				<td><%=bean.getNationality() %></td>
			</tr>
		</table>
	</div>
</body>
</html>