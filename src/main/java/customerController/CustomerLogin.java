package customerController;

import java.io.IOException;

import config.Hash;
import config.MyBatisContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import webdto.Member;
import webmapper.MemberMapper;

// 컨트롤러 역활 X, DB에 있는 이미지를 URL 형태로 변경해서 반환하는 용도
@WebServlet(urlPatterns = { "/customer/login.do", "/board/login.do" })
@MultipartConfig()
public class CustomerLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;

// ex) http://127.0.0.1:8080/web01/customer/login.do
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.getRequestDispatcher("/WEB-INF/customer/login.jsp").forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 비밀번호 암호화
		String hashPw = Hash.hashPW(request.getParameter("id"), request.getParameter("pw"));
		Member obj = new Member();
		obj.setId(request.getParameter("id"));
		obj.setPassword(hashPw);

		// mapper를 이용하여 로그인
		System.out.println(obj.toString());
		Member ret = MyBatisContext.getSqlSession().getMapper(MemberMapper.class).selectmemberLogin(obj);

		if (ret != null) { // 로그인 성공시
			// 세션에 기록 또는 읽기 위한 객체 생성
			HttpSession httpSession = request.getSession();
			// 세션에 필요한 정보를 기록
			// ex) 아이디, 이름을 기록 (30분간 유지)
			httpSession.setAttribute("UID", ret.getId());
			httpSession.setAttribute("UNAME", ret.getName());
			httpSession.setAttribute("UROLE", ret.getRole());
			String name = (String) request.getSession().getAttribute("UNAME");
			String url = (String) httpSession.getAttribute("url"); // 저장된 url을 다시 불러오기
			if (url == null) {
				request.setAttribute("url", "home.do");
				request.setAttribute("icon", "success");
				request.setAttribute("title", "로그인 완료!");
				request.setAttribute("text", "또 뵙네요, " + name + "님!");
				request.getRequestDispatcher("/WEB-INF/alert.jsp").forward(request, response);
			} else {
				request.setAttribute("url", url);
				request.setAttribute("icon", "success");
				request.setAttribute("title", "로그인 완료!");
				request.setAttribute("text", "또 뵙네요, " + name + "님!");
				request.getRequestDispatcher("/WEB-INF/alert.jsp").forward(request, response);
			}
			return; // 메소드 종료
		}
		request.setAttribute("icon", "customer/login.do");
		request.setAttribute("icon", "warning");
		request.setAttribute("title", "로그인 실패");
		request.setAttribute("text", "아이디나 비밀번호를 다시 확인해주세요!");
		request.getRequestDispatcher("/WEB-INF/alert.jsp").forward(request, response);
	}
}
