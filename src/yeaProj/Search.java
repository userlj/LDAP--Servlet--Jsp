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
@WebServlet("/Search")
public class Search extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Search() {
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

/*		String sDateFromString = request.getParameter("sDateFrom");
		String sDateToString = request.getParameter("sDateTo");
		String rDateFromString = request.getParameter("rDateFrom");
		String rDateToString = request.getParameter("rDateTo");
*/		
		String suid = request.getParameter("suid");
		String slname = request.getParameter("slname");
		String ruid = request.getParameter("ruid");
		String rlname = request.getParameter("rlname");
		String sdept = request.getParameter("sdept");
		String rdept = request.getParameter("rdept");
		String award = request.getParameter("award");
		

//		int numofpage = Integer.parseInt(request.getParameter("numOfPage"));
		

		//Date cdate = new Date(System.currentTimeMillis());
		
		response.setContentType("text/html");
		//PrintWriter pw = response.getWriter();

		try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			String url = "jdbc:mysql://bigyellowcat.cs.binghamton.edu/meng";
			Connection con = DriverManager.getConnection(url, "meng", "meng7842");

			
			String qs = "SELECT * FROM Award_Submitted WHERE 1=1 ";
			
			if (suid != null && !suid.isEmpty()) {
				qs = qs + "AND suid='" + suid + "' ";
				
			} else if (slname != null && !slname.isEmpty()) {
				qs = qs + "AND submitterN LIKE '%" + slname + "%' ";
				
			} else if (ruid != null && !ruid.isEmpty()) {
				qs = qs + "AND ruid='" + ruid + "' ";
				
			} else if (rlname != null && !rlname.isEmpty()) {
				qs = qs + "AND recipientN LIKE '%" + rlname + "%' ";
				
			} else if (sdept != null && !sdept.isEmpty()) {
				qs = qs + "AND submitterD='" + sdept + "' ";
				
			} else if (rdept != null && !rdept.isEmpty()) {
				qs = qs + "AND recipientD='" + rdept + "' ";
				
			} else if (award != null && !award.isEmpty()) {
				qs = qs + "AND awardType='" + award + "' ";
			
			}
			
			
	
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(qs);
            
            ServletOutputStream out = response.getOutputStream();
            out.println("<html><body><h2>Search Results</h2><br>");
            out.println("<table border=1px><tr><th>asid</th><th>submitter</th><th>submitter department</th>");
            out.println("<th>recipient</th><th>recipient department</th>");
            out.println("<th>award type</th><th>submit date</th><th>chosen date</th>");
            out.println("<th>valid</th></tr>");
            
            while (rs.next())
            {
            	String asid = rs.getString("asid");
            	String scn = rs.getString("submitterN");
            	String sDept = rs.getString("submitterD");
            	String rcn = rs.getString("recipientN");
            	String rDept = rs.getString("recipientD");
            	String atype = rs.getString("awardType");
            	Date sDate = rs.getDate("submitDate");
            	Date cDate = rs.getDate("chosenDate");
            	String valid = rs.getString("valid");
            	
            	out.println("<tr><td>"+asid+"</td><td>"+scn + "</td><td>" + sDept + "</td><td>"
            				+rcn+"</td><td>"+ rDept + "</td><td>" + atype+
            				"</td><td>"+sDate+"</td><td>"+cDate+"</td>"
            				+ "<td>" + valid + "</td></tr>");
            }
            out.println("</table>");
			out.println("<p><a href='delete.jsp'>Delete Awards</a>");
			out.println("<a href='update.jsp'>Update Awards</a>");
			out.println("<p><a href='entrance.jsp'>Home</a>");
			out.println("<a href='search.jsp'>Back</a></body></html>");

			
			} catch (Exception se) {
				se.printStackTrace();
		}

	}

}
