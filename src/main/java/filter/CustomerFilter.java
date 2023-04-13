package filter;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

// 127.0.0.1:8080/web01/customer/home.do  		작동안됨!
//127.0.0.1:8080/web01/customer/mypage.do  		작동됨!
// 127.0.0.1:8080/web01/customer/orderlist.do   작동됨!

/* 필터를 사용할 주소창을 입력 */
@WebFilter(urlPatterns = { "/customer/mypage.do", "/customer/orderlist.do", "/board/write.do", "/board/selectone.do" })
public class CustomerFilter implements Filter {
	@Override
	public void doFilter(ServletRequest arg0, ServletResponse arg1, FilterChain arg2)
			throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) arg0; // arg0은 request
		HttpServletResponse response = (HttpServletResponse) arg1; // arg1은 response
		System.out.println(" filter가 적용된 url 주소 : " + request.getRequestURI());

		HttpSession httpSession = request.getSession();
		String sessionId = (String) httpSession.getAttribute("UID");

		if (sessionId == null) { // 세션에 등록된 UID 객체가 없으면 다시 로그인 페이지로 보냄.
			response.sendRedirect("login.do");
			return; // 메소드를 종료시킨다.
		}
		
		// UID가 존재할 시 원래 수항하는 페이지로 이동
		arg2.doFilter(arg0, arg1);
	}
}
