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

// home(0) -> login(x) OR logout(x) -> home(o)
// board(o) -> login(x) -> board(O)
// 로그인후 이전페이지 이동을 위한 필터
/* 필터를 사용할 주소창을 입력 */
@WebFilter(urlPatterns = { "/customer/*"})
public class UrlFilter implements Filter {
	@Override
	public void doFilter(ServletRequest arg0, ServletResponse arg1, FilterChain arg2)
			throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) arg0; // arg0은 request
		HttpSession httpSession = request.getSession();
		String uri = request.getRequestURI();

		if ( !uri.contains("login.do") && !uri.contains("logout.do")) { // 세션에 등록된 UID 객체가 없으면 다시 로그인 페이지로 보냄.
			// home.do   			=> null		 => queryString이 null임.
			// product.do?itemno=33 => itemno=33 => queryString이 itemno=33임.('?'는 없음!)
			String queryString = request.getQueryString();
			
			if(queryString == null) {
				httpSession.setAttribute("url", request.getRequestURI());
				System.out.println("url 필터 : " + request.getRequestURI());
			}
			else {
				httpSession.setAttribute("url", request.getRequestURI()+"?"+queryString);
				System.out.println("url 필터 : " + request.getRequestURI()+"?"+queryString);

			}
		}
		
		// UID가 존재할 시 원래 수항하는 페이지로 이동
		arg2.doFilter(arg0, arg1);
	}
}
