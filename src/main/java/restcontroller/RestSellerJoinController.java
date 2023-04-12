package restcontroller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import com.google.gson.Gson;

import config.Hash;
import config.MyBatisContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import webdto.Member;
import webmapper.MemberMapper;

//127.00.1:8080/web01/api/seller/join.json
@WebServlet(urlPatterns = { "/api/seller/join.json" })
public class RestSellerJoinController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private Gson gson = new Gson();
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String hashPw = Hash.hashPW(request.getParameter("id"), request.getParameter("pw"));

		Member obj = new Member();
		obj.setId(request.getParameter("id"));
		obj.setPassword(hashPw);
		obj.setName(request.getParameter("name"));
		obj.setAge(Integer.parseInt(request.getParameter("age")));
		obj.setRole("SELLER");
		
		int ret = MyBatisContext.getSqlSession().getMapper(MemberMapper.class)
				.insertMemberOne(obj);

		Map<String, Object> map = new HashMap<>();
		map.put("ret", 0); // map => {"result":0}
		
		if (ret == 1) {
			map.put("ret", 1); // {"result":1}
		} 
		// 오브젝트타입 json으로 변경 (gson라이브러리)
		String jsonString = gson.toJson(map);
		
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		out.print(jsonString);
		out.flush();
	}
}
