package weebloog;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.googlecode.objectify.ObjectifyService;

public class AddSubscriberServlet extends HttpServlet {

	public void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		
		ObjectifyService.register(Subscriber.class );
		
		Subscriber subscriber = new Subscriber(req.getParameter("name"), req.getParameter("email"));
		
        ofy().save().entity(subscriber).now();
		
		resp.sendRedirect("/");
	}

}
