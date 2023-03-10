<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>studentDel.jsp</title>
	<style>
		h2,h4{
			text-align: center;
		}
		.delete{
			width:20px;
			margin-left: auto;
    		margin-right: auto;
		}
	</style>
</head>
<body>
	<h2>4. 학생 정보 삭제</h2>
	<h4>※ 지울 학생의 학번을 입력해주세요. 지운 후 복구는 안됩니다.</h4>
	<hr />
	
	<form method="POST" align="center">
	<fieldset>
		<legend>지울 학생 학번 입력</legend>
		<label for="stuid">학번</label>
		<input type="text" name="stuid" id="stuid">
		
		<br/>
		<div class="delete">
		<input type="hidden" name="command" value="delete" />
    	<input type="submit" value="삭제하기!" />
	</fieldset>
	</form>
	

</body>
</html>