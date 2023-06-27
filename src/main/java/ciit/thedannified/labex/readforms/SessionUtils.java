package ciit.thedannified.labex.readforms;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

public class SessionUtils {

    public static final int NEW_USER_SESSION = 100;
    public static final int UPDATED_USER_SESSION = 200;

    private static final Map<String, String> sessions = new HashMap<>();

    public static int addSession(String username, String sessionId) {
        Optional<String> previousSessionId = Optional.ofNullable(sessions.put(username, sessionId));

        if (previousSessionId.isEmpty()) {
            System.out.printf("[NEW] User %s's Session ID generated: [%s]%n", username, sessionId);
            return NEW_USER_SESSION;
        }
        else {
            System.out.printf("[UPDATE] User %s's Session ID changed: OLD: [%s] -> NEW: [%s]%n", username, previousSessionId.get(), sessionId);
            return UPDATED_USER_SESSION;
        }
    }

    public static boolean isValidSession(String username, String sessionId) {
        Optional<String> currentSessionId = Optional.ofNullable(sessions.get(username));

        return currentSessionId.map(s -> s.equals(sessionId)).orElse(false);
    }

    public static boolean hasUserLoggedIn(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        Optional<Cookie[]> cookies;
        String s;

        cookies = Optional.ofNullable(request.getCookies());

        if (cookies.isPresent()) {
            s = Arrays.stream(cookies.get())
                    .filter(a -> a.getName().equals("username"))
                    .map(Cookie::getValue).findFirst().orElse(null);

            if (isValidSession(s, session.getId())) {
                session.setAttribute("username", s);
                return true;
            }

            else return false;
        }
        else return false;
    }

}
