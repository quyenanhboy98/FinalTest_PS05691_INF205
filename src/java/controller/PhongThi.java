package controller;


public class PhongThi {
	private String MP="",TinhChatPhong="",Note="";
	private int SucChua=0;
	public PhongThi(){}
	public PhongThi(String MP,int SucChua,String TinhChatPhong,String Note){
		this.MP = MP;
		this.SucChua = SucChua;
		this.TinhChatPhong = TinhChatPhong;
		this.Note = Note;
	}
	public String getMP() {
		return MP;
	}
	public void setMP(String mP) {
		MP = mP;
	}
	public String getTinhChatPhong() {
		return TinhChatPhong;
	}
	public void setTinhChatPhong(String tinhChatPhong) {
		TinhChatPhong = tinhChatPhong;
	}
	public String getNote() {
		return Note;
	}
	public void setNote(String note) {
		Note = note;
	}
	public int getSucChua() {
		return SucChua;
	}
	public void setSucChua(int sucChua) {
		SucChua = sucChua;
	}
	
}
