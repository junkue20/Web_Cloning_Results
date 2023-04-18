<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<body style="color: rgba(123, 123, 102, 0.5);">
	<div id="layoutAuthentication">
		<div id="layoutAuthentication_content">
			<main>
				<div class="container">
					<div class="row justify-content-center">
						<div class="col-lg">
							<div class="card shadow-lg border-0 rounded-lg mt-5 mb-5">
								<div class="card-header">
									<h3 class="text-left font-weight-light my-4">나의 주문내역</h3>
								</div>
								<div class="card-body">
									<form class="form-inline d-flex justify-content-first"
										method="GET" th:action="@{/board/boardList}"
										th:value="${param.searchText}">
									</form>
									<form action="deletepurchase.do" method="post" id="form4">
									<table class="table">
										<thead  class="text-bg-warning p-3">
											<tr>
												<th scope="col">주문번호</th>
												<th scope="col">물품번호</th>
												<th scope="col">물품이름</th>
												<th scope="col">주문수량</th>
												<th scope="col">주문자명</th>
												<th scope="col">총 가격</th>
												<th scope="col">주문날짜</th>
											</tr>
										</thead>
										<tbody >
										<c:set var="total" value="${0}" />
											<c:forEach var="obj" items="${list}">
												<tr>
													<th scope="row"><input type="checkbox" name="chk[]" value="${obj.purchaseno}" /> ${obj.purchaseno}</th>
													<td>${obj.itemno}</td>
													<td>${obj.itemname}</td>
													<td>${obj.cnt}</td>
													<td>${obj.name}</td>
													<td><fmt:formatNumber value="${obj.totalpirce}" pattern="#,###" />원</td>
													<td>${obj.purchRegdate}</td>
													<c:set var="total" value="${total + obj.totalpirce}" />
												</tr>
											</c:forEach>
											<tr class="text-bg-light p-3" >
												<th colspan="6">합계</th>
												<td><fmt:formatNumber value="${total}" pattern="#,###" /> 원</td>
											</tr>
										</tbody>
									</table>
									<input type="button" class="btn btn-sm btn-outline-danger" value="주문취소" onclick="deletePurchaseAction()"/>
									</form>
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
</body>

<script>
	function deletePurchaseAction(){	
		// 체크박스의 체크유무 확인
		const chk = document.getElementsByName("chk[]");
		
		let isCheck = 0;
		for(let i=0; i<chk.length; i++){ // 찾은 갯수만큼 반복함.
			if(chk[i].checked === true) { // 1개라도 체크했다면 전송하기
				isCheck = 1;
				break;
			}
		}
		// 체크된 항목 종류 확인
		if( isCheck === 1 ) {
			Swal.fire({
				title: '주문을 취소할까요?',
				text: "주문 내역에서 완전히 사라져요!",
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: '좋아요, 한번 해봅시다!'
			}).then((result) => { // 확인을 누르면 submit
				if (result.isConfirmed) {
					
					Swal.fire({
						icon: 'success',
						title: '주문취소 완료',
						text: '성공적으로 취소되었습니다!',
						showConfirmButton: false,
					});
					document.getElementById("form4").submit();
				}
			});
		}
		else{ // 선택항목 없을시에는 에러창
			Swal.fire({
				icon: 'error',
				title: '선택된 항목이 없습니다.',
				text: '삭제하려면 주문내역을 선택해야해요!',
				showConfirmButton: true,
			});
			return false;
		}
	}
	
</script>