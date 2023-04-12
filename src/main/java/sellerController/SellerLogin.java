package sellerController;

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
@WebServlet(urlPatterns = { "/seller/login.do" })
@MultipartConfig()
public class SellerLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;

// ex) http://127.0.0.1:8080/web01/customer/login.do
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.getRequestDispatcher("/WEB-INF/seller/login.jsp").forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
	}
}
