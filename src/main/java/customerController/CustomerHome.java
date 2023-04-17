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
@WebServlet(urlPatterns = { "/customer/home.do" })
public class CustomerHome extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
	List<Item> list = MyBatisContext.getSqlSession().getMapper(ItemMapper.class)
			.selectItemListAll();
	
	for(Item item: list) {
		// 먼저 대표 이미지번호를 저장해둘 변수를 Item dto에 생성해준뒤, itemImageMapper에 이미지넘버를 불러오는 mapper를 작성한다.
		
		// mapper를 호출하여 해당물품의 가장 먼저 등록했던 이미지번호 1개를 가져온다.
		long imageNo = MyBatisContext.getSqlSession()
				  		.getMapper(ItemImageMapper.class)
				  		.selectItemImageMinOne(item.getNo());
		item.setImageNo(imageNo);
	}
	request.setAttribute("list", list);
	request.getRequestDispatcher("/WEB-INF/customer/home.jsp").forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}
}
