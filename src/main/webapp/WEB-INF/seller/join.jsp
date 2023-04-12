<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>판매자용 회원가입 페이지</title>
<!-- bootstrap -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
</head>
<body>
	<div class="container">
		<div style="width: 600px; margin: 0 auto; padding: 50px; border: 1px solid #efefef;">
			<h3>판매자 회원가입</h3>
				<div class="row">
					<div class="col-sm">
						<div class="form-floating mb-2">
							<input type="text" id="id" name="id" class="form-control"
								onkeyup="ajaxIDCheck(this)"> 
								<label for="id" id="lbl_check" class="form-label">사용할아이디</label>
						</div>

						<div class="form-floating mb-2">
							<input type="password" id="pw" name="pw" class="form-control"
								required /> <label for="pw" id="lbl_pwCheck" class="form-label">암호</label>
						</div>
						<div class="form-floating mb-2">
							<input type="password" id="pw1" class="form-control" required /> <label for="pw1"
								id="lbl_pwCheck" class="form-label">암호재확인</label>
						</div>
						<div class="form-floating mb-2">
							<input type="text" id="name" name="name" class="form-control"
								required /> <label for="name" class="form-label">이름</label>
						</div>
						<div class="form-floating mb-2">
							<input type="number" id="age" name="age" class="form-control" /> <label
								for="age" class="form-label">나이</label>
						</div>
						<div>
							<!-- 여기서 type을 submit으로 잡고 유효성 검사를 하게되면 강제로 데이터가 넘어가기 때문에 button으로 지정해주어야 함! -->
							<input type="button" value="회원가입" class="btn btn-success" onclick="joinAction()" />
							<a href="login.do" class="btn btn-secondary" >로그인으로</a>
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
	async function restJoinAction(){
		const id = document.getElementById('id');
		const pw = document.getElementById('pw');
		const name = document.getElementById('name');
		const age = document.getElementById('age');
		
		const url 	   = '${pageContext.request.contextPath}/api/seller/join.json';
		const headers  = { "Content-Type": "application/x-www-form-urlencoded" };
		const body 	   = { id : id.value, pw : pw.value, name : name.valeue, age : age.value  };
		const { data } = await axios.post(url, body, {headers});
		console.log(data);
		
		if(data.ret === 1) {
			Swal.fire({
				icon: 'success',
				title: '회원가입 성공!',
				text: '새로 가입한 정보로 로그인해주세요!',
				showConfirmButton: true,
				timer: 3000
			});
		
			window.location.href='home.do';
		}
		else{
			Swal.fire({
				icon: 'error',
				title: '회원가입 오류!',
				text: '관리자에게 문의해주세요.',
				showConfirmButton: true,
			});
		}
	}
	
	
	// 공통변수 모든 함수에서 사용가능함.
	
	var idcheck = 0; // 1이면 사용가능, 나머지는 사용불가 처리
	function joinAction() {
		const id = document.getElementById('id');
		const pw = document.getElementById('pw');
		const name = document.getElementById('name');
		const age = document.getElementById('age');
		
		if(id.value.length <=0){
			Swal.fire({
				icon: 'warning',
				title: '아이디를 입력하지 않았어요',
				text: '아이디는 어디로 간거죠..?',
				showConfirmButton: true,
				timer: 2500
			});
			id.focus();
			return false; // 함수종료, 전송하지 않음
		}
		
		if(idcheck === 0) {
			Swal.fire({
				icon: 'warning',
				title: '이미 사용중인 아이디네요!',
				text: '이런.. 이 멋진걸 누군가 이미 선점했나 보네요.',
				showConfirmButton: true,
				
			});
			id.focus();
			return false;
		}
		
		if(pw.value.length <=0){
			Swal.fire({
				icon: 'error',
				title: '패스워드를 입력하지 않았어요',
				text: '패스워드는 어디로 간거죠..?',
				showConfirmButton: true,
			});
			pw.focus();
			return false; // 함수종료, 전송하지 않음
		}
		
		if(pw.value.length <=7){
			Swal.fire({
				icon: 'warning',
				title: '패스워드가 너무 짧아요!',
				text:  '적어도 8자리 정도는 되어야 할 것 같아요.',
				showConfirmButton: true,
				
			});
			pw.focus();
			return false; // 함수종료, 전송하지 않음
		}
		
		if(pw1.value.length <=0){
			Swal.fire({
				icon: 'error',
				title: '패스워드 확인창이 비어있어요!',
				text: '패스워드를 한번 더 입력해주세요.',
				showConfirmButton: true,
				
			});
			pw1.focus();
			return false; // 함수종료, 전송하지 않음
		}
		
		if(pw.value !== pw1.value){
			Swal.fire({
				icon: 'warning',
				title: '패스워드가 일치하지 않아요!',
				text: '흠.. 다시 한번 확인해야할 것 같네요.',
				showConfirmButton: true,
				
			});
			pw1.focus();
			return false;
		}
		
		if(name.value.length <=0){
			Swal.fire({
				icon: 'error',
				title: '이름을 입력하지 않았어요!',
				text: '저희가 뭐라고 불러드리면 좋을까요?',
				showConfirmButton: true,
				
			});
			name.focus();
			return false;
		}
		
		if(age.value.length <=0){
			Swal.fire({
				icon: 'error',
				title: '나이를 입력하지 않았어요!',
				text: '민감한 주제이긴 하죠!',
				showConfirmButton: true,
				
			});
			age.focus();
			return false;
		}
		
		restJoinAction();
	}
	
	
	
	
	async function ajaxIDCheck(e){
		if(e.value.length>0) {
			// rest api 호출
			const url 		= '${pageContext.request.contextPath}/api/member/idcheck.json?id=' + e.value;
			const headers 	= {"Content-Type":"application/json"};
			const {data} 	= await axios.get(url, {headers});
			console.log(data);
			
			if(data.ret === 1){
				idcheck = 0;
				document.getElementById("lbl_check").innerText = '이미 사용중인 ID입니다!';
				document.getElementById("lbl_check").style.color = 'red';
				document.getElementById("id").className = 'form-control is-invalid';
			}
			else if(data.ret === 0){
				idcheck = 1;
				document.getElementById("lbl_check").innerText = '사용가능!';
				document.getElementById("lbl_check").style.color = 'blue';
				document.getElementById("id").className = 'form-control';

			}
		}
		else {
			document.getElementById("lbl_check").innerText = '아이디';
			document.getElementById("lbl_check").style.color = 'black';
			document.getElementById("id").className = 'form-control';
		}
	}
	
	</script>
</body>
</html>