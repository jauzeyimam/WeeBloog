package weebloog;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.googlecode.objectify.ObjectifyService;
import static com.googlecode.objectify.ObjectifyService.ofy;

@SuppressWarnings("serial")
public class RemoveSubscriberServlet extends HttpServlet{
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		ObjectifyService.register(Subscriber.class);
			
		List<Subscriber> subs = ObjectifyService.ofy().load()
				.type(Subscriber.class).list();

		for (Subscriber subscriber: subs) {
			if (subscriber.getEmail().equals(req.getParameter("email"))) {
				ofy().delete().entity(subscriber);
			}
		}
		
		resp.sendRedirect("/");
	}
}
