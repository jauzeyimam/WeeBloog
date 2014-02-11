package weebloog;

import java.io.IOException;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Properties;
import java.util.logging.Logger;

import javax.mail.Address;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.googlecode.objectify.ObjectifyService;

@SuppressWarnings("serial")
public class DailyReportServlet extends HttpServlet {
	public static final Logger _log = Logger.getLogger(DailyReportServlet.class
			.getName());

	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {

		Properties props = new Properties();
		Session session = Session.getDefaultInstance(props, null);
		try {
			ObjectifyService.register(Subscriber.class);
			List<Subscriber> subs = ObjectifyService.ofy().load()
					.type(Subscriber.class).list();
			Date date = new Date();
			date.setTime(date.getTime() - 86400000);

			// Retrieve the results
			ObjectifyService.register(BlogPost.class);
			List<BlogPost> posts = ObjectifyService.ofy().load()
					.type(BlogPost.class).list();
			Collections.sort(posts);

			String str = "Here is your daily post digest!\r\n\n";

			for (BlogPost post : posts) {
				if (post.getDate().after(date)) {
					str += post.getTitle() + "\r\n";
					str += post.getPost() + "\r\n";
					str += "Posted by " + post.getUser() + " on "
							+ post.getDateString() + "\r\n";
					str += "\n";
				}
			}
			
			str += "Visit us at weebloog.appspot.com for more!";

			// Send out Email

			if (!posts.isEmpty() && !subs.isEmpty()) {
				MimeMessage outMessage = new MimeMessage(session);
				outMessage.setFrom(new InternetAddress(
						"admin@weebloog.appspotmail.com"));
				
				for (Subscriber subscriber : subs) {
					outMessage.addRecipient(MimeMessage.RecipientType.TO,
							new InternetAddress(subscriber.getEmail()));
				}

				outMessage
						.setSubject("Daily Posts from The Weblog of Jauzey Imam and Zander Smith");
				outMessage.setText(str);
				Transport.send(outMessage);
			}
		} catch (MessagingException e) {
			_log.info("ERROR: Could not send out Email Results response : "
					+ e.getMessage());
		}
	}

	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doGet(req, resp);
	}

}