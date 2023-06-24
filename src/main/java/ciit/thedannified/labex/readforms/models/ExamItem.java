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
 * The {@code ExamItem} class represents an item question in an {@link Exam} object. It contains information about an
 * examination item's question, its set of available choices, and the key answer to the examination item.
 *
 * @author Danne Uriel Boiser
 */
public class ExamItem {

    /**
     * A string that defines the context of an item question.
     */
    private String question;
    /**
     * A set of answers that a user may choose to answer the item.
     */
    private List<String> choices;
    /**
     * A number that specifies the index of the correct answer in a set of {@link #choices}.
     */
    private int answer;

    /**
     * Instantiates an {@code ExamItem} that accepts a given question and instantiates an ArrayList object for {@link #choices} attribute.
     * @param question A string that defines the context of an item question.
     */
    private ExamItem(String question) {
        this.question = question;
        this.choices = new ArrayList<>();
    }

    /**
     * Instantiates an {@code ExamItem} that will accept a given question, a set of choices, and an index of its correct answer.
     * @param question a string that defines the context of an item question.
     * @param choices a set of answers that a user may choose to answer the item.
     * @param answer a number that specifies the index of the correct answer in a set of {@link #choices}.
     * @throws IndexOutOfBoundsException when the given index is invalid or is higher than the number of given {@link #choices}.
     */
    public ExamItem(String question, List<String> choices, int answer) throws IndexOutOfBoundsException {
        this(question);
        // Given index must be less than the total number of choices AND is valid (not less than or equal to -1)
        if (choices.size() > answer && answer > -1) {
            this.choices.addAll(choices);
            this.answer = answer;
        }
        else throw new IndexOutOfBoundsException("Answer index does not match to the number of available choices.");
    }

    /**
     * Instantiates an {@code ExamItem} that will accept a given question, a set of choices, and an index of its correct answer.
     * @param question a string that defines the context of an item question.
     * @param choices a set of answers that a user may choose to answer the item.
     * @param answer a number that specifies the index of the correct answer in a set of {@link #choices}.
     * @throws IndexOutOfBoundsException when the given index is invalid or exceeds the number of given {@link #choices}.
     */
    public ExamItem(String question, String[] choices, int answer) throws IndexOutOfBoundsException {
        this(question, List.of(choices), answer);
    }

    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public List<String> getChoices() {
        return choices;
    }

    public void setChoices(List<String> choices) {
        this.choices = choices;
    }

    public int getAnswer() {
        return answer;
    }

    public void setAnswer(int answer) {
        this.answer = answer;
    }
}
