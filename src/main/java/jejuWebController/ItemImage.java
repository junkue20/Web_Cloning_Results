package jejuWebController;

import java.io.IOException;

import config.MyBatisContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import webmapper.ItemImageMapper;


@WebServlet(urlPatterns = { "/item/image" })
public class ItemImage extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ItemImage() {
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ItemImageMapper mapper = MyBatisContext.getSqlSession().getMapper(ItemImageMapper.class);
		
		long no = Long.parseLong( request.getParameter("no") );
		
		// no를 전달하여 ItemImage정보 1개 가져옴.
		webdto.ItemImage obj = mapper.selectItemImageOne(no);
				
		response.setContentType(obj.getFiletype());// 이건 이미지다. html이 아니다.
		response.setStatus(200); // 200은 정상적인 처리결과다.
		response.getOutputStream().write(obj.getFiledata()); // 이게 실제 정보이다.
	}
}
