<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">

<div >
	<form action="mypage.do?menu=2" method="post" id="form2">
		<input type="password" name="password" placeholder="현재 비밀번호" />
		<input type="password" name="newPassword" placeholder="변경할 비밀번호" />
		<input type="password" name="newPassword1" placeholder="변경할 비밀번호 확인" />
		<input type="button" class="btn btn-primary" value="정보변경" onclick="updateMemberPassword()" />	
	</form>
		
</div>

</html>