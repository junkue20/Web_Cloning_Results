package customerController;

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
import webmapper.MemberMapper;

// 127.00.1:8080/web01/api/member/idcheck.json?id=중복아이디
@WebServlet(urlPatterns = { "/api/member/idcheck.json" })
public class RestMemberIDCheck extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Gson gson = new Gson(); // 라이브러리를 이용한 객체생성

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String id = request.getParameter("id");

		// 아이디를 전달, 중복일시 1, 없을시 0 반환
		int ret = MyBatisContext.getSqlSession()
				.getMapper(MemberMapper.class).selectMemberIdCheck(id);

		response.setContentType("application/json");
		Map<String, Object> map = new HashMap<>(); // 페이지네이션
		map.put("ret", ret);
		String jsonString = gson.toJson(map);

		// 호출된곳으로 값을 전송.
		PrintWriter out = response.getWriter();
		out.print(jsonString);
		out.flush();
	}
}
