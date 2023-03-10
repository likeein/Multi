<%@ page contentType="text/html; charset=UTF-8"
		import="model.*"%>

<%
	if(request.getMethod().equals("POST")) {
		request.setCharacterEncoding("UTF-8");
	}
%>

<jsp:useBean id="studentDAO" class="model.StudentDAO" scope="session" />
<jsp:useBean id="studentDO" class="model.StudentDO" scope="page" />
<jsp:useBean id="loginDO" class="model.StudentLoginDO" scope="page" />
<jsp:setProperty name="studentDO" property="*" />
<jsp:setProperty name="loginDO" property="*" />

<%
	String viewPath = "/WEB-INF/views/";
	String command = request.getParameter("command");
	
	if(session.getAttribute("id") == null){
		
		if(request.getMethod().equals("GET")){
			pageContext.forward(viewPath + "studentLogin.jsp");
		}else if(request.getMethod().equals("POST")){
			StudentLoginDO slDO = studentDAO.checkLogin(loginDO);
			
			if(slDO != null) {
				session.setAttribute("id", slDO.getId());
				session.setAttribute("name", slDO.getPasswd());
				
				response.sendRedirect("controller.jsp");
			}
			else {
				pageContext.forward(viewPath + "studentLogin.jsp");
			}
		}
	}else if(command != null && command.equals("end")){
		
		session.invalidate();
		response.sendRedirect("controller.jsp");
		
	}else if(command != null && command.equals("login")){
		
		pageContext.forward(viewPath + "studentList.jsp");
		
	}else if(command != null && command.equals("first")){
		
		pageContext.forward(viewPath + "studentInt.jsp");
		
		if(command != null && command.equals("insert")){
			studentDAO.insertStudent(studentDO);
			session.setAttribute("studentList", studentDAO.showStudent());
			pageContext.forward(viewPath + "studentList.jsp");
		}
		
	}else if(command != null && command.equals("second")){
		
		pageContext.forward(viewPath + "studentImpo.jsp");
		
		if(command != null && command.equals("showend")){
			session.setAttribute("studentList", studentDAO.showStudent());
			pageContext.forward(viewPath + "studentList.jsp");
		}
		
	}else if(command != null && command.equals("third")){
		
		pageContext.forward(viewPath + "studentModi.jsp");
		
		if(command != null && command.equals("modify")){
			studentDAO.modifyStudent(studentDO);
			session.setAttribute("studentList", studentDAO.showStudent());
			pageContext.forward(viewPath + "studentList.jsp");
		}
		
	}else if(command != null && command.equals("fourth")){
		
		pageContext.forward(viewPath + "studentDel.jsp");
		
		if(command != null && command.equals("delete")){
			studentDAO.deleteStudent(studentDO);
			session.setAttribute("studentList", studentDAO.showStudent());
			pageContext.forward(viewPath + "studentList.jsp");
		}
		
	}else{
		pageContext.forward(viewPath + "studentLogin.jsp");
	}
%>