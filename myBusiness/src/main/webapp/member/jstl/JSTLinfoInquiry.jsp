<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
<meta charset="UTF-8">
<style>
@import url("styles/style.css");

div {
	margin-top: 50px;
}

div > input {
	height: 30px;
	background-color: white;
	border-radius: 5px;
	margin: 0 10px;
}
div > input:hover {
	opacity: 0.7;
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
<script>
	function changeInfo(button) {
		let buttons = document.getElementsByClassName("btn");
		let infoInput = document.getElementsByClassName("infoInput");
		if ( button.value == "회원정보 변경" ) {
			buttons[0].style.display = "inline-block";
			buttons[1].style.display = "inline-block";
			buttons[2].style.display = "none";
			buttons[3].style.display = "none";
			for(let i=0;i<infoInput.length;i++) {
				infoInput[i].style.display = "table-cell";
			}
		} else if ( button.value == "비밀번호 변경" ) {
			buttons[0].style.display = "inline-block";
			buttons[1].style.display = "inline-block";
			buttons[2].style.display = "none";
			buttons[3].style.display = "none";
		} else if ( button.value == "취소" ) {
			buttons[0].style.display = "none";
			buttons[1].style.display = "none";
			buttons[2].style.display = "inline-block";
			buttons[3].style.display = "inline-block";
			for(let i=0;i<infoInput.length;i++) {
				infoInput[i].style.display = "none";
			}
		}
	}
</script>
</head>
<body>
	<div align="center">
		<h1>회원정보 조회</h1>
		<sql:query var="search" dataSource="${db}">
			SELECT * FROM tblmember where id=? 
			<sql:param value="${newIDKey}"/>
		</sql:query>
		<c:forEach var="info" items="${search.rows}">
			<table>
				<tr>
					<th>아이디</th>
					<td>${info.id }</td>
				</tr>
				<tr>
					<th>이름</th>
					<td>${info.name }</td>
					<td class="infoInput" style="display:none;"><input name="name"></td>
				</tr>
				<tr>
					<th>성별</th>
					<c:choose>
						<c:when test="${info.gender} eq '1'">
							<td>남자</td>
						</c:when>
						<c:otherwise>
							<td>여자</td>	
						</c:otherwise>
					</c:choose>
					<td class="infoInput" style="display:none;"><input name="gender"></td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td>${info.birthday }</td>
					<td class="infoInput" style="display:none;"><input name="birthday"></td>
				</tr>
				<tr>
					<th>이메일</th>
					<td>${info.email }</td>
					<td class="infoInput" style="display:none;"><input name="email"></td>
				</tr>
				<tr>
					<th>우편번호</th>
					<td>${info.zipcode }</td>
					<td class="infoInput" style="display:none;"><input name="zipcode"></td>
				</tr>
				<tr>
					<th>주소</th>
					<td>${info.address }</td>
					<td class="infoInput" style="display:none;"><input name="address"></td>
				</tr>
				<%
				String str = "";
				String[] hobbys = { "인터넷", "여행", "게임", "영화", "운동" };
				%>
				<c:set var="hobbys" value="<%=hobbys %>" />
				<c:set var="hobby" value="${info.hobby}" />
				<%
						String hobbyNum = (String)pageContext.getAttribute("hobby");
						String[] hobby = hobbyNum.split("");
				%>
				<c:set var="hobby" value="<%=hobby %>" />
				<tr>
					<th>취미</th>
					<td>
					<c:forEach var="myHobby" items="${hobbys }" begin="0" step="1" end="4" varStatus="status">
						<c:if test="${hobby[status.count-1] eq '1' }">
									${hobbys[status.count-1]}&nbsp&nbsp
						</c:if>
					</c:forEach>
					</td>
					<td class="infoInput" style="display:none;"><input name="hobby"></td>
				</tr>
				<sql:query var="getJobname" dataSource="${db}">
					SELECT jobname FROM tblmember NATURAL JOIN tbljob WHERE jobcode = ? and tblmember.id = ?
					<sql:param value="${info.jobcode}"/>
					<sql:param value="${newIDKey}"/>
				</sql:query>
				<tr>
					<th>직업</th>
					<td>
					<c:forEach var="jobname" items="${getJobname.rows }">
						${jobname['jobname']}
					</c:forEach>
					</td>
					<td class="infoInput" style="display:none;"><input name="jobcode"></td>
				</tr>
				<tr>
					<th>국적</th>
					<td>${info.nationality }</td>
					<td class="infoInput" style="display:none;"><input name="nationality"></td>
				</tr>
			</table>
	</c:forEach>
	</div>
	<div align="right" style="width:465px; margin:15px auto; font-size:20px;"><input class="btn" type="button" value="비밀번호 변경" onclick="changeInfo(this);"></div>
</body>
</html>