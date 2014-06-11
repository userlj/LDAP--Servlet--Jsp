package yeaProj;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mysql.jdbc.PreparedStatement;

/**
 * Servlet implementation class Login
 */
@WebServlet("/selectAward")
public class selectAward extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public selectAward() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		

		String asid = request.getParameter("asid");
		String awardType = request.getParameter("awardType");

		Date cdate = new Date(System.currentTimeMillis());
		
		response.setContentType("text/html");
		PrintWriter pw = response.getWriter();

		try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			String url = "jdbc:mysql://bigyellowcat.cs.binghamton.edu/meng";
			Connection con = DriverManager.getConnection(url, "meng", "meng7842");

			
			String qs = "UPDATE Award_Submitted "
					+ "SET awardType=?, chosenDate=? "
					+ "WHERE asid=?";
			
			PreparedStatement pst = (PreparedStatement) con.prepareStatement(qs);
			
			pst.setString(1, awardType);
			pst.setDate(2, cdate);
			pst.setString(3, asid);


			int i = pst.executeUpdate();
			if (i != 0) {
				
				pw.println("<p><b>Your award choice has been successful!</b>");
				pw.println("<p>The award will be mailed to you in a week.");
				pw.println("Thank you.");
				pw.println("<p><a href='entrance.jsp'>Home</a>");
				pw.println("<a href='submitAward.jsp'>Another Submission</a>");
				request.setAttribute("msg", "Congratulations! Your award choice has been successful! The award will be mailed to you in a week.");
				RequestDispatcher view = request.getRequestDispatcher("viewAward.jsp");
				view.forward(request, response);
				//response.sendRedirect("viewAward.jsp");

			} else {
				pw.println("<p><b>Your award has <font color=red>NOT</font> been successfully selected due"
						+ "to unexpected error, please try again.</b>");
				pw.println("<br><a href='entrance.jsp'>Home</a>");
				pw.println("<a href='viewAward.jsp'>View Award</a>");
				
			}

		}

		catch (Exception se) {
			se.printStackTrace();
		}

	}

}
