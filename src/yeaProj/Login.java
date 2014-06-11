package yeaProj;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Login
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
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
		
		String usernameString = request.getParameter("username");
		String passwordString = request.getParameter("password");
		HttpSession session = request.getSession();

		try{
			//response.setContentType("text/html");

			Class.forName ("com.mysql.jdbc.Driver").newInstance();
			String url = "jdbc:mysql://bigyellowcat.cs.binghamton.edu/meng";
			Connection  con  = DriverManager.getConnection(url,"meng","meng7842");
			
			// create sql statement
			String qs = "SELECT * FROM Users WHERE uid = '" + usernameString + "'";
			String qs1 = "SELECT * FROM Award_Submitted WHERE ruid= '" + usernameString + "'";
			Statement stmt = con.createStatement();
			
			// execute the statement
			ResultSet rs = stmt.executeQuery(qs);
			
			
			// get an output stream to send back the data
			//ServletOutputStream out = response.getOutputStream();

			// process the result set
			//PrintWriter out =response.getWriter();
			//out.println("<html><body><center><h2>My Fancy Query Page</h2></center><br>");
			//out.println("<table><tr>");
			String apsw;
			String atype;
			if (rs.next()) {
				apsw = rs.getString("userpassword");
				atype = rs.getString("type");
				if (apsw.equals(passwordString)) {
					request.setAttribute("result", "successful login!");
					session.setAttribute("status","login"); 
					session.setAttribute("user", usernameString);
					session.setAttribute("type", atype);
				} else {
					request.setAttribute("result", "Wrong password!");
				}
				//     out.println("<td>"+aid + "</td></tr>");
			} else {
				request.setAttribute("result", "Username doesn't exist!");
			}
			//  out.println("</table></body></html>");
			
			
			ResultSet rs1 = stmt.executeQuery(qs1);
			String valid;
			if (rs1.next()) {
				valid = rs1.getString("valid");
				if (valid.equals("true")) {
					session.setAttribute("recipient","true"); 
				} else {
					session.setAttribute("recipient","false"); 
				}
				//     out.println("<td>"+aid + "</td></tr>");
			}
		}


		catch(Exception se) {se.printStackTrace(); }

		  
		  
		RequestDispatcher view = request.getRequestDispatcher("/entrance.jsp");
		view.forward(request, response);
		
	}

}
