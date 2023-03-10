<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>studentList.jsp</title>
	<style>
		h2,h3{
			text-align: center;
		}
		.parent{
			width: 80%;
    		margin-left: auto;
    		margin-right: auto;
		}
		.first {
    		border: 1px solid;
    		width:30%;
    		box-sizing: border-box;
    		text-align: center;
    		font-size: 20px;
    		margin-left: auto;
    		margin-right: auto;
		}

		.second{
   		 	border: 1px solid;
    		width:30%;
    		box-sizing: border-box;
    		text-align: center;
    		font-size: 20px;
    		margin-left: auto;
    		margin-right: auto;
		}

		.third{
    		border: 1px solid;
			width:30%;
    		box-sizing: border-box;
    		text-align: center;
    		font-size: 20px;
    		margin-left: auto;
    		margin-right: auto;
		}
		.fourth{
    		border: 1px solid;
			width:30%;
    		box-sizing: border-box;
    		text-align: center;
    		font-size: 20px;
    		margin-left: auto;
    		margin-right: auto;
		}
		.end{
			width:20px;
			margin-left: auto;
    		margin-right: auto;
		}
	</style>
</head>
<body>
	<h3>"${name}" 선생님 반갑습니다.</h3>
	<h2>※원하시는 메뉴를 클릭해주세요.</h2>
	<br />
	
	<div class="parent">
        <div class="first">
        	<input type="hidden" name="command" value="first" />
    		<input type="submit" value="1. 학생 정보 입력" />
        </div>
        <div class="second">
        	<input type="hidden" name="command" value="second" />
    		<input type="submit" value="2. 학생 정보 조회" />
        </div>
        <div class="third">
        	<input type="hidden" name="command" value="third" />
    		<input type="submit" value="3. 학생 성적 변경" />
        </div>
        <div class="fourth">
        	<input type="hidden" name="command" value="fourth" />
    		<input type="submit" value="4. 학생 정보 삭제" />
        </div>
    </div>
    
    <br/>
    <div class="end">
    	<input type="hidden" name="command" value="end" />
    	<input type="submit" value="종료" />
    </div> 
</body>
</html>