package jejuWebController;

import java.io.IOException;

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

// 컨트롤러 역활 X, DB에 있는 이미지를 URL 형태로 변경해서 반환하는 용도
@WebServlet(urlPatterns = { "/item/imageupdate.do" })
@MultipartConfig()
public class ItemImageUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;

// ex) http://127.0.0.1:8080/web01/item/image?no=물품번호
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		System.out.println(request.getParameter("imageNo")); 
		
		long imageNo = Long.parseLong(request.getParameter("imageNo"));
		long itemNo = Long.parseLong(request.getParameter("ino"));
		Part file = request.getPart("file"); // 첨부된 이미지 파일

		if (file.getSize() > 0) {
			ItemImage itemimage = new ItemImage();
			itemimage.setNo(imageNo);
			itemimage.setItemno(itemNo);
			itemimage.setFilename(file.getSubmittedFileName());
			itemimage.setFilesize(file.getSize());
			itemimage.setFiledata(file.getInputStream().readAllBytes());
			itemimage.setFiletype(file.getContentType());

			int ret = MyBatisContext.getSqlSession().getMapper(ItemImageMapper.class).updateItemImageOne(itemimage);
			if (ret == 1) { // 변경 완료한 경우
//				request.setAttribute("message", "변경 완료되었습니다.");
				request.setAttribute("icon", "success");
				request.setAttribute("title", "변경완료");
				request.setAttribute("text", "화끈하시네요!");
				request.setAttribute("url", "imagewrite.do?ino=" + itemNo);
				request.getRequestDispatcher("/WEB-INF/alert.jsp").forward(request, response);
			} else { // 변경 실패한 경우
//				request.setAttribute("message", "변경 실패");
				request.setAttribute("icon", "warning");
				request.setAttribute("title", "변경실패");
				request.setAttribute("text", "변경에 실패했어요..");
				request.setAttribute("url", "imagewrite.do?ino=" + itemNo);
				request.getRequestDispatcher("/WEB-INF/alert.jsp").forward(request, response);
			}
		} else { // 변경사항 없는 경우
//			request.setAttribute("message", "변경사항 없음");
			request.setAttribute("icon", "question");
			request.setAttribute("title", "파일없음");
			request.setAttribute("text", "파일이.. 없네요?");
			request.setAttribute("url", "imagewrite.do?ino=" + itemNo);
			request.getRequestDispatcher("/WEB-INF/alert.jsp").forward(request, response);
		}

	}
}
