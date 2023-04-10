<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset='utf-8'>
<meta http-equiv='X-UA-Compatible' content='IE=edge'>
<title>물품이미지 등록하기</title>
<meta name='viewport' content='width=device-width, initial-scale=1'>
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
							<div class="card shadow-lg border-0 rounded-lg mt-5">
								<div class="card-header">
									<h3 class="text-left font-weight-light my-4">🖼️ 물품이미지 등록</h3>
								</div>

								<form id="form"
									action="${pageContext.request.contextPath}/item/imagewrite.do"
									method="post" enctype="multipart/form-data">
									<div class="card-body">
										<div class="form-floating mt-3 mb-3">
											<input type="text" name="ino" class="form-control" id="ino"
												for="floatingInput" value="${ino}" readonly> <label
												for="ino" class="form-label">물품번호</label>
										</div>
										<c:forEach var='tmp' items="${no}">
											<img src="${pageContext.request.contextPath}/item/image?no=${tmp}"
												style="width: 70px; height: 70px">
										</c:forEach>
										<hr />
										<div class="form-floating mt-3 mb-3">
											<img
												src="${pageContext.request.contextPath}/resources/images.png"
												id="img"
												style="width: 250px; height: 200px; cursor: pointer;"
												onclick="clickImage()"> <input type="file" name="file"
												id="file" class="form-control" style="display: none"
												onchange="imageChange(this)" />
										</div>

										<input type="button" value="등록" id="commit" name="commit"
											class="btn btn-success btn-right" onclick="insertItemImage()"></input>
										<a class="btn btn-secondary" href="select.do">목록으로</a>
									</div>
								</form>
								<form id="form1" action="imagewritebatch.do?ino=${ino}"
									method="post" enctype="multipart/form-data">
									<div class="card-body">
										<hr />
										<div class="form-floating mt-3 mb-3">
											<c:forEach var="idx" begin="1" end="3" step="1">
												<img
													src="${pageContext.request.contextPath}/resources/images.png"
													class="imgs"
													style="width: 50px; height: 50px; cursor: pointer;">
												<input type="file" name="file[]"
													onchange="imageChangeBatch(this, '${idx-1}')" />
												<br />
											</c:forEach>
										</div>
										<input type="button" value="일괄등록"
											class="btn btn-success btn-right"
											onclick="insertImageBatch()"></input> <a
											class="btn btn-secondary" href="select.do">목록으로</a>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</main>
		</div>
	</div>
	<!-- sweetalert2 -->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<script src="https://cdn.quilljs.com/1.3.6/quill.js"></script>
	<script>
		// document.getElementById("아이디"); id가 일치하는 1개 찾기
		// document.getElementsByName("name값"); name값이 일치하는 n개 찾기
		// document.getElementsByClassName("class값"); class값이 일치하는 n개 찾기
		// document.getElementsByTagName("img"); 태그가 img인 n개 찾기

		const imgs = document.getElementsByClassName("imgs");
		const files = document.getElementsByName("file[]")
		function imageChangeBatch(e, idx) {
			if (e.files.length > 0) {
				imgs[Number(idx)].src = URL.createObjectURL(e.files[0]); // 가상의 url 정보를 생성해 추가. 
			} else {
				imgs[Number(idx)].src = "${pageContext.request.contextPath}/resources/images.png";
			}
		}

		function insertImageBatch() { // no image 이미지를 클릭하면 "file"이라는 id의 기능을 실행시킨다. (이미지 추가하기 기능. 현재 감춰둔 상태)
			console.log(imgs);
			console.log(imgs.length);
			console.log(e.files);
			console.log(idx);
		}

		function clickImage() {
			document.getElementById("file").click();
		}

		function clickImages() {
			document.getElementById("file[]").click();
		}

		function imageChange(e) {
			console.log(e.files);
			if (e.files.length > 0) { // 첨부
				// 파일을 첨부하면 크롬에서 "blob:http://127.0.0.1:8080/...."라고 콘솔창에 띄운다.
				console.log(URL.createObjectURL(e.files[0])); // 확인용

				img.src = URL.createObjectURL(e.files[0]); // 가상의 url 정보를 생성해서 추가함. 
			} else { // 취소
				img.src = "${pageContext.request.contextPath}/resources/images.png";
			}
		}

		function insertItemImage() {
			// 유효성 검사 한 후 
			const file = document.getElementById("file");
			if (file.value.length <= 0) {
				Swal.fire('첨부된 파일이 없어요!', '이미지가 없으면 등록할 수 없어요.', 'error')
				return false;
			}
			// form 태그 전송
			document.getElementById("form").submit();

			Swal.fire({
				icon : 'success',
				title : '이미지등록 완료!',
				showConfirmButton : false,
				timer : 2000
			})
		}

		function insertImageBatch() {
			// 유효성 검사		
			var chk = 0;
			for (let i = 0; i < imgs.length; i++) { // 반복문으로 files 전체 유효성 검사
				if (files[i].value.length <= 0) {
					Swal.fire('첨부된 파일이 없어요!', '이미지가 없으면 등록할 수 없어요.', 'error')
					chk = 1;
					break; // 반복문 종료
				}
			}
			if (chk === 0) { // if문을 한번도 수행하지 않았다면,
				//form 전송
				document.getElementById("form1").submit();

				Swal.fire({
					icon : 'success',
					title : '이미지등록 완료!',
					showConfirmButton : false,
					timer : 2000
				})
			}
		}
	</script>
</body>
</html>