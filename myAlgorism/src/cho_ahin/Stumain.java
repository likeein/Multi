package cho_ahin;

import java.util.Scanner;

public class Stumain {

	public static void main(String[] args) {
		
		Scanner sc = new Scanner(System.in);
		StuController Stucon = new StuController();
		
		while(true) {
			System.out.println("### 학생 성적 관리 프로그램 ###");
			System.out.println("1. 학생 정보 입력");
			System.out.println("2. 학생 정보 조회");
			System.out.println("3. 성적 변경");
			System.out.println("4. 학생 정보 삭제");
			System.out.println("5. 프로그램 종료");
			System.out.println(">>>");
		
			int key = sc.nextInt();

		
			if(key == 1) {
				Stucon.StuInput();
			}else if(key == 2) {
				Stucon.Stusearch();
			}else if(key == 3) {
				Stucon.Stumodify();
			}else if(key == 4) {
				Stucon.Studelete();
			}else if(key == 5) {
				System.out.println("프로그램이 종료되었습니다.");
				break;
			}else {
				System.out.println("원하시는 메뉴의 숫자를 다시 입력해주세요.");
			}
		}

	}

}
