<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">

<div >
	<form action="mypage.do?menu=3" method="post" id="form3">
		<input type="password" name="password" placeholder="비밀번호 확인" />
		<input type="button" class="btn btn-danger" value="탈퇴하기" onclick="deleteMember()" />	
	</form>
		
</div>

</html>