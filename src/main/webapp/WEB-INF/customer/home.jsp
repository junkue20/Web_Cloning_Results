<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>고객용 홈</title>
<!-- bootstrap -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
	
<style>
	.grid {
		display: grid;
		grid-template-columns: 1fr 1fr 1fr 1fr;
		column-gap: 10px;
		row-gap: 10px;
		
	}
	
	.item {
		padding: 10px;
		border: 1px solid #cccccc;
		min-height: 300px;
	}
	
	a {
		text-decoration: none;
		color: #111111;
	}
	
	a:hover .item {
		color: blue;
		border: 1px solid blue;
	}
</style>
	
</head>

<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark" aria-label="Tenth navbar example">
    <div class="container-fluid">
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarsExample08" aria-controls="navbarsExample08" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse justify-content-md-center" id="navbarsExample08">
        <ul class="navbar-nav">
          <li class="nav-item">
            <a class="nav-link active" aria-current="page" href="#">Centered nav only</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#">Link</a>
          </li>
          <li class="nav-item">
            <a class="nav-link disabled">Disabled</a>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown" aria-expanded="false">Dropdown</a>
            <ul class="dropdown-menu">
              <li><a class="dropdown-item" href="#">Action</a></li>
              <li><a class="dropdown-item" href="#">Another action</a></li>
              <li><a class="dropdown-item" href="#">Something else here</a></li>
            </ul>
          </li>
        </ul>
      </div>
    </div>
  </nav>
  
  
	<div class="container">
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
		
		<div class="grid">
			<c:forEach var="obj" items="${list}">
			<a href="product.do?itemno=${obj.no}">
			 	<div class="item">
			 	<c:if test="${obj.imageNo != 0}">
			 		<img src="${pageContext.request.contextPath}/item/image?no=${obj.imageNo}"
			 			 style="width:100%; height:150px">
			 	</c:if>
			 	<c:if test="${obj.imageNo == 0}">
			 		<img src="${pageContext.request.contextPath}/resources/images.png"
			 			 style="width:100%; height:150px">
			 	</c:if>
			 		물품명 : ${obj.name}<br/>
			 		
			 		가격 : ${obj.price}원<br/>
			 		
			 		내용 : ${obj.content}<br/>
			 	</div>
			 </a>
			</c:forEach>
		</div>
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