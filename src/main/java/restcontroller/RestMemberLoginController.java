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

@WebServlet(urlPatterns = { "/api/member/login.json" })
public class RestMemberLoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private Gson gson = new Gson();
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String hashPw = Hash.hashPW( request.getParameter("id"),request.getParameter("pw"));
		
		Member obj = new Member();
		obj.setId( request.getParameter("id") );
		obj.setPassword( hashPw );
		System.out.println(obj.toString());
		
		Member ret = MyBatisContext.getSqlSession().getMapper(MemberMapper.class)
				.selectmemberLogin(obj);
		
		response.setContentType("application/json");
		Map<String, Object> map = new HashMap<>();
		map.put("ret", 0); // 실패시
		if(ret != null) {
			// react.js, vue.js등의 프런트엔드 프레임워크 개발시 토큰을 발행시킴 
			HttpSession httpSession = request.getSession();
			httpSession.setAttribute("UID", ret.getId());
			httpSession.setAttribute("UROLE", ret.getRole());
			httpSession.setAttribute("UNAME", ret.getName());
			map.put("ret", 1); //성공시
		}
		String jsonString = gson.toJson(map);
		PrintWriter out = response.getWriter();
		out.print(jsonString);
		out.flush();
	}
}
