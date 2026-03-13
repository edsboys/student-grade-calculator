<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VUT Student Grade Calculator</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Segoe UI', Arial, sans-serif; background: #f0f2f5; min-height: 100vh; display: flex; justify-content: center; align-items: center; }
        .container { background: white; padding: 40px; border-radius: 12px; box-shadow: 0 4px 20px rgba(0,0,0,0.1); width: 100%; max-width: 500px; }
        .header { text-align: center; margin-bottom: 30px; }
        .header h1 { color: #1a365d; font-size: 24px; margin-bottom: 5px; }
        .header p { color: #666; font-size: 14px; }
        .logo { color: #c8942e; font-size: 36px; margin-bottom: 10px; }
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; margin-bottom: 6px; font-weight: 600; color: #333; font-size: 14px; }
        .form-group input { width: 100%; padding: 12px; border: 2px solid #e2e8f0; border-radius: 8px; font-size: 16px; transition: border-color 0.3s; }
        .form-group input:focus { outline: none; border-color: #1a365d; }
        .btn { width: 100%; padding: 14px; background: #1a365d; color: white; border: none; border-radius: 8px; font-size: 16px; font-weight: 600; cursor: pointer; transition: background 0.3s; }
        .btn:hover { background: #2d4a7a; }
        .error { background: #fee2e2; color: #991b1b; padding: 12px; border-radius: 8px; margin-bottom: 20px; font-size: 14px; }
        .info { background: #e8f4f8; color: #1a365d; padding: 12px; border-radius: 8px; margin-top: 20px; font-size: 13px; line-height: 1.5; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <div class="logo">&#9881;</div>
            <h1>Student Grade Calculator</h1>
            <p>ASSDX4A DevOps Practical Assessment</p>
        </div>

        <% if (request.getAttribute("error") != null) { %>
            <div class="error"><%= request.getAttribute("error") %></div>
        <% } %>

        <form action="calculate" method="post">
            <div class="form-group">
                <label for="studentName">Student Name</label>
                <input type="text" id="studentName" name="studentName" placeholder="e.g. Thabo Mokoena" required>
            </div>
            <div class="form-group">
                <label for="semesterMark">Semester Mark (0–100)</label>
                <input type="number" id="semesterMark" name="semesterMark" min="0" max="100" step="0.01" placeholder="e.g. 65" required>
            </div>
            <div class="form-group">
                <label for="examMark">Exam Mark (0–100)</label>
                <input type="number" id="examMark" name="examMark" min="0" max="100" step="0.01" placeholder="e.g. 58" required>
            </div>
            <button type="submit" class="btn">Calculate Grade</button>
        </form>

        <div class="info">
            <strong>Grading Policy:</strong><br>
            Final Mark = (Semester × 0.4) + (Exam × 0.6)<br>
            Minimum semester mark for exam admission: 40%
        </div>
    </div>
</body>
</html>
