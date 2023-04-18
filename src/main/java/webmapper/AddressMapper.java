package webmapper;


import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import webdto.Address;

@Mapper
public interface AddressMapper {

	// 글쓰기
	@Insert ( value = { 
			"	INSERT INTO address ( postcode, address, memberid)	",
			"	VALUES(  #{obj.postcode}, #{obj.address}, #{obj.memberid}  )	"
	} )
	public int insertMemberAddress(@Param("obj") Address obj);
	
//	-------------------------------------------------------------------------

	@Select ( value = {
			"	SELECT * FROM address	",
			"	WHERE memberid =#{id}	"
	} )
	public List<Address> selectMemberAddress(@Param("id") String id);

//	-------------------------------------------------------------------------

	@Delete ( value = {
			"DELETE FROM address ",
			" WHERE no=#{obj.no} AND memberid =#{obj.memberid}"
	} )
	public int deleteMemberAddress(@Param("obj") Address obj);


}