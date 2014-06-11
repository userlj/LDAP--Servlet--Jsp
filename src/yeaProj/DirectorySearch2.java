package yeaProj;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Hashtable;

import javax.naming.Context;
import javax.naming.NamingEnumeration;
import javax.naming.directory.Attribute;
import javax.naming.directory.Attributes;
import javax.naming.directory.DirContext;
import javax.naming.directory.InitialDirContext;
import javax.naming.directory.SearchControls;
import javax.naming.directory.SearchResult;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import domain.LoginUserBean;

/**
 * Servlet implementation class DirectorySearch
 */
@WebServlet("/DirectorySearch2")
public class DirectorySearch2 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DirectorySearch2() {
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

		String usernameString = request.getParameter("slname");
		String BASE = "o=airius.com";
		//String FILTER = "uid=kvaughan";
		String FILTER = "sn="+usernameString;

		try
		{
		       Hashtable<String,String> environment = new Hashtable<String,String>();
		       environment.put(Context.INITIAL_CONTEXT_FACTORY,"com.sun.jndi.ldap.LdapCtxFactory");
		       environment.put(Context.PROVIDER_URL,"ldap://bigyellowcat.cs.binghamton.edu:389");
		       DirContext context = new InitialDirContext(environment);
		       SearchControls scope = new SearchControls();
		       scope.setSearchScope(SearchControls.SUBTREE_SCOPE);
		       NamingEnumeration<?> result = context.search(BASE, FILTER, scope);
		       
		       SearchResult srchresults;
		       //String srchNames = "";
		       
		       ArrayList<LoginUserBean> srchResult = new ArrayList<LoginUserBean>();
		       
		       while (result.hasMoreElements())
		       {
		    	   LoginUserBean newResult = new LoginUserBean();
		    	   
		    	   srchresults = (SearchResult) result.next();
		    	   Attributes attrs = srchresults.getAttributes();
		    	   NamingEnumeration<?>  ne = attrs.getAll();

		    	   while(ne.hasMore()) {
		    		   Attribute attr = (Attribute) ne.next();
		    		   String attrname = attr.getID();
		    		   Enumeration<?> values = attr.getAll();
		    		   
		    		   
		    		   if (attrname.equals("cn")) {
		    			   //srchNames = srchNames + values.nextElement() + " ";
		    			   newResult.setCn((String) values.nextElement());
		    		   } else if (attrname.equals("uid")) {
		    			   newResult.setUid((String) values.nextElement());
		    		   } else if (attrname.equals("departmentNumber")) {
		    			   newResult.setDeptNo((String) values.nextElement());
		    		   } else if (attrname.equals("mail")) {
		    			   newResult.setMail((String) values.nextElement());
		    		   }
		    		   
		    	   }
		    	   srchResult.add(newResult);
		       }
		       
		       //request.setAttribute("name", srchNames);
		       request.setAttribute("srchRecResults", srchResult);
		       
		       
		} catch (Exception e) {
			System.out.println("Execption: " + e.toString());
		}

		RequestDispatcher view = request.getRequestDispatcher("/submitAward.jsp");
		view.forward(request, response);
		
	}

}
