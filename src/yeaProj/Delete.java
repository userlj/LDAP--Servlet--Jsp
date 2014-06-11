package yeaProj;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mysql.jdbc.PreparedStatement;

/**
 * Servlet implementation class Report
 */
@WebServlet("/Delete")
public class Delete extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Delete() {
        super();
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


		String delId = request.getParameter("delId");
		
		response.setContentType("text/html");
		PrintWriter pw = response.getWriter();

		try {

			Class.forName("com.mysql.jdbc.Driver").newInstance();
			String url = "jdbc:mysql://bigyellowcat.cs.binghamton.edu/meng";
			Connection con = DriverManager.getConnection(url, "meng", "meng7842");

			
			String qs = "DELETE FROM Award_Submitted WHERE asid=?";


			PreparedStatement pst = (PreparedStatement) con.prepareStatement(qs);
			
			pst.setString(1, delId);



			int i = pst.executeUpdate();
			if (i != 0) {
				pw.println("<p><b>This record has been successfully submitted!</b>");
				pw.println("Thank you.");
				pw.println("<p><a href='entrance.jsp'>Home</a>");
				pw.println("<a href='search.jsp'>Back</a>");

			} else {
				pw.println("<p><b>This record has <font color=red>NOT</font> been successfully deleted due "
						+ "to unexpected error, please try again.</b>");
				pw.println("<br><a href='entrance.jsp'>Home</a>");
				pw.println("<a href='search.jsp'>Back</a>");
				
			}

		}

		catch (Exception se) {
			se.printStackTrace();
		}

	}

}
