<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>주문관리</title>
<!-- bootstrap -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
</head>
<body>
	<div class="container">
		<a href="select.do?menu=1" class="btn btn-sm btn-success">전체 주문목록</a>
		<a href="select.do?menu=2" class="btn btn-sm btn-success">회원별 주문사항</a>
		<a href="select.do?menu=3" class="btn btn-sm btn-success">물품별 주문사항</a>
		<a href="select.do?menu=4" class="btn btn-sm btn-success">시간대별 주문목록</a>
	<hr />
	
		<c:if test="${param.menu == 1}">
			<jsp:include page="../purchase_menu/menu1.jsp"></jsp:include>
		</c:if>
		<c:if test="${param.menu == 2}">
			<jsp:include page="../purchase_menu/menu2.jsp"></jsp:include>
		</c:if>
		<c:if test="${param.menu == 3}">
			<jsp:include page="../purchase_menu/menu3.jsp"></jsp:include>
		</c:if>
		<c:if test="${param.menu == 4}">
			<jsp:include page="../purchase_menu/menu4.jsp"></jsp:include>
		</c:if>
	</div>

	<!-- sweetalert2 -->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<!-- jQuery -->
	<script	src="${pageContext.request.contextPath}/resources/js/jquery-3.6.4.min.js"></script>
	<!-- axios -->
	<script	src="https://cdnjs.cloudflare.com/ajax/libs/axios/1.3.5/axios.min.js"></script>
</body>
</html>