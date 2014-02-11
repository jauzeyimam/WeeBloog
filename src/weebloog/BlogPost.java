package weebloog;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.TimeZone;

import com.google.appengine.api.users.User;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;

@Entity	
public class BlogPost implements Comparable<BlogPost>{
	@Id
	Long id;
	User user;
	String title;
	String post;
	Date date;
	
	@SuppressWarnings("unused")
	private BlogPost(){
	}
	
	public BlogPost(User user, String title, String post){
		this.user = user;
		this.title = title;
		this.post = post;
		date = new Date();
	}
	
	
	public User getUser() {
		return user;
	}

	public String getTitle() {
		return title;
	}

	public String getPost() {
		//String formatted = post.replaceAll("\n", "<br>");
		return post;
	}
	
	public Date getDate() {
		return date;
	}
	
	public String getDateString() {
        SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("dd-MM-yyyy KK:mm:ss a z");
        DATE_FORMAT.setTimeZone(TimeZone.getTimeZone("America/Chicago"));
        return DATE_FORMAT.format(date);
	}

	@Override
	public int compareTo(BlogPost o) {
		if(date.after(o.date))
			return -1;
		else if(date.before(o.date))
			return 1;
		return 0;
	}

}
