package cho_ahin;

import java.util.ArrayList;
import java.util.Scanner;

public class StuController {

	Stumain main = new Stumain();
	ArrayList<StuData> list = new ArrayList();
	StuData data;
	Scanner sc = new Scanner(System.in);
	String ID; // 학번
	String name; //이름 
	String gender; //성별
	int korea; //국어 점수
	int english; //영어 점수
	int math; //수학 점수
	int science; //과학 점수
	
	// 학생 정보 입력 
	void StuInput() {
		
		System.out.println("### 학생 정보 입력 ###");
		System.out.println("1. 학번: ");
		ID = sc.next();
		System.out.println("2. 이름: ");
		name = sc.next();
		System.out.println("3. 성별: ");
		gender = sc.next();
		System.out.println("4. 국어 점수: ");
		korea = sc.nextInt();
		System.out.println("5. 영어 점수: ");
		english = sc.nextInt();
		System.out.println("6. 수학 점수: ");
		math = sc.nextInt();
		System.out.println("7. 과학 점수: ");
		science = sc.nextInt();
		
		System.out.println("정보 입력을 다 하셨으면 0을 입력해주세요.");
		System.out.println(">>>");
		int key = sc.nextInt();
		if(key == 0) {
			list.add(new StuData(ID, name, gender, korea, english, math, science));
			System.out.println("정보 저장 완료 !! 초기 화면으로 돌아갑니다.");;
		}
		
	}
	
	// 학생 정보 조회
	void Stusearch() {
		
		System.out.println("찾으실 학생의 이름 또는 학번을 입력해주세요. : ");
		
		String findkey = sc.next();
		
		for(int i = 0; i<list.size(); i++) {
			
			if(findkey.equals(list.get(i).getID()) || findkey.equals(list.get(i).getname())) {
				System.out.println("학번: " + list.get(i).getID() + "\n"
						+ "이름: " + list.get(i).getname() + "\n"
						+ "성별: " + list.get(i).getgender() + "\n"
						+ "국어 점수: " + list.get(i).getkorea() + "\n"
						+ "영어 점수: " + list.get(i).getenglish() + "\n"
						+ "수학 점수: " + list.get(i).getmath() + "\n"
						+ "과학 점수: " + list.get(i).getscience() + "\n");
			}
		}
		
		System.out.println("정보 조회가 완료되어었으면 0을 입력해주세요");
		System.out.println(">>>");
		int key = sc.nextInt();
		if(key == 0) {
			System.out.println("정보 조회 완료 !! 초기 화면으로 돌아갑니다.");;
		}
		
	}
	
	// 성적 변경
	void Stumodify() {
		
		System.out.println("수정하실 학생의 이름 또는 학번을 입력해주세요. : ");
		String modifykey = sc.next();
		
		for(int i=0; i<list.size(); i++) {
			
			if(modifykey.equals(list.get(i).getID()) || modifykey.equals(list.get(i).getname())){
				
				System.out.println("수정하고 싶은 과목의 버튼을 눌러주세요.");
				System.out.println("1. 국어:" + list.get(i).getkorea());
				System.out.println("2. 영어:" + list.get(i).getenglish());
				System.out.println("3. 수학:" + list.get(i).getmath());
				System.out.println("4. 과학:" + list.get(i).getscience());
				System.out.println(">>>");
				
				int key = sc.nextInt();
				
				if(key == 1) {
					list.get(i).setkorea(sc.nextInt());
				}else if(key == 2) {
					list.get(i).setenglish(sc.nextInt());
				}else if(key == 3) {
					list.get(i).setmath(sc.nextInt());
				}else if(key == 4) {
					list.get(i).setscience(sc.nextInt());
				}else {
					System.out.println("숫자를 잘못입력하셨습니다. 다시 시도 해주세요.");
				}
				
				System.out.println("수정을 완료하셨다면 0를 입력해주세요.");
				System.out.println(">>>");
				key = sc.nextInt();
				if(key == 0) {
					System.out.println("성적 변경 완료 !!");
					System.out.println("학번: " + list.get(i).getID() + "\n"
							+ "이름: " + list.get(i).getname() + "\n"
							+ "성별: " + list.get(i).getgender() + "\n"
							+ "국어 점수: " + list.get(i).getkorea() + "\n"
							+ "영어 점수: " + list.get(i).getenglish() + "\n"
							+ "수학 점수: " + list.get(i).getmath() + "\n"
							+ "과학 점수: " + list.get(i).getscience() + "\n");
					break;
				}
			}
		}
	}
	
	// 학생 정보 삭제
	void Studelete() {
		
		System.out.println("삭제하실 학생의 이름 또는 학번을 입력해주세요. :");
		String deletekey = sc.next();
		
		for(int i = 0; i < list.size(); i++) {
			
			if(deletekey.equals(list.get(i).getID()) || deletekey.equals(list.get(i).getname())) {
				
				System.out.println("삭제하실 학생의 정보가 맞는지 확인해주세요.");
				System.out.println("학번: " + list.get(i).getID() + "\n"
						+ "이름: " + list.get(i).getname() + "\n"
						+ "성별: " + list.get(i).getgender() + "\n"
						+ "국어 점수: " + list.get(i).getkorea() + "\n"
						+ "영어 점수: " + list.get(i).getenglish() + "\n"
						+ "수학 점수: " + list.get(i).getmath() + "\n"
						+ "과학 점수: " + list.get(i).getscience() + "\n");
				
				System.out.println("\n 이 학생의 정보 삭제를 원하신다면 학생의 학번을 입력해주세요.");
				System.out.println(">>>");
				String deleteStu = sc.next();
				
				for(StuData data : list) {
					if(data.getID().equals(deleteStu)) {
						list.remove(data);
						System.out.println("성공적으로 삭제 완료 !!");
						break;
					}
				}
			}
		}
	}
	
}
