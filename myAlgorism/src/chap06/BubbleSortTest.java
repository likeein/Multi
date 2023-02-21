package chap06;

import java.util.Arrays;

public class BubbleSortTest {

	public void swap(int [] arr, int idx1, int idx2) {
		int temp;
		temp = arr[idx1];
		arr[idx1] = arr[idx2];
		arr[idx2] = temp;
	}
	
	public void bubblesort1(int [] arr) {
		int lastIdx = arr.length - 1;
		
		for(int i=0; i < lastIdx; i++) {
			for(int j = lastIdx; j>i; j--) {
				if(arr[j -1] > arr[j]) {
					this.swap(arr, j - 1, j);
				}
			}
		}
	}
	
	public void bubblesort2(int [] arr) {
		
		int lastIdx = arr.length - 1;
		
		for(int i=0; i < lastIdx; i++) {
			int SwapCont = 0;
			
			for(int j = lastIdx; j>i; j--) {
				if(arr[j -1] > arr[j]) {
					this.swap(arr, j - 1, j);
					SwapCont ++;
				}
			}
			
			if(SwapCont == 0) {
				break;
			}
		}
	}
	
	public static void main(String[] args) {
		
		int [] arr = {1, 6, 4, 3, 7, 8, 9};
		BubbleSortTest test = new BubbleSortTest();
		
		//버블정렬를 이용하여 arr 베열을 정렬하는 코드를 작성하세요.
		//System.out.println(Arrays.toString(arr));
		test.bubblesort1(arr);
		test.bubblesort2(arr);

	}

}
