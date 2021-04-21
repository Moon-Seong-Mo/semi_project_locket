package common.controller;

import java.util.HashMap;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import member.model.vo.Member;

/**
 * Application Lifecycle Listener implementation class SessionMoniter
 *
 */
@WebListener
public class SessionMoniter implements HttpSessionListener, HttpSessionAttributeListener {
	public static HashMap<String, HttpSession> sessionMap = new HashMap<String, HttpSession>();
	
	/**
	 * Default constructor.
	 */
	public SessionMoniter() {
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpSessionListener#sessionCreated(HttpSessionEvent)
	 */
	public void sessionCreated(HttpSessionEvent se) {

	}

	/**
	 * @see HttpSessionListener#sessionDestroyed(HttpSessionEvent)
	 */
	public void sessionDestroyed(HttpSessionEvent se) {
		Object attr = null;
		if ((attr = se.getSession().getAttribute("loginMember")) != null) {
			if (attr instanceof Member) {
				String id = ((Member) attr).getId();
				sessionMap.remove(id);
				System.out.println(id + " 로그아웃");
			}
		}
	}
	
	public void attributeAdded(HttpSessionBindingEvent se) {
		Object attr = null;
		if ((attr = se.getSession().getAttribute("loginMember")) != null) {
			if (attr instanceof Member) {
				String id = ((Member)attr).getId();
				
				System.out.println(id + " 로그인");
				sessionMap.put(id, se.getSession());
				
			}
		}
	}
}
