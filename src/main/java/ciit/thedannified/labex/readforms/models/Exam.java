package ciit.thedannified.labex.readforms.models;

import java.util.ArrayList;
import java.util.List;

/**
 * The {@code Exam} class represents a virtual examination similar to taking a simple test or quiz in real life. It
 * has a set of questions that a user may answer and get results from after taking the test.
 *
 * @author Danne Uriel Boiser
 */
public class Exam {

    /**
     * Container of ExamItem objects that represent series of questions of an Exam.
     */
    private List<ExamItem> examItems;

    public Exam() {
        this.examItems = new ArrayList<>();
    }

    public List<ExamItem> getExamItems() {
        return examItems;
    }

    public void setExamItems(List<ExamItem> examItems) {
        this.examItems = examItems;
    }

    /**
     * Compares all answer inputs to the key answers of the Exam and returns a total score of correct answers.
     * @param answers An array of Integers containing the answer inputs of the user.
     * @return sum of correct answers checked in this {@link Exam}.
     */
    public int checkAnswers(List<Integer> answers) {
        int score = 0;

        for (int i = 0; i < getExamItems().size(); i++)
            if (getExamItems().get(i).getAnswer() == answers.get(i)) score++;

        return score;
    }

}
