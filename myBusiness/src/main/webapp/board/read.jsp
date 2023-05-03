<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="board.BoardBean"%>
<jsp:useBean id="bMgr" class="board.BoardMgr" />
<%
	  request.setCharacterEncoding("UTF-8");
	  int num = Integer.parseInt(request.getParameter("num"));
	  String nowPage = request.getParameter("nowPage");
	  String keyField = request.getParameter("keyField");
	  String keyWord = request.getParameter("keyWord");
	  bMgr.upCount(num);//조회수 증가
	  BoardBean bean = bMgr.getBoard(num);//게시물 가져오기
	  String name = bean.getName();
	  String subject = bean.getSubject();
      String regdate = bean.getRegdate();
	  String content = bean.getContent();
	  String filename = bean.getFilename();
	  int filesize = bean.getFilesize();
	  String ip = bean.getIp();
	  int count = bean.getCount();
	  boolean secret = bean.getPass().length()!=0;
	  session.setAttribute("bean", bean);//게시물을 세션에 저장
%>
<html>
<head>
<title>JSP Board</title>
<link href="../member/styles/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function list(){
	    document.listFrm.submit();
	 } 
	
	function down(filename){
		 document.downFrm.filename.value=filename;
		 document.downFrm.submit();
	}
	
	function loginCheck(action) {
		const url = action.getAttribute("data-value");
		
		<% if ( session.getAttribute("idKey") != null ) {%>
			location.href = url;
		<%} else {%>
			alert("글쓰기 권한이 없습니다. 로그인 해주세요.");
		<%}%>
	}
</script>
</head>
<body bgcolor="#FFFFCC">
<br/><br/>
<table align="center" width="800" cellspacing="3">
 <tr>
  <td bgcolor="#FFCC00" height="25" align="center"><font color=#525252>글읽기</font></td>
 </tr>
 <tr>
  <td colspan="2">
   <table cellpadding="3" cellspacing="0" width="100%"> 
    <tr> 
  <td align="center" bgcolor="#AACC00" width="10%"><font color=#525252 size="4"> 이 름 </font></td>
  <td><%=name%></td>
  <td align="center" bgcolor="#AACC00" width="10%"><font color=#525252 size="4"> 등록날짜 </font></td>
  <td><%=regdate%></td>
 </tr>
 <tr> 
    <td align="center" bgcolor="#AACC00"><font color=#525252 size="4"> 제 목 </font></td>
    <td colspan="3"><%=subject%></td>
   </tr>
   <tr> 
     <td align="center" bgcolor="#AACC00"><font color=#525252 size="4"> 첨부파일 </font></td>
     <td colspan="3">
     <% if( filename !=null && !filename.equals("")) {%>
  		<a href="javascript:down('<%=filename%>')"><%=filename%></a>
  		 &nbsp;&nbsp;<font color="blue">(<%=filesize%>KBytes)</font>  
  		 <%} else{%> 등록된 파일이 없습니다.<%}%>
     </td>
   </tr>
   <tr> 
    <td colspan="4"><br/><pre><%=content%></pre><br/></td>
   </tr>
   <tr>
    <td colspan="4" align="right">
     <%=ip%>로 부터 글을 남기셨습니다./  조회수  <%=count%>
    </td>
   </tr>
   </table>
  </td>
 </tr>
 <tr>
  <td align="center" colspan="2"> 
 <hr/>
 [ <a href="javascript:list()">리스트</a> | 
 <a href="#" onclick="loginCheck(this);" data-value="update.jsp?nowPage=<%=nowPage%>&num=<%=num%>">수 정</a> |
 <a href="#" onclick="loginCheck(this);" data-value="reply.jsp?nowPage=<%=nowPage%>" >답 변</a> | 
 <a href="#" onclick="loginCheck(this);" data-value="delete.jsp?nowPage=<%= nowPage%>&num=<%=num%>&secret=<%=secret%>">삭 제</a> ]<br/>
  </td>
 </tr>
</table>

<form name="downFrm" action="download.jsp" method="post">
	<input type="hidden" name="filename">
</form>

<form name="listFrm" method="post" action="list.jsp">
	<input type="hidden" name="nowPage" value="<%=nowPage%>">
	<%if(!(keyWord==null || keyWord.equals(""))){ %>
	<input type="hidden" name="keyField" value="<%=keyField%>">
	<input type="hidden" name="keyWord" value="<%=keyWord%>">
	<%}%>
</form>
</body>
</html>