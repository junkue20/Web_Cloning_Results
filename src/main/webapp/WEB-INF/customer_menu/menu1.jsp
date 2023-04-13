<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">

<div >
	<form action="mypage.do?menu=1" method="post" id="form1">
		<input type="text"  name="name" placeholder="이름" value="${obj.name}" />
		<input type="number"  name="age" placeholder="나이" value="${obj.age}" />
		<input type="button" class="btn btn-primary" value="정보변경" onclick="updateMemberInfo()" />	
	</form>
		
</div>

</html>