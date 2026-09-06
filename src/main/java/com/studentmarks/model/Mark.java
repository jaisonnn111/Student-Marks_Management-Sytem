package com.studentmarks.model;

public class Mark {

    private int studentId;
    private String subjectCode;
    private double score;
    private String grade;

    public Mark() {
    }

    public Mark(int studentId, String subjectCode, double score, String grade) {
        this.studentId = studentId;
        this.subjectCode = subjectCode;
        this.score = score;
        this.grade = grade;
    }

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public String getSubjectCode() {
        return subjectCode;
    }

    public void setSubjectCode(String subjectCode) {
        this.subjectCode = subjectCode;
    }

    public double getScore() {
        return score;
    }

    public void setScore(double score) {
        this.score = score;
    }

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade;
    }
}