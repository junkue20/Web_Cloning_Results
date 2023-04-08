package pinterestController;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(urlPatterns = {"/pinterest.html"})
public class Pinterest extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public Pinterest() {
	}
//	${pageContext.request.contextPath}/resources/day08/
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// main.jsp 파일 랜더링 
		request.getRequestDispatcher("/WEB-INF/day07/pinterest.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}
}
