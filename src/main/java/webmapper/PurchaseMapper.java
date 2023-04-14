package webmapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import webdto.Purchase;
import webdto.PurchaseView;

@Mapper
public interface PurchaseMapper {

	// 주문 등록
	@Insert ( value = { 
			"	INSERT INTO purchase( cnt, itemno, customerid)	",
			"	VALUES(  #{obj.cnt}, #{obj.itemno}, #{obj.customerid}  )	" 
			} )
	public int insertPurchase(@Param("obj") Purchase obj);
	
//	-------------------------------------------------------------------------
	
	// 현재 로그인한 사용자가 주문한 내역 조회
	@Select ( value = {
				"	SELECT * FROM PURCHASE	",
				"	WHERE customerid =#{id}	"
			} )
	public List<Purchase> selectPurchaseMember(@Param("id") String id);
//	-------------------------------------------------------------------------
	
	// 주문 + 고객 + 물품 조인한 VIEW 만들기
	// 주문번호, 주문일자, 주문자아이디, 주문자이름, 물품명, 물품가격
	@Select( value = {
				"	SELECT * FROM purchaseview WHERE customerid=#{id}	"
			} )
	public List<PurchaseView> selectPurchaseViewMember(@Param("id") String id);
	
//	-------------------------------------------------------------------------

	
	
//	-------------------------------------------------------------------------


}