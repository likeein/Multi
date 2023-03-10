<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>studentModi.jsp</title>
	<style>
		h2, h4{
			text-align: center;
		}
		.modify{
			width:20px;
			margin-left: auto;
    		margin-right: auto;
		}
	</style>
</head>
<body>
	<h2>3. 학생 성적 변경</h2>
	<h4>※ 바꿀 학생의 정보를 다시 입력해주세요.</h4>
	<hr />
	
	<form method="POST" align="center">
	<fieldset>
		<legend>학생 성적 입력</legend>
		<label for="stuid">학번</label>
		<input type="text" name="stuid" id="stuid">
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
	<div class="modify">
		<input type="hidden" name="command" value="modify" />
    	<input type="submit" value="수정하기!" />
	</div>
</body>
</html>