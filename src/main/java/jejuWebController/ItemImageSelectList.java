package jejuWebController;

import java.io.IOException;
import java.util.List;

import config.MyBatisContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import webmapper.ItemImageMapper;


@WebServlet(urlPatterns = { "/item/selectimagelist" })
public class ItemImageSelectList extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ItemImageMapper mapper = MyBatisContext.getSqlSession().getMapper(ItemImageMapper.class);

		long ino = Long.parseLong(request.getParameter("ino"));
    //  <a href="selectimagelist.do?itemno=${obj.no}"><button>등록된이미지보기</button></a>

		List<Long> no = mapper.selectItemImageList(ino);

		// mapper로 itemno를 전달해서 해당하는 이미지번호만 리턴
		
		
		request.setAttribute("no", no );
		request.getRequestDispatcher("/WEB-INF/item_img_write.jsp").forward(request, response);


	}
}
