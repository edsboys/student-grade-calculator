package com.vut.calculator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/calculate")
public class GradeServlet extends HttpServlet {

    private GradeCalculator calculator = new GradeCalculator();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String studentName = request.getParameter("studentName");
        String semesterMarkStr = request.getParameter("semesterMark");
        String examMarkStr = request.getParameter("examMark");

        try {
            double semesterMark = Double.parseDouble(semesterMarkStr);
            double examMark = Double.parseDouble(examMarkStr);

            // Validate marks
            if (!calculator.isValidMark(semesterMark) || !calculator.isValidMark(examMark)) {
                request.setAttribute("error", "Marks must be between 0 and 100.");
                request.getRequestDispatcher("/index.jsp").forward(request, response);
                return;
            }

            // Check exam admission
            boolean admitted = calculator.hasExamAdmission(semesterMark);
            request.setAttribute("studentName", studentName);
            request.setAttribute("semesterMark", semesterMark);
            request.setAttribute("admitted", admitted);

            if (admitted) {
                double finalMark = calculator.calculateFinalMark(semesterMark, examMark);
                String grade = calculator.determineGrade(finalMark);
                boolean supplementary = calculator.qualifiesForSupplementary(finalMark);

                request.setAttribute("examMark", examMark);
                request.setAttribute("finalMark", finalMark);
                request.setAttribute("grade", grade);
                request.setAttribute("supplementary", supplementary);
            }

            request.getRequestDispatcher("/result.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Please enter valid numeric marks.");
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        }
    }
}
