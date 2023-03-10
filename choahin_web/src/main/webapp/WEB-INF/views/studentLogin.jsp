<%@ page contentType="text/html; charset=UTF-8" import="model.*"%>

<jsp:useBean id="studentDAO" class="model.StudentDAO" scope="session" />
<jsp:useBean id="loginDO" class="model.StudentLoginDO" scope="page" />
<jsp:setProperty name="loginDO" property="*" />

<%
	if(request.getMethod().equals("POST")) {
		StudentLoginDO result = studentDAO.checkLogin(loginDO);
		if(result != null) {
			session.setAttribute("id", result.getId());
			session.setAttribute("name", result.getName());
			
			response.sendRedirect("studentList.jsp");
		}
	}
%>


<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>StudentLogin.jsp</title>
	<style>
		h1,h3{
			text-align: center;
		}		
		form{
			text-align: center;
			border-width: 2px;
			font-size: 20px;
		}
	</style>
</head>
<body>
	<h1>학생 성적 관리 프로그램</h1>
	<hr />
	
	<form method="post">
	<fieldset>
		<legend>관리자 로그인</legend>
		<label for="id">ID</label>
		<input type="text" name="id" id="id" /> /
		<label for="passwd">Passwd</label>
		<input type="password" name="passwd" id="passwd" />
		<input type="hidden" name="command" value="login" />
		<input type="submit" value="login" />
	</fieldset>
	</form>
	<br/>
	
	<h3>※관리자 계정으로만 로그인 가능합니다.</h3>
</body>
</html>