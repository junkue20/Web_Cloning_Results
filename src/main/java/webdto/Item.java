package webdto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Item {

	private long no;
	private String name;
	private String content;
	private long quantity;
	private long price;
	private Date regdate;
	
	private long imageNo; // 대표 이미지번호를 저장할 임시변수

}