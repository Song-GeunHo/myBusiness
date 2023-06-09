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
		<form method=post action="infoInquiryProc.jsp" onsubmit="return checkInput();">
			<table>
				<tr>
					<th>아이디</th>
					<td><%=bean.getId()%></td>
				</tr>
				<tr>
					<th>이름</th>
					<td><%=bean.getName()%></td>
					<td class="infoInput" style="display:none;"><input name="name"></td>
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
					<td class="infoInput" style="display:none;"><input name="gender"></td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td><%=bean.getBirthday()%></td>
					<td class="infoInput" style="display:none;"><input name="birthday"></td>
				</tr>
				<tr>
					<th>이메일</th>
					<td><%=bean.getEmail()%></td>
					<td class="infoInput" style="display:none;"><input name="email"></td>
				</tr>
				<tr>
					<th>우편번호</th>
					<td><%=bean.getZipcode()%></td>
					<td class="infoInput" style="display:none;"><input name="zipcode"></td>
				</tr>
				<tr>
					<th>주소</th>
					<td><%=bean.getAddress()%></td>
					<td class="infoInput" style="display:none;"><input name="address"></td>
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
				
				if(str.length()!=0) {
					if (str.charAt(str.length() - 1) == ' ') {
						str = str.substring(0, str.length() - 2);
					}
				}
				%>
				<tr>
					<th>취미</th>
					<td><%=str%></td>
					<td class="infoInput" style="display:none;"><input name="hobby"></td>
				</tr>
				<tr>
					<th>직업</th>
					<td><%=bean.getJob()%></td>
					<td class="infoInput" style="display:none;"><input name="jobcode"></td>
				</tr>
				<tr>
					<th>국적</th>
					<td><%=bean.getNationality() %></td>
					<td class="infoInput" style="display:none;"><input name="nationality"></td>
				</tr>
			</table>
		</form>
	</div>
	<div align="right" style="width:465px; margin:15px auto; font-size:20px;"><input class="btn" type="button" value="취소" style="display:none;" onclick="changeInfo(this);"><input class="btn" type="submit" value="확인" style="display:none;"><input class="btn" type="button" value="비밀번호 변경" onclick="changeInfo(this);"><input class="btn" type="button" value="회원정보 변경" onclick="changeInfo(this);"></div>
</body>
</html>