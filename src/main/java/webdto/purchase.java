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
public class purchase {
	private long no; // 시퀀스 사용
	private long cnt;
	private long itemno;
	private String customerid;
	private Date regdate; // 자동으로 들어감.

}