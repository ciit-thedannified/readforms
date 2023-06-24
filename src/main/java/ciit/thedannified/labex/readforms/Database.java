package ciit.thedannified.labex.readforms;

import ciit.thedannified.labex.readforms.models.ExamRecord;
import jakarta.validation.constraints.NotNull;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Database {

    private static final Map<String, String> users = new HashMap<>();
    private static final Map<String, Integer> records = new HashMap<>();

    static {

        /*
            Sample website users.

            NOTE: You may add more samples as long as they have the following:
                    - a username (key) containing at least 3-16 characters; and
                    - a password (value) containing at least 8 characters.
         */
        users.put("danneboiser", "adminadmin");
        users.put("kojiescolar", "adminadmin");
        users.put("erikadanielle", "adminadmin");
        users.put("nathancaballero", "adminadmin");

        /*
            Sample exam records.

            NOTE: You may add more samples as long as they have the following:
                    - a username (key) containing at least 3-16 characters; and
                    - a score (value) with an integer value of 1-5.
         */

        // SAMPLE [UNCOMMENT IF YOU WISH TO USE THE FORMAT]
        // records.put("danneboiser", 4);
    }

    public static Map<String, String> getUsers() {
        return users;
    }

    /**
     * Retrieves all user scores from the database records.
     * @return list of all {@link ExamRecord} objects
     */
    public static List<ExamRecord> getAllScores() {
        List<ExamRecord> retrievedRecords = new ArrayList<>();

        records.forEach((username, score) -> {
            ExamRecord retrievedRecord = new ExamRecord(username, score);
            retrievedRecords.add(retrievedRecord);
        });

        return retrievedRecords;
    }

    /**
     * Checks if the client's credentials exist in the database.
     * @param username client's username
     * @param password client's password
     * @return true if the user exists; otherwise, return false.
     */
    public static boolean validateUser(String username, @NotNull String password) {
        String retrievedUser = users.get(username);

        return password.equals(retrievedUser);
    }

    /**
     * Creates a new user to the database. Usernames already taken cannot be used by new clients.
     * @param username client's username
     * @param password client's password
     * @return true if the account is new; otherwise, return false.
     */
    public static boolean createUser(String username, String password) {
        if (!users.containsKey(username.toLowerCase())) {
            users.put(username, password);
            return true;
        }

        return false;
    }

    /**
     * Adds or updates a client's exam record to the database.
     * @param username client's username
     * @param score client's score
     */
    public static void addRecord(String username, int score) {
        records.put(username, score);
    }

    /**
     * Checks if the user has already taken the quiz before.
     * @param username client's username
     * @return true if the user has already taken the quiz before; otherwise, return false.
     */
    public static boolean hasTakenQuiz(String username) {
        return records.containsKey(username);
    }

}
