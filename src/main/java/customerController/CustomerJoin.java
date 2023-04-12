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
import webdto.Member;
import webmapper.MemberMapper;

// 컨트롤러 역활 X, DB에 있는 이미지를 URL 형태로 변경해서 반환하는 용도
@WebServlet(urlPatterns = { "/customer/join.do" })
@MultipartConfig()
public class CustomerJoin extends HttpServlet {
	private static final long serialVersionUID = 1L;

// ex) http://127.0.0.1:8080/web01/item/image?no=물품번호
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.getRequestDispatcher("/WEB-INF/customer/join.jsp").forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 이전화면에서 버튼을 눌러서 페이지가 이동되면서 전송된 데이터를 받기
		String hashPw = Hash.hashPW(request.getParameter("id"), request.getParameter("pw"));

		Member obj = new Member();
		obj.setId(request.getParameter("id"));
		obj.setPassword(hashPw);
		obj.setName(request.getParameter("name"));
		obj.setAge(Integer.parseInt(request.getParameter("age")));
		obj.setRole("CUSTOMER");

		// mapper를 이용하여 추가하기
		int ret = MyBatisContext.getSqlSession().getMapper(MemberMapper.class).insertMemberOne(obj);
		if (ret == 1) { // 127.0.0.1:8080/web01/customer/home.do
			response.sendRedirect(request.getContextPath() + "/customer" + "/home.do");
			
		} else {
			response.sendRedirect("/customer/join.do");
		}
	}
}
