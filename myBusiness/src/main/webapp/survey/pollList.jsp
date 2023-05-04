<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="survey.*,java.util.Vector, java.time.LocalDate"%>
<jsp:useBean id="pMgr" class="survey.PollMgr" />
<%! LocalDate today = LocalDate.now(); %>
<html>
<head>
<title>JSP Poll</title>
<link href="../member/styles/style.css"rel="stylesheet" type="text/css">
<style>#surveyForm {min-height: 170;}</style>
</head>
<body>
	<div align="center">
		<br/>
		<h1>투표프로그램</h1>
		<hr width="600"/>
		<div id="surveyForm" style="padding: 10px 0; width: 600;">
			<h2><b>설문폼</b></h2>
			<!--폴 리스트 폼 자리-->
			<jsp:include page="pollForm.jsp" />
		<hr width="600"/>
		<b>설문리스트</b>
		<!--폴 리스트 테이블 자리-->
		<table>
			<tr>
				<td>
					<table width="700" border="1">
						<tr bgColor="#FFCC00" align="center">
							<td align="center"><b>번호</b></td>
							<td><b>제목</b></td>
							<td><b>시작일~종료일</b></td>
						</tr>
						<%
							  Vector<PollListBean> vlist = pMgr.getAllList();

							  int count = vlist.size();
							  for (int i = 0; i < vlist.size(); i++) {
								PollListBean plBean = vlist.get(i);
								int num = plBean.getNum();
								String question = plBean.getQuestion();
								String sdate = plBean.getSdate();
								String edate = plBean.getEdate();

								out.println("	<tr><td align='center'>" + count + "</td>");
								out.println("<td><a href='pollList.jsp?num=" + num + "'>"
										+ question + "</a></td>");
								out.println("<td>" + sdate +" ~ "+ edate + "</td></tr>");
								count = count - 1;
							}
						%>
					</table>
				</td>
			</tr>
			<tr>
				<td align="right"><a href="pollInsert.jsp">설문 작성하기</a></td>
			</tr>
		</table>
	</div>
</body>
</html>