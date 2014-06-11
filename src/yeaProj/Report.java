package yeaProj;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Report
 */
@WebServlet("/Report")
public class Report extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Report() {
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

		String dateString = request.getParameter("date");
		String reportType = request.getParameter("reportType");
		String deptNo = request.getParameter("deptNo");
		String eUid = request.getParameter("eserial");
		String eType = request.getParameter("etype");

		//Date cdate = new Date(System.currentTimeMillis());
		
		response.setContentType("text/html");
		//PrintWriter pw = response.getWriter();

		try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			String url = "jdbc:mysql://bigyellowcat.cs.binghamton.edu/meng";
			Connection con = DriverManager.getConnection(url, "meng", "meng7842");

			
			String qs = null;
			if (reportType.equals("dept")) {
				
				qs = "SELECT * FROM Award_Submitted "
					+ "WHERE submitterD='"+deptNo+"' OR recipientD='"+deptNo+"'";
				
			} else if (reportType.equals("empl")) {
				
				
				if (eType.equals("submitter")) {
					qs = "SELECT * FROM Award_Submitted"
							+ " WHERE suid='"+eUid+"'";
					
				} else if (eType.equals("recipient")) {
					qs = "SELECT * FROM Award_Submitted"
							+ " WHERE ruid='"+eUid+"'";
					
				} else {
					System.err.println("Please select either submitter or recipient.");
					
				}
				
			} else {
				System.err.println("Please select either department report or employee report.");
				
			}
			
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(qs);
            
            ServletOutputStream out = response.getOutputStream();
            out.println("<html><body><h2>Report</h2><br>");
            out.println("<i>"+dateString+"</i><p>");
            out.println("<table border=1px><tr><th>submitter</th><th>submitter department</th>");
            out.println("<th>recipient</th><th>recipient department</th>");
            out.println("<th>award type</th><th>submit date</th><th>chosen date</th>");
            out.println("<th>valid</th></tr>");
            while (rs.next())
            {
            	String scn = rs.getString("submitterN");
            	String sdept = rs.getString("submitterD");
            	String rcn = rs.getString("recipientN");
            	String rdept = rs.getString("recipientD");
            	String atype = rs.getString("awardType");
            	Date sDate = rs.getDate("submitDate");
            	Date cDate = rs.getDate("chosenDate");
            	String valid = rs.getString("valid");
            	
            	out.println("<tr><td>"+scn + "</td><td>" + sdept + "</td><td>"
            				+rcn+"</td><td>"+ rdept + "</td><td>" + atype+
            				"</td><td>"+sDate+"</td><td>"+cDate+"</td><td>"
            				+ valid +"</td></tr>");
            }
            out.println("</table>");
			out.println("<p><a href='entrance.jsp'>Home</a>");
			out.println("<a href='reports.jsp'>Back</a></body></html>");

			} catch (Exception se) {
				se.printStackTrace();
		}

	}

}
