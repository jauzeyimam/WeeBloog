package weebloog;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.googlecode.objectify.ObjectifyService;

@SuppressWarnings("serial")
public class AddSubscriberServlet extends HttpServlet {

	public void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		
		ObjectifyService.register(Subscriber.class);
		
		List<Subscriber> subs = ObjectifyService.ofy().load()
				.type(Subscriber.class).list();

		
		boolean exists = false;
		
		for (Subscriber subscriber: subs) {
			if (subscriber.getEmail().equals(req.getParameter("email"))) {
				exists = true;
			}
		}
		
		if (exists == false) {
			Subscriber subscriber = new Subscriber(req.getParameter("name"), req.getParameter("email"));
	        ofy().save().entity(subscriber).now();
		}
		
		
		resp.sendRedirect("/");
	}

}
