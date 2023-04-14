<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>상품 페이지</title>
<!-- bootstrap -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">	
</head>
<body>
	<div class="container">
		<jsp:include page="customer_header.jsp"></jsp:include>
		
		<c:if test="${not empty imageNo}">
			<c:forEach var="no" items="${imageNo}">
				<img src="${pageContext.request.contextPath}/item/image?no=${no}" 
						style="width:200px; height:150px" />
			</c:forEach>
		</c:if>
		
		<c:if test="${empty imageNo}">
			<img src="${pageContext.request.contextPath}/resources/images.png"
				style="width:200px; height:150px" />
		</c:if>
		
		<p>${obj.no}</p>
		<p>${obj.name}</p>
		<p>${obj.content}</p>
		<p>${obj.price}원</p>
		<form id="form" action="purchase.do" method="post">
			<input type="hidden" name="itemno" value="${obj.no}"> 
				<select name="cnt">
					<c:forEach var="idx" begin="1" end="1000" step="1">
						<option value="${idx}">${idx}</option>
					</c:forEach>
				</select>
			<input type="submit" class="btn btn-sm btn-success" value="주문하기" onclick="purchaseAction()"/>
		</form>
	</div>

	<!-- sweetalert2 -->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<!-- jQuery -->
	<script	src="${pageContext.request.contextPath}/resources/js/jquery-3.6.4.min.js"></script>
	<!-- axios -->
	<script	src="https://cdnjs.cloudflare.com/ajax/libs/axios/1.3.5/axios.min.js"></script>
	<script>
		function purchaseAction(){
			// 주문 여부 물어보는 유효성 검사
		}
		
	</script>
</body>
</html>