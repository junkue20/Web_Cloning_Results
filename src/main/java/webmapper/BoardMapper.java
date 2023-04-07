package webmapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import webdto.Board;

@Mapper
public interface BoardMapper {

	// 글쓰기
	@Insert ( value = { 
			"	INSERT INTO board( title, content, writer)	",
			"	VALUES( #{obj.title}, #{obj.content}, #{obj.writer}  )	" 
			} )
	public int insertBoard(@Param("obj") Board board);
	
//	-------------------------------------------------------------------------
	
	// 전체목록
	@Select ( value = {
			"	SELECT * FROM board		"
	} )
	public List<Board> selectBoard();
//	-------------------------------------------------------------------------------------------------------
	
	@Select ( value = {
			"	SELECT * FROM board		",
			"	WHERE no = #{no}	"
	} )
	public Board selectBoardOne(@Param("no") long no);
	
//	-------------------------------------------------------------------------------------------------------

	// 전체 갯수 (페이지네이션용)
	@Select ( value = {
			"	SELECT COUNT(*) cnt FROM board	"
	} )
	public long countBoardList ();
	
//	-------------------------------------------------------------------------------------------------------

	// 10개씩 게시글 조회
	@Select ( value = { 
			"  SELECT b.* FROM  ",
					"  ( SELECT b.*, ROW_NUMBER() OVER( ORDER BY no DESC ) rown FROM BOARD b ) b  ",
			"   WHERE   ",
					"  rown >= #{start} AND rown <= #{end} ",
			"  ORDER BY no DESC  "
	} )
	public List<Board> selectBoardList(@Param("start") int start, @Param("end") int end ); // 1, 2, 3, 4, 각 페이지당 10개씩

//	-------------------------------------------------------------------------------------------------------
	
	// #{} => 값을 표현할 때
		// ${} => 컬럼명, 테이블명 등..
		@Select ( value = { // 물품 검색
				"  SELECT * FROM board  ",
				"  WHERE ${column}  ",
				"  LIKE  '%' || #{text} || '%'  ",
				"  ORDER BY no DESC  "
		} )
		public List<Board> selectItemList(@Param("column") String column,@Param("text") String text );
		
//	-------------------------------------------------------------------------------------------------------
		
	// 조회수 증가 (글번호를 입력하면 해당 글 번호의 조회수만 1증가)
		@Update ( value = {
			"	UPDATE	board	",
			"	SET hit = hit+1  WHERE no =#{no}		"
		} )
		public int updateBoardHit (@Param("no") long no);
		
		
		
		// insert, update, delete => 전부 int형으로 반환해야함!
		// 다만 select는 list, object, int, string등 다양하게 반환가능

//	-------------------------------------------------------------------------------------------------------
		
		// 이전 게시글 조회
		@Select ( value = {
				"  SELECT NVL( MAX(no),0 )  ",
				"  FROM board  ",
				"  WHERE  ",
					"  no < #{no}  "
				
		} )
		public long selectPrevBoardOne(@Param("no")long no);
		
//	-------------------------------------------------------------------------------------------------------

		// 다음 게시글 조회
		@Select ( value = {
				"  SELECT NVL( MIN(no),0 )  ",
				"  FROM board  ",
				"  WHERE  ",
					"  no > #{no}  "
				
		} )
		public long selectNextBoardOne(@Param("no")long no);
		
//	-------------------------------------------------------------------------------------------------------

		// 게시글 수정하기
		@Update ( value = {
				"  UPDATE board  ",
				"  SET  ",
					"  title = #{obj.title},  ",
					"  content = #{obj.content},  ",
					"  writer = #{obj.writer}   ",
				"  WHERE  no = #{obj.no}  "
		})
		public int updateBoardOne(@Param("obj") Board board);


//	-------------------------------------------------------------------------------------------------------

		// 게시글 삭제하기
		@Delete ( value = {
				"  DELETE FROM board  ",
				"  WHERE no =#{no}  "
		} )
		public int deleteBoardOne(@Param("obj") long board);

}