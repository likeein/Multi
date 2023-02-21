package cho_ahin;

public class StuData {

	String ID; // 학번
	String name; //이름 
	String gender; //성별
	int korea; //국어 점수
	int english; //영어 점수
	int math; //수학 점수
	int science; //과학 점수
	
	StuData(String ID, String name, String gender, int korea, int english, int math, int science){
		
		this.ID = ID;
		this.name = name;
		this.gender = gender;
		this.korea = korea;
		this.english = english;
		this.math = math;
		this.science = science;
	}
	
	public String getID() { //학번 가져오기
		return ID;
	}
	
	public String getname() { //이름 가져오기
		return name;
	}
	
	public String getgender() { //성별 가져오기
		return gender;
	}
	
	public int getkorea() { //국어 점수 가져오기
		return korea;
	}
	
	public void setkorea(int korea) { // 국어 점수 바꾸기
		this.korea = korea;
	}
	
	public int getenglish() { //영어 점수 가져오기
		return english;
	}
	
	public void setenglish(int english) { // 영어 점수 바꾸기
		this.english = english;
	}
	
	public int getmath() { //수학 점수 가져오기
		return math;
	}
	
	public void setmath(int math) { // 수학 점수 바꾸기
		this.math = math;
	}
	
	public int getscience() { //과학 점수 가져오기
		return science;
	}
	
	public void setscience(int science) { // 과학 점수 바꾸기
		this.science = science;
	}
}
