<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>고객용 마이페이지</title>
<!-- bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">

	
</head>
<body>
	<div class="container">
		<nav class="navbar" style="background-color: #e3f2fd;">
			<a href="home.do" class="btn btn-primary">홈으로</a>
			<a href="mypage.do?menu=1" class="btn btn-success">회원정보수정</a>
			<a href="mypage.do?menu=2" class="btn btn-success">비밀번호변경</a> 
			<a href="mypage.do?menu=4" class="btn btn-success">주문내역</a> 
			<a href="mypage.do?menu=5" class="btn btn-success">주소관리</a>
			<a href="mypage.do?menu=3" class="btn btn-danger">회원탈퇴</a> 
		</nav>

		<hr />
		<!-- a태그의 menu값에 해당하는 정보가 나오도록 if문 구성 -->
		<c:if test="${param.menu == 1}">
			<jsp:include page="../customer_menu/menu1.jsp"></jsp:include>
		</c:if>
		<c:if test="${param.menu == 2}">
			<jsp:include page="../customer_menu/menu2.jsp"></jsp:include>
		</c:if>
		<c:if test="${param.menu == 3}">
			<jsp:include page="../customer_menu/menu3.jsp"></jsp:include>
		</c:if>
		<c:if test="${param.menu == 4}">
			<jsp:include page="../customer_menu/menu4.jsp"></jsp:include>
		</c:if>
		<c:if test="${param.menu == 5}">
			<jsp:include page="../customer_menu/menu5.jsp"></jsp:include>
		</c:if>
	</div>

	<!-- sweetalert2 -->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<!-- jQuery -->
	<script	src="${pageContext.request.contextPath}/resources/js/jquery-3.6.4.min.js"></script>
	<!-- axios -->
	<script	src="https://cdnjs.cloudflare.com/ajax/libs/axios/1.3.5/axios.min.js"></script>
	<!-- bootstrap -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
	<script>
		// ---------------------------- 이름, 나이변경
		function updateMemberInfo() {
			// 유효성 검사
			const name = document.getElementsByName("name")[0];
			const age = document.getElementsByName("age")[0];
			
			if(name.value.length <=0){
				Swal.fire({
					icon: 'error',
					title: '이름칸이 비었음!',
					text: '수정하고자 하는 이름을 입력해주셔야 해요.',
					showConfirmButton: true,
				});
				name.focus();
				return false;
			}
		if(age.value.length <=0){
			Swal.fire({
				icon: 'error',
				title: '나이칸이 비었음!',
				text: '수정하고자 하는 나이를 입력해주셔야 해요.',
				showConfirmButton: true,
			});
			age.focus();
			return false;
		}
		
		if(age.value.length >=4){
			Swal.fire({
				icon: 'question',
				title: '나이가 너무 많은데요..?',
				text: '이정도 나이면 기네스북 감이에요!',
				showConfirmButton: true,
			});
			return false;
		}	
		
			Swal.fire({
				title: '정말로 변경하실건가요?',
				text: "취소하더라도 언제든지 변경할 수 있어요!",
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: '좋아요, 한번 가봅시다!'
			}).then((result) => {
			if (result.isConfirmed) {
			// document.getElementsByTagName("form")[0].submit();
			const form = document.getElementsByTagName("form");
			form[0].submit();
			}
		});	
	}
							
		// ---------------------------- 비밀번호 변경

					
		function updateMemberPassword(){
			const password = document.getElementsByName("password")[0];
			const newPassword = document.getElementsByName("newPassword")[0];
			const newPassword1 = document.getElementsByName("newPassword1")[0];

			if(password.value.length <=0){
				Swal.fire({
					icon: 'error',
					title: '비밀번호가 비어있습니다.',
					text: '지금까지 쓰고 계시던 비밀번호를 입력해주세요!',
					showConfirmButton: true,
				});
				password.focus();
				return false;
			}
			
			if(newPassword.value.length <=0){
				Swal.fire({
					icon: 'error',
					title: '새 비밀번호가 비어있습니다.',
					text: '수정하고싶은 비밀번호를 입력해주셔야 해요.',
					showConfirmButton: true,
				});
				newPassword.focus();
				return false;
			}
			
			if(newPassword1.value.length <=0){
				Swal.fire({
					icon: 'error',
					title: '새 비밀번호가 비어있습니다.',
					text: '새 비밀번호값을 다시한번 입력해주세요.',
					showConfirmButton: true,
				});
				newPassword1.focus();
				return false;
			}
			
			if(newPassword.value.length <=7){
				Swal.fire({
					icon: 'warning',
					title: '비밀번호가 너무 짧습니다.',
					text: '비밀번호는 최소 8자리로 입력해주세요!',
					showConfirmButton: true,
				});
				newPassword.focus();
				return false;
			}
			
			
			if(newPassword.value !== newPassword1.value){
				Swal.fire({
					icon: 'error',
					title: '새 암호 불일치!',
					text: '새로운 비밀번호가 일치하지 않아요.',
					showConfirmButton: true,
				});
				newPassword.focus();
				return false;
			}
			
			Swal.fire({
				title: '정말로 변경하실건가요?',
				text: "취소하더라도 언제든지 변경할 수 있어요!",
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: '좋아요, 한번 가봅시다!'
			}).then((result) => {
			if (result.isConfirmed) {
					
				const form = document.getElementsByTagName("form");
				form[0].submit();
				}
			});	
		}
		
		// ---------------------------- 회원탈퇴
		
		function deleteMember(){
			const password = document.getElementsByName("password")[0];
			if(password.value.length <=0){
				Swal.fire({
					icon: 'error',
					title: '입력된 비밀번호가 없습니다.',
					text: '탈퇴하려면 비밀번호를 입력해야해요!',
					showConfirmButton: true,
				});
				password.focus();
				return false;
			}
			
			Swal.fire({
				title: '정말로 탈퇴하실건가요?',
				text: "탈퇴후에는 계정 복구를 할 수 없어요.",
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: '좋아요, 한번 가봅시다!'
			}).then((result) => {
			if (result.isConfirmed) {
				const form = document.getElementsByTagName("form");
				form[0].submit();
			}
		});
			
		}
	</script>
</body>
</html>