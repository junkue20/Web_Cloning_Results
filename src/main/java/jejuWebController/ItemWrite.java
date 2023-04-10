package jejuWebController;

import java.io.IOException;

import config.MyBatisContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import webdto.Item;
import webmapper.ItemMapper;

@WebServlet(urlPatterns = { "/item/write.do" })
public class ItemWrite extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ItemWrite() {
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// main.jsp 파일 랜더링
		request.getRequestDispatcher("/WEB-INF/item_write.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		Item obj = new Item();
		obj.setName(request.getParameter("name"));
		obj.setPrice(Long.parseLong(request.getParameter("price")));
		obj.setContent(request.getParameter("content"));
		obj.setQuantity(Long.parseLong(request.getParameter("quantity")));
		
		// 전달받은 값 확인용
		System.out.println(obj.toString());
		
		// Mapper를 통한 데이터 추가
		int ret = MyBatisContext.getSqlSession().getMapper(ItemMapper.class)
				.insertItemOne(obj);
		
		if (ret==1) {
			// 절대 경로를 이용한 페이지 이동
			response.sendRedirect(request.getContextPath() + "/item" + "/select.do");
		}
		else {
			// 상대 결로를 이용한 페이지 이동
			response.sendRedirect("write.do");
		}
	}

}
