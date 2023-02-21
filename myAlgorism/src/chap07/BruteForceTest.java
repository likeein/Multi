package chap07;

public class BruteForceTest {

	public static void main(String[] args) {
		String text = "ABABCDEFGHA";
		String pattern = "ABC";
		
		for(int i=0; i<text.length() - pattern.length(); i++) {
			
			boolean isEqual = true;
			
			for(int j=i; j< i +pattern.length(); j++) {
				if(text.charAt(j) != pattern.charAt(j - i)) {
					isEqual = false;
					break;
				}
			}
			
			if(isEqual) {
				System.out.println((i + 1) + "번째 위치에서 패턴과 동일한 문자열 발견 !");
				break;
			}
		}
	}
}
