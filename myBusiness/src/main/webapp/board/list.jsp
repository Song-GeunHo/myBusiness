<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="board.BoardBean, java.util.*, java.util.regex.*"%>
<%@page import="java.util.Vector"%>
<jsp:useBean id="bMgr" class="board.BoardMgr" />
<%	
	  request.setCharacterEncoding("UTF-8");
	  
      int totalRecord=0; //전체레코드수
	  int numPerPage=10; // 페이지당 레코드 수 
	  int pagePerBlock=15; //블럭당 페이지수 
	  
	  int totalPage=0; //전체 페이지 수
	  int totalBlock=0;  //전체 블럭수 

	  int nowPage=1; // 현재페이지
	  int nowBlock=1;  //현재블럭
	  
	  int start=0; //디비의 select 시작번호
	  int end=10; //시작번호로 부터 가져올 select 갯수
	  
	  int listSize=0; //현재 읽어온 게시물의 수

	String keyWord = "", keyField = "";
	Vector<BoardBean> vlist = null;
	if (request.getParameter("keyWord") != null) {
		keyWord = request.getParameter("keyWord");
		keyField = request.getParameter("keyField");
	}
	if (request.getParameter("reload") != null){
		if(request.getParameter("reload").equals("true")) {
			keyWord = "";
			keyField = "";
		}
	}
	
	if (request.getParameter("nowPage") != null) {
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}
	 start = (nowPage * numPerPage)-numPerPage;
	 end = numPerPage;
	 
	totalRecord = bMgr.getTotalCount(keyField, keyWord);
	totalPage = (int)Math.ceil((double)totalRecord / numPerPage);  //전체페이지수
	nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock); //현재블럭 계산
	  
	totalBlock = (int)Math.ceil((double)totalPage / pagePerBlock);  //전체블럭계산
