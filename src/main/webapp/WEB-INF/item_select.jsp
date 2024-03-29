<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>물품목록 조회하기</title>
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
									<h3 class="text-left font-weight-light my-4">물품 조회하기</h3>
								</div>
								<div class="card-body">
									<form class="form-inline d-flex justify-content-first"
										method="GET" th:action="@{/item/itemList}"
										th:value="${param.searchText}">
										<div class="col-auto">
											<input type="text" class="form-control" id="searchText"
												name="searchText" placeholder="검색어">
										</div>
										<div class="col-auto">
											<button type="submit" class="btn btn-success mb-2">검색</button>
										</div>
									</form>
									<table class="table">
										<thead>
											<tr>
												<th scope="col">no</th>
												<th scope="col">name</th>
												<th scope="col">content</th>
												<th scope="col">quantity</th>
												<th scope="col">price</th>
												<th scope="col">date</th>
												<th scope="col">image</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="obj" items="${list}">
												<tr>
													<td scope="row"><a href="#">${obj.no}</td>
													<td>${obj.name}</a></td>
													<td>${obj.content}</td>
													<td>${obj.quantity}</td>
													<td>${obj.price}</td>
													<td>${obj.regdate}</td>
													<td><a href="imagewrite.do?ino=${obj.no}" 
														   class="btn btn-warning">이미지등록</a></td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
									<hr />

									<div class="col-auto">
										<a type="button" class="btn btn-success"
											href="/web01/item/write.do">물품등록하기</a>
									</div>
									<br>
									<div class="col-auto pull-end">
										<ul id="pagination-demo"
											class="pagination-sm d-flex justify-content-center"></ul>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</main>
		</div>
	</div>
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
	
	
		$(function() {
			$('#pagination-demo').twbsPagination({
				totalPages : Number('${pages}'),
				visiblePages : 10,
				first : '◀',
				last : '▶',
				next : '▷',
				prev : '◁',
				initiateStartPageClick : false,
				// 페이지 활성화 (주소창에 있는 페이지값을 받아오는 역할)
				startPage : Number('${param.page}'),
				onPageClick : function(event, page) {
					/*$('#page-content').text('Page ' + page);*/
					window.location.href = "select.do?page=" + page;
				}
			});
		});
	</script>
</body>
</html>

