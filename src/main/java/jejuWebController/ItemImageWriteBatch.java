package jejuWebController;

import java.io.IOException;
import java.util.Collection;

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

@WebServlet(urlPatterns = { "/item/imagewritebatch.do" })
@MultipartConfig
public class ItemImageWriteBatch extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		long ino = Long.parseLong(request.getParameter("ino"));
		request.setAttribute("ino", ino);
		request.getRequestDispatcher("/WEB-INF/item_img_write.jsp").forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		long ino = Long.parseLong(request.getParameter("ino"));
		Collection<Part> partlist = request.getParts();

		for (Part part : partlist) {
			if (part.getName().equals("file[]")) {
				ItemImage obj = new ItemImage();
				obj.setItemno(ino);
				obj.setFilename(part.getSubmittedFileName()); // 첨부한 파일명
				obj.setFilesize(part.getSize()); // 첨부한 파일크기
				obj.setFiletype(part.getContentType()); // 첨부한 파일의 종류 (gif, jpg, png ...)
				obj.setFiledata(part.getInputStream().readAllBytes()); // 첨부한 파일 실제 데이터

				System.out.println(obj);

				int ret = MyBatisContext.getSqlSession().getMapper(ItemImageMapper.class).insertItemImage(obj);
			}
		}
		response.sendRedirect("imagewrite.do?ino=" + ino);

	}
}
