package jejuWebController;

import java.io.IOException;
import java.util.List;

import config.MyBatisContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import webdto.ItemImage;
import webmapper.ItemImageMapper;

@WebServlet(urlPatterns = { "/item/imagewrite.do" })
@MultipartConfig
public class ItemImageWrite extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ItemImageWrite() {
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		// 1. 주소창의 물품번호 가져오기
		long ino = Long.parseLong(request.getParameter("ino"));
		request.setAttribute("ino", ino);
		
		// 2. 물품번호에 해당하는 이미지 번호들
		List<Long> imageNo = MyBatisContext.getSqlSession()
				.getMapper(ItemImageMapper.class)
				.selectItemImageList(ino);
		request.setAttribute("imageNo", imageNo);

		request.getRequestDispatcher("/WEB-INF/item_img_write.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		long ino = Long.parseLong(request.getParameter("ino"));
		Part part = request.getPart("file");

		ItemImage obj = new ItemImage();
		obj.setItemno(ino);
		obj.setFilename(part.getSubmittedFileName()); // 첨부한 파일명
		obj.setFilesize(part.getSize()); // 첨부한 파일크기
		obj.setFiletype(part.getContentType()); // 첨부한 파일의 종류 (gif, jpg, png ...)
		obj.setFiledata(part.getInputStream().readAllBytes()); // 첨부한 파일 실제 데이터

		int ret = MyBatisContext.getSqlSession()
				.getMapper(ItemImageMapper.class)
				.insertItemImage(obj);

		if (ret == 1) {
			// 절대경로
			response.sendRedirect(request.getContextPath() + "/item" + "/imagewrite.do?ino=" + ino);
		}
		
		else {
			// 상대경로
			response.sendRedirect("imagewrite.do?ino=" + ino);
		}
	}
}
