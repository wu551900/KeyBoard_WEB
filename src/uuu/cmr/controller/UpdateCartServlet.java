package uuu.cmr.controller;

import java.io.IOException;
import java.util.HashSet;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import uuu.cmr.entity.CartItem;
import uuu.cmr.entity.ShoppingCart;

/**
 * Servlet implementation class UpdateCartServlet
 */
@WebServlet("/member/update_cart.do")
public class UpdateCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateCartServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		ShoppingCart cart = (ShoppingCart)session.getAttribute("cart");
		if(cart!=null && cart.size()>0) {
			
			Set<CartItem> trashCan = new HashSet<>();
			for(CartItem item:cart.getCartItemSet()) {
				//1.讀取request中這筆item的quantity和delete
				String quantity = request.getParameter("quantity" + item.hashCode());
				String delete = request.getParameter("delete" + item.hashCode());
				//2.呼叫商業邏輯
				if(delete==null) {
					//修改該item數量
					cart.updateCart(item, Integer.parseInt(quantity));
				}else {
					//直接從cart刪除該item數量
					//cart.remove(item);//可能在runtime發生java.util.ConcurrentModificationException
					
					//將該item移至trashCan
					trashCan.add(item);
				}
			}
			for(CartItem item:trashCan) {
				cart.remove(item);
			}
			trashCan.clear();
		}
		
		//3.外部轉交給cart.jsp
		response.sendRedirect(request.getContextPath()+"/member/cart.jsp");
	}

}
