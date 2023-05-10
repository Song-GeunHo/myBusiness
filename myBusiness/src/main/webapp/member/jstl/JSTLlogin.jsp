<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<title>홈페이지</title>
<link href="../styles/style.css" rel="stylesheet" type="text/css">
<style>
td{ padding: 10px; }
input { height: 30px; cursor: pointer; padding-left: 10px; }
input[type="button"] { background-color: white; color: #131921; font-weight: 700; border-radius: 5px; padding-left: 5px; }
input[type="button"]:hover { opacity: 0.8; }
</style>
<script type="text/javascript">
	function loginCheck() {
		if (document.loginFrm.id.value == "") {
			alert("아이디를 입력해 주세요.");
			document.loginFrm.id.focus();
			return;
		}
		if (document.loginFrm.pwd.value == "") {
			alert("비밀번호를 입력해 주세요.");
			document.loginFrm.pwd.focus();
			return;
		}
		document.loginFrm.submit();
	} 
</script>
</head>
<body>
<div align="center"><br/><br/>
		<c:choose>
			<c:when test="${newIDKey ne null }">
		<br><br>
		<font size="10"><b>${newIDKey}</b>님 환영 합니다.
		<p>제한된 기능을 사용 할 수가 있습니다.<p/><hr><br><br></font>
			<font size="7"><a href="JSTLinfoInquiry.jsp">회원정보 조회</a> | <a href="JSTLlogout.jsp">로그아웃</a></font>
		</c:when>
		<c:otherwise>
		<form name="loginFrm" method="post" action="JSTLloginProc.jsp">
			<table>
				<tr>
					<td align="center" colspan="2"><h4 style="background-color:#FFCC00; color:#414141; cursor:pointer;" onclick="location.href='../login.jsp'">JSPStudy</h4></td>
				</tr>
				<tr>
					<td>아 이 디</td>
					<td><input name="id"></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="pwd"></td>
				</tr>
				<tr>
					<td colspan="2">
						<div align="right">
							<input type="button" value="로그인" onclick="loginCheck();">&nbsp;
						</div>
					</td>
				</tr>
			</table>
		</form>
		</c:otherwise>
		</c:choose>
	</div>
</body>
</html>