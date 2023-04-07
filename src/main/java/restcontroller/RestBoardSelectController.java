package restcontroller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.google.gson.Gson;

import config.MyBatisContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import webdto.Board;
import webmapper.BoardMapper;

@WebServlet(urlPatterns = { "/api/board/select.json" })
public class RestBoardSelectController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Gson gson = new Gson(); // 라이브러리를 이용한 객체생성

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 문자로된 페이지 정보를 전달받음.
		String page = request.getParameter("page");

		// 10개 단위로 가져오기 위한 페이지네이션(PN) 시작값과 종료값
		int start = Integer.parseInt(page) * 10 - 9;
		int end = Integer.parseInt(page) * 10;

		// mapper를 통한 결과조회
		List<Board> list = MyBatisContext.getSqlSession()
				.getMapper(BoardMapper.class).selectBoardList(start, end);

		long cnt = MyBatisContext.getSqlSession()
				.getMapper(BoardMapper.class).countBoardList();

		// 전송하는 데이터 타입설정 (json문서) <= text/html을 json문서로
		response.setContentType("application/json");

		// list 객체를 json으로 변환
		Map<String, Object> map = new HashMap<>(); // 페이지네이션
		map.put("list", list);
		map.put("pages", (cnt - 1) / 10 + 1);
		String jsonString = gson.toJson(map);

		// 호출된곳으로 값을 전송.
		PrintWriter out = response.getWriter();
		out.print(jsonString);
		out.flush();
	}
}
