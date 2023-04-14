package webdto;

import java.util.Date;

import lombok.Data;

@Data
public class PurchaseView {
	private long no; // 시퀀스 사용
	private long cnt;
	private String customerid; // DB에는 ID로 저장됨.
	private String customername; // DB에는 NAME으로 저장됨.
	private long itemno;
	private String itemname;
	private long itemprice;
	private long totalpirce;
	private Date purchRegdate; 
}