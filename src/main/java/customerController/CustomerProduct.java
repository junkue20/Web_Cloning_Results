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
@WebServlet(urlPatterns = { "/customer/product.do" })
public class CustomerProduct extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String itemno = request.getParameter("itemno");

		System.out.println(itemno);
		
		if (itemno == null) {
			response.sendRedirect("home.do");
			return;
		}
		// itemMapper에서 물품정보 받기
		Item obj = MyBatisContext.getSqlSession().getMapper(ItemMapper.class)
				.selectOneItem(Long.parseLong(itemno));
		request.setAttribute("obj", obj); // 물품정보 전송
		
		// itemImageMapper에서 물품이미지 번호 받기
		List<Long> imageNo = MyBatisContext.getSqlSession().getMapper(ItemImageMapper.class)
				.selectItemImageList(Long.parseLong(itemno)); // 한 물품의 모든 이미지들 select
		request.setAttribute("imageNo", imageNo); // 물품이미지 번호 전송

		// product.jsp 페이지로 전송
		request.getRequestDispatcher("/WEB-INF/customer/product.jsp").forward(request, response);
	}
}
