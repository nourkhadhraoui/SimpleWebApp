<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    int id = Integer.parseInt(request.getParameter("id"));
    String title = "", content = "";

    try {
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/simple_site_db", "root", "");
        PreparedStatement stmt = conn.prepareStatement("SELECT * FROM articles WHERE id = ?");
        stmt.setInt(1, id);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            title = rs.getString("title");
            content = rs.getString("content");
        }
        rs.close(); stmt.close(); conn.close();
    } catch (Exception e) {
        
    }
%>

<!DOCTYPE html>
<html lang="ar">
<head>
    <meta charset="UTF-8">
    <title>📝 تعديل المقال</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #ff9a9e, #fad0c4, #fbc2eb, #a1c4fd, #c2e9fb, #d4fc79, #96e6a1);
            background-size: 200% 200%;
            animation: rainbowBG 14s ease infinite;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            direction: rtl;
        }

        @keyframes rainbowBG {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        .form-wrapper {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(12px);
            padding: 50px 40px;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.2);
            width: 90%;
            max-width: 620px;
            animation: fadeIn 1s ease;
        }

        h2 {
            color: #6a1b9a;
            text-align: center;
            margin-bottom: 25px;
            font-size: 28px;
        }

        label {
            font-size: 18px;
            color: #444;
            margin-bottom: 10px;
            display: block;
        }

        input[type="text"],
        textarea {
            width: 100%;
            padding: 14px;
            font-size: 16px;
            border: 2px solid #ccc;
            border-radius: 12px;
            margin-bottom: 20px;
            transition: all 0.3s ease-in-out;
            background-color: #fff;
        }

        input[type="text"]:focus,
        textarea:focus {
            border-color: #ab47bc;
            box-shadow: 0 0 10px rgba(171, 71, 188, 0.3);
        }

        input[type="submit"] {
            background: linear-gradient(45deg, #8e24aa, #d81b60);
            color: #fff;
            border: none;
            padding: 14px 0;
            width: 100%;
            font-size: 18px;
            border-radius: 50px;
            cursor: pointer;
            transition: transform 0.2s ease, background 0.3s ease;
        }

        input[type="submit"]:hover {
            background: linear-gradient(45deg, #6a1b9a, #c2185b);
            transform: scale(1.03);
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 600px) {
            .form-wrapper {
                padding: 30px 20px;
            }

            h2 {
                font-size: 24px;
            }

            input[type="submit"] {
                font-size: 16px;
            }
        }
    </style>
</head>
<body>

<div class="form-wrapper">
    <h2>🔧 تعديل المقال</h2>
    <form action="my_articles.jsp" method="post">
        <input type="hidden" name="id" value="<%= id %>">

        <label for="title">العنوان:</label>
        <input type="text" id="title" name="title" value="<%= title %>" required>

        <label for="content">المحتوى:</label>
        <textarea id="content" name="content" rows="8" required><%= content %></textarea>

        <input type="submit" value="💾 تحديث المقال">
    </form>
</div>

</body>
</html> 