<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="member.MemberBean"%>
<jsp:useBean id="mMgr" class="member.MemberMgr"/>
<%
		request.setCharacterEncoding("UTF-8");
		String id = (String) session.getAttribute("idKey");
		MemberBean mBean = mMgr.getMember(id);
		String	name = mBean.getName();
%>
<html>
<head>
<title>JSP Board</title>
<link href="../member/styles/style.css" rel="stylesheet" type="text/css">
<style>td{padding: 10px;} tr:last-child>td>input{background-color:white; border-radius:5px; height:30px; font-weight:500;} tr:last-child>td>input:hover{opacity:0.8;}</style>
</head>
<body bgcolor="#FFFFCC">
<div align="center">
<br/><br/>
<table width="600" cellpadding="3">
	<tr>
		<td bgcolor="FFCC00" height="25" align="center">글쓰기</td>
	</tr>
</table>
<br/>
<form name="postFrm" method="post" action="boardPost" enctype="multipart/form-data">
<input type="hidden" name="name" value="<%=name %>">
<table width="800" cellpadding="3" align="center">
	<tr>
		<td align=center>
		<table align="center">
			<tr>
				<td width="20%">제 목</td>
				<td width="70%">
				<input style="height:35px;" name="subject" size="50" maxlength="30" required></td>
			</tr>
			<tr>
				<td>내 용</td>
				<td><textarea name="content" rows="10" cols="50" required></textarea></td>
			</tr>
			<tr>
				<td>비밀 번호</td>
				<td><input style="height:35px;" type="password" name="pass" size="15" maxlength="15"></td>
			</tr>
			<tr>
			 <tr>
     			<td>파일찾기</td> 
     			<td><input style="height:35px; line-height:35px; background-color:#131921; border:none; color:white;" type="file" name="filename" size="50" maxlength="50"></td>
    		</tr>
 			<tr>
 				<td>내용타입</td>
 				<td> HTML<input type=radio name="contentType" value="HTTP" >&nbsp;&nbsp;&nbsp;
  			 	TEXT<input type=radio name="contentType" value="TEXT" checked>
  			 	</td>
 			</tr>
			<tr>
				<td colspan="2"><hr/></td>
			</tr>
			<tr>
				<td colspan="2" style="text-align: right;">
					 <input type="submit" value="등록">
					 <input type="reset" value="다시쓰기">
					 <input type="button" value="리스트" onClick="javascript:location.href='list.jsp'">
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<input type="hidden" name="ip" value="<%=request.getRemoteAddr()%>">
</form>
</div>
</body>
</html>