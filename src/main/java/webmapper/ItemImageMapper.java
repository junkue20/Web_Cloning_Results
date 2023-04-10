package webmapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import webdto.ItemImage;

@Mapper
public interface ItemImageMapper {

/*------------------------------------------------------------------------*/

	@Insert( value = {
		"  INSERT INTO itemimage ( itemno, filename, filesize, filetype, filedata  )  ",
		"	VALUES (  ",
			"	#{obj.itemno},   #{obj.filename}, ",
			"   #{obj.filesize}, #{obj.filetype}, ",
			"   #{obj.filedata}  ) "
	} )
	public int insertItemImage(@Param("obj") ItemImage itemImage);
	
/*------------------------------------------------------------------------*/
	
	@Select( value = {
		"	SELECT * FROM itemimage  ",
		" 	WHERE no=#{no}	"	
	} )
	public ItemImage selectItemImageOne(@Param("no") long no);
	
/*------------------------------------------------------------------------*/
	
	@Select( value = {
			"	SELECT no FROM itemimage  ",
			" 	WHERE itemno=#{no}	ORDER BY no DESC"	
		} )
		public List<Long> selectItemImageList(@Param("no") long no);
/*------------------------------------------------------------------------*/

	@Delete( value = {
			" 	DELETE FROM itemimage	",
			"	WHERE no = #{no} AND itemno = #{itemno}	"
			
		} )
	public int deleteItemImageListOne(@Param("no") long no,@Param("itemno") long itemno );

/*------------------------------------------------------------------------*/

	@Update( value = {
			"	UPDATE itemimage ",
			"	SET   ",
				"	filename =#{obj.filename} , ",
				"	filesize =#{obj.filesize} , ",
				"	filetype =#{obj.filetype} , ",
				"	filedata =#{obj.filedata}	",
			"	WHERE  no =#{obj.no}  AND  itemno =#{obj.itemno}	"
			
	} )
	public int updateItemImageOne(@Param("obj") ItemImage itemimage );
}
