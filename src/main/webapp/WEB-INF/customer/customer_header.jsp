<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<h3>고객용 홈 화면</h3>
		<a href="home.do" class="btn btn-primary">홈으로</a>
		<a href="/web01/board/select.do" class="btn btn-success">자유게시판</a>
		<!-- 세션이 빈 상태일때  -->
		<c:if test="${sessionScope.UID eq null}">
			<a href="login.do" class="btn btn-success">로그인</a>
			<a href="join.do" class="btn btn-success">회원가입</a>
		</c:if>
		<!-- 세션에 로그인 정보가 들어있을때  -->
		<c:if test="${sessionScope.UID ne null}">
		<a href="mypage.do" class="btn btn-success">마이페이지</a>
		<label>${sessionScope.UNAME}님, 안녕하세요?</label>
			<a href="#" onclick="logoutAction()" class="btn btn-danger">로그아웃</a>
		</c:if>
		<hr />