package customerController;

import java.io.IOException;

import config.MyBatisContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import webdto.Purchase;
import webmapper.PurchaseMapper;

// 127.00.1:8080/web01/customer/home.do
@WebServlet(urlPatterns = { "/customer/purchase.do" })
public class CustomerPurchase extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/customer/purchase.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// DB에 추가하기
		long itemno = Long.parseLong(request.getParameter("itemno"));
		long cnt = Long.parseLong(request.getParameter("cnt"));
		String customerid = (String) request.getSession().getAttribute("UID");

		Purchase obj = new Purchase();
		obj.setItemno(itemno);
		obj.setCnt(cnt);
		obj.setCustomerid(customerid);

		int ret = MyBatisContext.getSqlSession().getMapper(PurchaseMapper.class).insertPurchase(obj);
		if (ret != 1) {
			request.setAttribute("url", "product.do?itemno=" + itemno);
			request.setAttribute("icon", "error");
			request.setAttribute("title", "주문 실패");
			request.setAttribute("text", "다시 시도해주세요.");
			request.getRequestDispatcher("/WEB-INF/alert.jsp").forward(request, response);
		}
		response.sendRedirect("mypage.do?menu=4");
	}
	
}
