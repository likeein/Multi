<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>studentInt.jsp</title>
	<style>
		h2{
			text-align: center;
		}
		.insert{
			width:20px;
			margin-left: auto;
    		margin-right: auto;
		}
	</style>
</head>
<body>
	<h2>1. 학생 정보 입력</h2>
	<hr />
	
	<form method="POST" align="center">
	<fieldset>
		<legend>학생 정보 입력</legend>
		<label for="stuid">학번</label>
		<input type="text" name="stuid" id="stuid">
		<ladel for="stuname">이름</ladel>
		<input type="text" name="stuname" id="stuname">
		<ladel for="gender">성별</ladel>
		<input type="text" name="gender" id="gender">
		<ladel for="korea">국어 점수</ladel>
		<input type="number" name="korea" id="korea">
		<ladel for="english">영어 점수</ladel>
		<input type="number" name="english" id="english">
		<ladel for="math">수학 점수</ladel>
		<input type="number" name="math" id="math">
		<ladel for="science">과학 점수</ladel>
		<input type="number" name="science" id="science">
	</fieldset>
	</form>
	
	<br/>
	<div class="insert">
		<input type="hidden" name="command" value="insert" />
    	<input type="submit" value="저장하기!" />
	</div>
</body>
</html>