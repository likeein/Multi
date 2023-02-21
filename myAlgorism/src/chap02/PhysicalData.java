package chap02;

public class PhysicalData {

	String name;            // 이름
    int    height;          // 키
    double vision;          // 시력

    //--- 생성자(constructor) ---//
    PhysicalData(String name, int height, double vision) {
        this.name     = name;
        this.height = height;
        this.vision = vision;
    }
        
}
