package kr.accom.vo;

public class AccomFavVO {
	private int Accom_num;
	private int mem_num;
	
	public AccomFavVO() {}
	
	public AccomFavVO(int accom_num, int mem_num) {
		this.Accom_num = accom_num;
		this.mem_num = mem_num;
	}

	public int getAccom_num() {
		return Accom_num;
	}

	public void setAccom_num(int accom_num) {
		Accom_num = accom_num;
	}

	public int getMem_num() {
		return mem_num;
	}

	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	
	
	
}
