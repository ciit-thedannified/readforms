/*
    **************************************************************************
    COURSE SUBJECT: CSELEC1 - DYNAMIC WEB PROGRAMMING (JAVA EE/REST API)
    ASSIGNMENT TITLE: Lab Exercise: Reading HTML Form Data with JSP

    SUBMITTED BY:   BOISER, Danne Uriel M.
                    BS Computer Science - 2nd Year

    SUBMITTED TO:   FULLER, Jonathan F.
                    Class Instructor
    ***************************************************************************
    NOTE:   This file contains the source code used to run a working JSP file
            executed in Eclipse JavaEE Developers IDE and Apache Tomcat 9.0
 */
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
