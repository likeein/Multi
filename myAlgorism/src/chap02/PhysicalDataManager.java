package chap02;

public class PhysicalDataManager {

	static final int VMAX = 21;
	PhysicalData[] x;
	int[] vdist;
	
	PhysicalDataManager(PhysicalData[] x){
		this.x = x;
		this.vdist = new int[PhysicalDataManager.VMAX];
		this.distVision();                                    // 시력의 분포를 구함
	}
	
	//--- 키의 평균값을 구함 ---//
    double aveHeight() {
        double sum = 0;

        for (int i = 0; i < this.x.length; i++) {
        	
        	sum += this.x[i].height;
        }
            
        return sum / this.x.length;
    }

    //--- 시력의 분포를 구함 ---//
    void distVision() {
    	
        for (int i = 0; i < this.x.length; i++) {
        	if (this.x[i].vision >= 0.0 && this.x[i].vision <= VMAX / 10.0) {
            	this.vdist[(int)(this.x[i].vision * 10)]++;
            }
        }
       
    }
}
