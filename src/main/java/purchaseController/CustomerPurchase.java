package purchaseController;

import java.io.IOException;
import java.util.List;

import config.MyBatisContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import webdto.Purchase;
import webdto.PurchaseView;
import webmapper.PurchaseMapper;

// 127.0.0.1:8080/web01/purchase/select.do
@WebServlet(urlPatterns = { "/purchase/select.do" })
public class CustomerPurchase extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String menu = request.getParameter("menu");
		if (menu==null) {
			response.sendRedirect("select.do?menu=1");
			return; // 메소드 종료
		}
		request.getRequestDispatcher("/WEB-INF/purchase/purchase_select.jsp").forward(request, response);
	}
	
}

