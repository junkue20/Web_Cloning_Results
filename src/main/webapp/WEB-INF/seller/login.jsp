<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>판매자용 로그인</title>
<!-- bootstrap -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
</head>
<body>
	<div class="container">
		<div style="width:600px; margin:0 auto; padding: 50px; border:1px solid #efefef;">
        	<h3>로그인(ajax)</h3>
            <div class="row">
                <div class="col-sm">
	                <div class="form-floating mb-2">
	                    <input type="text" id="id1" class="form-control" />
	                    <label for="id1" class="form-label">아이디</label>
	                </div>
	                <div class="form-floating mb-2">
	                    <input type="password" id="pw1" class="form-control" />
	                    <label for="pw1" class="form-label">암호</label>
	                </div>
	                <div>
                    	<input type="button" value="로그인" class="btn btn-success" 
                    		onclick="restLoginAction()"/>
                    	<a href="join.do" class="btn btn-secondary">처음이신가요?</a> 
						<a href="home.do" class="btn btn-primary">홈으로</a>	
                    </div>
                </div>
            </div>
		</div>
	</div>
	

	<!-- sweetalert2 -->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<!-- jQuery -->
	<script	src="${pageContext.request.contextPath}/resources/js/jquery-3.6.4.min.js"></script>
	<!-- axios -->
	<script	src="https://cdnjs.cloudflare.com/ajax/libs/axios/1.3.5/axios.min.js"></script>
	<script>
	async function restLoginAction(){
		const id = document.getElementById("id1");
		const pw = document.getElementById("pw1");
		
		const url 	   = '${pageContext.request.contextPath}/api/seller/login.json';
		const headers  = { "Content-Type": "application/x-www-form-urlencoded" };
		const body 	   = { id : id.value, pw : pw.value };
		const { data } = await axios.post(url, body, {headers});
		console.log(data);
		if(data.ret === 1) {
			Swal.fire({
				icon: 'success',
				title: '로그인 성공!',
				text: '${sessionScope.UNAME}님 안녕하세요?',
				showConfirmButton: true,
				timer: 3000
			});
		
			window.location.href='home.do';
		}
		else{
			Swal.fire({
				icon: 'error',
				title: '로그인 오류!',
				text: '아이디 또는 패스워드를 다시 확인해주세요!',
				showConfirmButton: true,
			});
		}
	}
	</script>
</body>
</html>