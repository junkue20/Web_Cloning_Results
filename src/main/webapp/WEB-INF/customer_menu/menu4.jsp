<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<body style="color: rgba(123, 123, 102, 0.5);">
	<div id="layoutAuthentication">
		<div id="layoutAuthentication_content">
			<main>
				<div class="container">
					<div class="row justify-content-center">
						<div class="col-lg">
							<div class="card shadow-lg border-0 rounded-lg mt-5 mb-5">
								<div class="card-header">
									<h3 class="text-left font-weight-light my-4">주문내역 조회하기</h3>
								</div>
								<div class="card-body">
									<form class="form-inline d-flex justify-content-first"
										method="GET" th:action="@{/board/boardList}"
										th:value="${param.searchText}">
									</form>
									<table class="table">
										<thead>
											<tr>
												<th scope="col">주문번호</th>
												<th scope="col">물품번호</th>
												<th scope="col">주문수량</th>
												<th scope="col">주문자 아이디</th>
												<th scope="col">주문날짜</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="obj" items="${list}">
												<tr>
													<td>${obj.no}</td>
													<td>${obj.itemno}</td>
													<td>${obj.cnt}</td>
													<td>${obj.customerid}</td>
													<td>${obj.regdate}</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
									<hr />
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