%>
<html>
<head>
<title>JSP Board</title>
<link href="../member/styles/style.css" rel="stylesheet" type="text/css">
<style>tr:first-child > * { color: #525252; }</style>
<script type="text/javascript">
	function list() {
		document.listFrm.action = "list.jsp";
		document.listFrm.submit();
	}
	
	function pageing(page) {
		document.readFrm.nowPage.value = page;
		document.readFrm.submit();
	}
	
	function block(value){
		 document.readFrm.nowPage.value=<%=pagePerBlock%>*(value-1)+1;
		 document.readFrm.submit();
	} 
	
	function checkPass(pass, num) {
		const input = prompt("비밀글 입니다.", "비밀번호를 입력해주세요");
		if ( input == pass ) {
			read(num);
		} else {
			alert("비밀번호가 일치하지 않습니다.");
		}
	}
	
	function read(num){
		document.readFrm.num.value=num;
		document.readFrm.action="read.jsp";
		document.readFrm.submit();
	}
	
	function check() {
	     if (document.searchFrm.keyWord.value == "") {
	   alert("검색어를 입력하세요.");
	   document.searchFrm.keyWord.focus();
	   return;
	     }
	  document.searchFrm.submit();
	 }
	
	function loginCheck() {
		<% if ( session.getAttribute("idKey") != null ) {%>
			location.href = "post.jsp";
		<%} else {%>
			alert("글쓰기 권한이 없습니다. 로그인 해주세요.");
		<%}%>
	}
</script>
</head>
<body bgcolor="#FFFFCC">
<div align="center">
	<br/>
	<a href="../member/login.jsp"><h1>JSPBoard</h1></a>
	<br/>
	<table align="center" width="600">
			<tr>
				<td style="color: white;">Total : <%=totalRecord%>Articles(<font color="#FFCC00">
				<%=nowPage%>/<%=totalPage%>Pages</font>)</td>
			</tr>
	</table>
	<table align="center" width="800" cellpadding="3">
		<tr>
			<td align="center" colspan="2">
			<%
				  vlist = bMgr.getBoardList(keyField, keyWord, start, end);
				  listSize = vlist.size();//브라우저 화면에 보여질 게시물갯수
				  if (vlist.isEmpty()) {
					out.println("등록된 게시물이 없습니다.");
				  } else {
			%>
				  <table width="100%" cellpadding="2" cellspacing="0">
					<tr align="center" bgcolor="#FFCC00" height="120%">
						<td>번 호</td>
						<td>제 목</td>
						<td>이 름</td>
						<td>날 짜</td>
						<td>조회수</td>
					</tr>
					<%
						  for (int i = 0;i<numPerPage; i++) {
							if (i == listSize) break;
							BoardBean bean = vlist.get(i);
							int num = bean.getNum();
							String name = bean.getName();
							String cname = "";			

							if ( name.length() < 3 ) {
								cname = name.charAt(0) + "*";
							} else {
								cname += name.charAt(0);
								for ( int k=1 ; k<name.length() ; k++ ) {
									cname += "*";
								}
								cname += name.charAt(name.length()-1);
							}					
							name = cname;
							
							String subject = bean.getSubject();
							String regdate = bean.getRegdate();
							int depth = bean.getDepth();
							int count = bean.getCount();
					%>
					<tr>
						<td align="center">
							<%if ( !bean.getPass().equals("") ) { %>
							<img src="icons/secret.png" width="20" height="20">
							<%} else {%>
							<img style="visibility:hidden;"width="20" height="20">
							<%} %>
							<%=totalRecord-((nowPage-1)*numPerPage)-i%>
						</td>
						<td>
						<%
							  if(depth>0){
								for(int j=0;j<depth;j++){
									out.println("&nbsp;&nbsp;");
									}
								}
						%>
						<%
								boolean deleted = false;
								ArrayList<Boolean> deletedBoard = null;
								if ( session.getAttribute("deletedBoard") != null ) {
									 deletedBoard= (ArrayList<Boolean>) session.getAttribute("deletedBoard");

									 if ( deletedBoard.contains(bean.getNum()) ) {
										deleted = true;
									 }
								}
						%>
						<%
								if( !deleted ) {
									String str = "";
									String pass = bean.getPass();
									boolean secret = pass.length()!=0;
									if ( secret ) {
										str = "javascript:checkPass('"+pass+"',"+num+")";
									} else {
										str = "javascript:read("+num+")";
									}
						%>
										<a href= <%=str %>><%=subject%></a>
						<%	} else{%>
										<font color="red"><del><%=subject%></del></font>
						<%	} %>
						</td>
						<td align="center"><%=name%></td>
						<td align="center"><%=regdate%></td>
						<td align="center"><%=count%></td>
						</tr>
					<%}//for%>
				</table> <%
 			}//if
 		%>
			</td>
		</tr>
		<tr>
			<td colspan="2"><br /><br /></td>
		</tr>
		<tr>
			<td>
			<!-- 페이징 및 블럭 처리 Start--> 
			<%
   				  int pageStart = (nowBlock -1)*pagePerBlock + 1 ; //하단 페이지 시작번호
   				  int pageEnd = ((pageStart + pagePerBlock ) <= totalPage) ?  (pageStart + pagePerBlock): totalPage+1; 
   				  //하단 페이지 끝번호
   				  if(totalPage !=0){
    			  	if (nowBlock > 1) {%>
    			  		<a href="javascript:block('<%=nowBlock-1%>')">prev...</a><%}%>&nbsp; 
    			  		<%for ( ; pageStart < pageEnd; pageStart++){%>
     			     	<a href="javascript:pageing('<%=pageStart %>')"> 
     					<%if(pageStart==nowPage) {%><font color="#0077FF"> <%}%>
     					[ <%=pageStart %> ] 
     					<%if(pageStart==nowPage) {%></font> <%}%></a> 
    					<%}//for%>&nbsp; 
    					<%if (totalBlock > nowBlock ) {%>
    					<a href="javascript:block('<%=nowBlock+1%>')">.....next</a>
    				<%}%>&nbsp;  
   				<%}%>
 				<!-- 페이징 및 블럭 처리 End-->
				</td>
				<td align="right">
					<a href="javascript:loginCheck()">[글쓰기]</a> 
					<a href="javascript:list()">[처음으로]</a>
				</td>
			</tr>
		</table>
	<hr width="800"/>
	<form  name="searchFrm"  method="get" action="list.jsp">
	<table width="800" cellpadding="4" cellspacing="0">
 		<tr>
  			<td align="center" valign="bottom">
   				<select name="keyField" size="1" style="width: 80px; height: 30px; text-align: center; font-size: 14px;">
    				<option value="name"> 이 름</option>
    				<option value="subject"> 제 목</option>
    				<option value="content"> 내 용</option>
   				</select>
   				<input size="16" name="keyWord" style="height: 30px; font-size: 14px;">
   				<input type="button"  value="찾기" style="cursor: pointer; background-color: white; border-radius: 5px; width: 50px; height: 30px; text-align: center; font-size: 14px;" onClick="javascript:check()">
   				<input type="hidden" name="nowPage" value="1">
  			</td>
 		</tr>
	</table>
	</form>
	<form name="listFrm" method="post">
		<input type="hidden" name="reload" value="true"> 
		<input type="hidden" name="nowPage" value="1">
	</form>
	<form name="readFrm" method="get">
		<input type="hidden" name="num"> 
		<input type="hidden" name="nowPage" value="<%=nowPage%>"> 
		<input type="hidden" name="keyField" value="<%=keyField%>"> 
		<input type="hidden" name="keyWord" value="<%=keyWord%>">
	</form>
</div>
</body>
</html>