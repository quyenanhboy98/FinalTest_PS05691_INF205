package controller;


public class MonHoc {
	private String MaMH,Lop,MSSV;
	private String TenMH,Nhom,Ten,mail;
	private String To,Ho;
	private String thigiuaki;
	public String getThigiuaki() {
		return thigiuaki;
	}
	public void setThigiuaki(String thigiuaki) {
		this.thigiuaki = thigiuaki;
	}
	public MonHoc(){}
	public MonHoc(String MaMH,String TenMH,String Nhom,String To,String Lop,String MSSV,String Ho,String Ten,String mail,String thigiuaki){
		this.MaMH = MaMH;
		this.TenMH = TenMH;
		this.Nhom = Nhom;
		this.To = To;
		this.Lop = Lop;
		this.MSSV = MSSV;
		this.Ho = Ho;
		this.Ten = Ten;
		this.mail = mail;
		this.thigiuaki = thigiuaki;
	}
	public String getMaMH() {
		return MaMH;
	}
	public void setMaMH(String maMH) {
		MaMH = maMH;
	}
	public String getLop() {
		return Lop;
	}
	public void setLop(String lop) {
		Lop = lop;
	}
	public String getMSSV() {
		return MSSV;
	}
	public void setMSSV(String mSSV) {
		MSSV = mSSV;
	}
	public String getTenMH() {
		return TenMH;
	}
	public void setTenMH(String tenMH) {
		TenMH = tenMH;
	}
	public String getNhom() {
		return Nhom;
	}
	public void setNhom(String nhom) {
		Nhom = nhom;
	}
	public String getTen() {
		return Ten;
	}
	public void setTen(String ten) {
		Ten = ten;
	}
	public String getTo() {
		return To;
	}
	public void setTo(String to) {
		To = to;
	}
	public String getHo() {
		return Ho;
	}
	public void setHo(String ho) {
		Ho = ho;
	}
	public String getMail() {
		return mail;
	}
	public void setMail(String mail) {
		this.mail = mail;
	}
}
