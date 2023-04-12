package webmapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import webdto.Member;

@Mapper
public interface MemberMapper {

/*------------------------------------------------------------------------*/

	// 회원가입
	@Insert( value = {
			"  INSERT INTO memtb   ",
					"  ( id , password , ",
				      "  name , age, role )  ",
			"  VALUES (  ",
				      "  #{obj.id}, #{obj.password},  ",
				      "  #{obj.name}, #{obj.age}, #{obj.role})  ",
	})
	public int insertMemberOne(@Param("obj") Member obj);

/*------------------------------------------------------------------------*/

	// 로그인
	@Select( value = {
			"	SELECT id, name, age, role	",
			"	FROM memtb 	",
			"	WHERE id = #{obj.id} AND password = #{obj.password}	"
	} )
	public Member selectmemberLogin(@Param("obj") Member obj);

/*------------------------------------------------------------------------*/
	
	@Update( value = {
		"	<script>	",
			"	UPDATE memtb SET name =#{obj.name}	",
				"	<if test =	'obj.age != null'>	",
					" ,	age = #{obj.age}	",
				"	</if>	",
			"	WHERE id = #{obj.id}	",
		"	</script>	"
//			"	UPDATE memtb SET name =#{obj.name}	",
//				" ,	age =#{obj.age}	",
//			"	WHERE id =#{obj.id}	",
	} )
	public int updateMemberInfo (@Param("obj") Member obj);
	
/*------------------------------------------------------------------------*/
	
	@Update( value = {
			"	UPDATE memtb SET password = #{obj.newPassword}",
			"	WHERE id = #{obj.id} AND password = #{obj.password}	"
	} )
	public int updateMemberPw(@Param("obj") Member obj);
	
/*------------------------------------------------------------------------*/

	@Update( value = {
			"	UPDATE memtb SET	",
				"	password = null, name = null , age = null, regdate = null	",
			"	WHERE id = #{obj.id} AND password =	#{obj.password}"
	} )
	public int deleteMemberInfo(@Param("obj") Member obj);
	
/*------------------------------------------------------------------------*/
	
	// 중복되는 id값의 개수를 받아옴
	@Select( value = {
			"	SELECT COUNT(*) cnt FROM memtb	",
			"	WHERE id = #{id}	"
	} )
	public int selectMemberIdCheck(@Param("id") String id);

}