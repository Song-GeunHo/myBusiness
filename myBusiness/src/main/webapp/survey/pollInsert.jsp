<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.time.LocalDate"%>
<%!LocalDate today = LocalDate.now();%>
<html>
<head>
<title>JSP Poll</title>
<link href="../member/styles/style.css" rel="stylesheet" type="text/css">
<script>
	function monthCheck(select) {
		let month = select.value;
		let options = null;
		if ( select.getAttribute("name") == "sdateM" ) {
			let curSelect = document.getElementsByName("sdateD");
			options = curSelect[0].options;
		} else {
			let curSelect = document.getElementsByName("edateD");
			options = curSelect[0].options;
		}
		if ( month == 2) {
			if(<%=today.isLeapYear()%>) {
				options[29].hidden = true;
				options[30].hidden = true;
			} else {
				options[28].hidden = true;
				options[29].hidden = true;
				options[30].hidden = true;
			}
		} else if (month == 1 || month == 3 || month == 5 || month == 7
				|| month == 8 || month == 10 || month == 12) {
			options[28].hidden = false;
			options[29].hidden = false;
			options[30].hidden = false;
		} else {
			options[28].hidden = false;
			options[29].hidden = false;
			options[30].hidden = true;
		}
	}
	
	function checkDate() {
		let form = document.pollInsertFrm;
		let sdate = form.sdateY.value + form.sdateM.value + form.sdateD.value;
		let edate = form.edateY.value + form.edateM.value + form.edateD.value;
		if ( parseInt(sdate) > parseInt(edate) ) {
			alert("시작일자와 종료일자를 확인해주세요.");
			form.sdateY.value = <%=today.getYear()%>;
			form.sdateM.value = 1;
			form.sdateD.value = 1;
			form.edateY.value = <%=today.getYear()%>;
			form.edateM.value = 1;
			form.edateD.value = 1;
		}
	}
	
	function checkInput() {
		let form = document.pollInsertFrm;
		let question = form.question;
		let item = form.item;
		let toggle = false;
		
		if ( question.value != "" ) {
			toggle = true;
		} else {
			alert("질문을 입력해주세요.");
			toggle = false
		}
		
		let count = 0;
		for ( let i=0 ; i < item.length ; i++ ) {
			if ( item[i].value != "" ) {
				count++;
			}
		}
		
		if ( count > 1 ) {
			toggle = true;
		}  else {
			alert("항목을 입력해주세요.");
			toggle = false;
		}
		
		return toggle;
	}
</script>
</head>
<body bgcolor="#FFFFCC">
	<div align="center">
		<br />
		<h2>투표프로그램</h2>
		<hr width="600" />
		<b>설문작성</b>
		<hr width="600" />
		<form name="pollInsertFrm" method="post" action="pollInsertProc.jsp" onsubmit="return checkInput();">
			<table border="1" width="500">
				<tr>
					<td><b>질문</b></td>
					<td colspan="2"><input name="question" size="30"></td>
				</tr>
				<tr>
					<td rowspan="10"><b>항목</b></td>
					<%
					for (int i = 1; i <= 4; i++) {
						out.println("<td>" + (i * 2 - 1) + ": <input name='item'></td>");
						out.println("<td>" + (i * 2) + ": <input name='item'></td>");
						out.println("</tr>");
						if (i == 9) {
							out.println("");
						} else {
							out.println("<tr>");
						}
					} //for end
					%>
				
				<tr>
					<td>시작일</td>
					<td colspan="2"><select name="sdateY" onchange="checkDate();">
							<option value="<%=today.getYear()%>"><%=today.getYear()%>
							<option value="<%=today.getYear() + 1%>"><%=today.getYear()+1%>
							
						</select>년 <select name="sdateM" onchange="monthCheck(this); checkDate();">
							<%
							for (int i = 1; i <= 12; i++) {
								out.println("<option value='" + i + "'>" + i);
							}
							%>
						</select>월 
						<select name='sdateD' onchange="checkDate();">
							<%
							for (int i = 1; i <= 31; i++) {
								out.println("<option value='" + i + "'>" + i);
							}
							%>
						</select> 일</td>
				</tr>
				<tr>
					<td>종료일</td>
					<td colspan=2><select name="edateY" onchange="checkDate();">
							<option value="<%=today.getYear()%>"><%=today.getYear()%>
							<option value="<%=today.getYear() + 1%>"><%=today.getYear()+1%>
							
						</select>년 <select name="edateM" onchange="monthCheck(this); checkDate();">
							<%
							for (int i = 1; i <= 12; i++) {
								out.println("<option value='" + i + "'>" + i);
							}
							%>
						</select>월 <select name="edateD" onchange="checkDate();">
							<%
							for (int i = 1; i <= 31; i++) {
								if ( i == 2 ) {
									out.println("<option value='" + i + "' selected>" + i);	
								} else {
									out.println("<option value='" + i + "'>" + i);
								}
							}
							%>
						</select>일</td>
				</tr>
				<tr>
					<td>복수투표</td>
					<td colspan=2><input type="radio" name="type" value="1"
							checked
						>yes <input type="radio" name="type" value="0">no</td>
				</tr>
				<tr>
					<td colspan=3><input type="submit" value="작성하기"> <input
							type="reset" value="다시쓰기"
						> <input type="button" value="리스트"
							onClick="javascript:location.href='pollList.jsp'"
						></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>