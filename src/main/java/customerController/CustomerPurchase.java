package customerController;

import java.io.IOException;
import java.util.List;

import config.MyBatisContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import webdto.Item;
import webmapper.ItemImageMapper;
import webmapper.ItemMapper;

// 127.00.1:8080/web01/customer/home.do
@WebServlet(urlPatterns = { "/customer/purchase.do" })
public class CustomerPurchase extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}
}
