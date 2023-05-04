<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
<title>회원가입</title>
<link href="styles/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="scripts/script.js"></script>
<script type="text/javascript">
	function idCheck(id) {
		frm = document.regFrm;
		if (id == "") {
			alert("아이디를 입력해 주세요.");
			frm.id.focus();
			return;
		}
		url = "idCheck.jsp?id=" + id;
		window.open(url, "IDCheck", "width=300,height=150");
	}

	function zipSearch() {
		url = "zipSearch.jsp?search=n";
		window.open(url, "ZipCodeSearch","width=500,height=300,scrollbars=yes");
	}
</script>
</head>
<body onLoad="regFrm.id.focus()">
	<div align="center">
		<br /><br />
		<form name="regFrm" method="post" action="memberProc.jsp">
			<table cellpadding="5">
				<tr>
					<td>
						<table border="1" cellspacing="0" cellpadding="2" width="900">
							<tr bgcolor="#FFCC00">
								<td colspan="3"><font color="black"><b>회원 가입</b></font></td>
							</tr>
							<tr>
								<td width="20%">아이디</td>
								<td width="50%">
									<input name="id" size="15"> 
									<input type="button" value="ID중복확인" onClick="idCheck(this.form.id.value)">
								</td>
								<td width="30%">아이디를 적어 주세요.</td>
							</tr>
							<tr>
								<td>패스워드</td>
								<td><input type="password" name="pwd" size="15"></td>
								<td>패스워드를 적어주세요.</td>
							</tr>
							<tr>
								<td>패스워드 확인</td>
								<td><input type="password" name="repwd" size="15"></td>
								<td>패스워드를 확인합니다.</td>
							</tr>
							<tr>
								<td>이름</td>
								<td><input name="name" size="15">
								</td>
								<td>이름을 적어주세요.</td>
							</tr>
							<tr>
								<td>성별</td>
								<td>
									남<input type="radio" name="gender" value="1" checked> 
									여<input type="radio" name="gender" value="2">
								</td>
								<td>성별을 선택 하세요.</td>
							</tr>
							<tr>
								<td>생년월일</td>
								<td><input type="date" name="birthday" size="6" min="1950-01-01" max="2015-12-31"></td>
								<td>생년월일를 적어 주세요.</td>
							</tr>
							<tr>
								<td>Email</td>
								<td><input name="email" size="30">
								</td>
								<td>이메일를 적어 주세요.</td>
							</tr>
							<tr>
								<td>우편번호</td>
								<td><input name="zipcode" size="5" readonly>
									<input type="button" value="우편번호찾기" onClick="zipSearch()">
								</td>
								<td>우편번호를 검색하세요.</td>
							</tr>
							<tr>
								<td>주소</td>
								<td><input name="address" size="45"></td>
								<td>주소를 적어 주세요.</td>
							</tr>
							<tr>
								<td>취미</td>
								<td>인터넷<input type="checkbox" name="hobby" value="인터넷">
									여행<input type="checkbox" name="hobby" value="여행"> 게임<input
									type="checkbox" name="hobby" value="게임"> 영화<input
									type="checkbox" name="hobby" value="영화"> 운동<input
									type="checkbox" name="hobby" value="운동">
								</td>
								<td>취미를 선택 하세요.</td>
							</tr>
							<tr>
								<td>직업</td>
								<td><select name=jobcode>
										<option value="" selected>선택하세요.
										<option value="0">무직
										<option value="1">회사원
										<option value="2">연구전문직
										<option value="3">교수학생
										<option value="4">일반자영업
										<option value="5">공무원
										<option value="6">의료인
										<option value="7">법조인
										<option value="8">종교.언론/예술인
										<option value="9">농/축/수산/광업인
										<option value="a">주부
										<option value="b">기타
								</select></td>
								<td>직업을 선택 하세요.</td>
							</tr>
							<tr>
								<td>국적</td>
								<td><input name="nationality" size="20"></td>
								<td>국적을 입력하세요</td>
							</tr>
							<tr bgcolor="#FFCC00">
								<td colspan="3" align="center">
								   <input type="button" value="회원가입" onclick="inputCheck()">
								    &nbsp; &nbsp; 
								    <input type="reset" value="다시쓰기">
								    &nbsp; &nbsp;
								    <input type="button" value="로그인" onClick="javascript:location.href='login.jsp'">
								 </td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>