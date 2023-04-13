<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>게시글 목록 조회하기</title>
<!-- Include stylesheet -->
<link href="https://cdn.quilljs.com/1.3.6/quill.snow.css"
	rel="stylesheet">
<!-- Bootstrap -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ"
	crossorigin="anonymous">
</head>
<body style="color: rgba(123, 123, 102, 0.5);">
	<div id="layoutAuthentication">
		<div id="layoutAuthentication_content">
			<main>
				<div class="container">
					<div class="row justify-content-center">
						<div class="col-lg">
							<div class="card shadow-lg border-0 rounded-lg mt-5 mb-5">
								<div class="card-header">
									<h3 class="text-left font-weight-light my-4">${board.title}</h3>
								</div>
								<div class="card-body">

									<div class="container">
										<div class="">번호 : ${board.no}</div>
										<div class="">조회수 : ${board.hit}</div>
										<div class="">작성자 : ${board.writer}</div>
										<hr />
									</div>
									<div class="">${board.content}</div>
									<hr />
									<div>
										<h5>${board.regdate}</h5>
									</div>
									<hr />
									<div class="mb-3 row">
										<div class="col-sm-10">
											<a class="btn btn-success" href="select.do">목록으로</a>
											<button class="btn btn-secondary" href="#">수정하기</button>
											<a class="btn btn-secondary" href="#"
												onclick="deleteBoardOne()">삭제하기</a> <a
												class="btn btn-warning " href="#"
												onclick="ajaxUpdateHit('${prevNo}')">이전글</a> <a
												class="btn btn-warning " href="#"
												onclick="ajaxUpdateHit('${nextNo}')">다음글</a>
										</div>
									</div>

									<br>
									<div class="col-auto pull-end"></div>

								</div>
							</div>
						</div>
					</div>
				</div>
			</main>
		</div>
	</div>
	<!-- sweetalert2 -->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<!-- axios CDN -->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/axios/1.3.5/axios.min.js"
		integrity="sha512-nnNHpffPSgINrsR8ZAIgFUIMexORL5tPwsfktOTxVYSv+AUAILuFYWES8IHl+hhIhpFGlKvWFiz9ZEusrPcSBQ=="
		crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<!-- jQuery CDN -->
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"
		integrity="sha256-oP6HI9z1XaZNBrJURtCoUT5SUnxFr8s3BzRl+cbzUq8="
		crossorigin="anonymous"></script>
	<!-- twbsPagination CDN -->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/twbs-pagination/1.4.2/jquery.twbsPagination.min.js"
		integrity="sha512-frFP3ZxLshB4CErXkPVEXnd5ingvYYtYhE5qllGdZmcOlRKNEPbufyupfdSTNmoF5ICaQNO6SenXzOZvoGkiIA=="
		crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script>
	
	// 페이지 넘어가기 전 조회수 1 증가시키기
	async function ajaxUpdateHit(no){
		// 1. restful을 이용해서 조회수를 증가
		const url = '${pageContext.request.contextPath}/api/board/updatehit.json?no=' + no;
		const headers = {"Content-Type":"application/json"};
		
		//await axios.get(url, {headers})
		//await axios.post(url, body, {headers})
		//await axios.put(url, body, {headers})
		//await axios.delete(url, {headers:{ }, data:{ }})
		
		const {	data } = await axios.put(url, {}, {headers});
		console.log(data);
		if(data.result === 1) {
			// 2. 상세화면 페이지로 전환
			window.location.href='selectone.do?no=' + no;
		}			
	}
	
	function deleteBoardOne() {
				
		Swal.fire({
			  title: '정말로 지우실건가요?',
			  text: "지워진 게시글은 복구할 수 없어요!",
			  icon: 'warning',
			  showCancelButton: true,
			  confirmButtonColor: '#3085d6',
			  cancelButtonColor: '#d33',
			  confirmButtonText: '좋아요, 지워봅시다!'
			}).then((result) => {
			  if (result.isConfirmed) {
				  
				var form = document.createElement("form"); // 변수 'form'을 선언
	            	form.action = "deleteone.do";
	            	form.method = "post"; // post 형식으로 넘김
	           		form.style.display = "none"; // 별도로 화면표시는 x
	           	 
	            var inputNo = document.createElement("input"); 
	                inputNo.type="text";
	                inputNo.name="no";
	              	inputNo.value=${param.no}; // text형식으로 게시글 no를 저장.
	              	form.appendChild(inputNo);

	            // body 태그에 넣기
	            
	            
	            Swal.fire({
 					icon: 'success',
  					title: '삭제 완료!',
  					showConfirmButton: false,
  					timer: 1500
				})
	             
	            document.body.appendChild(form);
	            form.submit();
				  
			    
			  }
			})
     };
	</script>
</body>
</html>

