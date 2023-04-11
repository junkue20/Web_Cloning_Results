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
@WebServlet(urlPatterns = { "/item/image" })
public class ItemImage extends HttpServlet {
	private static final long serialVersionUID = 1L;

// ex) http://127.0.0.1:8080/web01/item/image?no=물품번호
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ItemImageMapper mapper = MyBatisContext.getSqlSession().getMapper(ItemImageMapper.class);
		// img의 위치를 src에 설정하는 용도
		long no = Long.parseLong( request.getParameter("no") );
		// no를 전달하여 ItemImage정보 1개 가져옴.
		webdto.ItemImage obj = mapper.selectItemImageOne(no);
				
		response.setContentType(obj.getFiletype());// 이건 이미지다. html이 아니다.
		response.setStatus(200); // 200은 정상적인 처리결과다.
		response.getOutputStream().write(obj.getFiledata()); // 이게 실제 정보이다.
	}
}
