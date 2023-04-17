package customerController;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import config.MyBatisContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import webmapper.PurchaseMapper;

// 127.00.1:8080/web01/customer/home.do
@WebServlet(urlPatterns = { "/customer/deletepurchase.do" })
public class CustomerDeletePurchase extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String[] chk = request.getParameterValues("chk[]");
		String id = (String) request.getSession().getAttribute("UID");
		Map<String, Object> map = new HashMap<>();
		map.put("chk",chk);
		map.put("id",id);
		MyBatisContext.getSqlSession().getMapper(PurchaseMapper.class).deletePurchase(map);	
		response.sendRedirect("mypage.do?menu=4");
	}
	
}
