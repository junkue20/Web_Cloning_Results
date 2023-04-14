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
import webdto.Member;
import webmapper.ItemMapper;
import webmapper.MemberMapper;

// 컨트롤러 역활 X, DB에 있는 이미지를 URL 형태로 변경해서 반환하는 용도
@WebServlet(urlPatterns = { "/seller/join.do" })
@MultipartConfig()
public class SellerJoin extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// 1. 판매자용 회원가입 화면만들기
	// 2. 판매자 회원가입용 rest api 만들기
	// 3. axios.post를 이용한 회원가입
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {		
		
		request.getRequestDispatcher("/WEB-INF/seller/join.jsp").forward(request, response);

	}
}
