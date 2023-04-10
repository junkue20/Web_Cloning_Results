<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset='utf-8'>
<meta http-equiv='X-UA-Compatible' content='IE=edge'>
<title>물품게시판 글쓰기</title>
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
									<h3 class="text-left font-weight-light my-4">📜 물품 게시판</h3>
								</div>
								<form id="form" action="write.do" method="post">
									<div class="card-body">

										<div class="form-floating mt-3 mb-3">
											<input type="text" name="name" class="form-control" id="name"
												for="floatingInput" autofocus required /> <label for="name"
												class="form-label">물품명</label>
										</div>
										<div id="editor" style="height: 400px; color: #333333;">
											<p>물품 설명을 기재해주세요.</p>
										</div>

										<textarea rows="" cols="" id="content" name="content"
											style="display: none"></textarea>

										<div class="form-floating mt-3 mb-3">
											<input type="number" name="price" class="form-control"
												id="price" for="floatingInput" autofocus required> <label
												for="" price"" class="form-label">가격</label>
										</div>
										<div class="form-floating mt-3 mb-3">
											<!-- 숫자만 가능하도록 설정 -->
											<input type="number" name="quantity" class="form-control"
												id="quantity" for="floatingInput" autofocus required>
											<label for="quantity" class="form-label">수량</label>
										</div>
										<input type="button" value="등록"
											class="btn btn-success btn-right" onclick="insertItem()"></input>
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
		var toolbarOptions = [ [ 'bold', 'italic', 'underline', 'strike' ], // toggled buttons
		[ 'blockquote', 'code-block' ],

		[ {
			'header' : 1
		}, {
			'header' : 2
		} ], // custom button values
		[ {
			'list' : 'ordered'
		}, {
			'list' : 'bullet'
		} ], [ {
			'script' : 'sub'
		}, {
			'script' : 'super'
		} ], // superscript/subscript
		[ {
			'indent' : '-1'
		}, {
			'indent' : '+1'
		} ], // outdent/indent
		[ {
			'direction' : 'rtl'
		} ], // text direction

		[ {
			'size' : [ 'small', false, 'large', 'huge' ]
		} ], // custom dropdown
		[ {
			'header' : [ 1, 2, 3, 4, 5, 6, false ]
		} ],

		[ {
			'color' : []
		}, {
			'background' : []
		} ], // dropdown with defaults fromF theme
		[ {
			'font' : []
		} ], [ {
			'align' : []
		} ],

		[ 'clean' ] // remove formatting button
		];

		// 위쪽에 있는 태그중에 id가 editor인것을 찾아서 toolbar는 toolbarOptions의 값으로 대체하고 테마를 snow로 해서 변경.
		const quill = new Quill('#editor', {
			modules : {
				toolbar : toolbarOptions
			},
			theme : 'snow'
		});

		function insertItem() {

			/* 1. 유효성 검사 */
			// 물품명 유효성 검사
			const name = document.getElementById("name");
			if (name.value.length <= 0) {
				Swal.fire('물품명이 없네요..?', '물품명을 입력해주세요!', 'question')
				name.focus();
				return false;
			}

			// 가격 유효성 검사
			const price = document.getElementById("price");
			if (price.value.length <= 0) {
				Swal.fire('그래서 가격이 얼마죠..?', '가격을 입력해주세요!', 'question')
				price.focus();
				return false;
			}

			// 수량 유효성 검사
			const quantity = document.getElementById("quantity");
			if (quantity.value.length <= 0) {
				Swal.fire('물품이 총 몇개죠..?', '가격을 입력해주세요!', 'question')
				quantity.focus();
				return false;
			}

			/* 2. div 대그의 내용을 전송할 수 있게 변경 */
			const divContent = quill.root.innerHTML;
			document.getElementById("content").value = divContent;

			/* 3. 전송시킴 */
			document.getElementById("form").submit();

			/* 4. 등록성공  */
			
			Swal.fire({
				icon : 'success',
				title : '물품등록 완료!',
				showConfirmButton : false,
				timer : 2000
			})
		}
	</script>
</body>
</html>