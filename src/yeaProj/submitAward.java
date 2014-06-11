package yeaProj;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mysql.jdbc.PreparedStatement;

/**
 * Servlet implementation class Login
 */
@WebServlet("/submitAward")
public class submitAward extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public submitAward() {
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

		String scnString = request.getParameter("scn");
		String sdeptString = request.getParameter("sdept");
		String suidString = request.getParameter("suid");
		String rcnString = request.getParameter("rcn");
		String rdeptString = request.getParameter("rdept");
		String rmailString = request.getParameter("rmail");
		String ruidString = request.getParameter("ruid");
		String descString = request.getParameter("desc");

		Date sdate = new Date(System.currentTimeMillis());
		//String sdateString = sdate.toString();
		
		
		response.setContentType("text/html");
		PrintWriter pw = response.getWriter();

		try {

			Class.forName("com.mysql.jdbc.Driver").newInstance();
			String url = "jdbc:mysql://bigyellowcat.cs.binghamton.edu/meng";
			Connection con = DriverManager.getConnection(url, "meng", "meng7842");

			
			String qs = "INSERT INTO Award_Submitted "
					+ "(valid, suid, submitterN, submitterD, ruid, recipientN,"
					+ " recipientD, recipientM, awardType, description, submitDate)"
					+ "VALUES ('true',?,?,?,?,?,?,?,'N/A',?,?)";


			PreparedStatement pst = (PreparedStatement) con.prepareStatement(qs);
			
			pst.setString(1, suidString);
			pst.setString(2, scnString);
			pst.setString(3, sdeptString);
			pst.setString(4, ruidString);
			pst.setString(5, rcnString);
			pst.setString(6, rdeptString);
			pst.setString(7, rmailString);
			pst.setString(8, descString);
			pst.setDate(9, sdate);


			int i = pst.executeUpdate();
			if (i != 0) {
				pw.println("<p><b>Your award has been successfully submitted!</b>");
				pw.println("<p>An email has been sent to the recipient's manager for further permission.");
				pw.println("Thank you.");
				pw.println("<p><a href='entrance.jsp'>Home</a>");
				pw.println("<a href='submitAward.jsp'>Another Submission</a>");

			} else {
				pw.println("<p><b>Your award has <font color=red>NOT</font> been successfully submitted due"
						+ "to unexpected error, please try again.</b>");
				pw.println("<br><a href='entrance.jsp'>Home</a>");
				pw.println("<a href='submitAward.jsp'>Another Submission</a>");
				
			}

		}

		catch (Exception se) {
			se.printStackTrace();
		}

	}

}
