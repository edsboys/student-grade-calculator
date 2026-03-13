<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Grade Result - VUT Calculator</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Segoe UI', Arial, sans-serif; background: #f0f2f5; min-height: 100vh; display: flex; justify-content: center; align-items: center; }
        .container { background: white; padding: 40px; border-radius: 12px; box-shadow: 0 4px 20px rgba(0,0,0,0.1); width: 100%; max-width: 500px; }
        .header { text-align: center; margin-bottom: 30px; }
        .header h1 { color: #1a365d; font-size: 22px; }
        .result-card { background: #f8fafc; border: 2px solid #e2e8f0; border-radius: 10px; padding: 24px; margin-bottom: 20px; }
        .result-row { display: flex; justify-content: space-between; padding: 8px 0; border-bottom: 1px solid #e2e8f0; }
        .result-row:last-child { border-bottom: none; }
        .result-label { color: #666; font-size: 14px; }
        .result-value { font-weight: 600; color: #1a365d; font-size: 14px; }
        .grade-badge { display: inline-block; padding: 6px 16px; border-radius: 20px; font-weight: 700; font-size: 16px; margin-top: 10px; }
        .distinction { background: #dcfce7; color: #166534; }
        .merit { background: #dbeafe; color: #1e40af; }
        .credit { background: #fef9c3; color: #854d0e; }
        .pass { background: #fed7aa; color: #9a3412; }
        .fail { background: #fee2e2; color: #991b1b; }
        .denied { background: #fee2e2; color: #991b1b; }
        .supplementary { background: #fef3c7; color: #92400e; padding: 12px; border-radius: 8px; margin-top: 15px; font-size: 14px; text-align: center; }
        .btn-back { display: block; text-align: center; padding: 14px; background: #1a365d; color: white; text-decoration: none; border-radius: 8px; font-size: 16px; font-weight: 600; margin-top: 20px; }
        .btn-back:hover { background: #2d4a7a; }
        .grade-section { text-align: center; padding: 15px 0; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Grade Report</h1>
        </div>

        <div class="result-card">
            <div class="result-row">
                <span class="result-label">Student Name</span>
                <span class="result-value"><%= request.getAttribute("studentName") %></span>
            </div>
            <div class="result-row">
                <span class="result-label">Semester Mark</span>
                <span class="result-value"><%= request.getAttribute("semesterMark") %>%</span>
            </div>

            <% if ((Boolean) request.getAttribute("admitted")) { %>
                <div class="result-row">
                    <span class="result-label">Exam Admission</span>
                    <span class="result-value" style="color: #166534;">✓ ADMITTED</span>
                </div>
                <div class="result-row">
                    <span class="result-label">Exam Mark</span>
                    <span class="result-value"><%= request.getAttribute("examMark") %>%</span>
                </div>
                <div class="result-row">
                    <span class="result-label">Final Mark</span>
                    <span class="result-value"><%= request.getAttribute("finalMark") %>%</span>
                </div>

                <div class="grade-section">
                    <%
                        String grade = (String) request.getAttribute("grade");
                        String badgeClass = "fail";
                        if ("Distinction".equals(grade)) badgeClass = "distinction";
                        else if ("Merit".equals(grade)) badgeClass = "merit";
                        else if ("Credit".equals(grade)) badgeClass = "credit";
                        else if ("Pass".equals(grade)) badgeClass = "pass";
                    %>
                    <span class="grade-badge <%= badgeClass %>"><%= grade %></span>
                </div>

                <% if ((Boolean) request.getAttribute("supplementary")) { %>
                    <div class="supplementary">
                        ⚠ This student qualifies for a <strong>supplementary exam</strong>.
                    </div>
                <% } %>
            <% } else { %>
                <div class="result-row">
                    <span class="result-label">Exam Admission</span>
                    <span class="result-value denied">✗ DENIED</span>
                </div>
                <div class="grade-section">
                    <span class="grade-badge denied">NO EXAM ADMISSION</span>
                    <p style="margin-top: 10px; color: #666; font-size: 13px;">
                        Student did not meet the minimum semester mark of 40% required for exam admission.
                    </p>
                </div>
            <% } %>
        </div>

        <a href="calculate" class="btn-back">← Calculate Another</a>
    </div>
</body>
</html>
