package chap03;

public class BinarySearchExam {

	int binarySerach(int [] arr, int key) {
		
		int result = -1;
		int pl, pr, pc;
		
		pl = 0;
		pr = arr.length - 1;
		
		while(true) {
			
			pc = (pl + pr) / 2;
			
			System.out.println("pl: " + pl+ "pr: " + pr + "pc: " + pc + "arr[" + pc + "]: " + arr[pc]);
			
			if(arr[pc] == key) {
				result = pc;
				break;
			}
			else if(arr[pc] < key) {
				pl = pc + 1;
			}
			else {
				pr = pc - 1;
			}
			
			if(pl > pr) {
				break;
			}
		}
		
		return result;
	}
	
	public static void main(String[] args) {
		
		int [] arr = {5, 7, 15, 28, 29, 31, 39, 58, 68, 70, 95};
		int key = 39;
		BinarySearchExam exam = new BinarySearchExam();
		
		System.out.println();
	}

}
