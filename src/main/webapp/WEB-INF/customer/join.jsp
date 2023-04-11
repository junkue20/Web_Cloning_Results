<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>고객용 회원</title>
<!-- bootstrap -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
</head>
<body>
	<div class="container">
		<div
			style="width: 600px; margin: 0 auto; padding: 50px; border: 1px solid #efefef;">
			<h3>회원가입</h3>
			<div class="row">
				<div class="col-sm">
					<div class="form-floating mb-2">
						<input type="text" id="id" class="form-control"	onkeyup="ajaxIDCheck(this)">
						<label for="id" id="lbl_check" class="form-label">사용할아이디</label>
					</div>

					<div class="form-floating mb-2">
						<input type="password" id="pw" class="form-control" required /> <label
							for="pw" class="form-label">암호</label>
					</div>
					<div class="form-floating mb-2">
						<input type="password" id="pw1" class="form-control" required />
						<label for="pw1" class="form-label">암호재확인</label>
					</div>
					<div class="form-floating mb-2">
						<input type="text" id="name" class="form-control" required /> <label
							for="name" class="form-label">이름</label>
					</div>
					<div class="form-floating mb-2">
						<input type="text" id="age" class="form-control" /> <label
							for="age" class="form-label">나이</label>
					</div>
					<div>
						<input type="submit" value="회원가입" class="btn btn-success">
						<button type="button" class="btn btn-secondary">로그인하기</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- sweetalert2 -->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<!-- jQuery -->
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.4.min.js"></script>
	<!-- axios -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/axios/1.3.5/axios.min.js"></script>	

	<script>
	async function ajaxIDCheck(e){
		console.log(e.value);
			document.getElementById("lbl_check").innerText = '아이디';
			document.getElementById("lbl_check").style.color = 'black';
			document.getElementById("id").className = 'form-control';
		if(e.value.length>0) {
			// rest api 호출
			const url 		= '${pageContext.request.contextPath}/api/member/idcheck.json?id=' + e.value;
			const headers 	= {"Content-Type":"application/json"};
			const {data} 	= await axios.get(url, {headers});
			console.log(data);
			if(data.ret === 1){
				document.getElementById("lbl_check").innerText = '이미 사용중인 ID입니다!';
				document.getElementById("lbl_check").style.color = 'red';
				document.getElementById("id").className = 'form-control is-invalid';
			}
			else if(data.ret === 0){
				document.getElementById("lbl_check").innerText = '사용가능!';
				document.getElementById("lbl_check").style.color = 'blue';
				document.getElementById("id").className = 'form-control';

			}
		} 
	}
	</script>
</body>
</html>