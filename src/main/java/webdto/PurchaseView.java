package webdto;

import java.util.Date;

import lombok.Data;

@Data
public class PurchaseView {
	private long purchaseno; // 시퀀스 사용
	private long cnt;
	private String customerid; // DB에는 ID로 저장됨.
	private String name; // DB에는 NAME으로 저장됨.
	private long itemno;
	private String itemname;
	private long itemprice;
	private long totalpirce; // (itemprice * cnt)
	private Date purchRegdate; 
}