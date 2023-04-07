package jejuWebController;

import java.io.IOException;

import config.MyBatisContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import webmapper.BoardMapper;

@WebServlet(urlPatterns = { "/board/deleteone.do" })

public class BoardDeleteOne extends HttpServlet {
	private static final long serialVersionUSID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BoardMapper mapper = MyBatisContext.getSqlSession().getMapper(BoardMapper.class);

		long no = Long.parseLong(request.getParameter("no"));
		
		
		request.setAttribute("no", no);
		
		int ret = mapper.deleteBoardOne(no);		
		
		if(ret == 1) { // 성공했을 때 => 게시판 목록 이동
			// 주소창을 selectlist.do로 변경시키고, 엔터키를 누름. GET
			response.sendRedirect("select.do");
		}
		else { // 실패했을때 => 다시 게시글 화면으로 이동
			// 주소창을 insertone.do로 변경시키고 엔터키를 자동화 GET
			response.sendRedirect("selectone.do?no=${no}");
		}
	}
}
