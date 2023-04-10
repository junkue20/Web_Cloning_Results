package webmapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import webdto.Board;
import webdto.Item;

@Mapper
public interface ItemMapper {

/*------------------------------------------------------------------------------------------------------*/

	@Insert( value = {
			"  INSERT INTO item( name, content, price, quantity ) ",
			"  VALUES  (",
				"  #{obj.name},  #{obj.content},  ",
				"  #{obj.price}, #{obj.quantity} ) "
	} )
	public int insertItemOne(@Param("obj") Item item);
	
/*------------------------------------------------------------------------------------------------------*/
	
	// #{} => 값을 표현할 때
	// ${} => 컬럼명, 테이블명 등..
	@Select( value = { // 물품 검색
			"  SELECT * FROM item  ",
			"  WHERE ${column}  ",
			"  LIKE  '%' || #{text} || '%'  ",
			"  ORDER BY no DESC  "
	} )
	public List<Item> selectItemList(@Param("column") String column,@Param("text") String text );

/*------------------------------------------------------------------------------------------------------*/
	
	@Select( value = { // 10개씩 페이지 갯수 생성
			"  SELECT  ",
			"  COUNT(*)  ",
			"  FROM item  "
	} )
	public long countItemList();
	
/*------------------------------------------------------------------------------------------------------*/

	// 전체목록
		@Select ( value = {
				"	SELECT * FROM Item		"
		} )
		public List<Item> selectItem();

/*------------------------------------------------------------------------------------------------------*/
	
	// 10개씩 조회
		@Select ( value = { 
				"  SELECT i.* FROM  ",
						"  ( SELECT i.*, ROW_NUMBER() OVER( ORDER BY no DESC ) rown FROM item i ) i  ",
				"   WHERE   ",
						"  rown >= #{start} AND rown <= #{end} ",
				"  ORDER BY no DESC  "
		} )
		public List<Item> selectTenItemList(@Param("start") int start, @Param("end") int end ); // 1, 2, 3, 4, 각 페이지당 10개씩
		
}
