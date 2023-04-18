package customerController;

import java.io.IOException;

import config.MyBatisContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import webdto.Address;
import webmapper.AddressMapper;

// 127.00.1:8080/web01/customer/deleteaddress.do
@WebServlet(urlPatterns = { "/customer/deleteaddress.do" })
public class CustomerDeleteAddress extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {		
		Address obj = new Address();
		obj.setMemberid((String) request.getSession().getAttribute("UID"));
		obj.setNo(Long.parseLong(request.getParameter("no")));
		
		 int ret = MyBatisContext.getSqlSession().getMapper(AddressMapper.class)
				 .deleteMemberAddress(obj);	
		 if(ret == 1) {
			 response.sendRedirect("mypage.do?menu=5");
			 return;
		 }
		 response.sendRedirect("mypage.do?menu=5");
	}
	
}
