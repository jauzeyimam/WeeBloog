package weebloog;

import java.util.Date;

import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;


@Entity
public class Subscriber implements Comparable<Subscriber> {
	@Id
	Long id;
	String name;
	String email;
	Date date;

	@SuppressWarnings("unused")
	private Subscriber() {

	}

	public Subscriber(String name, String email) {
		this.name = name;
		this.email = email;
		date = new Date();
	}
	
	public long getId() {
		return id;
	}

	public String getName() {
		return name;
	}

	public String getEmail() {
		return email;
	}

	public Date getDate() {
		return date;
	}

	@Override
	public int compareTo(Subscriber o) {
		if (date.after(o.date))
			return -1;
		else if (date.before(o.date))
			return 1;
		return 0;
	}

}
