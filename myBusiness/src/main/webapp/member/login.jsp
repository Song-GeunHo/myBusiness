<%@ page contentType="text/html; charset=UTF-8" %>
<%
	  request.setCharacterEncoding("UTF-8");
	  String id = (String)session.getAttribute("idKey");
%>
<html>
<head>
<title>홈페이지</title>
<link href="styles/style.css" rel="stylesheet" type="text/css">
<style>
td{ padding: 10px; }
input { height: 30px; cursor: pointer; padding-left: 10px; }
input[type="button"] { background-color: white; color: #131921; font-weight: 700; border-radius: 5px; padding-left: 5px; }
input[type="button"]:hover { opacity: 0.8; }
</style>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/7.2.0/sweetalert2.min.css">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/7.2.0/sweetalert2.all.min.js"></script>
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
	/*
	function rePwd() {
		swal.fire({
			  title: 'Login Form',
			  html: `<input type="text" id="login" class="swal2-input" placeholder="Username">
			  <input type="password" id="password" class="swal2-input" placeholder="Password">`,
			  confirmButtonText: 'Sign in',
			  focusConfirm: false,
			  preConfirm: () => {
			    const login = Swal.getPopup().querySelector('#login').value
			    const password = Swal.getPopup().querySelector('#password').value
			    if (!login || !password) {
			      Swal.showValidationMessage(`Please enter login and password`)
			    }
			    return { login: login, password: password }
			  }
			}).then((result) => {
			  Swal.fire(`
			    Login: ${result.value.login}
			    Password: ${result.value.password}
			  `.trim())
			})
		({
				title: "비밀번호 확인",
			 	icon: "info",
			 	content: {
			 		element: "input",
			 		attributes: {
			 			placeholder: "비밀번호를 입력해주세요",
			 			type: "password",
			 		},
			 	},
			})

				if ( value == null ) {
					swal({
						title: "비밀번호를 입력해주세요.",
						icon: "error",
					});
				} else {

				}
			});
	}*/
</script>
</head>
<body>
<div align="center"><br/><br/>
		<%if (id != null) {%>
		<br><br>
		<font size="10"><b><%=id%></b>님 환영 합니다.
		<p>제한된 기능을 사용 할 수가 있습니다.<p/><hr><br><br></font>
			<font size="7"><a href="../board/list.jsp">게시판</a> | <a href="../survey/pollList.jsp">설문조사</a> | <a href="infoInquiry.jsp">회원정보 조회</a> | <a href="logout.jsp">로그아웃</a></font>
			<%} else {%>
		<form name="loginFrm" method="post" action="loginProc.jsp">
			<table>
				<tr>
					<td align="center" colspan="2"><h4 style="background-color:#FFCC00; color:#414141">JSPStudy</h4></td>
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
							<input type="button" value="게시판" onclick="location.href='../board/list.jsp'" style="position: relative; left: -65px;">
							<input type="button" value="설문조사" onclick="location.href='../survey/pollList.jsp'" style="position: relative; left: -60px;">
							<input type="button" value="로그인" onclick="loginCheck();">&nbsp;
							<input type="button" value="회원가입" onClick="javascript:location.href='member.jsp'">
						</div>
					</td>
				</tr>
			</table>
		</form>
		<div style="width:500px;display:flex; justify-content:center;">
			<div style="width:15px; background-color:white;"></div>
			<div style="font-size:2em; cursor:pointer;" onclick="window.open('jstl/JSTLlogin.jsp');">JSTL_SQL TAG</div>
		</div>
		<%}%>
	</div>
</body>
</html>