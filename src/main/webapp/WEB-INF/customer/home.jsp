<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>고객용용 홈</title>
<!-- bootstrap -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
</head>
<body>
	<div class="container">
		<a href="home.do" class="btn btn-primary">홈으로</a>
		<!-- 세션이 빈 상태일때  -->
		<c:if test="${sessionScope.UID eq null}">
			<a href="login.do" class="btn btn-success">로그인</a>
			<a href="join.do" class="btn btn-success">회원가입</a>
		</c:if>
		<!-- 세션에 로그인 정보가 들어있을때  -->
		<c:if test="${sessionScope.UID ne null}">
		<label>${sessionScope.UNAME}님, 안녕하세요?</label>
			<a href="#" onclick="logoutAction()" class="btn btn-danger">로그아웃</a>
		</c:if>
		<hr />
	</div>

	<!-- sweetalert2 -->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<!-- jQuery -->
	<script
		src="${pageContext.request.contextPath}/resources/js/jquery-3.6.4.min.js"></script>
	<!-- axios -->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/axios/1.3.5/axios.min.js"></script>
	<script>
		function logoutAction() {
			var form = document.createElement("form");
			form.setAttribute("action", "logout.do");
			form.setAttribute("method", "post");
			form.style.display = "none";
			document.body.appendChild(form);
			form.submit();
		}
	</script>
</body>
</html>