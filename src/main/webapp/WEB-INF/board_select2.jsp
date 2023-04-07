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
									<h3 class="text-left font-weight-light my-4">게시글 조회하기</h3>
								</div>
								<div class="card-body">
									<form class="form-inline d-flex justify-content-first"
										method="GET" th:action="@{/board/boardList}"
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
												<th scope="col">title</th>
												<th scope="col">content</th>
												<th scope="col">writer</th>
												<th scope="col">hit</th>
												<th scope="col">date</th>
											</tr>
										</thead>
										<tbody id="tbody">
											<tr>
												<td scope="row">${obj.no}</td>
												<td>${obj.title}</td>
												<td>${obj.content}</td>
												<td>${obj.writer}</td>
												<td>${obj.hit}</td>
												<td>${obj.regdate}</td>
											</tr>
										</tbody>
									</table>
									<hr />

									<div class="col-auto">
										<a type="button" class="btn btn-success"
											href="/web01/board/write.do">글쓰기</a>
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
	$(function(){
		// 1. restful 호출해서 목록을 받아오는 것.. 
		async function ajaxBoardList(page) {
			// 같은 서버내에서는 http://127.0.0.1:8080/web03 생략이 가능하다.
			const url = '${pageContext.request.contextPath}/api/board/select.json?page=' + page;
			const headers = {"Content-Type":"application/json"};
			
			const { data } = await axios.get(url,{headers}); 
			// await 코드때문에 실행이 끝나기 전까지 아래의 코드는 실행되지 않는다.
			console.log(data);
		
		
			// 1-2. 함수를 pages정보를 넘겨서 생서시킴
			initPagination ( Number(data.pages) );
		
		
		
			const tbody = document.getElementById('tbody');
			tbody.innerHTML = '';
			// 가져온 data를 반복문을 통해 출력
			for(let tmp of data.list) {
				console.log(tmp.no, tmp.title, tmp.content);
				tbody.innerHTML +=
					'<tr>' +
						'<td scope="row">' + tmp.no + '</td>' +
						'<td>' + tmp.title + '</td>' +
						'<td>' + tmp.content + '</td>' +
						'<td>' + tmp.writer + '</td>' +
						'<td>' + tmp.hit + '</td>' +
						'<td>' + tmp.regdate + '</td>' +
					'</tr>';
			}
		};
	
		ajaxBoardList(1);
	
	 
		// 2. 페이지네이션 생성하는 함수
		function initPagination(pages) {
			$('#pagination-demo').twbsPagination({
				totalPages : pages,
				visiblePages : 10,
				first : '◀',
				last : '▶',
				next : '▷',
				prev : '◁',
				onPageClick  : function (event, page) {
					// 1번 함수호출
					ajaxBoardList(page);
				}
			});
		};
		
	});
	
	</script>

</body>
</html>

