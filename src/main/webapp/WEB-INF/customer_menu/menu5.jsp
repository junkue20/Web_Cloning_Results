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
									<h3 class="text-left font-weight-light my-4">현재 등록된 주소 목록</h3>
								</div>
								<div class="card-body">
								<div>
	<!-- 모달 트리거 버튼 -->
	<table class="table">
		<thead class="text-bg-warning p-3">
			<tr>
				<th>번호</th>
				<th>우편번호</th>
				<th>주소</th>
				<th>등록일</th>
				<th>버튼</th>
			</tr>
		</thead>
		<tbody class="text-bg-light p-3">
			 <c:forEach var="obj" items="${list}">
				<tr>
					<td>${obj.no}</td>
					<td>${obj.postcode}</td>
					<td>${obj.address}</td>
					<td>${obj.regdate}</td>
					<td><button class="btn btn-sm btn-outline-danger" onclick="deleteAddress('${obj.no}')">삭제</button></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<button type="button" class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" 
		data-bs-target="#exampleModal">주소등록</button>
	<hr />
</div>
<form action ="insertaddress.do" method="post" id="form5">
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">주소등록</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>       
      </div>
      <div class="modal-body">
        	<input type="text" name="postcode" id="postcode" placeholder="우편번호" readonly>
			<input type="button" class="btn btn-sm btn-success" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
			<input type="text" name="address" id="address" placeholder="주소" readonly><br>
			<input type="text" name="detailAddress" id="detailAddress" placeholder="상세주소">
			<input type="text" name="extraAddress" id="extraAddress" placeholder="참고항목">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-sm btn-success" onclick = "insertAddressAction()">등록</button>
        <button type="button" class="btn btn-sm btn-secondary" data-bs-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>
</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</main>
		</div>
	</div>
</body>


<!-- Daum Postcode -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
function deleteAddress(no) {
	const form = document.createElement('form');
	form.setAttribute('action', 'deleteaddress.do?no=' + no);
	form.setAttribute('method', 'post');
	form.style.display='none';
	
	Swal.fire({
		title: '정말로 삭제하실건가요?',
		text: "삭제된 주소는 완전히 지워지게됩니다!",
		icon: 'warning',
		showCancelButton: true,
		confirmButtonColor: '#3085d6',
		cancelButtonColor: '#d33',
		confirmButtonText: '좋아요, 한번 가봅시다!'
	}).then((result) => {
	if (result.isConfirmed) {
		document.body.appendChild(form);
		form.submit();
	}
});
}


function insertAddressAction() {
	const postcode = document.getElementById("postcode");
	const address = document.getElementById("address"); 
	const detailAddress = document.getElementById("detailAddress"); 
	
	if(postcode.value.length <= 0){
		Swal.fire({
			icon: 'error',
			title: '우편번호가 비어있습니다.',
			text: '우편번호 찾기를 통해 주소를 입력해주세요!',
			showConfirmButton: true,
		});
		postcode.focus();
		return false;
	}
	
	if(address.value.length <= 0){
		Swal.fire({
			icon: 'error',
			title: '주소가 비어있습니다.',
			text: '주소를 입력해야해요.',
			showConfirmButton: true,
		});
		address.focus();
		return false;
	}
	
	if(detailAddress.value.length <= 0){
		Swal.fire({
			icon: 'error',
			title: '상세주소가 비어있습니다.',
			text: '상세주소를 입력해주세요.',
			showConfirmButton: true,
		});
		detailAddress.focus();
		return false;
	}
	
	document.getElementById('form5').submit();

}



function execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("extraAddress").value = extraAddr;
            
            } else {
                document.getElementById("extraAddress").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('postcode').value = data.zonecode;
            document.getElementById("address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("detailAddress").focus();
        }
    }).open();
}
</script>