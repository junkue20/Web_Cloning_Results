package jejuWebController;

import java.io.IOException;
import java.util.List;

import config.MyBatisContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import webdto.Board;
import webmapper.BoardMapper;

@WebServlet(urlPatterns = { "/board/updateone.do" })

public class BoardUpdateOne extends HttpServlet {
	private static final long serialVersionUSID = 1L;

	public BoardUpdateOne() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 1. 주소창의 no 가져오기
		String obj = request.getParameter("no");
		// 2. no값이 없으면 목록으로 보내기
		if (obj == null) {
			response.sendRedirect("select.do?page=1");
			return;
		}

		long no = Long.parseLong(obj);

		/* 이전, 다음글 조회하기 */

		// 이전, 다음글
		long prevNo = MyBatisContext.getSqlSession().getMapper(BoardMapper.class).selectPrevBoardOne(no);
		long nextNo = MyBatisContext.getSqlSession().getMapper(BoardMapper.class).selectNextBoardOne(no);
		// no값 전송
		request.setAttribute("prevNo", prevNo);
		request.setAttribute("nextNo", nextNo);

		// 3. no값을 이용해서 mapper호출 후 결과 받기
		Board board = MyBatisContext.getSqlSession().getMapper(BoardMapper.class).selectBoardOne(no);

		// 4. view로 전달
		request.setAttribute("board", board);

		// 5. view 표시
		request.getRequestDispatcher("/WEB-INF/board_selectone.jsp").forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}
}
