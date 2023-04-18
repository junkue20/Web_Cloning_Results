package customerController;

import java.io.IOException;

import config.MyBatisContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import webdto.Address;
import webmapper.AddressMapper;

// 127.0.0.1:8080/web01/customer/insertaddress.do
@WebServlet(urlPatterns = { "/customer/insertaddress.do" })
public class CustomerInsertAddress extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
	}
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String id = (String) request.getSession().getAttribute("UID");
		
		Address obj = new Address();
		obj.setMemberid(id);
		obj.setPostcode( request.getParameter("postcode") );
		obj.setAddress( request.getParameter("address") + " " + request.getParameter("detailAddress") + " " +request.getParameter("extraAddress") );

		int ret = MyBatisContext.getSqlSession().getMapper(AddressMapper.class)
			.insertMemberAddress(obj);
		if (ret == 1) {
			request.setAttribute("url", "mypage.do?menu=5");
			request.setAttribute("icon", "success");
			request.setAttribute("title", "등록완료");
			request.setAttribute("text", "등록에 성공했어요!");
			request.getRequestDispatcher("/WEB-INF/alert.jsp").forward(request, response);
		} else {
			request.setAttribute("url", "mypage.do?menu=5");
			request.setAttribute("icon", "error");
			request.setAttribute("title", "등록실패");
			request.setAttribute("text", "정보가 등록되지 않았어요. 잠시 후 다시 시도해주세요.");
			request.getRequestDispatcher("/WEB-INF/alert.jsp").forward(request, response);
		}
	}
}
