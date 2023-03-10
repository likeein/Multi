<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>studentImpo</title>
	<style>
		h2{
			text-align: center;
		}
		.showend{
			width:20px;
			margin-left: auto;
    		margin-right: auto;
		}
	</style>
</head>
<body>
	<h2>2. 학생 정보 조회</h2>
	<hr />
	
	<form method="POST">
	<table align="center">
		<tr><th>학번</th><th>이름</th><th>성별</th><th>국어점수</th><th>영어점수</th><th>수학점수</th><th>과학점수</th></tr>
			
		
		<c:forEach items="${studentList}" var="studentList">
			<tr>
			<td>${studentList.stuid}</td><td>${studentList.stuname}</td><td>${studentList.gender}</td>
			<td>${studentList.korea}</td><td>${studentList.english}</td><td>${studentList.math}</td><td>${studentList.science}</td>	
			</tr>
		</c:forEach>
	</table>
	
	<br/>
	<div class="showend">
		<input type="hidden" name="command" value="showend" />
    	<input type="submit" value="조회완료!" />
	</div>
	</form>
</body>
</html>