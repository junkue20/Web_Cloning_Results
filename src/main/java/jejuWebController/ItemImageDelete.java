package jejuWebController;

import java.io.IOException;

import config.MyBatisContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import webmapper.ItemImageMapper;

// 컨트롤러 역활 X, DB에 있는 이미지를 URL 형태로 변경해서 반환하는 용도
@WebServlet(urlPatterns = { "/item/imagedelete.do" })
public class ItemImageDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;

// ex) http://127.0.0.1:8080/web01/item/image?no=물품번호
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 삭제를 위해 필요한 값 (물품번호, 이미지번호)
		long imageNo = Long.parseLong(request.getParameter("no"));
		long itemNo = Long.parseLong(request.getParameter("ino"));
		// Mapper를 통한 삭제
		int ret = MyBatisContext.getSqlSession()
				.getMapper(ItemImageMapper.class)
				.deleteItemImageListOne(imageNo, itemNo);

		// 삭제 후 보내는 페이지
		if (ret == 1) {
			response.sendRedirect(request.getContextPath() + "/item" + "/imagewrite.do?ino=" + itemNo);
		} else {
			response.sendRedirect("imagewrite.do?ino=" + itemNo);
		}
	}
}
