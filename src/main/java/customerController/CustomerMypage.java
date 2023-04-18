package customerController;

import java.io.IOException;
import java.util.List;

import config.Hash;
import config.MyBatisContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import webdto.Address;
import webdto.Member;
import webdto.PurchaseView;
import webmapper.AddressMapper;
import webmapper.MemberMapper;
import webmapper.PurchaseMapper;

// 127.00.1:8080/web01/customer/home.do
@WebServlet(urlPatterns = { "/customer/mypage.do" })
public class CustomerMypage extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String menu = request.getParameter("menu");
		if (menu == null) {
			response.sendRedirect("mypage.do?menu=1");
			return; // 메소드 종료, 아래쪽 실행안됨.
		}

		// 세션에서 아이디 꺼내기
		String id = (String) request.getSession().getAttribute("UID");
		String name = (String) request.getSession().getAttribute("UNAME");
		String role = (String) request.getSession().getAttribute("UROLE");
		String age = (String) request.getSession().getAttribute("UAGE");
		if (Integer.parseInt(menu) == 1) { // 정보변경시
			Member obj = MyBatisContext.getSqlSession().getMapper(MemberMapper.class).selectMemberOne(id);
			// 아이디를 전송해서 이름과 나이를 받아옴.
			request.setAttribute("obj", obj);
		}
		else if (Integer.parseInt(menu) == 4) { // 구매내역 조회
			List<PurchaseView> list = MyBatisContext.getSqlSession().getMapper(PurchaseMapper.class).selectPurchaseViewMember(id);
			request.setAttribute("list", list);
		}
		else if (Integer.parseInt(menu) == 5){ // 주소관리
			List<Address> list =  MyBatisContext.getSqlSession().getMapper(AddressMapper.class).selectMemberAddress(id);
			request.setAttribute("list", list);
		}
		request.getRequestDispatcher("/WEB-INF/customer/mypage.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int menu = Integer.parseInt(request.getParameter("menu"));
		String id = (String) request.getSession().getAttribute("UID");
		
		if (menu == 1) { // 이름, 나이변경
			String name = request.getParameter("name");
			int age = Integer.parseInt(request.getParameter("age"));
			Member obj = new Member();
			obj.setId(id);
			obj.setName(name);
			obj.setAge(age);
			
			int ret = MyBatisContext.getSqlSession().getMapper(MemberMapper.class).updateMemberInfo(obj);

			if (ret == 1) {
				request.setAttribute("url", "mypage.do");
				request.setAttribute("icon", "success");
				request.setAttribute("title", "정보변경 성공!");
				request.setAttribute("text", "이제" + name + "님이라고 불러드려야겠네요.");
				request.getRequestDispatcher("/WEB-INF/alert.jsp").forward(request, response);
			} else {
				request.setAttribute("url", "mypage.do");
				request.setAttribute("icon", "error");
				request.setAttribute("title", "정보변경 실패!");
				request.setAttribute("text", "변경이 적용되지 않았어요. 다시 시도해주세요.");
				request.getRequestDispatcher("/WEB-INF/alert.jsp").forward(request, response);
			}
			
		} else if (menu == 2) { // 비밀번호 변경
			String password = request.getParameter("password");
			String newPassword = request.getParameter("newPassword");

			String oldHashPw = Hash.hashPW(id, password);
			String newHashPw = Hash.hashPW(id, newPassword);
			Member obj = new Member();
			obj.setId(id);
			obj.setPassword(oldHashPw);
			obj.setNewPassword(newHashPw);
			// mapper 호출 후 변경
			int ret = MyBatisContext.getSqlSession().getMapper(MemberMapper.class).updateMemberPw(obj);

			// sweetAlert
			if (ret == 1) {
				request.setAttribute("url", "mypage.do");
				request.setAttribute("icon", "success");
				request.setAttribute("title", "비밀번호변경 성공!");
				request.setAttribute("text", "이제 좀 더 안전해졌어요!");
				request.getRequestDispatcher("/WEB-INF/alert.jsp").forward(request, response);
			} else {
				request.setAttribute("url", "mypage.do?menu=2");
				request.setAttribute("icon", "error");
				request.setAttribute("title", "비밀번호변경 실패!");
				request.setAttribute("text", "비밀번호를 다시 한번 확인해주세요.");
				request.getRequestDispatcher("/WEB-INF/alert.jsp").forward(request, response);
			}

			
		} else if (menu == 3) { // 회원탈퇴
			String password = request.getParameter("password");
			String hashPw = Hash.hashPW(id, password);
			Member obj = new Member();
			obj.setId(id);
			obj.setPassword(hashPw);
			
			// mapper 호출 후 탈퇴
			int ret = MyBatisContext.getSqlSession().getMapper(MemberMapper.class).deleteMemberInfo(obj);

			// sweetAlert
			if (ret == 1) {
				HttpSession httpSession = request.getSession();
				httpSession.invalidate();
				request.setAttribute("url", "mypage.do");
				request.setAttribute("icon", "success");
				request.setAttribute("title", "탈퇴가 완료되었습니다.");
				request.setAttribute("text", "그동안 감사했어요!");
				request.getRequestDispatcher("/WEB-INF/alert.jsp").forward(request, response);
			} else {
				request.setAttribute("url", "mypage.do?menu=3");
				request.setAttribute("icon", "error");
				request.setAttribute("title", "비밀번호가 일치하지 않습니다!");
				request.setAttribute("text", "비밀번호를 다시한번 확인해주세요.");
				request.getRequestDispatcher("/WEB-INF/alert.jsp").forward(request, response);
			}
		}

	}
}
