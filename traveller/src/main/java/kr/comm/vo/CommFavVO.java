package kr.comm.vo;

public class CommFavVO {
	private int comm_num;
	private int mem_num;
	
	public CommFavVO() {}
	
	public CommFavVO(int comm_num, int mem_num) {
		this.comm_num = comm_num;
		this.mem_num = mem_num;
	}
	public int getComm_num() {
		return comm_num;
	}
	public void setComm_num(int comm_num) {
		this.comm_num = comm_num;
	}
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
}
