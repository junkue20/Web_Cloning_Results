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
import jakarta.servlet.http.HttpSession;
import webmapper.PurchaseMapper;

//127.0.0.1:8080/web01/api/purchase/member.json
@WebServlet(urlPatterns = { "/api/purchase/member.json" })
public class RestPurchasememberController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private Gson gson = new Gson();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// mapper를 이용해 회원별 주문수량 합계
		// SELECT customerid, SUM(cnt) cnt FROM purchase GROUP BY customerid;
		response.setContentType("application/json");
		List<Map<String, Object>> list = MyBatisContext.getSqlSession()
					.getMapper(PurchaseMapper.class).seletMemberGroup();
				
		String jsonString = gson.toJson(list);
		PrintWriter out = response.getWriter();
		out.print(jsonString);
		out.flush();
	}
}
