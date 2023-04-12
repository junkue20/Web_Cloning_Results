<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
</head>
<body>
<!-- sweetalert2 -->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<script>
		Swal.fire({
			icon: '${icon}',
			title: '${title}',
			text: '${text}',
			showConfirmButton: false,
			timer: 2500
		});
		
		window.location.href = '${url}';
		
		 // 주소창을 바꾸고 enter키 (a 태그와 동일한 기능)
		
		/* alert('${message}'); // 알람을 표시 */
		
	</script>
</body>
</html>